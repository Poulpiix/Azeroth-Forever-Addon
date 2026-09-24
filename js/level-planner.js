/*
 * Azeroth Forever : planificateur de niveau (curseur, modes, parcours de montée).
 *
 * Interface seulement. L'état et les règles vivent dans calculator.js et
 * build-path.js ; ce module crée les contrôles et les met à jour via update(view).
 */
window.WF = window.WF || {};

(function () {
  "use strict";

  // Toasts : 2 s pour un refus, un peu plus pour les avis au chargement du lien.
  var TOAST_DELAY = 2000;
  var TOAST_DELAY_NOTICE = 4000;

  var HINTS = {
    fin: "Build niveau 60 : vous placez les points finaux, l'ordre de montée est calculé tout seul.",
    parcours: "Choisir l'ordre : chaque clic est le prochain point que vous prendrez en montant de niveau."
  };

  function el(tag, cls, text) {
    var node = document.createElement(tag);
    if (cls) node.className = cls;
    if (text !== undefined) node.textContent = text;
    return node;
  }

  /* ---- Toast en overlay (position fixe, aucune hauteur réservée) ---- */
  var toastTimer = null;

  function toastEl() {
    var node = document.querySelector("[data-af-toast]");
    if (!node) {
      node = el("div", "af-toast");
      node.setAttribute("data-af-toast", "");
      node.setAttribute("role", "status");
      node.setAttribute("aria-live", "polite");
      document.body.appendChild(node);
    }
    return node;
  }

  function toast(text, kind) {
    var node = toastEl();
    clearTimeout(toastTimer);
    if (!text) {
      node.classList.remove("show");
      return;
    }
    node.textContent = text;
    node.className = "af-toast show is-" + (kind || "info");
    var delay = kind && kind.indexOf("notice") === 0 ? TOAST_DELAY_NOTICE : TOAST_DELAY;
    toastTimer = setTimeout(function () { node.classList.remove("show"); }, delay);
  }

  function stepButton(step) {
    var btn = el("button", "planner-step-btn");
    btn.type = "button";
    btn.setAttribute("data-step-level", step.level);
    btn.setAttribute("data-step-n", step.n);
    btn.appendChild(el("span", "planner-step-lvl", "Niv. " + step.level));
    btn.appendChild(el("span", "planner-step-txt", step.talentName + " " + step.rank + "/" + step.maxRank));
    return btn;
  }

  function mount(api) {
    var toolbar = document.querySelector(".calc-toolbar");
    var trees = document.querySelector("[data-trees]");
    if (!toolbar || !trees) return null;

    var old = document.querySelector("[data-planner]");
    if (old) old.parentNode.removeChild(old);
    toast("");

    /* ---- Panneau principal ---- */
    var panel = el("section", "planner");
    panel.setAttribute("data-planner", "");
    panel.setAttribute("aria-label", "Planifier sans dépenser");
    panel.innerHTML =
      '<div class="planner-row">' +
        '<div class="planner-level">' +
          '<label class="planner-label" for="planner-level">Voir mon build au niveau <b data-planner-level-out>60</b></label>' +
          '<input id="planner-level" class="planner-range" type="range" min="10" max="60" step="1" value="60" data-planner-level>' +
          '<div class="planner-scale" aria-hidden="true"><span data-planner-min>10</span><span>60</span></div>' +
        '</div>' +
        '<div class="planner-stats">' +
          '<div class="planner-stat"><span>Disponibles</span><b data-planner-available>51</b></div>' +
          '<div class="planner-stat"><span>Dépensés</span><b data-planner-spent>0</b></div>' +
          '<div class="planner-stat"><span>Restants</span><b data-planner-left>51</b></div>' +
        '</div>' +
      '</div>' +
      '<div class="planner-row planner-row--tools">' +
        '<div class="planner-modes" role="group" aria-label="Comment placer les points">' +
          '<button type="button" class="planner-mode" data-planner-mode="fin" aria-pressed="true">Build niveau 60</button>' +
          '<button type="button" class="planner-mode" data-planner-mode="parcours" aria-pressed="false">Choisir l\'ordre moi-même</button>' +
        '</div>' +
        // Place réservée en permanence (visibility) : afficher ou masquer ces deux
        // contrôles ne change jamais la hauteur du panneau, donc les arbres ne bougent pas.
        '<div class="planner-extra">' +
          '<button type="button" class="planner-toggle-all is-off" data-planner-toggle aria-expanded="false" aria-controls="planner-pop" aria-hidden="true" tabindex="-1">Voir l\'ordre des points</button>' +
          '<button class="btn ghost is-off" type="button" data-planner-recalc aria-hidden="true" tabindex="-1" ' +
            'title="Recalcule l\'ordre arbre par arbre à partir des points déjà placés.">Remettre l\'ordre automatique</button>' +
        '</div>' +
      '</div>' +
      '<p class="planner-hint" data-planner-hint></p>' +
      // Liste flottante (position fixe, hauteur fixe, défilement interne) : hors du flux de la page.
      '<div class="planner-pop" id="planner-pop" data-planner-pop role="dialog" aria-labelledby="planner-pop-title" hidden>' +
        '<div class="planner-pop-head">' +
          '<h2 class="planner-pop-title" id="planner-pop-title">Ordre des points</h2>' +
          '<button type="button" class="planner-pop-close" data-planner-close aria-label="Fermer l\'ordre des points" title="Fermer">×</button>' +
        '</div>' +
        '<div class="planner-all" data-planner-all></div>' +
        '<div class="planner-pop-foot" data-planner-pop-foot hidden>' +
          '<button class="btn ghost" type="button" data-planner-recalc-pop ' +
            'title="Recalcule l\'ordre arbre par arbre à partir des points déjà placés.">Remettre l\'ordre automatique</button>' +
        '</div>' +
      '</div>';
    toolbar.parentNode.insertBefore(panel, toolbar.nextSibling);

    // Nettoie l'ancien bloc « Parcours de montée » s'il existe encore (navigation interne).
    var oldPath = document.querySelector(".planner-path");
    if (oldPath) oldPath.parentNode.removeChild(oldPath);

    var q = function (sel) { return panel.querySelector(sel); };
    var range = q("[data-planner-level]");
    var levelOut = q("[data-planner-level-out]");
    var minOut = q("[data-planner-min]");
    var availableOut = q("[data-planner-available]");
    var spentOut = q("[data-planner-spent]");
    var leftOut = q("[data-planner-left]");
    var recalcBtn = q("[data-planner-recalc]");
    var hint = q("[data-planner-hint]");
    var pop = q("[data-planner-pop]");
    var toggleAll = q("[data-planner-toggle]");
    var allBox = q("[data-planner-all]");
    var closeBtn = q("[data-planner-close]");
    var popFoot = q("[data-planner-pop-foot]");
    q("[data-planner-recalc-pop]").addEventListener("click", function () {
      api.recalc();
    });
    var allKey = "";
    var lastView = null;

    range.addEventListener("input", function () {
      api.setLevel(parseInt(range.value, 10));
    });
    panel.querySelectorAll("[data-planner-mode]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        api.setMode(btn.getAttribute("data-planner-mode"));
      });
    });
    recalcBtn.addEventListener("click", function () {
      api.recalc();
    });
    allBox.addEventListener("click", function (e) {
      var btn = e.target.closest ? e.target.closest("[data-step-level]") : null;
      if (!btn) return;
      api.setLevel(parseInt(btn.getAttribute("data-step-level"), 10));
    });
    function setPopOpen(open) {
      pop.hidden = !open;
      toggleAll.setAttribute("aria-expanded", open ? "true" : "false");
      toggleAll.textContent = open ? "Masquer l'ordre des points" : "Voir l'ordre des points";
      if (open && lastView) {
        renderAll(lastView);
        scrollToCurrent();
      }
    }
    toggleAll.addEventListener("click", function () {
      setPopOpen(pop.hidden);
    });
    closeBtn.addEventListener("click", function () {
      setPopOpen(false);
      toggleAll.focus();
    });
    pop.addEventListener("keydown", function (e) {
      if (e.key === "Escape") {
        setPopOpen(false);
        toggleAll.focus();
      }
    });

    // Fait défiler la liste (et seulement elle) jusqu'au niveau actuel.
    function scrollToCurrent() {
      var row = allBox.querySelector(".planner-step.is-current") || allBox.lastElementChild;
      if (!row) return;
      var top = row.getBoundingClientRect().top - allBox.getBoundingClientRect().top + allBox.scrollTop;
      var target = top - allBox.clientHeight / 2;
      allBox.scrollTop = Math.max(0, target);
    }

    function setOff(node, off) {
      node.classList.toggle("is-off", off);
      if (off) {
        node.setAttribute("aria-hidden", "true");
        node.setAttribute("tabindex", "-1");
      } else {
        node.removeAttribute("aria-hidden");
        node.removeAttribute("tabindex");
      }
    }

    // Ordre complet, regroupé par arbre (segments consécutifs d'un même arbre).
    function renderAll(view) {
      var key = view.order.join(",") + "|" + view.invalidStep;
      if (key !== allKey) {
        allKey = key;
        allBox.innerHTML = "";
        if (!view.steps.length) {
          allBox.appendChild(el("p", "planner-all-empty", "Aucun point placé pour l'instant. Cliquez un talent pour prendre votre premier point."));
        }
        var group = null;
        var list = null;
        var first = 0;
        view.steps.forEach(function (step, i) {
          var prev = view.steps[i - 1];
          if (!prev || prev.treeIdx !== step.treeIdx) {
            group = el("div", "planner-group");
            var head = el("h3", "planner-group-title");
            head.appendChild(document.createTextNode(step.treeName + " "));
            head.appendChild(el("span", "planner-group-range"));
            group.appendChild(head);
            list = el("ol", "planner-group-list");
            group.appendChild(list);
            allBox.appendChild(group);
            first = step.level;
          }
          group.querySelector(".planner-group-range").textContent =
            "niv. " + first + (step.level !== first ? "–" + step.level : "");
          var li = el("li", "planner-step");
          li.appendChild(stepButton(step));
          list.appendChild(li);
        });
      }
      var rows = allBox.querySelectorAll(".planner-step");
      for (var j = 0; j < rows.length; j++) {
        var step = view.steps[j];
        var current = step.level === view.level;
        rows[j].classList.toggle("is-current", current);
        rows[j].classList.toggle("is-future", step.level > view.level);
        rows[j].classList.toggle("is-invalid", j === view.invalidStep);
        var b = rows[j].firstChild;
        if (current) b.setAttribute("aria-current", "step");
        else b.removeAttribute("aria-current");
        if (j === view.invalidStep) b.title = view.validation.message;
      }
    }

    function update(view) {
      lastView = view;
      range.min = view.minLevel;
      range.max = view.maxLevel;
      if (String(range.value) !== String(view.level)) range.value = view.level;
      range.setAttribute("aria-valuetext", "Niveau " + view.level + ", " + view.available + " points disponibles");
      levelOut.textContent = view.level;
      minOut.textContent = view.minLevel;
      availableOut.textContent = view.available;
      spentOut.textContent = view.spentAt;
      leftOut.textContent = Math.max(0, view.available - view.spentAt);

      panel.querySelectorAll("[data-planner-mode]").forEach(function (btn) {
        var on = btn.getAttribute("data-planner-mode") === view.mode;
        btn.classList.toggle("on", on);
        btn.setAttribute("aria-pressed", on ? "true" : "false");
      });
      var parcours = view.mode === "parcours";
      panel.classList.toggle("is-parcours", parcours);
      hint.textContent = HINTS[view.mode] || HINTS.fin;
      setOff(recalcBtn, view.isAuto);
      popFoot.hidden = view.isAuto;

      // « Build niveau 60 » : aucune liste. « Choisir l'ordre » : lien discret, replié par défaut.
      // Ajouter un point ne l'ouvre jamais : on met seulement à jour la liste si elle est déjà ouverte.
      setOff(toggleAll, !parcours);
      if (!parcours && !pop.hidden) setPopOpen(false);
      if (parcours && !pop.hidden) {
        renderAll(view);
        scrollToCurrent();
      }
    }

    return { update: update, message: toast };
  }

  window.WF.levelPlanner = { mount: mount };
})();
