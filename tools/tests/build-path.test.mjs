// Tests du codec et des règles de parcours (Phase 1).
// Lancer depuis la racine du site :  node --test tools/tests/
import { test } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { createRequire } from "node:module";
import vm from "node:vm";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, "..", "..");
const require = createRequire(import.meta.url);
const BP = require(path.join(root, "js", "build-path.js"));

const sandbox = { window: {} };
vm.runInNewContext(readFileSync(path.join(root, "js", "talents-data.js"), "utf8"), sandbox);
const CLASSES = sandbox.window.TALENTS_FR;
const cls = (slug) => CLASSES.find((c) => c.slug === slug);
const WARRIOR = BP.catalog(cls("guerrier"));
const EXAMPLE = "35325213132100000-555500000000000000-000000000000000000";

// PRNG déterministe pour les tests « propriété ».
function prng(seed) {
  let s = seed >>> 0;
  return () => ((s = (s * 1664525 + 1013904223) >>> 0) / 4294967296);
}
// Construit un build valide aléatoire en ajoutant des points légaux un par un.
function randomValidOrder(cat, rnd, points) {
  let order = [];
  for (let guard = 0; order.length < points && guard < 5000; guard++) {
    const idx = Math.floor(rnd() * cat.entries.length);
    const r = BP.append(cat, order, idx);
    if (r.ok) order = r.order;
  }
  return order;
}

test("?build= historique : décodage de l'exemple Guerrier et réencodage identique", () => {
  const ranks = BP.parseBuild(WARRIOR, EXAMPLE);
  assert.equal(BP.totalOf(ranks), 51);
  assert.equal(ranks[105958], 3); // Frappe héroïque améliorée
  assert.equal(ranks[110524], 1); // Exaltation sanguinaire
  assert.equal(ranks[105938], 5); // Voix tonitruante
  assert.equal(BP.serializeBuild(WARRIOR, ranks), EXAMPLE);
});

test("?build= : tolérances de l'ancien décodeur conservées", () => {
  const ranks = BP.parseBuild(WARRIOR, "9x3");
  assert.equal(ranks[105958], 3, "rang borné au max");
  assert.equal(ranks[105957], 0, "caractère non numérique ignoré");
  assert.equal(ranks[105956], 3);
  assert.equal(BP.serializeBuild(WARRIOR, ranks), "30300000000000000-000000000000000000-000000000000000000");
});

test("vieux lien sans path : ordre auto, Armes du 10 au 40 puis Fureur du 41 au 60", () => {
  const res = BP.resolve(WARRIOR, EXAMPLE, null);
  assert.equal(res.recalculated, false);
  assert.equal(res.order.length, 51);
  assert.ok(BP.validateOrder(WARRIOR, res.order).ok);
  const steps = BP.steps(WARRIOR, res.order, 0);
  assert.equal(steps[0].level, 10);
  assert.equal(steps[0].talentName, "Frappe héroïque améliorée");
  assert.equal(steps[0].rank, 1);
  const lastArms = steps.filter((s) => s.treeName === "Armes").pop();
  const firstFury = steps.find((s) => s.treeName === "Fureur");
  assert.equal(lastArms.level, 40);
  assert.equal(lastArms.talentName, "Exaltation sanguinaire");
  assert.equal(firstFury.level, 41);
  assert.equal(steps[50].level, 60);
  assert.equal(steps[50].talentName, "Colère déchaînée");
  assert.ok(steps.every((s, i) => i === 0 || s.treeIdx >= steps[i - 1].treeIdx), "on ne revient jamais à un arbre précédent");
});

test("ordre auto déterministe et encode/decode/égalité", () => {
  const a = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  const b = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  assert.deepEqual(a, b);
  const p = BP.encodePath(WARRIOR, a, 0);
  assert.equal(p.length, 2 + 51);
  assert.match(p, /^[A-Za-z0-9_-]+$/, "URL-safe");
  assert.ok(p.startsWith("10"));
  const d = BP.decodePath(WARRIOR, p);
  assert.ok(d.ok);
  assert.deepEqual(d.order, a);
  assert.equal(d.talented, 0);
});

test("path valide et cohérent : conservé tel quel (ordre manuel)", () => {
  // Parcours manuel : Fureur d'abord, puis Armes.
  const ranks = BP.parseBuild(WARRIOR, EXAMPLE);
  const auto = BP.autoOrder(WARRIOR, ranks);
  const fury = auto.filter((i) => WARRIOR.entries[i].treeIdx === 1);
  const arms = auto.filter((i) => WARRIOR.entries[i].treeIdx === 0);
  const manual = fury.concat(arms);
  assert.ok(BP.validateOrder(WARRIOR, manual).ok);
  const res = BP.resolve(WARRIOR, EXAMPLE, BP.encodePath(WARRIOR, manual, 0));
  assert.equal(res.recalculated, false);
  assert.deepEqual(res.order, manual);
  assert.equal(BP.steps(WARRIOR, res.order, 0)[0].treeName, "Fureur");
});

test("path corrompu : build gagne, parcours recalculé", () => {
  for (const bad of ["", "9", "2A", "1", "1x", "10*AB", "10" + "A".repeat(60), "10" + "_"]) {
    const res = BP.resolve(WARRIOR, EXAMPLE, bad);
    if (bad === "") { assert.equal(res.recalculated, false); continue; }
    assert.equal(res.recalculated, true, JSON.stringify(bad));
    assert.equal(BP.serializeBuild(WARRIOR, res.ranks), EXAMPLE);
    assert.ok(BP.validateOrder(WARRIOR, res.order).ok);
  }
});

test("path en conflit avec build : build gagne + recalcul", () => {
  const other = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, "5"));
  const res = BP.resolve(WARRIOR, EXAMPLE, BP.encodePath(WARRIOR, other, 0));
  assert.equal(res.recalculated, true);
  assert.equal(res.reason, "conflict");
  assert.equal(BP.serializeBuild(WARRIOR, res.ranks), EXAMPLE);
  assert.deepEqual(res.order, BP.autoOrder(WARRIOR, res.ranks));
});

test("path avec les bons rangs mais un ordre illégal : recalculé", () => {
  const auto = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  const reversed = auto.slice().reverse();
  const res = BP.resolve(WARRIOR, EXAMPLE, BP.encodePath(WARRIOR, reversed, 0));
  assert.equal(res.recalculated, true);
  assert.equal(res.reason, "invalid");
});

test("tentative de dépasser 51 points", () => {
  const order = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  const prot = WARRIOR.entries.find((e) => e.treeIdx === 2 && e.talent.row === 0);
  const r = BP.append(WARRIOR, order, prot.index);
  assert.equal(r.ok, false);
  assert.equal(r.code, "cap");
  assert.match(r.message, /51 points/);
  // Un build fabriqué à plus de 51 points donne un ordre invalide (signalé, pas corrigé en silence).
  const over = BP.resolve(WARRIOR, "35325213132100000-555500000000000000-550000000000000000", null);
  assert.equal(BP.validateOrder(WARRIOR, over.order).code, "cap");
  assert.equal(BP.decodePath(WARRIOR, "10" + "A".repeat(52)).ok, false);
});

test("Talentueux décale le premier point au niveau 9, sans dépasser 51", () => {
  assert.equal(BP.firstLevel(0), 10);
  assert.equal(BP.firstLevel(1), 9);
  assert.equal(BP.pointsAvailable(9, 0), 0);
  assert.equal(BP.pointsAvailable(10, 0), 1);
  assert.equal(BP.pointsAvailable(60, 0), 51);
  assert.equal(BP.pointsAvailable(9, 1), 1);
  assert.equal(BP.pointsAvailable(59, 1), 51);
  assert.equal(BP.pointsAvailable(60, 1), 51, "jamais plus de 51");
  assert.equal(BP.levelOfPoint(1, 1), 9);
  assert.equal(BP.levelOfPoint(51, 1), 59);
  // Rangs 2 à 5 : TBD, aucun effet supplémentaire inventé.
  assert.equal(BP.firstLevel(5), 9);
  const order = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  const p = BP.encodePath(WARRIOR, order, 1);
  assert.ok(p.startsWith("11"));
  const res = BP.resolve(WARRIOR, EXAMPLE, p);
  assert.equal(res.talented, 1);
  assert.equal(res.recalculated, false);
  assert.equal(BP.steps(WARRIOR, res.order, 1)[0].level, 9);
});

test("prérequis manquant : refusé avec un message clair", () => {
  // Maîtrise de la Rage (r2) exige Maîtrise tactique améliorée 5/5.
  const ranks = BP.parseBuild(WARRIOR, "55500000000000000"); // 15 pts, tactique à 0
  const order = BP.autoOrder(WARRIOR, ranks);
  const rage = WARRIOR.byId[105951];
  const r = BP.append(WARRIOR, order, rage.index);
  assert.equal(r.ok, false);
  assert.equal(r.code, "prereq");
  assert.match(r.message, /Maîtrise de la Rage nécessite Maîtrise tactique améliorée au rang 5/);
});

test("palier de 5 points non atteint : refusé", () => {
  const charge = WARRIOR.byId[105955]; // rangée 1
  const r = BP.append(WARRIOR, [WARRIOR.byId[105958].index], charge.index);
  assert.equal(r.ok, false);
  assert.equal(r.code, "tier");
  assert.match(r.message, /nécessite 5 points dans l'arbre Armes \(1 à ce moment du parcours\)/);
});

test("Mode Parcours : clic droit retire le dernier rang de CE talent, pas le dernier point global", () => {
  const fhs = WARRIOR.byId[105958].index; // r0
  const dev = WARRIOR.byId[105957].index; // r0
  let order = [fhs, dev, fhs, dev];
  const r = BP.removeLastOf(WARRIOR, order, fhs);
  assert.ok(r.ok);
  assert.deepEqual(r.order, [fhs, dev, dev]);
  // Retrait qui casserait un palier plus loin dans le parcours : refusé.
  const five = [fhs, fhs, fhs, dev, dev];
  const withCharge = BP.append(WARRIOR, five, WARRIOR.byId[105955].index);
  assert.ok(withCharge.ok);
  const refused = BP.removeLastOf(WARRIOR, withCharge.order, dev);
  assert.equal(refused.ok, false);
  assert.match(refused.message, /^Impossible de retirer Déviation : charge améliorée nécessite 5 points/);
});

test("prérequis dans la même rangée (Paladin, Prêtre) : l'ordre auto les place d'abord", () => {
  for (const slug of ["paladin", "pretre"]) {
    const cat = BP.catalog(cls(slug));
    for (const e of cat.entries) {
      for (const req of e.talent.requires || []) {
        const p = cat.byId[req.id];
        if (p.talent.row !== e.talent.row) continue;
        // Build minimal : points bas d'arbre + prérequis + talent.
        const rnd = prng(7);
        let order = [];
        for (let g = 0; g < 20000 && !(order.includes(e.index)); g++) {
          const pick = rnd() < 0.3 ? (rnd() < 0.5 ? p.index : e.index) : cat.entries.filter((x) => x.treeIdx === e.treeIdx)[Math.floor(rnd() * cat.entries.filter((x) => x.treeIdx === e.treeIdx).length)].index;
          const r = BP.append(cat, order, pick);
          if (r.ok) order = r.order;
        }
        assert.ok(order.includes(e.index), slug + " : " + e.talent.name + " atteignable");
        const auto = BP.autoOrder(cat, BP.ranksFromOrder(cat, order));
        assert.ok(BP.validateOrder(cat, auto).ok, slug + " : ordre auto valide avec " + e.talent.name);
        assert.ok(auto.indexOf(p.index) < auto.indexOf(e.index));
      }
    }
  }
});

test("9 classes : catalogue < 64 talents, builds valides aléatoires => ordre auto valide et aller-retour exact", () => {
  assert.equal(CLASSES.length, 9);
  for (const c of CLASSES) {
    const cat = BP.catalog(c);
    assert.ok(cat.entries.length <= 64);
    const rnd = prng(c.id * 97);
    for (let k = 0; k < 60; k++) {
      const pts = 1 + Math.floor(rnd() * 51);
      const manual = randomValidOrder(cat, rnd, pts);
      assert.ok(BP.validateOrder(cat, manual).ok);
      const ranks = BP.ranksFromOrder(cat, manual);
      const build = BP.serializeBuild(cat, ranks);
      // encode -> decode -> égalité (build et path)
      assert.ok(BP.sameRanks(cat, BP.parseBuild(cat, build), ranks));
      const res = BP.resolve(cat, build, BP.encodePath(cat, manual, k % 2));
      assert.equal(res.recalculated, false, c.slug + " " + build);
      assert.deepEqual(res.order, manual);
      assert.equal(res.talented, k % 2);
      // ordre auto : valide, même build, arbres jamais entrelacés
      const auto = BP.autoOrder(cat, ranks);
      assert.ok(BP.validateOrder(cat, auto).ok, c.slug + " auto " + build);
      assert.ok(BP.sameRanks(cat, BP.ranksFromOrder(cat, auto), ranks));
      const trees = auto.map((i) => cat.entries[i].treeIdx);
      assert.ok(trees.every((t, i) => i === 0 || t >= trees[i - 1]));
    }
  }
});

test("état au niveau simulé : seuls les N premiers points comptent", () => {
  const order = BP.autoOrder(WARRIOR, BP.parseBuild(WARRIOR, EXAMPLE));
  const at20 = BP.ranksFromOrder(WARRIOR, order, BP.pointsAvailable(20, 0));
  assert.equal(BP.totalOf(at20), 11);
  assert.equal(at20[105958], 3);
  assert.equal(at20[105938], 0, "Fureur pas encore commencé au niveau 20");
  const at41 = BP.ranksFromOrder(WARRIOR, order, BP.pointsAvailable(41, 0));
  assert.equal(at41[105938], 1);
});
