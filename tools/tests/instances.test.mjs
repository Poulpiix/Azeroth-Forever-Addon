// Tests des fiches d'instances (Phase 4, fiches dépliables sur /donjons).
// Lancer depuis la racine du site :  node --test "tools/tests/*.test.mjs"
import { test } from "node:test";
import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";
import { ROOT, loadInstances, validate, statusOf, plan, leftovers, BUNDLE } from "../instances/build.mjs";

const require = createRequire(import.meta.url);
const { renderDetail } = require(path.join(ROOT, "js", "dungeons.js"));

const list = loadInstances();
const donjons = fs.readFileSync(path.join(ROOT, "donjons.html"), "utf8");
const cards = [...donjons.matchAll(/<li class="ig-card" data-id="(\w+)" data-slug="([a-z0-9-]+)"/g)];

// Fiche de démonstration, jamais publiée : prouve que la fiche sait afficher
// des boss et des quêtes. Contenu volontairement factice.
function demo(overrides) {
  return Object.assign(JSON.parse(JSON.stringify(list[0].data)), overrides);
}

test("41 fiches, une par carte de /donjons, dans le même ordre", () => {
  assert.equal(list.length, 41);
  assert.deepEqual(list.map((x) => x.data.id), cards.map((c) => c[1]));
  assert.deepEqual(list.map((x) => x.data.slug), cards.map((c) => c[2]));
});

test("toutes les fiches sont valides et les slugs sont uniques", () => {
  assert.deepEqual(list.flatMap((x) => validate(x.data, x.file)), []);
  const all = list.flatMap((x) => x.data.slugs);
  assert.equal(new Set(all).size, all.length);
});

test("chaque carte est un bouton qui déplie sa fiche (pas de lien vers une autre page)", () => {
  assert.equal((donjons.match(/<h3><button type="button" class="ig-link" aria-expanded="false">/g) || []).length, 41);
  assert.doesNotMatch(donjons, /href="donjons-/);
  assert.match(donjons, /<script src="js\/dungeons\.js\?v=\d+"><\/script>/);
});

test("rien d'inventé : aucun boss ni quête sans source dans le repo", () => {
  for (const { data } of list) {
    assert.deepEqual(data.bosses, [], data.slug);
    assert.deepEqual(data.quests, [], data.slug);
  }
});

test("fiche dépliée : toutes les lignes sont là, même vides (« — », « À compléter »), sans bouton Fermer", () => {
  for (const { data } of list) {
    const html = renderDetail(data);
    for (const label of ["Type", "Origine", "Niveaux", "Joueurs", "Group Finder", "Entrée", "Lockout"]) {
      assert.ok(html.includes("<dt>" + label + "</dt>"), data.slug + " : ligne " + label);
    }
    assert.match(html, /<h4>Bosses<\/h4><p class="ig-empty-line">À compléter<\/p>/, data.slug + " : bosses");
    assert.match(html, /<h4>Quêtes<\/h4><p class="ig-empty-line">À compléter<\/p>/, data.slug + " : quêtes");
    assert.doesNotMatch(html, /Fermer|data-ig-close|indisponible/);
    assert.match(html, /Sujet à changement pendant la bêta/);
  }
});

test("fiche minimale sans JSON (données de la carte seulement) : même bloc, jamais d'erreur", () => {
  const bare = { names: { fr: "X", en: null, frOfficial: true }, type: "bg", origin: "new", levels: null, players: null };
  const html = renderDetail(bare);
  for (const label of ["Type", "Niveaux", "Joueurs", "Group Finder", "Entrée", "Lockout"]) assert.ok(html.includes("<dt>" + label + "</dt>"), label);
  assert.match(html, /<dt>Joueurs<\/dt><dd><span class="ig-na"[^>]*>—/);
  assert.equal((html.match(/À compléter/g) || []).length, 2);
});

test("Gouffre de Ragefeu : fiche modèle, TBD assumé", () => {
  const rfc = list.find((x) => x.data.slug === "gouffre-de-ragefeu").data;
  assert.deepEqual(rfc.slugs, ["gouffre-de-ragefeu", "ragefire-chasm"]);
  assert.equal(statusOf(rfc), "vide");
  const html = renderDetail(rfc);
  assert.match(html, /<dt>Niveaux<\/dt><dd><b class="num">13–18<\/b><\/dd>/);
  assert.match(html, /<dt>Joueurs<\/dt><dd><span class="ig-na"[^>]*>—/);
  assert.match(html, /<h4>Bosses<\/h4><p class="ig-empty-line">À compléter<\/p>/);
  assert.match(html, /Butin : Loot non publié\./);
  assert.match(html, /Écarts avec Classic : <span class="ig-na"/);
});

test("la fiche affiche boss et quêtes quand ils existent (fiche de démonstration)", () => {
  const inst = demo({
    bosses: [
      { names: { fr: "Boss A", en: "Boss A EN" }, oneLiner: "Une phrase.", foreverNote: "Note.", confidence: "classic", source: "donjons" },
      { names: { fr: "Boss <B>" }, confidence: "annonce", source: "donjons" }
    ],
    quests: [{ names: { fr: "Quête A" }, level: 15, faction: "horde", rewards: { items: ["Objet"] }, confidence: "classic", source: "donjons" }],
    entry: { where: "Ici.", how: "Par là.", source: "donjons" },
    classicDiff: "Diff."
  });
  assert.deepEqual(validate(inst), []);
  assert.equal(statusOf(inst), "complet");
  const html = renderDetail(inst);
  assert.match(html, /<h4>Bosses <small>2<\/small><\/h4><ol/);
  assert.match(html, /<b>Boss A<\/b> <span class="ig-en">\(Boss A EN\)<\/span>/);
  assert.match(html, /Boss &lt;B&gt;/, "texte échappé");
  assert.match(html, /Donnée Classic, à revérifier en Forever/);
  assert.match(html, /<dt>Faction<\/dt><dd>Horde<\/dd>/);
  assert.match(html, /<dt>Donneur<\/dt><dd><span class="ig-na"/);
  assert.match(html, /<dt>Entrée<\/dt><dd>Ici\. Par là\.<\/dd>/);
});

test("validation : boss sans source refusé, tableaux obligatoires", () => {
  assert.ok(validate(demo({ bosses: [{ names: { fr: "X" }, confidence: "classic", source: "inconnue" }] })).some((e) => /boss 0 : source absente/.test(e)));
  assert.ok(validate(demo({ quests: undefined })).some((e) => /quests doit être un tableau/.test(e)));
});

test("statut : vide, partiel, complet", () => {
  assert.equal(statusOf(demo({})), "vide");
  assert.equal(statusOf(demo({ summary: "x", summarySource: "donjons" })), "partiel");
  assert.equal(statusOf(demo({ bosses: [{}] })), "partiel");
});

test("_index.json liste chaque slug avec complet | partiel | vide", () => {
  const index = JSON.parse(fs.readFileSync(path.join(ROOT, "data", "instances", "_index.json"), "utf8"));
  assert.equal(index.instances.length, 41);
  for (const row of index.instances) {
    const inst = list.find((x) => x.data.slug === row.slug);
    assert.ok(inst, row.slug);
    assert.equal(row.statut, statusOf(inst.data));
  }
  assert.equal(index.compte.complet + index.compte.partiel + index.compte.vide, 41);
});

test("fichiers générés à jour (_fiches.json, _index.json, version dans donjons.html)", () => {
  const { errors, files } = plan();
  assert.deepEqual(errors, []);
  for (const [rel, content] of Object.entries(files)) {
    assert.equal(fs.readFileSync(path.join(ROOT, rel), "utf8"), content, rel + " : relancer node tools/instances/build.mjs");
  }
  assert.match(donjons, new RegExp('data-instances-src="' + BUNDLE.replace(/\./g, "\\.") + '\\?v=[0-9a-f]{10}"'));
});

test("une seule page publique : plus de pages donjons-*, anciennes adresses redirigées", () => {
  assert.deepEqual(leftovers(), []);
  const ht = fs.readFileSync(path.join(ROOT, ".htaccess"), "utf8");
  assert.match(ht, /RewriteRule \^donjons-\(\[a-z0-9-\]\+\?\)\(\?:\\\.html\)\?\/\?\$ https:\/\/azerothforever\.info\/donjons\?ouvrir=\$1 \[R=301,L\]/);
  assert.ok(ht.indexOf("donjons?ouvrir=") < ht.indexOf("RewriteCond %{THE_REQUEST} \\s/+(.+)\\.html"), "avant la règle .html");
  const sitemap = fs.readFileSync(path.join(ROOT, "sitemap.xml"), "utf8");
  assert.doesNotMatch(sitemap, /donjons-/);
});
