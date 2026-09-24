// Tests du code de partage AF1- (Phase 2).
// Lancer depuis la racine du site :  node --test "tools/tests/*.test.mjs"
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
const SC = require(path.join(root, "js", "share-code.js"));
const sandbox = { window: {} };
vm.runInNewContext(readFileSync(path.join(root, "js", "talents-data.js"), "utf8"), sandbox);
const CLASSES = sandbox.window.TALENTS_FR;
const EXAMPLE = "35325213132100000-555500000000000000-000000000000000000";

function prng(seed) {
  let s = seed >>> 0;
  return () => ((s = (s * 1664525 + 1013904223) >>> 0) / 4294967296);
}

test("CRC-8 (poly 0x07, init 0) : valeur de référence", () => {
  assert.equal(SC.crc8("123456789"), 0xf4); // CRC-8/SMBUS check value
});

test("exemple Guerrier 31/20/0 : code stable et relu à l'identique", () => {
  const cls = CLASSES.find((c) => c.slug === "guerrier");
  const cat = BP.catalog(cls);
  const p = BP.encodePath(cat, BP.autoOrder(cat, BP.parseBuild(cat, EXAMPLE)), 0);
  const code = SC.encode(cls, p);
  assert.match(code, /^AF1-CB10[A-Za-z0-9_-]{51}-[0-9A-F]{2}$/);
  const back = SC.decode(code, CLASSES);
  assert.ok(back.ok, back.error);
  assert.equal(back.slug, "guerrier");
  assert.equal(back.build, EXAMPLE);
  assert.equal(back.path, p);
  // tolérance : espaces, retours à la ligne, préfixe en minuscules
  assert.ok(SC.decode("  af1-" + code.slice(4, 30) + "\n" + code.slice(30) + " ", CLASSES).ok);
});

test("9 classes : encode -> decode -> égalité (build + path), ordres manuels compris", () => {
  for (const cls of CLASSES) {
    const cat = BP.catalog(cls);
    const rnd = prng(cls.id * 31);
    for (let k = 0; k < 40; k++) {
      let order = [];
      const target = Math.floor(rnd() * 52);
      for (let g = 0; g < 4000 && order.length < target; g++) {
        const r = BP.append(cat, order, Math.floor(rnd() * cat.entries.length));
        if (r.ok) order = r.order;
      }
      const p = BP.encodePath(cat, order, 0);
      const code = SC.encode(cls, p);
      const back = SC.decode(code, CLASSES);
      assert.ok(back.ok, cls.slug + " " + code + " " + back.error);
      assert.equal(back.slug, cls.slug);
      assert.equal(back.path, p);
      assert.equal(back.build, BP.serializeBuild(cat, BP.ranksFromOrder(cat, order)));
    }
  }
});

test("checksum : toute faute de frappe d'un caractère est détectée", () => {
  const cls = CLASSES.find((c) => c.slug === "druide");
  const cat = BP.catalog(cls);
  const rnd = prng(5);
  let order = [];
  for (let g = 0; g < 4000 && order.length < 40; g++) {
    const r = BP.append(cat, order, Math.floor(rnd() * cat.entries.length));
    if (r.ok) order = r.order;
  }
  const code = SC.encode(cls, BP.encodePath(cat, order, 0));
  const alphabet = BP.ALPHABET + "ABCDEF";
  let tried = 0;
  for (let i = 4; i < code.length; i++) {
    if (code[i] === "-" && i === code.length - 3) continue;
    for (const ch of alphabet) {
      if (ch === code[i]) continue;
      // le checksum est en hexadécimal, insensible à la casse : « f3 » = « F3 »
      if (i >= code.length - 2 && ch.toUpperCase() === code[i].toUpperCase()) continue;
      const bad = code.slice(0, i) + ch + code.slice(i + 1);
      tried++;
      assert.equal(SC.decode(bad, CLASSES).ok, false, "faute non détectée : " + bad);
    }
  }
  assert.ok(tried > 1000);
});

test("codes refusés avec un message clair", () => {
  const msg = (c) => SC.decode(c, CLASSES).error;
  assert.match(msg(""), /AF1-/);
  assert.match(msg("hello"), /doit commencer par AF1-/);
  assert.match(msg("AF1H-xyz-00"), /Héritage/);
  assert.match(msg("AF1-CB10AAA"), /incomplet/);
  assert.match(msg("AF1-CB10AAA-00"), /abîmé/);
  // classe inconnue (id 6 = Chevalier de la mort, absent) avec un checksum correct
  const payload = "C" + BP.ALPHABET[6] + "10";
  assert.match(msg("AF1-" + payload + "-" + SC.crc8(payload).toString(16).toUpperCase().padStart(2, "0")), /Classe inconnue/);
  // ordre impossible (Charge améliorée sans palier) avec un checksum correct
  const cat = BP.catalog(CLASSES[0]);
  const bad = "CB10" + BP.ALPHABET[cat.byId[105955].index];
  assert.match(msg("AF1-" + bad + "-" + SC.crc8(bad).toString(16).toUpperCase().padStart(2, "0")), /ordre impossible/);
});
