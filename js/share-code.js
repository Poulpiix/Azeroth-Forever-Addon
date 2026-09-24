/*
 * Azeroth Forever : code de partage « AF1- » (classe).
 *
 * Format (voir packages/schema/BUILD_CODEC.md, section 9) :
 *   AF1-C<classe><path>-<crc>
 *   - « AF1- »  : préfixe, version 1 du code
 *   - « C »     : type (C = build de classe ; H = héritage et X = combo plus tard)
 *   - <classe>  : 1 caractère, ALPHABET[id de classe WoW] (Guerrier 1 = « B »)
 *   - <path>    : exactement la valeur de ?path= (version, Talentueux, 1 caractère par point)
 *   - <crc>     : CRC-8 (polynôme 0x07, init 0x00) du texte « C<classe><path> », 2 chiffres hexa
 *
 * Logique pure, sans DOM : window.WF.shareCode dans le navigateur, module.exports sous Node.
 * Dépend de build-path.js (ALPHABET, catalogue, validation).
 */
(function (root, factory) {
  var bp = (root && root.WF && root.WF.buildPath) ||
    (typeof module === "object" && module.exports && typeof require === "function" ? require("./build-path.js") : null);
  var api = factory(bp);
  if (typeof module === "object" && module.exports) module.exports = api;
  if (root) {
    root.WF = root.WF || {};
    root.WF.shareCode = api;
  }
})(typeof window !== "undefined" ? window : null, function (BP) {
  "use strict";

  var PREFIX = "AF1-";
  var PREFIX_HERITAGE = "AF1H-";
  var KIND_CLASS = "C";

  // Id de classe WoW -> page du site. Sert à router un code AF1- collé sur une page
  // qui n'a pas les données de talents (ex. /arbre-heritage).
  var CLASS_SLUGS = { 1: "guerrier", 2: "paladin", 3: "chasseur", 4: "voleur", 5: "pretre", 7: "chaman", 8: "mage", 9: "demoniste", 11: "druide" };

  function crc8(text) {
    var crc = 0;
    for (var i = 0; i < text.length; i++) {
      crc ^= text.charCodeAt(i) & 0xff;
      for (var b = 0; b < 8; b++) {
        crc = crc & 0x80 ? ((crc << 1) ^ 0x07) & 0xff : (crc << 1) & 0xff;
      }
    }
    return crc;
  }

  function hex2(n) {
    var h = n.toString(16).toUpperCase();
    return h.length < 2 ? "0" + h : h;
  }

  function classChar(cls) {
    return BP.ALPHABET.charAt(cls.id);
  }

  // Contrôle rapide d'un code collé, sans données de jeu : préfixe, checksum, type.
  // Renvoie { ok, kind: "C"|"H", code (forme canonique), slug (classe) } ou { ok:false, error }.
  function inspect(input) {
    var fail = function (msg) { return { ok: false, error: msg }; };
    var code = String(input || "").replace(/\s+/g, "");
    if (!code) return fail("Collez un code qui commence par AF1- (classe) ou AF1H- (héritage).");
    var kind = null;
    var rest = "";
    if (code.slice(0, PREFIX_HERITAGE.length).toUpperCase() === PREFIX_HERITAGE) {
      kind = "H";
      rest = code.slice(PREFIX_HERITAGE.length);
    } else if (code.slice(0, PREFIX.length).toUpperCase() === PREFIX) {
      kind = "C";
      rest = code.slice(PREFIX.length);
    } else {
      return fail("Ce n'est pas un code Azeroth Forever : il doit commencer par AF1- ou AF1H-.");
    }
    var m = /^(.+)-([0-9A-Fa-f]{2})$/.exec(rest);
    if (!m) return fail("Code incomplet : recopiez-le en entier, jusqu'aux 2 derniers caractères.");
    if (hex2(crc8(m[1])) !== m[2].toUpperCase()) {
      return fail("Code abîmé (somme de contrôle fausse) : recopiez-le en entier.");
    }
    var out = { ok: true, kind: kind, code: (kind === "H" ? PREFIX_HERITAGE : PREFIX) + m[1] + "-" + m[2].toUpperCase(), payload: m[1] };
    if (kind === "C") {
      if (m[1].charAt(0) !== KIND_CLASS) return fail("Type de code inconnu.");
      out.slug = CLASS_SLUGS[BP.ALPHABET.indexOf(m[1].charAt(1))];
      if (!out.slug) return fail("Classe inconnue dans ce code.");
    }
    return out;
  }

  // cls : entrée de TALENTS_FR ; path : valeur de ?path= (déjà validée).
  function encode(cls, path) {
    var payload = KIND_CLASS + classChar(cls) + path;
    return PREFIX + payload + "-" + hex2(crc8(payload));
  }

  // Relit un code collé. classes : window.TALENTS_FR.
  // Renvoie { ok, slug, cls, build, path } ou { ok:false, error } (message en français).
  function decode(input, classes) {
    var fail = function (msg) { return { ok: false, error: msg }; };
    var code = String(input || "").replace(/\s+/g, "");
    if (!code) return fail("Collez un code qui commence par AF1-.");
    if (/^AF1H-/i.test(code)) return fail("C'est un code d'Héritage : il n'est pas encore pris en charge ici.");
    if (code.slice(0, PREFIX.length).toUpperCase() !== PREFIX) {
      return fail("Ce n'est pas un code Azeroth Forever : il doit commencer par AF1-.");
    }
    var rest = code.slice(PREFIX.length);
    var m = /^(.+)-([0-9A-Fa-f]{2})$/.exec(rest);
    if (!m) return fail("Code incomplet : recopiez-le en entier, jusqu'aux 2 derniers caractères.");
    var payload = m[1];
    if (hex2(crc8(payload)) !== m[2].toUpperCase()) {
      return fail("Code abîmé (somme de contrôle fausse) : recopiez-le en entier.");
    }
    if (payload.charAt(0) !== KIND_CLASS) return fail("Type de code inconnu.");
    var classId = BP.ALPHABET.indexOf(payload.charAt(1));
    var cls = null;
    for (var i = 0; i < (classes || []).length; i++) {
      if (classes[i].id === classId) cls = classes[i];
    }
    if (!cls) return fail("Classe inconnue dans ce code.");
    var path = payload.slice(2);
    var cat = BP.catalog(cls);
    var decoded = BP.decodePath(cat, path);
    if (!decoded.ok) return fail("Parcours illisible dans ce code (" + decoded.error.charAt(0).toLowerCase() + decoded.error.slice(1) + ")");
    var check = BP.validateOrder(cat, decoded.order);
    if (!check.ok) return fail("Ce code décrit un ordre impossible (étape " + (check.step + 1) + ") : " + check.message);
    return {
      ok: true,
      slug: cls.slug,
      cls: cls,
      path: path,
      build: BP.serializeBuild(cat, BP.ranksFromOrder(cat, decoded.order)),
      talented: decoded.talented
    };
  }

  return {
    PREFIX: PREFIX,
    PREFIX_HERITAGE: PREFIX_HERITAGE,
    CLASS_SLUGS: CLASS_SLUGS,
    crc8: crc8,
    hex2: hex2,
    inspect: inspect,
    encode: encode,
    decode: decode
  };
});
