/*
 * Azeroth Forever : calculateur de l'arbre d'Héritage.
 *
 * Version lisible de l'ancien heritage-calculator.js minifié (v2), puis Phase 3 :
 * curseur « points dépensés » 0-16, presets, partage (lien, code AF1H-, coller un code).
 *
 * Données : js/heritage-data.js (window.HERITAGE_FR). Règles et code : js/heritage-path.js.
 * state.ranks = rangs FINAUX (ce que ?hbuild= enregistre). Le curseur ne change que l'affichage.
 */
window.WF = window.WF || {};

(function () {
  "use strict";

  var MAX_POINTS = 16;
  var ICON_MEDIUM = "https://wow.zamimg.com/images/wow/icons/medium/";
  var ICON_UNKNOWN = "inv_misc_questionmark";
  var URL_PARAM = "hbuild";

  var TREES = (window.HERITAGE_FR && window.HERITAGE_FR.trees) || [];
  var PRESETS = (window.HERITAGE_FR && window.HERITAGE_FR.presets) || [];
  var TALENTED_KEY = "aventure__talentueux";

  function HP() {
    return window.WF.heritagePath;
  }

  var state = {
    ranks: {},
    level: MAX_POINTS,
    catalog: null
  };

  function realNodes(tree) {
    return tree.nodes.filter(function (node) { return !node.placeholder; });
  }

  function resetRanks() {
    state.ranks = {};
    TREES.forEach(function (tree) {
      realNodes(tree).forEach(function (node) {
        state.ranks[tree.id + "__" + node.id] = 0;
      });
    });
  }

  function key(tree, node) {
    return tree.id + "__" + node.id;
  }

  function totalPoints() {
    var sum = 0;
    for (var k in state.ranks) sum += state.ranks[k];
    return sum;
  }

  function treePoints(tree) {
    var sum = 0;
    realNodes(tree).forEach(function (node) {
      sum += state.ranks[key(tree, node)] || 0;
    });
    return sum;
  }

  function tierUnlocked(tree, node) {
    return !node.tier || treePoints(tree) >= node.tier;
  }

  var initialized = false;

  function changeRank(tree, node, delta) {
    var k = key(tree, node);
    var current = state.ranks[k] || 0;
    if (delta > 0) {
      if (current >= node.maxRank) return;
      if (totalPoints() >= 16) return;
      if (!tierUnlocked(tree, node)) return;
      state.ranks[k] = current + 1;
    } else {
      if (current <= 0) return;
      var next = current - 1;
      var remaining = treePoints(tree) - 1;
      var breaksTier = realNodes(tree).some(function (other) {
        var rank = other.id === node.id ? next : state.ranks[key(tree, other)] || 0;
        return rank > 0 && other.tier > 0 && remaining < other.tier;
      });
      if (breaksTier) return void flashRefused(k);
      state.ranks[k] = next;
    }
    scheduleRender();
  }

  function flashRefused(k) {
    var el = document.querySelector('.talent[data-id="' + k + '"]');
    if (!el) return;
    el.style.borderColor = "#e0605a";
    setTimeout(function () {
      scheduleRender();
    }, 220);
  }

  function loadFromUrl() {
    var value = new URL(window.location.href).searchParams.get(URL_PARAM);
    if (!value) return;
    var blocks = value.split("-");
    TREES.forEach(function (tree, treeIdx) {
      var chars = (blocks[treeIdx] || "").split("");
      realNodes(tree).forEach(function (node, nodeIdx) {
        var rank = parseInt(chars[nodeIdx], 10);
        if (!isNaN(rank)) state.ranks[key(tree, node)] = Math.max(0, Math.min(node.maxRank, rank));
      });
    });
  }

  function buildTrees() {
    var host = document.querySelector("[data-heritage-trees]");
    if (!host) return;
    host.innerHTML = "";
    TREES.forEach(function (tree, treeIdx) {
      var treeEl = document.createElement("div");
      treeEl.className = "tree";
      treeEl.dataset.treeIdx = treeIdx;
      var maxRow = Math.max.apply(null, tree.nodes.map(function (n) { return n.row; }));
      treeEl.innerHTML =
        '<div class="tree-head"><img src="' + ICON_MEDIUM + tree.icon + '.jpg" alt=""><h2>' + tree.name + '</h2>' +
        '<span class="count" data-tree-count></span>' +
        '<button class="btn ghost tree-reset" type="button" data-tree-reset title="Réinitialiser cet arbre" aria-label="Réinitialiser l\'arbre ' + tree.name + '">' +
        '<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true" focusable="false">' +
        '<path fill="currentColor" d="M12 5V2L7 6l5 4V7a5 5 0 1 1-5 5H5a7 7 0 1 0 7-7z"/></svg></button></div>' +
        '<div class="tree-bar"><span data-tree-bar></span></div>' +
        '<p class="tree-desc">' + tree.desc + '</p>' +
        '<div class="tree-grid-wrap"><div class="tree-grid" style="grid-template-rows:repeat(' + (maxRow + 1) + ',56px)"></div></div>';
      host.appendChild(treeEl);
      var grid = treeEl.querySelector(".tree-grid");
      tree.nodes.forEach(function (node) {
        grid.appendChild(createCell(tree, node));
      });
      treeEl.querySelector("[data-tree-reset]").addEventListener("click", function () {
        realNodes(tree).forEach(function (node) { state.ranks[key(tree, node)] = 0; });
        scheduleRender();
      });
    });
    if (!document.querySelector(".ttip")) {
      var tip = document.createElement("div");
      tip.className = "ttip";
      document.body.appendChild(tip);
    }
  }

  function createCell(tree, node) {
    var cell = document.createElement("div");
    cell.className = "talent" + (node.placeholder ? " placeholder locked" : "");
    if (node.id) cell.dataset.id = key(tree, node);
    cell.style.gridColumn = node.col + 1;
    cell.style.gridRow = node.row + 1;
    cell.innerHTML = '<img src="' + ICON_MEDIUM + (node.placeholder ? ICON_UNKNOWN : node.icon) + '.jpg" alt="">' +
      (node.placeholder ? "" : '<span class="rank-badge"></span><span class="plan-badge" aria-hidden="true"></span>');

    if (!node.placeholder) {
      var longPressTimer = null;
      var longPressFired = false;
      cell.tabIndex = 0;
      cell.setAttribute("role", "button");
      cell.addEventListener("click", function () {
        changeRank(tree, node, 1);
      });
      cell.addEventListener("contextmenu", function (e) {
        e.preventDefault();
        if (!longPressFired) changeRank(tree, node, -1);
      });
      cell.addEventListener("keydown", function (e) {
        if (e.key === "Enter" || e.key === " " || e.key === "+") {
          e.preventDefault();
          changeRank(tree, node, e.shiftKey ? -1 : 1);
        } else if (e.key === "Backspace" || e.key === "Delete" || e.key === "-") {
          e.preventDefault();
          changeRank(tree, node, -1);
        }
      });
      cell.addEventListener("focus", function () {
        try {
          if (!cell.matches(":focus-visible")) return;
        } catch (e) {}
        hintMode = "kb";
        var rect = cell.getBoundingClientRect();
        hovered = { tree: tree, node: node };
        var tip = document.querySelector(".ttip");
        if (tip) {
          tip.innerHTML = tooltipHtml(tree, node);
          tip.classList.add("show");
          positionTooltip({ clientX: rect.right - 8, clientY: rect.top - 8 });
        }
      });
      cell.addEventListener("blur", function () {
        if (hintMode === "kb") hideTooltip();
      });
      cell.addEventListener("touchstart", function () {
        longPressFired = false;
        clearTimeout(longPressTimer);
        longPressTimer = setTimeout(function () {
          longPressFired = true;
          changeRank(tree, node, -1);
        }, 500);
      }, { passive: true });
      cell.addEventListener("touchmove", function () {
        clearTimeout(longPressTimer);
      }, { passive: true });
      cell.addEventListener("touchend", function (e) {
        clearTimeout(longPressTimer);
        if (longPressFired && e.cancelable) e.preventDefault();
      });
    }
    cell.addEventListener("mouseenter", function (e) {
      hintMode = isTouchOnly() ? "touch" : "mouse";
      hovered = { tree: tree, node: node };
      var tip = document.querySelector(".ttip");
      if (!tip) return;
      tip.innerHTML = tooltipHtml(tree, node);
      tip.classList.add("show");
      positionTooltip(e);
    });
    cell.addEventListener("mousemove", positionTooltip);
    cell.addEventListener("mouseleave", hideTooltip);
    return cell;
  }

  function setupToolbar() {
    var resetBtn = document.querySelector("[data-reset-all]");
    if (resetBtn) {
      resetBtn.addEventListener("click", function () {
        resetRanks();
        scheduleRender();
      });
    }
    var copyBtn = document.querySelector("[data-copy-link]");
    if (copyBtn) {
      copyBtn.addEventListener("click", copyLink);
      if (window.WF.shareUI && window.WF.shareCode) {
        window.WF.shareUI.mountMenu(copyBtn, {
          linkHint: "Lien de cette page (?hbuild=)",
          codeHint: "Code AF1H- à coller dans l'addon ou sur ce site",
          copyCode: copyCode,
          paste: function () { window.WF.shareUI.openPasteDialog(openPastedCode); }
        });
      }
    }
  }

  /* ---------- Panneau : curseur, presets, textes ---------- */

  function mountPanel() {
    var toolbar = document.querySelector(".calc-toolbar");
    if (!toolbar) return;
    var old = document.querySelector("[data-h-planner]");
    if (old) old.parentNode.removeChild(old);
    var panel = document.createElement("section");
    panel.className = "planner h-planner";
    panel.setAttribute("data-h-planner", "");
    panel.setAttribute("aria-label", "Planifier l'Héritage");
    panel.innerHTML =
      '<div class="planner-row">' +
        '<div class="planner-level">' +
          '<label class="planner-label" for="h-level">Voir mon héritage à <b data-h-level-out>16</b> points dépensés</label>' +
          '<input id="h-level" class="planner-range" type="range" min="0" max="' + MAX_POINTS + '" step="1" value="' + MAX_POINTS + '" data-h-level>' +
          '<div class="planner-scale" aria-hidden="true"><span>0</span><span>' + MAX_POINTS + '</span></div>' +
        '</div>' +
        '<div class="h-presets" role="group" aria-label="Presets">' +
          '<span class="h-presets-label">Presets</span>' +
          PRESETS.map(function (p) {
            return '<button type="button" class="btn ghost h-preset" data-h-preset="' + p.id + '" title="' + p.desc + '">' + p.name + '</button>';
          }).join("") +
        '</div>' +
      '</div>' +
      '<p class="h-note">Les points sont gagnés sur le compte et dépensés par personnage.</p>' +
      '<p class="h-talented is-off" data-h-talented aria-hidden="true">Tes talents de classe commencent au niveau 9.</p>';
    toolbar.parentNode.insertBefore(panel, toolbar.nextSibling);

    var range = panel.querySelector("[data-h-level]");
    range.addEventListener("input", function () {
      state.level = Math.max(0, Math.min(MAX_POINTS, parseInt(range.value, 10) || 0));
      scheduleRender();
    });
    panel.querySelectorAll("[data-h-preset]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        var preset = PRESETS.filter(function (p) { return p.id === btn.getAttribute("data-h-preset"); })[0];
        if (!preset) return;
        applyRanks(preset.ranks);
        state.level = MAX_POINTS;
        toast("Preset « " + preset.name + " » appliqué (" + MAX_POINTS + " points).", "info");
      });
    });
  }

  function applyRanks(ranks) {
    resetRanks();
    for (var k in ranks) {
      if (Object.prototype.hasOwnProperty.call(state.ranks, k)) state.ranks[k] = ranks[k];
    }
    scheduleRender();
    writeUrl();
  }

  function toast(text, kind) {
    if (window.WF.shareUI) window.WF.shareUI.toast(text, kind);
  }

  /* ---------- Partage : code AF1H- ---------- */

  function copyCode() {
    var res = HP().autoOrder(state.catalog, state.ranks);
    if (!res.acquirable) {
      toast("Cet héritage ne respecte pas les paliers de points : impossible d'en faire un code.", "error");
      return;
    }
    var code = HP().encode(state.catalog, state.ranks);
    window.WF.shareUI.copyText(code, "Code addon copié : " + code, "Copiez ce code :");
  }

  // Code collé : AF1- part vers la bonne classe, AF1H- est chargé ici.
  function openPastedCode(value) {
    var route = window.WF.shareUI.routeCode(value, { kind: "H" });
    if (!route.ok) return route.error;
    if (route.navigate) {
      window.location.assign(route.navigate);
      return "";
    }
    var res = HP().decode(route.code, state.catalog);
    if (!res.ok) return res.error;
    applyRanks(res.ranks);
    state.level = MAX_POINTS;
    toast("Héritage chargé depuis le code.", "info");
    return "";
  }

  // /arbre-heritage?code=AF1H-… (code collé depuis une page classe).
  function applyCodeParam() {
    var url = new URL(window.location.href);
    var code = url.searchParams.get("code");
    if (!code || !HP()) return "";
    url.searchParams.delete("code");
    var res = HP().decode(code, state.catalog);
    if (res.ok) url.searchParams.set(URL_PARAM, res.hbuild);
    history.replaceState(null, "", url.toString());
    return res.ok ? "" : res.error;
  }

  window.WF.initHeritage = function () {
    if (!document.querySelector("[data-heritage]")) return;
    if (!HP() || !TREES.length) return;
    state.catalog = HP().catalog(TREES);
    state.level = MAX_POINTS;
    resetRanks();
    var codeError = applyCodeParam();
    loadFromUrl();
    buildTrees();
    setupToolbar();
    mountPanel();
    if (codeError) toast("Code non ouvert : " + codeError.charAt(0).toLowerCase() + codeError.slice(1), "notice-error");
    scheduleRender();
    if (!initialized) initialized = true;
  };

  document.addEventListener("DOMContentLoaded", function () {
    window.WF.initHeritage();
  });

  var renderQueued = false;

  function scheduleRender() {
    if (renderQueued) return;
    renderQueued = true;
    requestAnimationFrame(function () {
      renderQueued = false;
      render();
    });
  }

  // Rangs visibles au curseur : les N premiers points de l'ordre automatique.
  // À 16 points on montre toujours l'héritage final complet.
  function ranksAtCursor() {
    if (!state.catalog || state.level >= MAX_POINTS) return state.ranks;
    var order = HP().autoOrder(state.catalog, state.ranks).order;
    return HP().ranksAt(state.catalog, order, state.level);
  }

  function render() {
    var spent = totalPoints();
    var atRanks = ranksAtCursor();
    var spentEl = document.querySelector("[data-points-spent]");
    if (spentEl) spentEl.textContent = spent;
    document.querySelectorAll("[data-heritage-pips] i").forEach(function (pip, idx) {
      pip.classList.toggle("on", idx < spent);
    });
    var leftEl = document.querySelector("[data-points-left]");
    if (leftEl) leftEl.textContent = MAX_POINTS - spent;

    TREES.forEach(function (tree, treeIdx) {
      var treeEl = document.querySelector('.tree[data-tree-idx="' + treeIdx + '"]');
      if (!treeEl) return;
      var pts = treePoints(tree);
      var ptsAt = 0;
      realNodes(tree).forEach(function (node) { ptsAt += atRanks[key(tree, node)] || 0; });
      treeEl.querySelector("[data-tree-count]").textContent = ptsAt === pts ? pts + " / " + MAX_POINTS : ptsAt + " → " + pts + " pts";
      var bar = treeEl.querySelector("[data-tree-bar]");
      if (bar) bar.style.width = Math.min(100, ptsAt / MAX_POINTS * 100) + "%";
      realNodes(tree).forEach(function (node) {
        var cell = treeEl.querySelector('.talent[data-id="' + key(tree, node) + '"]');
        if (!cell) return;
        var finalRank = state.ranks[key(tree, node)] || 0;
        var rank = atRanks[key(tree, node)] || 0;
        var planned = finalRank > rank;
        var unlocked = tierUnlocked(tree, node);
        cell.classList.toggle("locked", finalRank === 0 && !unlocked);
        cell.classList.toggle("has-points", rank > 0);
        cell.classList.toggle("maxed", rank === node.maxRank);
        cell.classList.toggle("is-future", planned && rank === 0);
        cell.classList.toggle("is-partial", planned && rank > 0);
        cell.querySelector(".rank-badge").textContent = rank + "/" + node.maxRank;
        cell.querySelector(".plan-badge").textContent = planned ? "→" + finalRank : "";
        cell.setAttribute("aria-label", node.name + ", rang " + rank + " sur " + node.maxRank +
          (planned ? ", rang " + finalRank + " prévu plus tard" : "") +
          (finalRank === 0 && !unlocked ? ", verrouillé" : ""));
        cell.style.borderColor = "";
      });
    });

    updatePanel(spent);
    refreshOpenTooltip();
    clearTimeout(urlTimer);
    urlTimer = setTimeout(writeUrl, 400);
  }

  function updatePanel(spent) {
    var panel = document.querySelector("[data-h-planner]");
    if (!panel) return;
    var range = panel.querySelector("[data-h-level]");
    if (String(range.value) !== String(state.level)) range.value = state.level;
    range.setAttribute("aria-valuetext", state.level + " points dépensés sur " + MAX_POINTS);
    panel.querySelector("[data-h-level-out]").textContent = state.level;
    // Talentueux : phrase discrète, place toujours réservée (aucun décalage de la page).
    var talented = panel.querySelector("[data-h-talented]");
    var on = (state.ranks[TALENTED_KEY] || 0) >= 1;
    talented.classList.toggle("is-off", !on);
    if (on) talented.removeAttribute("aria-hidden");
    else talented.setAttribute("aria-hidden", "true");
  }

  function refreshOpenTooltip() {
    if (!hovered) return;
    var tip = document.querySelector(".ttip");
    if (!tip || !tip.classList.contains("show")) return;
    tip.innerHTML = tooltipHtml(hovered.tree, hovered.node);
  }

  var hovered = null;
  var hintMode = "mouse";

  function isTouchOnly() {
    try {
      return matchMedia("(hover: none)").matches;
    } catch (e) {
      return false;
    }
  }

  function tooltipHtml(tree, node) {
    if (node.placeholder) return '<h4>Compétence inconnue</h4><p class="desc">Sera ajoutée dans un futur contenu.</p>';
    var rank = state.ranks[key(tree, node)] || 0;
    var html = "<h4>" + node.name + "</h4>";
    var atRank = state.level < MAX_POINTS ? (ranksAtCursor()[key(tree, node)] || 0) : rank;
    html += '<div class="meta">Rang ' + rank + "/" + node.maxRank + " · " + (node.meta || "Passif") + "</div>";
    html += '<p class="desc">' + node.desc + "</p>";
    if (atRank !== rank) html += '<p class="plan-at">À ' + state.level + " points dépensés : rang " + atRank + "/" + node.maxRank + "</p>";
    if (!tierUnlocked(tree, node)) {
      html += '<p class="req">Nécessite ' + node.tier + " points d'héritage dépensés dans " + tree.name + ".</p>";
    }
    html += '<p class="ttip-hint">' + (
      hintMode === "kb" ? "Entrée : apprendre · Retour arrière : oublier"
        : hintMode === "touch" ? "Toucher : apprendre · Appui long : oublier"
          : "Clic : apprendre · Clic droit : oublier"
    ) + "</p>";
    return html;
  }

  function positionTooltip(e) {
    var tip = document.querySelector(".ttip");
    if (!tip) return;
    var margin = 10;
    var w = tip.offsetWidth || 300;
    var h = tip.offsetHeight || 140;
    var x = e.clientX + 18;
    var y = e.clientY + 18;
    if (x + w > window.innerWidth - margin) x = e.clientX - w - 18;
    if (x < margin) x = margin;
    if (x + w > window.innerWidth - margin) x = window.innerWidth - w - margin;
    if (y + h > window.innerHeight - margin) y = window.innerHeight - h - margin;
    if (y < margin) y = margin;
    tip.style.left = x + "px";
    tip.style.top = y + "px";
  }

  function hideTooltip() {
    hovered = null;
    var tip = document.querySelector(".ttip");
    if (tip) tip.classList.remove("show");
  }

  var urlTimer = null;

  function hbuildString() {
    return TREES.map(function (tree) {
      return realNodes(tree).map(function (node) { return state.ranks[key(tree, node)] || 0; }).join("");
    }).join("-");
  }

  function writeUrl() {
    clearTimeout(urlTimer);
    var url = new URL(window.location.href);
    url.searchParams.set(URL_PARAM, hbuildString());
    history.replaceState(null, "", url.toString());
  }

  function copyLink() {
    writeUrl();
    var href = window.location.href;
    if (window.WF.shareUI) {
      window.WF.shareUI.copyText(href, "Lien copié : héritage de cette page.", "Copiez ce lien :");
      return;
    }
    window.prompt("Copiez ce lien :", href);
  }
})();
