/*
 * Azeroth Forever : codec et règles du parcours de talents (?build= + ?path=).
 *
 * Logique pure, sans DOM. Utilisable dans le navigateur (window.WF.buildPath)
 * et sous Node (module.exports) pour les tests : tools/tests/build-path.test.mjs.
 * Spécification : packages/schema/BUILD_CODEC.md
 */
(function (root, factory) {
  var api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  if (root) {
    root.WF = root.WF || {};
    root.WF.buildPath = api;
  }
})(typeof window !== "undefined" ? window : null, function () {
  "use strict";

  var ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
  var PATH_VERSION = "1";
  var MAX_POINTS = 51;
  var MAX_LEVEL = 60;
  var DATA_BUILD = "1.60.1.69893";
  // Talentueux (Héritage) : seul l'effet du rang 1 est connu (1er point au niveau 9).
  // Les rangs 2 à 5 sont TBD : on ne leur prête aucun effet supplémentaire.
  var TALENTED_KNOWN_MAX = 1;
  var TALENTED_MAX_STORED = 7;

  /* ---------- Catalogue ---------- */

  // Catalogue stable d'une classe : les talents à plat, arbre par arbre, dans
  // l'ordre des données (= ordre de ?build=). L'index sert de caractère dans ?path=.
  function catalog(cls) {
    var entries = [];
    var byId = {};
    cls.trees.forEach(function (tree, treeIdx) {
      tree.talents.forEach(function (talent, talentIdx) {
        var entry = {
          index: entries.length,
          treeIdx: treeIdx,
          talentIdx: talentIdx,
          tree: tree,
          talent: talent
        };
        entries.push(entry);
        byId[talent.id] = entry;
      });
    });
    if (entries.length > ALPHABET.length) {
      throw new Error("Catalogue trop grand pour ?path= : " + entries.length + " talents");
    }
    return { cls: cls, entries: entries, byId: byId };
  }

  function emptyRanks(cat) {
    var ranks = {};
    cat.entries.forEach(function (e) { ranks[e.talent.id] = 0; });
    return ranks;
  }

  /* ---------- ?build= (format historique, inchangé) ---------- */

  // Même tolérance que l'ancien décodeur : caractère non numérique ignoré,
  // rang borné à [0, maxRank], bloc manquant = 0, caractères en trop ignorés.
  function parseBuild(cat, str) {
    var ranks = emptyRanks(cat);
    if (!str) return ranks;
    var blocks = String(str).split("-");
    cat.cls.trees.forEach(function (tree, treeIdx) {
      var chars = (blocks[treeIdx] || "").split("");
      tree.talents.forEach(function (talent, talentIdx) {
        var rank = parseInt(chars[talentIdx], 10);
        if (!isNaN(rank)) ranks[talent.id] = Math.max(0, Math.min(talent.maxRank, rank));
      });
    });
    return ranks;
  }

  function serializeBuild(cat, ranks) {
    return cat.cls.trees.map(function (tree) {
      return tree.talents.map(function (t) { return ranks[t.id] || 0; }).join("");
    }).join("-");
  }

  function totalOf(ranks) {
    var sum = 0;
    for (var id in ranks) sum += ranks[id] || 0;
    return sum;
  }

  function sameRanks(cat, a, b) {
    return cat.entries.every(function (e) {
      return (a[e.talent.id] || 0) === (b[e.talent.id] || 0);
    });
  }

  /* ---------- Niveaux ---------- */

  function effectiveTalented(talented) {
    var t = parseInt(talented, 10) || 0;
    return Math.max(0, Math.min(TALENTED_KNOWN_MAX, t));
  }

  // Niveau du premier point de talent : 10, ou 9 avec Talentueux rang 1.
  function firstLevel(talented) {
    return 10 - effectiveTalented(talented);
  }

  // Points disponibles à un niveau. Même base que l'affichage actuel du site
  // (niveau requis = 9 + points) : 1 point au niveau 10, 51 au niveau 60.
  function pointsAvailable(level, talented) {
    var lvl = parseInt(level, 10) || 0;
    var pts = lvl - (firstLevel(talented) - 1);
    return Math.max(0, Math.min(MAX_POINTS, pts));
  }

  // Niveau où l'on dépense le point numéro n (1 = premier point).
  function levelOfPoint(n, talented) {
    return Math.min(MAX_LEVEL, firstLevel(talented) - 1 + n);
  }

  /* ---------- ?path= ---------- */

  // Format : <version "1"><Talentueux 0-7><1 caractère par point>.
  function encodePath(cat, order, talented) {
    var t = Math.max(0, Math.min(TALENTED_MAX_STORED, parseInt(talented, 10) || 0));
    return PATH_VERSION + String(t) + order.map(function (idx) { return ALPHABET.charAt(idx); }).join("");
  }

  function decodePath(cat, str) {
    var result = { ok: false, talented: 0, order: [], error: "" };
    if (typeof str !== "string" || str.length < 2) {
      result.error = "Parcours vide ou tronqué.";
      return result;
    }
    if (str.charAt(0) !== PATH_VERSION) {
      result.error = "Version de parcours inconnue.";
      return result;
    }
    var t = str.charAt(1);
    if (!/^[0-7]$/.test(t)) {
      result.error = "En-tête de parcours invalide.";
      return result;
    }
    result.talented = parseInt(t, 10);
    var body = str.slice(2);
    if (body.length > MAX_POINTS) {
      result.error = "Parcours trop long (plus de 51 points).";
      return result;
    }
    for (var i = 0; i < body.length; i++) {
      var idx = ALPHABET.indexOf(body.charAt(i));
      if (idx < 0 || idx >= cat.entries.length) {
        result.error = "Caractère de parcours invalide.";
        result.order = [];
        return result;
      }
      result.order.push(idx);
    }
    result.ok = true;
    return result;
  }

  /* ---------- Règles ---------- */

  function tierNeeded(talent) {
    return 5 * talent.row;
  }

  function findInTree(tree, id) {
    for (var i = 0; i < tree.talents.length; i++) {
      if (tree.talents[i].id === id) return tree.talents[i];
    }
    return null;
  }

  // Vérifie qu'on peut acheter le prochain rang de `entry` dans l'état courant.
  // ranks : rangs déjà achetés ; treePts : points par arbre ; total : total dépensé.
  function checkStep(cat, entry, ranks, treePts, total) {
    if (!entry) return { ok: false, code: "unknown", message: "Talent inconnu dans ce parcours." };
    var talent = entry.talent;
    var current = ranks[talent.id] || 0;
    if (current >= talent.maxRank) {
      return { ok: false, code: "maxed", message: talent.name + " est déjà au rang maximum (" + talent.maxRank + ")." };
    }
    if (total >= MAX_POINTS) {
      return { ok: false, code: "cap", message: "Plafond de 51 points atteint." };
    }
    var reqs = talent.requires || [];
    for (var i = 0; i < reqs.length; i++) {
      if ((ranks[reqs[i].id] || 0) < reqs[i].qty) {
        var reqTalent = findInTree(entry.tree, reqs[i].id);
        return {
          ok: false,
          code: "prereq",
          message: talent.name + " nécessite " + (reqTalent ? reqTalent.name : "un autre talent") + " au rang " + reqs[i].qty + "."
        };
      }
    }
    var need = tierNeeded(talent);
    var have = treePts[entry.treeIdx] || 0;
    if (have < need) {
      return {
        ok: false,
        code: "tier",
        message: talent.name + " nécessite " + need + " points dans l'arbre " + entry.tree.name + " (" + have + " à ce moment du parcours)."
      };
    }
    return { ok: true };
  }

  // Rejoue un ordre. Renvoie { ok, step (index 0 de l'étape fautive), code, message }.
  function validateOrder(cat, order) {
    var ranks = emptyRanks(cat);
    var treePts = cat.cls.trees.map(function () { return 0; });
    var total = 0;
    for (var i = 0; i < order.length; i++) {
      var entry = cat.entries[order[i]];
      var check = checkStep(cat, entry, ranks, treePts, total);
      if (!check.ok) {
        return { ok: false, step: i, code: check.code, message: check.message, level: i + 1 };
      }
      ranks[entry.talent.id] += 1;
      treePts[entry.treeIdx] += 1;
      total += 1;
    }
    return { ok: true, step: -1 };
  }

  // Rangs obtenus après les `count` premiers points de l'ordre (tous si omis).
  function ranksFromOrder(cat, order, count) {
    var ranks = emptyRanks(cat);
    var n = count === undefined ? order.length : Math.max(0, Math.min(order.length, count));
    for (var i = 0; i < n; i++) {
      var entry = cat.entries[order[i]];
      if (entry) ranks[entry.talent.id] += 1;
    }
    return ranks;
  }

  // Ordre automatique déterministe (Mode Fin) :
  // arbre par arbre dans l'ordre de l'UI, on termine un arbre avant le suivant ;
  // dans un arbre, rangée par rangée, gauche à droite ; les prérequis passent
  // avant le talent qui en dépend ; chaque talent est monté jusqu'à son rang final.
  function autoOrder(cat, ranks) {
    var order = [];
    var placed = {};

    function place(entry, guard) {
      var talent = entry.talent;
      if (placed[talent.id] || guard[talent.id]) return;
      var target = ranks[talent.id] || 0;
      if (target <= 0) return;
      guard[talent.id] = true;
      (talent.requires || []).forEach(function (req) {
        var reqEntry = cat.byId[req.id];
        if (reqEntry && reqEntry.treeIdx === entry.treeIdx) place(reqEntry, guard);
      });
      placed[talent.id] = true;
      for (var r = 0; r < target; r++) order.push(entry.index);
    }

    cat.entries.forEach(function (entry) { place(entry, {}); });
    return order;
  }

  /* ---------- Opérations d'édition ---------- */

  // Mode Parcours : ajoute un rang de `index` à la fin de l'ordre.
  function append(cat, order, index) {
    var entry = cat.entries[index];
    var ranks = ranksFromOrder(cat, order);
    var treePts = cat.cls.trees.map(function () { return 0; });
    order.forEach(function (idx) { treePts[cat.entries[idx].treeIdx] += 1; });
    var check = checkStep(cat, entry, ranks, treePts, order.length);
    if (!check.ok) return { ok: false, order: order, code: check.code, message: check.message };
    return { ok: true, order: order.concat([index]) };
  }

  // Mode Parcours : retire le DERNIER rang de ce talent dans l'ordre
  // (pas forcément le dernier point global). Refusé si l'ordre devient invalide.
  function removeLastOf(cat, order, index) {
    var pos = order.lastIndexOf(index);
    if (pos < 0) return { ok: false, order: order, code: "empty", message: "" };
    var next = order.slice(0, pos).concat(order.slice(pos + 1));
    var wasValid = validateOrder(cat, order).ok;
    var check = validateOrder(cat, next);
    if (wasValid && !check.ok) {
      var talent = cat.entries[index].talent;
      return {
        ok: false,
        order: order,
        code: check.code,
        message: "Impossible de retirer " + talent.name + " : " + lowerFirst(check.message)
      };
    }
    return { ok: true, order: next };
  }

  // Retire tous les points d'un arbre en gardant l'ordre relatif des autres.
  function withoutTree(cat, order, treeIdx) {
    return order.filter(function (idx) { return cat.entries[idx].treeIdx !== treeIdx; });
  }

  function lowerFirst(s) {
    return s ? s.charAt(0).toLowerCase() + s.slice(1) : s;
  }

  /* ---------- Chargement depuis l'URL ---------- */

  // Règles : build gagne. path absent = ordre auto sans message.
  // path corrompu, invalide ou en conflit avec build = ordre auto + recalculated.
  function resolve(cat, buildStr, pathStr) {
    var hasBuild = typeof buildStr === "string" && buildStr !== "";
    var hasPath = typeof pathStr === "string" && pathStr !== "";
    var ranks = parseBuild(cat, hasBuild ? buildStr : "");
    var out = { ranks: ranks, order: null, talented: 0, recalculated: false, reason: "" };

    if (hasPath) {
      var decoded = decodePath(cat, pathStr);
      out.talented = decoded.talented;
      if (!decoded.ok) {
        out.recalculated = true;
        out.reason = "corrupt";
      } else {
        var fromPath = ranksFromOrder(cat, decoded.order);
        var valid = validateOrder(cat, decoded.order).ok;
        if (!hasBuild && valid) {
          out.ranks = fromPath;
          out.order = decoded.order;
        } else if (!sameRanks(cat, fromPath, ranks)) {
          out.recalculated = true;
          out.reason = "conflict";
        } else if (!valid) {
          out.recalculated = true;
          out.reason = "invalid";
        } else {
          out.order = decoded.order;
        }
      }
    }
    if (!out.order) out.order = autoOrder(cat, out.ranks);
    return out;
  }

  // Lignes de la liste « Parcours de montée ».
  function steps(cat, order, talented) {
    var ranks = emptyRanks(cat);
    return order.map(function (idx, i) {
      var entry = cat.entries[idx];
      ranks[entry.talent.id] += 1;
      return {
        n: i + 1,
        level: levelOfPoint(i + 1, talented),
        treeIdx: entry.treeIdx,
        treeName: entry.tree.name,
        talentId: entry.talent.id,
        talentName: entry.talent.name,
        rank: ranks[entry.talent.id],
        maxRank: entry.talent.maxRank
      };
    });
  }

  return {
    ALPHABET: ALPHABET,
    PATH_VERSION: PATH_VERSION,
    MAX_POINTS: MAX_POINTS,
    MAX_LEVEL: MAX_LEVEL,
    DATA_BUILD: DATA_BUILD,
    TALENTED_KNOWN_MAX: TALENTED_KNOWN_MAX,
    catalog: catalog,
    emptyRanks: emptyRanks,
    parseBuild: parseBuild,
    serializeBuild: serializeBuild,
    totalOf: totalOf,
    sameRanks: sameRanks,
    effectiveTalented: effectiveTalented,
    firstLevel: firstLevel,
    pointsAvailable: pointsAvailable,
    levelOfPoint: levelOfPoint,
    encodePath: encodePath,
    decodePath: decodePath,
    validateOrder: validateOrder,
    ranksFromOrder: ranksFromOrder,
    autoOrder: autoOrder,
    append: append,
    removeLastOf: removeLastOf,
    withoutTree: withoutTree,
    resolve: resolve,
    steps: steps
  };
});
