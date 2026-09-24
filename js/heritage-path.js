/*
 * Azeroth Forever : règles et code de partage de l'arbre d'Héritage (Phase 3).
 *
 * Logique pure, sans DOM : window.WF.heritagePath / module.exports.
 * Spécification : packages/schema/BUILD_CODEC.md, section 11.
 *
 *  - ?hbuild= : format historique inchangé (3 blocs, 1 chiffre par nœud).
 *  - Pas de ?path= pour l'héritage : l'ordre des points (pour le curseur 0-16)
 *    est toujours calculé automatiquement à partir des rangs.
 *  - Code : AF1H-1<rangs>-<crc> (21 chiffres, même ordre que ?hbuild=).
 */
(function (root, factory) {
  var sc = (root && root.WF && root.WF.shareCode) ||
    (typeof module === "object" && module.exports && typeof require === "function" ? require("./share-code.js") : null);
  var api = factory(sc);
  if (typeof module === "object" && module.exports) module.exports = api;
  if (root) {
    root.WF = root.WF || {};
    root.WF.heritagePath = api;
  }
})(typeof window !== "undefined" ? window : null, function (SC) {
  "use strict";

  var MAX_POINTS = 16;
  var CODE_VERSION = "1";
  var PREFIX = "AF1H-";

  /* ---------- Catalogue ---------- */

  function catalog(trees) {
    var entries = [];
    var byKey = {};
    trees.forEach(function (tree, treeIdx) {
      tree.nodes.forEach(function (node) {
        if (node.placeholder) return;
        var entry = { index: entries.length, treeIdx: treeIdx, tree: tree, node: node, key: tree.id + "__" + node.id };
        entries.push(entry);
        byKey[entry.key] = entry;
      });
    });
    return { trees: trees, entries: entries, byKey: byKey };
  }

  function emptyRanks(cat) {
    var ranks = {};
    cat.entries.forEach(function (e) { ranks[e.key] = 0; });
    return ranks;
  }

  function totalOf(ranks) {
    var sum = 0;
    for (var k in ranks) sum += ranks[k] || 0;
    return sum;
  }

  /* ---------- ?hbuild= (inchangé) ---------- */

  function parseHbuild(cat, str) {
    var ranks = emptyRanks(cat);
    if (!str) return ranks;
    var blocks = String(str).split("-");
    cat.trees.forEach(function (tree, treeIdx) {
      var chars = (blocks[treeIdx] || "").split("");
      var nodeIdx = 0;
      tree.nodes.forEach(function (node) {
        if (node.placeholder) return;
        var rank = parseInt(chars[nodeIdx], 10);
        if (!isNaN(rank)) ranks[tree.id + "__" + node.id] = Math.max(0, Math.min(node.maxRank, rank));
        nodeIdx++;
      });
    });
    return ranks;
  }

  function serializeHbuild(cat, ranks) {
    return cat.trees.map(function (tree) {
      return tree.nodes.filter(function (n) { return !n.placeholder; }).map(function (node) {
        return ranks[tree.id + "__" + node.id] || 0;
      }).join("");
    }).join("-");
  }

  /* ---------- Ordre automatique (curseur 0-16) ---------- */

  // Arbre par arbre (ordre de l'UI) ; dans un arbre, on prend le premier nœud
  // disponible par palier puis rangée puis colonne, et on le monte jusqu'à son
  // rang final. Si un build ne peut pas être monté point par point (paliers),
  // les points restants sont ajoutés dans le même ordre (affichage seulement).
  function autoOrder(cat, ranks) {
    var order = [];
    var acquirable = true;
    cat.trees.forEach(function (tree, treeIdx) {
      var todo = cat.entries.filter(function (e) { return e.treeIdx === treeIdx && (ranks[e.key] || 0) > 0; });
      todo.sort(function (a, b) {
        return (a.node.tier || 0) - (b.node.tier || 0) || a.node.row - b.node.row || a.node.col - b.node.col || a.index - b.index;
      });
      var spent = 0;
      while (todo.length) {
        var pick = -1;
        for (var i = 0; i < todo.length; i++) {
          if (!todo[i].node.tier || spent >= todo[i].node.tier) { pick = i; break; }
        }
        if (pick < 0) {
          acquirable = false;
          pick = 0;
        }
        var entry = todo.splice(pick, 1)[0];
        for (var r = 0; r < ranks[entry.key]; r++) {
          order.push(entry.index);
          spent++;
        }
      }
    });
    return { order: order, acquirable: acquirable && order.length <= MAX_POINTS };
  }

  function ranksAt(cat, order, count) {
    var ranks = emptyRanks(cat);
    var n = count === undefined ? order.length : Math.max(0, Math.min(order.length, count));
    for (var i = 0; i < n; i++) ranks[cat.entries[order[i]].key] += 1;
    return ranks;
  }

  /* ---------- Code AF1H- ---------- */

  function crc(text) {
    return SC.hex2(SC.crc8(text));
  }

  function encode(cat, ranks) {
    var payload = CODE_VERSION + cat.entries.map(function (e) { return ranks[e.key] || 0; }).join("");
    return PREFIX + payload + "-" + crc(payload);
  }

  // Renvoie { ok, ranks, hbuild } ou { ok:false, error } (message en français).
  function decode(input, cat) {
    var fail = function (msg) { return { ok: false, error: msg }; };
    var info = SC.inspect(input);
    if (!info.ok) return info;
    if (info.kind !== "H") return fail("C'est un code de classe (AF1-), pas un code d'Héritage.");
    var payload = info.payload;
    if (payload.charAt(0) !== CODE_VERSION) return fail("Version de code d'Héritage inconnue : mettez le site à jour.");
    var digits = payload.slice(1);
    if (digits.length !== cat.entries.length || !/^[0-9]+$/.test(digits)) {
      return fail("Code d'Héritage illisible (" + digits.length + " rangs au lieu de " + cat.entries.length + ").");
    }
    var ranks = emptyRanks(cat);
    for (var i = 0; i < cat.entries.length; i++) {
      var entry = cat.entries[i];
      var rank = parseInt(digits.charAt(i), 10);
      if (rank > entry.node.maxRank) {
        return fail(entry.node.name + " ne peut pas dépasser le rang " + entry.node.maxRank + ".");
      }
      ranks[entry.key] = rank;
    }
    if (totalOf(ranks) > MAX_POINTS) return fail("Ce code dépense plus de " + MAX_POINTS + " points d'Héritage.");
    if (!autoOrder(cat, ranks).acquirable) return fail("Ce code ne respecte pas les paliers de points de l'arbre.");
    return { ok: true, ranks: ranks, hbuild: serializeHbuild(cat, ranks) };
  }

  return {
    MAX_POINTS: MAX_POINTS,
    PREFIX: PREFIX,
    catalog: catalog,
    emptyRanks: emptyRanks,
    totalOf: totalOf,
    parseHbuild: parseHbuild,
    serializeHbuild: serializeHbuild,
    autoOrder: autoOrder,
    ranksAt: ranksAt,
    encode: encode,
    decode: decode
  };
});
