/*
 * Azeroth Forever : calculateur de talents de classe.
 *
 * Version lisible de l'ancien calculator.js minifié (v2), puis Phase 1 :
 * curseur de niveau, ?path= (ordre des points), Mode Fin / Mode Parcours.
 *
 * Règle clé : state.ranks = rangs FINAUX (ce que ?build= et « Sauvegarder »
 * enregistrent). Le curseur ne change que l'AFFICHAGE (state.level).
 * Invariant : state.ranks === ranksFromOrder(state.order).
 * Dépend de js/build-path.js (window.WF.buildPath) et js/level-planner.js.
 */
window.WF = window.WF || {};

(function () {
  "use strict";

  var ICON_LARGE = "https://wow.zamimg.com/images/wow/icons/large/";
  var STATUS_LABELS = {
    new: "Nouveau",
    changed: "Modifié",
    unchanged: "Vérifié identique"
  };
  var CLASSIC_PREF_KEY = "wf-classic-toggle";
  var CLASS_COLORS = {
    guerrier: "#C79C6E",
    paladin: "#F58CBA",
    chasseur: "#ABD473",
    voleur: "#FFF569",
    pretre: "#FFFFFF",
    chaman: "#0070DE",
    mage: "#69CCF0",
    demoniste: "#9482C9",
    druide: "#FF7D0A"
  };
  var CLASS_BANNERS = {
    guerrier: "banner-guerrier.webp",
    paladin: "banner-paladin.webp",
    chasseur: "banner-chasseur.webp",
    voleur: "banner-voleur.webp",
    pretre: "banner-pretre.webp",
    chaman: "banner-chaman.webp",
    mage: "banner-mage.webp",
    demoniste: "banner-demoniste.webp",
    druide: "banner-druide.webp"
  };

  var MAX_LEVEL = 60;

  var state = {
    classData: null,
    ranks: {},
    showClassic: false,
    catalog: null,
    order: [],
    level: MAX_LEVEL,
    mode: "fin",
    // Toujours 0 sur le builder de classe : aucun perk d'Héritage n'y est relié
    // (à revoir en Phase 3 avec le libellé exact d'un nœud de heritage-calculator.js).
    talented: 0
  };
  var planner = null;

  function BP() {
    return window.WF.buildPath;
  }

  function syncClassicToggle() {
    var btn = document.querySelector("[data-classic-toggle]");
    if (!btn) return;
    btn.classList.toggle("on", state.showClassic);
    btn.setAttribute("aria-pressed", state.showClassic ? "true" : "false");
  }

  var resizeBound = false;

  function totalPoints() {
    var sum = 0;
    for (var id in state.ranks) sum += state.ranks[id];
    return sum;
  }

  function treePoints(tree) {
    var sum = 0;
    tree.talents.forEach(function (talent) {
      sum += state.ranks[talent.id] || 0;
    });
    return sum;
  }

  function rowUnlocked(tree, row) {
    return row === 0 || treePoints(tree) >= 5 * row;
  }

  function requirementsMet(tree, talent) {
    return !talent.requires || !talent.requires.length || talent.requires.every(function (req) {
      return (state.ranks[req.id] || 0) >= req.qty;
    });
  }

  function plannerMessage(text, kind) {
    if (planner) planner.message(text, kind);
  }

  function orderIsValid(order) {
    return BP().validateOrder(state.catalog, order).ok;
  }

  function changeRank(tree, talent, delta) {
    if (state.mode === "parcours") return changeRankPath(tree, talent, delta);
    return changeRankFinal(tree, talent, delta);
  }

  // Mode Parcours : +1 ajoute ce rang à la fin de l'ordre ; -1 retire le dernier
  // rang de CE talent dans l'ordre (pas forcément le dernier point global).
  function changeRankPath(tree, talent, delta) {
    var bp = BP();
    var idx = state.catalog.byId[talent.id].index;
    var res = delta > 0 ? bp.append(state.catalog, state.order, idx) : bp.removeLastOf(state.catalog, state.order, idx);
    if (!res.ok) {
      if (res.code === "empty") return;
      plannerMessage(res.message, "error");
      return void flashRefused(talent.id);
    }
    state.order = res.order;
    state.ranks = bp.ranksFromOrder(state.catalog, state.order);
    if (delta > 0) state.level = Math.max(state.level, bp.levelOfPoint(state.order.length, state.talented));
    plannerMessage("");
    scheduleRender();
  }

  // Mode Fin : on édite les rangs finaux, l'ordre est recalculé automatiquement.
  function changeRankFinal(tree, talent, delta) {
    var bp = BP();
    if (delta > 0) {
      var add = bp.append(state.catalog, state.order, state.catalog.byId[talent.id].index);
      if (!add.ok) {
        if (add.code !== "maxed") plannerMessage(add.message, "error");
        return;
      }
    } else if ((state.ranks[talent.id] || 0) > 0) {
      var next = {};
      for (var id in state.ranks) next[id] = state.ranks[id];
      next[talent.id] -= 1;
      var check = bp.validateOrder(state.catalog, bp.autoOrder(state.catalog, next));
      if (!check.ok && orderIsValid(bp.autoOrder(state.catalog, state.ranks))) {
        plannerMessage("Impossible de retirer " + talent.name + " : " + check.message.charAt(0).toLowerCase() + check.message.slice(1), "error");
        return void flashRefused(talent.id);
      }
    }
    var before = state.ranks[talent.id] || 0;
    legacyChangeRank(tree, talent, delta);
    if ((state.ranks[talent.id] || 0) !== before) {
      state.order = bp.autoOrder(state.catalog, state.ranks);
      plannerMessage("");
    }
  }

  // Règles historiques du calculateur (inchangées), appliquées aux rangs finaux.
  function legacyChangeRank(tree, talent, delta) {
    var current = state.ranks[talent.id] || 0;
    if (delta > 0) {
      if (current >= talent.maxRank) return;
      if (totalPoints() >= 51) return;
      if (!rowUnlocked(tree, talent.row)) return;
      if (!requirementsMet(tree, talent)) return;
      state.ranks[talent.id] = current + 1;
    } else {
      if (current <= 0) return;
      var next = current - 1;
      var breaksDependant = tree.talents.some(function (other) {
        if ((state.ranks[other.id] || 0) <= 0) return false;
        return (other.requires || []).some(function (req) {
          return req.id === talent.id && next < req.qty;
        });
      });
      if (breaksDependant) return void flashRefused(talent.id);
      var remaining = treePoints(tree) - 1;
      var breaksTier = tree.talents.some(function (other) {
        var rank = other.id === talent.id ? next : state.ranks[other.id] || 0;
        return rank > 0 && remaining < 5 * other.row;
      });
      if (breaksTier) return void flashRefused(talent.id);
      state.ranks[talent.id] = next;
    }
    scheduleRender();
  }

  function flashRefused(talentId) {
    var el = document.querySelector('.talent[data-id="' + talentId + '"]');
    if (!el) return;
    el.style.borderColor = "#e0605a";
    setTimeout(function () {
      scheduleRender();
    }, 220);
  }

  function readClassicPref() {
    try {
      return localStorage.getItem(CLASSIC_PREF_KEY) === "1";
    } catch (e) {
      return false;
    }
  }

  function writeClassicPref(on) {
    try {
      localStorage.setItem(CLASSIC_PREF_KEY, on ? "1" : "0");
    } catch (e) {}
  }

  // ?build= garde son format historique (même décodage tolérant).
  // ?path= ajoute l'ordre : absent = ordre auto ; corrompu ou en conflit = build gagne.
  function loadBuildFromUrl() {
    var params = new URL(window.location.href).searchParams;
    var res = BP().resolve(state.catalog, params.get("build"), params.get("path"));
    state.ranks = res.ranks;
    state.order = res.order;
    // Le chiffre Talentueux de ?path= est lu par le codec mais ignoré ici :
    // curseur 10 à 60, 1er point au niveau 10. Le lien réécrit porte donc « 10 ».
    state.talented = 0;
    return res;
  }

  function hexToRgba(hex, alpha) {
    var h = hex.replace("#", "");
    if (h.length === 3) {
      h = h.split("").map(function (c) { return c + c; }).join("");
    }
    return "rgba(" + parseInt(h.substring(0, 2), 16) + "," + parseInt(h.substring(2, 4), 16) + "," + parseInt(h.substring(4, 6), 16) + "," + alpha + ")";
  }

  function setupHeaderAndToolbar() {
    var cls = state.classData;
    var portrait = document.querySelector("[data-class-portrait]");
    if (portrait) portrait.src = "https://wow.zamimg.com/images/wow/icons/medium/" + cls.icon + ".jpg";

    var nameEl = document.querySelector("[data-class-name]");
    if (nameEl) {
      nameEl.textContent = cls.name;
      var nameColor = CLASS_COLORS[cls.slug];
      if (nameColor) nameEl.style.color = nameColor;
    }

    var accent = CLASS_COLORS[cls.slug];
    if (accent) {
      document.documentElement.style.setProperty("--class-accent", accent);
      document.documentElement.style.setProperty("--class-accent-soft", hexToRgba(accent, 0.55));
    }

    var head = document.querySelector(".calc-head");
    var banner = CLASS_BANNERS[cls.slug];
    if (head && banner && !head.querySelector(".calc-banner-bg")) {
      var bg = document.createElement("div");
      bg.className = "calc-banner-bg";
      bg.style.backgroundImage = "url('img/" + banner + "')";
      head.insertBefore(bg, head.firstChild);
      head.classList.add("has-banner");
    }

    var activeLink = document.querySelector(".class-strip a.active");
    if (activeLink) {
      var linkColor = CLASS_COLORS[cls.slug];
      if (linkColor) {
        activeLink.style.color = linkColor;
        activeLink.style.borderColor = linkColor;
      }
    }

    var copyBtn = document.querySelector("[data-copy-link]");
    if (copyBtn) {
      copyBtn.addEventListener("click", copyLink);
      setupShareButtons(copyBtn);
    }

    var resetBtn = document.querySelector("[data-reset-all]");
    if (resetBtn) {
      resetBtn.addEventListener("click", function () {
        for (var id in state.ranks) state.ranks[id] = 0;
        state.order = [];
        plannerMessage("");
        scheduleRender();
      });
    }

    var classicBtn = document.querySelector("[data-classic-toggle]");
    if (classicBtn) {
      classicBtn.addEventListener("click", function () {
        state.showClassic = !state.showClassic;
        writeClassicPref(state.showClassic);
        syncClassicToggle();
        scheduleRender();
      });
    }
  }

  function buildTrees() {
    var host = document.querySelector("[data-trees]");
    if (!host) return;

    state.classData.trees.forEach(function (tree, treeIdx) {
      var treeEl = document.createElement("div");
      treeEl.className = "tree";
      treeEl.dataset.treeIdx = treeIdx;
      var maxRow = Math.max.apply(null, tree.talents.map(function (t) { return t.row; }));
      treeEl.innerHTML =
        '<div class="tree-bg" style="background-image:url(\'img/' + tree.id + '.webp\')"></div>' +
        '<div class="tree-head"><img src="' + ICON_LARGE + tree.icon + '.jpg" alt="">' +
        '<h2><button type="button" class="tree-toggle" aria-expanded="true">' + tree.name +
        '<span class="tree-toggle-caret" aria-hidden="true"></span></button></h2>' +
        '<span class="count" data-tree-count></span>' +
        '<button class="btn ghost tree-reset" type="button" data-tree-reset title="Réinitialiser cet arbre" aria-label="Réinitialiser l\'arbre ' + tree.name + '">' +
        '<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true" focusable="false">' +
        '<path fill="currentColor" d="M12 5V2L7 6l5 4V7a5 5 0 1 1-5 5H5a7 7 0 1 0 7-7z"/></svg></button></div>' +
        '<div class="tree-bar"><span data-tree-bar></span></div>' +
        '<div class="tree-grid-wrap"><div class="tree-grid" style="grid-template-rows:repeat(' + (maxRow + 1) + ',66px)">' +
        '<svg class="lines"></svg></div></div>';
      host.appendChild(treeEl);

      var grid = treeEl.querySelector(".tree-grid");
      tree.talents.forEach(function (talent) {
        grid.appendChild(createTalentCell(tree, talent));
      });

      treeEl.querySelector("[data-tree-reset]").addEventListener("click", function () {
        tree.talents.forEach(function (t) { state.ranks[t.id] = 0; });
        state.order = BP().withoutTree(state.catalog, state.order, treeIdx);
        scheduleRender();
      });
    });

    if (!document.querySelector(".ttip")) {
      var tip = document.createElement("div");
      tip.className = "ttip";
      document.body.appendChild(tip);
    }
    setupMobileCollapse();
  }

  function createTalentCell(tree, talent) {
    var cell = document.createElement("div");
    var longPressTimer = null;
    var longPressFired = false;

    cell.className = "talent";
    cell.tabIndex = 0;
    cell.setAttribute("role", "button");
    cell.dataset.id = talent.id;
    cell.style.gridColumn = talent.col + 1;
    cell.style.gridRow = talent.row + 1;
    cell.innerHTML = '<img src="' + ICON_LARGE + talent.icon + '.jpg" alt=""><span class="status-dot"></span><span class="rank-badge"></span><span class="plan-badge" aria-hidden="true"></span>';

    cell.addEventListener("click", function () {
      changeRank(tree, talent, 1);
    });
    cell.addEventListener("contextmenu", function (e) {
      e.preventDefault();
      if (!longPressFired) changeRank(tree, talent, -1);
    });
    cell.addEventListener("keydown", function (e) {
      if (e.key === "Enter" || e.key === " " || e.key === "+") {
        e.preventDefault();
        changeRank(tree, talent, e.shiftKey ? -1 : 1);
      } else if (e.key === "Backspace" || e.key === "Delete" || e.key === "-") {
        e.preventDefault();
        changeRank(tree, talent, -1);
      }
    });
    cell.addEventListener("focus", function () {
      try {
        if (!cell.matches(":focus-visible")) return;
      } catch (e) {}
      hintMode = "kb";
      var rect = cell.getBoundingClientRect();
      hovered = { tree: tree, talent: talent };
      var tip = document.querySelector(".ttip");
      tip.innerHTML = tooltipHtml(tree, talent);
      tip.classList.add("show");
      positionTooltip({ clientX: rect.right - 8, clientY: rect.top - 8 });
    });
    cell.addEventListener("blur", function () {
      if (hintMode === "kb") hideTooltip();
    });
    cell.addEventListener("touchstart", function () {
      longPressFired = false;
      clearTimeout(longPressTimer);
      longPressTimer = setTimeout(function () {
        longPressFired = true;
        changeRank(tree, talent, -1);
      }, 500);
    }, { passive: true });
    cell.addEventListener("touchmove", function () {
      clearTimeout(longPressTimer);
    }, { passive: true });
    cell.addEventListener("touchend", function (e) {
      clearTimeout(longPressTimer);
      if (longPressFired && e.cancelable) e.preventDefault();
    });
    cell.addEventListener("mouseenter", function (e) {
      hintMode = isTouchOnly() ? "touch" : "mouse";
      hovered = { tree: tree, talent: talent };
      var tip = document.querySelector(".ttip");
      tip.innerHTML = tooltipHtml(tree, talent);
      tip.classList.add("show");
      positionTooltip(e);
    });
    cell.addEventListener("mousemove", positionTooltip);
    cell.addEventListener("mouseleave", hideTooltip);
    return cell;
  }

  window.WF.initCalculator = function () {
    var slug = document.body.getAttribute("data-class");
    if (!slug || !window.TALENTS_FR || !window.WF.buildPath) return;
    // Les pages compétences ont aussi body[data-class] mais pas d'arbres : rien à faire.
    if (!document.querySelector("[data-trees]")) return;
    var cls = window.TALENTS_FR.find(function (c) { return c.slug === slug; });
    if (!cls) return;

    state.classData = cls;
    state.catalog = BP().catalog(cls);
    state.ranks = BP().emptyRanks(state.catalog);
    state.order = [];
    state.level = MAX_LEVEL;
    state.mode = "fin";
    state.talented = 0;
    state.atRanks = null;
    invalidShown = "";
    state.showClassic = readClassicPref();
    var codeError = applyCodeParam(slug);
    if (codeError === null) return; // redirection vers la bonne classe en cours
    var loaded = loadBuildFromUrl();
    setupHeaderAndToolbar();
    buildTrees();
    planner = window.WF.levelPlanner ? window.WF.levelPlanner.mount(plannerApi) : null;
    if (codeError) plannerMessage("Code non ouvert : " + codeError.charAt(0).toLowerCase() + codeError.slice(1), "notice-error");
    if (loaded.recalculated) {
      plannerMessage("Parcours recalculé : l'ordre du lien ne correspondait pas à ce build.", "notice");
    }
    syncClassicToggle();
    scheduleRender();
    if (!resizeBound) {
      window.addEventListener("resize", function () { drawLines(); });
      resizeBound = true;
    }
  };

  document.addEventListener("DOMContentLoaded", function () {
    window.WF.initCalculator();
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

  function requiredLevel(points) {
    return points === 0 ? 1 : Math.min(60, 9 + points);
  }

  var plannerApi = {
    setLevel: function (level) {
      var min = BP().firstLevel(state.talented);
      state.level = Math.max(min, Math.min(MAX_LEVEL, parseInt(level, 10) || MAX_LEVEL));
      scheduleRender();
    },
    setMode: function (mode) {
      state.mode = mode === "parcours" ? "parcours" : "fin";
      plannerMessage("");
      scheduleRender();
    },
    recalc: function () {
      state.order = BP().autoOrder(state.catalog, state.ranks);
      plannerMessage("Ordre automatique rétabli : arbre par arbre, rangée par rangée.", "info");
      scheduleRender();
    }
  };

  // Rangs visibles au niveau simulé : les N premiers points de l'ordre.
  // Au niveau 60 on montre toujours le build final complet.
  function ranksAtLevel() {
    if (state.level >= MAX_LEVEL) return state.ranks;
    var count = BP().pointsAvailable(state.level, state.talented);
    return BP().ranksFromOrder(state.catalog, state.order, count);
  }

  function render() {
    var cls = state.classData;
    var spent = totalPoints();
    var atRanks = ranksAtLevel();
    state.atRanks = atRanks;

    var spentEl = document.querySelector("[data-points-spent]");
    if (spentEl) spentEl.textContent = spent;
    var bar = document.querySelector("[data-points-bar]");
    if (bar) bar.style.width = Math.min(100, spent / 51 * 100) + "%";
    var leftEl = document.querySelector("[data-points-left]");
    if (leftEl) leftEl.textContent = 51 - spent;
    var levelEl = document.querySelector("[data-required-level]");
    if (levelEl) levelEl.textContent = requiredLevel(spent);

    cls.trees.forEach(function (tree, treeIdx) {
      var treeEl = document.querySelector('.tree[data-tree-idx="' + treeIdx + '"]');
      if (!treeEl) return;
      var pts = treePoints(tree);
      var ptsAt = 0;
      tree.talents.forEach(function (t) { ptsAt += atRanks[t.id] || 0; });
      treeEl.querySelector("[data-tree-count]").textContent = ptsAt === pts ? pts + " pts" : ptsAt + "/" + pts + " pts";
      var treeBar = treeEl.querySelector("[data-tree-bar]");
      if (treeBar) treeBar.style.width = Math.min(100, ptsAt / 51 * 100) + "%";

      tree.talents.forEach(function (talent) {
        var cell = treeEl.querySelector('.talent[data-id="' + talent.id + '"]');
        var finalRank = state.ranks[talent.id] || 0;
        var rank = atRanks[talent.id] || 0;
        var available = rowUnlocked(tree, talent.row) && requirementsMet(tree, talent);
        var planned = finalRank > rank;
        cell.classList.toggle("locked", finalRank === 0 && !available);
        cell.classList.toggle("has-points", rank > 0);
        cell.classList.toggle("maxed", rank === talent.maxRank);
        cell.classList.toggle("is-future", planned && rank === 0);
        cell.classList.toggle("is-partial", planned && rank > 0);
        var planBadge = cell.querySelector(".plan-badge");
        if (planBadge) planBadge.textContent = planned ? "→" + finalRank : "";
        cell.classList.remove("status-new", "status-changed", "status-unchanged");
        cell.classList.add("status-" + talent.status);
        cell.querySelector(".status-dot").textContent = talent.status === "new" || talent.status === "changed" ? "★" : "✓";
        cell.querySelector(".rank-badge").textContent = rank + "/" + talent.maxRank;
        cell.setAttribute("aria-label", talent.name + ", rang " + rank + " sur " + talent.maxRank +
          (planned ? ", rang " + finalRank + " prévu plus tard" : "") +
          (finalRank === 0 && !available ? ", verrouillé" : ""));
        cell.style.borderColor = "";
      });
    });

    drawLines();
    refreshOpenTooltip();
    updatePlanner(atRanks);
    clearTimeout(urlTimer);
    urlTimer = setTimeout(writeUrl, 400);
  }

  function updatePlanner(atRanks) {
    if (!planner) return;
    var bp = BP();
    var validation = bp.validateOrder(state.catalog, state.order);
    var spentAt = 0;
    for (var id in atRanks) spentAt += atRanks[id] || 0;
    var isAuto = state.order.join(",") === bp.autoOrder(state.catalog, state.ranks).join(",");
    var trees = state.classData.trees.map(function (tree) {
      var at = 0;
      var fin = 0;
      tree.talents.forEach(function (t) {
        at += atRanks[t.id] || 0;
        fin += state.ranks[t.id] || 0;
      });
      return { name: tree.name, at: at, final: fin };
    });
    planner.update({
      level: state.level,
      minLevel: bp.firstLevel(state.talented),
      maxLevel: MAX_LEVEL,
      available: bp.pointsAvailable(state.level, state.talented),
      spentAt: spentAt,
      mode: state.mode,
      isAuto: isAuto,
      trees: trees,
      order: state.order,
      steps: bp.steps(state.catalog, state.order, state.talented),
      validation: validation,
      invalidStep: validation.ok ? -1 : validation.step
    });
    // Build impossible à monter point par point (lien fabriqué) : un seul toast,
    // pas de message permanent dans le panneau.
    var invalidKey = validation.ok ? "" : validation.step + "|" + validation.message;
    if (invalidKey && invalidKey !== invalidShown) {
      plannerMessage("Ce build ne peut pas être obtenu point par point (étape " + (validation.step + 1) + ") : " + validation.message, "notice-error");
    }
    invalidShown = invalidKey;
  }
  var invalidShown = "";

  function refreshOpenTooltip() {
    if (!hovered) return;
    var tip = document.querySelector(".ttip");
    if (!tip || !tip.classList.contains("show")) return;
    tip.innerHTML = tooltipHtml(hovered.tree, hovered.talent);
  }

  function drawLines() {
    document.querySelectorAll(".tree-grid").forEach(function (grid) {
      var svg = grid.querySelector("svg.lines");
      if (!svg) return;
      svg.innerHTML = "";
      var treeIdx = grid.closest(".tree").dataset.treeIdx;
      var tree = state.classData.trees[treeIdx];
      var gridRect = grid.getBoundingClientRect();
      tree.talents.forEach(function (talent) {
        (talent.requires || []).forEach(function (req) {
          var fromEl = grid.querySelector('.talent[data-id="' + req.id + '"]');
          var toEl = grid.querySelector('.talent[data-id="' + talent.id + '"]');
          if (!fromEl || !toEl) return;
          var a = fromEl.getBoundingClientRect();
          var b = toEl.getBoundingClientRect();
          var met = ((state.atRanks || state.ranks)[req.id] || 0) >= req.qty;
          var line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", a.left + a.width / 2 - gridRect.left);
          line.setAttribute("y1", a.top + a.height / 2 - gridRect.top);
          line.setAttribute("x2", b.left + b.width / 2 - gridRect.left);
          line.setAttribute("y2", b.top + b.height / 2 - gridRect.top);
          line.setAttribute("stroke", met ? "#caa24a" : "#4a3826");
          line.setAttribute("stroke-width", "2");
          svg.appendChild(line);
        });
      });
    });
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

  function setupMobileCollapse() {
    var trees = Array.prototype.slice.call(document.querySelectorAll("[data-trees] .tree"));
    if (!trees.length) return;
    var mobile = matchMedia("(max-width: 760px)");

    function openOnly(openIdx) {
      trees.forEach(function (treeEl, idx) {
        var collapsed = mobile.matches && idx !== openIdx;
        treeEl.classList.toggle("is-collapsed", collapsed);
        var toggle = treeEl.querySelector(".tree-toggle");
        if (toggle) toggle.setAttribute("aria-expanded", collapsed ? "false" : "true");
      });
      drawLines();
    }

    var openIdx = 0;
    var best = -1;
    trees.forEach(function (treeEl, idx) {
      var pts = treePoints(state.classData.trees[idx]);
      if (pts > best) {
        best = pts;
        openIdx = idx;
      }
    });
    openOnly(openIdx);

    trees.forEach(function (treeEl, idx) {
      var toggle = treeEl.querySelector(".tree-toggle");
      if (!toggle) return;
      toggle.addEventListener("click", function () {
        if (!mobile.matches) return;
        openIdx = treeEl.classList.contains("is-collapsed") ? idx : -1;
        openOnly(openIdx);
      });
    });
    if (mobile.addEventListener) {
      mobile.addEventListener("change", function () { openOnly(openIdx); });
    }
  }

  function findTalent(tree, id) {
    return tree.talents.filter(function (t) { return t.id === id; })[0];
  }

  function missingRequirements(tree, talent) {
    if (!talent.requires || !talent.requires.length) return "";
    return talent.requires
      .filter(function (req) { return (state.ranks[req.id] || 0) < req.qty; })
      .map(function (req) {
        var reqTalent = findTalent(tree, req.id);
        return reqTalent ? reqTalent.name + " (" + req.qty + ")" : "";
      })
      .filter(Boolean)
      .join(", ");
  }

  function tooltipHtml(tree, talent) {
    var rank = state.ranks[talent.id] || 0;
    var shownIdx = rank > 0 ? rank - 1 : 0;
    var shownRank = talent.ranks[shownIdx] || talent.ranks[0];
    var classicRanks = talent.classic && talent.classic.ranks;
    var classicShown = classicRanks && classicRanks[shownIdx];
    var nextIdx = rank > 0 && rank < talent.maxRank ? rank : -1;
    var nextRank = nextIdx >= 0 ? talent.ranks[nextIdx] : null;
    var classicNext = nextIdx >= 0 && classicRanks ? classicRanks[nextIdx] : null;

    var html = "<h4>" + talent.name + "</h4>";
    html += '<div class="meta">Rang ' + rank + "/" + talent.maxRank + ' <span class="badge ' + talent.status + '">' + STATUS_LABELS[talent.status] + "</span></div>";
    if (talent.cost) html += '<div class="ttip-cost">' + talent.cost + "</div>";
    html += '<p class="desc">' + (shownRank ? shownRank.description : "") + "</p>";
    if (talent.aura) {
      html += '<p class="aura">' + talent.aura.text + (talent.aura.duration ? ' <span class="aura-dur">(' + talent.aura.duration + ")</span>" : "") + "</p>";
    }
    if (talent.derived && shownIdx < talent.maxRank - 1) {
      html += '<p class="est">Rangs intermédiaires calculés à partir du dernier rang (seul rang publié par Wowhead).</p>';
    }
    if (talent.estimated) html += '<p class="est">Valeurs partiellement estimées (donnée incomplète sur Wowhead).</p>';
    if (talent.note) html += '<p class="est">' + talent.note + "</p>";
    if (nextRank) html += '<div class="next-rank"><b>Prochain rang</b>' + nextRank.description + "</div>";
    var atRank = state.atRanks ? state.atRanks[talent.id] || 0 : rank;
    if (atRank !== rank) {
      html += '<p class="plan-at">Au niveau ' + state.level + " : rang " + atRank + "/" + talent.maxRank + "</p>";
    }
    if (state.showClassic && (classicShown || classicNext)) {
      html += '<div class="classic-block">';
      html += '<span class="classic-label">Classic</span>';
      if (classicShown) html += '<p class="desc">' + classicShown.description + "</p>";
      if (classicNext) html += '<div class="next-rank-classic"><b>Prochain rang (Classic)</b>' + classicNext.description + "</div>";
      html += "</div>";
    }
    if (!rowUnlocked(tree, talent.row)) {
      html += '<p class="req">Nécessite ' + (talent.req || 5 * talent.row) + " points dans cet arbre.</p>";
    }
    var missing = missingRequirements(tree, talent);
    if (missing) html += '<p class="req">Nécessite : ' + missing + "</p>";
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

  function buildString() {
    return state.classData.trees.map(function (tree) {
      return tree.talents.map(function (t) { return state.ranks[t.id] || 0; }).join("");
    }).join("-");
  }

  // ?path= n'est écrit que pour un ordre valide ; sinon il est retiré (build seul).
  function pathString() {
    if (!state.catalog) return "";
    if (!state.order.length && !state.talented) return "";
    if (!orderIsValid(state.order)) return "";
    return BP().encodePath(state.catalog, state.order, state.talented);
  }

  function writeUrl() {
    clearTimeout(urlTimer);
    var url = new URL(window.location.href);
    url.searchParams.set("build", buildString());
    var path = pathString();
    if (path) url.searchParams.set("path", path);
    else url.searchParams.delete("path");
    history.replaceState(null, "", url.toString());
  }

  function isAutoOrder() {
    if (!state.catalog) return true;
    return state.order.join(",") === BP().autoOrder(state.catalog, state.ranks).join(",");
  }

  // Recharge un build + parcours sans recharger la page (utilisé par builds.js
  // quand un build sauvegardé porte un ordre).
  function setBuildAndPath(build, path) {
    if (!state.catalog) return;
    var res = BP().resolve(state.catalog, build, path || null);
    state.ranks = res.ranks;
    state.order = res.order;
    state.talented = 0;
    if (res.recalculated) {
      plannerMessage("Parcours recalculé : l'ordre enregistré ne correspondait pas à ce build.", "notice");
    }
    scheduleRender();
    writeUrl();
  }

  // API lue par builds.js : « Sauvegarder » enregistre toujours les rangs FINAUX.
  window.WF.calc = {
    getBuildString: function () {
      return state.classData ? buildString() : "";
    },
    getPathString: pathString,
    isAutoOrder: isAutoOrder,
    setBuildAndPath: setBuildAndPath
  };

  /* ---------- Code addon AF1- (copier / coller) ---------- */

  function shareCode() {
    return window.WF.shareCode;
  }

  function shareUI() {
    return window.WF.shareUI;
  }

  // « Partager » : Copier le lien / Copier le code addon / Coller un code (js/share-ui.js).
  function setupShareButtons(copyBtn) {
    if (!shareCode() || !shareUI()) return;
    shareUI().mountMenu(copyBtn, {
      linkHint: "Lien de cette page (build + ordre des points)",
      codeHint: "Code AF1- à coller dans l'addon ou sur ce site",
      copyCode: copyCode,
      paste: function () { shareUI().openPasteDialog(openPastedCode); }
    });
  }

  // Code collé : AF1H- part vers /arbre-heritage, AF1- rouvre la bonne classe.
  function openPastedCode(value) {
    var route = shareUI().routeCode(value, { kind: "C", slug: state.classData.slug });
    if (!route.ok) return route.error;
    if (route.navigate) {
      window.location.assign(route.navigate);
      return "";
    }
    var res = shareCode().decode(route.code, window.TALENTS_FR);
    if (!res.ok) return res.error;
    window.location.assign("/" + res.slug + "?build=" + encodeURIComponent(res.build) + "&path=" + encodeURIComponent(res.path));
    return "";
  }

  // Lien /{classe}?code=AF1-… (code collé depuis une autre page) : on le remplace
  // par ?build= + ?path= avant le chargement normal. Renvoie un message d'erreur éventuel.
  function applyCodeParam(slug) {
    var url = new URL(window.location.href);
    var code = url.searchParams.get("code");
    if (!code || !shareCode()) return "";
    url.searchParams.delete("code");
    var res = shareCode().decode(code, window.TALENTS_FR);
    if (!res.ok) {
      history.replaceState(null, "", url.toString());
      return res.error;
    }
    url.searchParams.set("build", res.build);
    url.searchParams.set("path", res.path);
    url.searchParams.delete("b");
    if (res.slug !== slug) {
      url.pathname = "/" + res.slug;
      window.location.replace(url.toString());
      return null;
    }
    history.replaceState(null, "", url.toString());
    return "";
  }

  function currentCode() {
    if (!orderIsValid(state.order)) return "";
    var path = BP().encodePath(state.catalog, state.order, state.talented);
    return shareCode().encode(state.classData, path);
  }

  function copyCode() {
    var code = currentCode();
    if (!code) {
      plannerMessage("Ce build ne peut pas être monté point par point : impossible d'en faire un code.", "error");
      return;
    }
    copyText(code, "Code addon copié : " + code, "Copiez ce code :");
  }

  function copyText(text, doneMessage, promptLabel) {
    shareUI().copyText(text, doneMessage, promptLabel);
  }

  function copyLink() {
    writeUrl();
    copyText(window.location.href, "Lien copié : build et ordre des points.", "Copiez ce lien :");
  }

})();
