// Tests de l'arbre d'Héritage (Phase 3) : ?hbuild=, ordre auto, code AF1H-, presets.
// Lancer depuis la racine du site :  node --test "tools/tests/*.test.mjs"
import { test } from "node:test";
import assert from "node:assert/strict";
import { createRequire } from "node:module";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, "..", "..");
const require = createRequire(import.meta.url);
const HP = require(path.join(root, "js", "heritage-path.js"));
const SC = require(path.join(root, "js", "share-code.js"));
const DATA = require(path.join(root, "js", "heritage-data.js"));
const CAT = HP.catalog(DATA.trees);
const HOME_EXAMPLE = "5200000-0200000-0200000"; // lien de la page d'accueil

function prng(seed) {
  let s = seed >>> 0;
  return () => ((s = (s * 1664525 + 1013904223) >>> 0) / 4294967296);
}
// Build légal aléatoire, construit point par point avec les règles du calculateur.
function randomLegal(rnd, points) {
  const ranks = HP.emptyRanks(CAT);
  for (let g = 0; g < 3000 && HP.totalOf(ranks) < points; g++) {
    const e = CAT.entries[Math.floor(rnd() * CAT.entries.length)];
    const tp = CAT.entries.filter((x) => x.treeIdx === e.treeIdx).reduce((s, x) => s + ranks[x.key], 0);
    if (ranks[e.key] < e.node.maxRank && (!e.node.tier || tp >= e.node.tier)) ranks[e.key]++;
  }
  return ranks;
}

test("catalogue : 21 nœuds (7 par arbre), ordre de ?hbuild=", () => {
  assert.equal(CAT.entries.length, 21);
  assert.deepEqual(DATA.trees.map((t) => t.nodes.filter((n) => !n.placeholder).length), [7, 7, 7]);
  assert.equal(CAT.entries[0].node.name, "Travail acharné");
  assert.equal(CAT.byKey["aventure__talentueux"].node.name, "Talentueux");
});

test("?hbuild= historique : lecture tolérante et réécriture identique", () => {
  const r = HP.parseHbuild(CAT, HOME_EXAMPLE);
  assert.equal(r["metiers__travail-acharne"], 5);
  assert.equal(r["metiers__marchandage"], 2);
  assert.equal(r["aventure__bien-repose"], 2);
  assert.equal(r["ingeniosite__gourmet"], 2);
  assert.equal(HP.serializeHbuild(CAT, r), HOME_EXAMPLE);
  assert.equal(HP.serializeHbuild(CAT, HP.parseHbuild(CAT, "9x5")), "5050000-0000000-0000000");
});

test("ordre auto : arbre par arbre, paliers respectés, curseur à N points", () => {
  const r = HP.parseHbuild(CAT, HOME_EXAMPLE);
  const { order, acquirable } = HP.autoOrder(CAT, r);
  assert.ok(acquirable);
  assert.equal(order.length, 11);
  assert.equal(CAT.entries[order[0]].node.name, "Travail acharné");
  assert.equal(CAT.entries[order[5]].node.name, "Marchandage"); // palier 5 atteint
  const at6 = HP.ranksAt(CAT, order, 6);
  assert.equal(at6["metiers__marchandage"], 1);
  assert.equal(at6["aventure__bien-repose"], 0);
  assert.deepEqual(HP.ranksAt(CAT, order, 16), r);
});

test("build aux paliers impossibles : signalé non montable, affiché quand même", () => {
  // 2 points au palier 0 + 3 au palier 5 : le calculateur historique peut y arriver par retraits.
  const r = HP.parseHbuild(CAT, "2000030-0000000-0000000");
  const res = HP.autoOrder(CAT, r);
  assert.equal(res.acquirable, false);
  assert.equal(res.order.length, 5);
});

test("code AF1H- : exemple réel et aller-retour", () => {
  const r = HP.parseHbuild(CAT, HOME_EXAMPLE);
  const code = HP.encode(CAT, r);
  assert.match(code, /^AF1H-1[0-9]{21}-[0-9A-F]{2}$/);
  const back = HP.decode(code, CAT);
  assert.ok(back.ok, back.error);
  assert.equal(back.hbuild, HOME_EXAMPLE);
  assert.ok(HP.decode(" af1h-" + code.slice(5, 15) + "\n" + code.slice(15) + " ", CAT).ok);
  const rnd = prng(3);
  for (let k = 0; k < 200; k++) {
    const rr = randomLegal(rnd, Math.floor(rnd() * 17));
    const c = HP.encode(CAT, rr);
    const b = HP.decode(c, CAT);
    assert.ok(b.ok, c + " " + b.error);
    assert.deepEqual(b.ranks, rr);
  }
});

test("code AF1H- : fautes de frappe détectées, refus clairs", () => {
  const code = HP.encode(CAT, HP.parseHbuild(CAT, HOME_EXAMPLE));
  for (let i = 5; i < code.length; i++) {
    for (const ch of "0123456789ABCDEF") {
      if (ch === code[i]) continue;
      if (i >= code.length - 2 && ch.toUpperCase() === code[i].toUpperCase()) continue;
      const bad = code.slice(0, i) + ch + code.slice(i + 1);
      assert.equal(HP.decode(bad, CAT).ok, false, bad);
    }
  }
  const withCrc = (payload) => "AF1H-" + payload + "-" + SC.hex2(SC.crc8(payload));
  assert.match(HP.decode(withCrc("1" + "9".repeat(21)), CAT).error, /rang/);
  assert.match(HP.decode(withCrc("1" + "5050500" + "0500000" + "0000000"), CAT).error, /plus de 16/);
  assert.match(HP.decode(withCrc("1200003" + "0".repeat(15)), CAT).error, /paliers/);
  assert.match(HP.decode(withCrc("2" + "0".repeat(21)), CAT).error, /Version/);
  assert.match(HP.decode(withCrc("1000"), CAT).error, /illisible/);
  assert.match(HP.decode("AF1-CB10-" + SC.hex2(SC.crc8("CB10")), CAT).error, /code de classe/);
});

test("routage : AF1- et AF1H- reconnus sans données de jeu", () => {
  const h = SC.inspect(HP.encode(CAT, HP.parseHbuild(CAT, HOME_EXAMPLE)));
  assert.equal(h.kind, "H");
  const c = SC.inspect("AF1-CB10AAABBBBBCCCDDEEEEEFFGHHHIJJJKKLRRRRRSSSSSTTTTTUUUUU-A7");
  assert.equal(c.kind, "C");
  assert.equal(c.slug, "guerrier");
  assert.match(SC.inspect("AF1-CB10AAABBBBB-00").error, /abîmé/);
});

test("presets : 3 presets, noms de nœuds réels, 16 points, paliers respectés", () => {
  assert.deepEqual(DATA.presets.map((p) => p.name), ["Premier perso leveling", "Métiers", "Qualité de vie niveau 60"]);
  for (const p of DATA.presets) {
    const ranks = HP.emptyRanks(CAT);
    for (const [k, v] of Object.entries(p.ranks)) {
      assert.ok(CAT.byKey[k], p.name + " : nœud inconnu " + k);
      assert.ok(v >= 1 && v <= CAT.byKey[k].node.maxRank, p.name + " : rang " + k);
      ranks[k] = v;
    }
    assert.equal(HP.totalOf(ranks), 16, p.name);
    assert.ok(HP.autoOrder(CAT, ranks).acquirable, p.name + " montable point par point");
    assert.ok(HP.decode(HP.encode(CAT, ranks), CAT).ok);
  }
  assert.equal(DATA.presets[0].ranks["aventure__talentueux"], 1, "Talentueux : seul le rang 1 est connu");
});
