/*
 * Azeroth Forever : interface de partage commune (pages classe et Héritage).
 *
 *  - bouton « Partager » + menu : Copier le lien / Copier le code addon / Coller un code
 *  - fenêtre « Coller un code »
 *  - routage d'un code collé : AF1- vers la bonne classe, AF1H- vers /arbre-heritage
 *  - toast (même élément que le planificateur de niveau)
 *
 * Dépend de share-code.js (window.WF.shareCode). Aucun script inline, aucun CDN (CSP).
 */
window.WF = window.WF || {};

(function () {
  "use strict";

  var TOAST_DELAY = 2000;
  var TOAST_DELAY_LONG = 4000;
  var toastTimer = null;

  function toast(text, kind) {
    var node = document.querySelector("[data-af-toast]");
    if (!node) {
      node = document.createElement("div");
      node.className = "af-toast";
      node.setAttribute("data-af-toast", "");
      node.setAttribute("role", "status");
      node.setAttribute("aria-live", "polite");
      document.body.appendChild(node);
    }
    clearTimeout(toastTimer);
    if (!text) {
      node.classList.remove("show");
      return;
    }
    node.textContent = text;
    node.className = "af-toast show is-" + (kind || "info");
    var delay = kind && kind.indexOf("notice") === 0 ? TOAST_DELAY_LONG : TOAST_DELAY;
    toastTimer = setTimeout(function () { node.classList.remove("show"); }, delay);
  }

  function copyText(text, doneMessage, promptLabel) {
    var done = function () { toast(doneMessage, "info"); };
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).then(done, function () { window.prompt(promptLabel, text); });
    } else {
      window.prompt(promptLabel, text);
    }
  }

  // Où doit aller un code collé ? page = { kind: "C", slug } ou { kind: "H" }.
  // Renvoie { ok:false, error } | { ok:true, local:true, code } | { ok:true, navigate: url }.
  function routeCode(input, page) {
    var info = window.WF.shareCode.inspect(input);
    if (!info.ok) return info;
    if (info.kind === page.kind) return { ok: true, local: true, code: info.code };
    if (info.kind === "H") return { ok: true, navigate: "/arbre-heritage?code=" + encodeURIComponent(info.code) };
    return { ok: true, navigate: "/" + info.slug + "?code=" + encodeURIComponent(info.code) };
  }

  /* ---------- Menu « Partager » ---------- */

  // copyBtn : le bouton « Copier le lien » existant (il garde son attribut et son écouteur).
  // handlers : { copyCode: fn, paste: fn }.
  function mountMenu(copyBtn, handlers) {
    var bar = copyBtn.parentNode;
    if (bar.classList.contains("share-menu-list")) return; // déjà en place

    var wrap = document.createElement("div");
    wrap.className = "share-menu";
    wrap.setAttribute("data-share-menu", "");
    wrap.innerHTML =
      '<button type="button" class="btn primary share-toggle" data-share-toggle aria-haspopup="menu" aria-expanded="false" aria-controls="share-menu-list">' +
        'Partager<span class="share-caret" aria-hidden="true"></span></button>' +
      '<div class="share-menu-list" id="share-menu-list" role="menu" aria-label="Partager" data-share-list hidden></div>';
    bar.insertBefore(wrap, copyBtn);
    var toggle = wrap.querySelector("[data-share-toggle]");
    var list = wrap.querySelector("[data-share-list]");

    function item(node, label, hint) {
      node.type = "button";
      node.className = "share-item";
      node.setAttribute("role", "menuitem");
      node.setAttribute("tabindex", "-1");
      node.innerHTML = "";
      node.appendChild(document.createTextNode(label));
      if (hint) {
        var small = document.createElement("small");
        small.textContent = hint;
        node.appendChild(small);
      }
      list.appendChild(node);
      return node;
    }

    item(copyBtn, "Copier le lien", handlers.linkHint || "Lien de cette page");
    var codeBtn = item(document.createElement("button"), "Copier le code addon", handlers.codeHint || "Code à coller dans l'addon ou sur ce site");
    codeBtn.setAttribute("data-copy-code", "");
    codeBtn.addEventListener("click", function () { closeMenu(false); handlers.copyCode(); });
    var pasteBtn = item(document.createElement("button"), "Coller un code", "Code AF1- (classe) ou AF1H- (héritage)");
    pasteBtn.setAttribute("data-paste-code", "");
    pasteBtn.addEventListener("click", function () { closeMenu(false); handlers.paste(); });
    copyBtn.addEventListener("click", function () { closeMenu(false); });

    function items() {
      return Array.prototype.slice.call(list.querySelectorAll("[role=menuitem]"));
    }
    // Position fixe calculée à l'ouverture : jamais coupé par une barre qui défile.
    function place() {
      var r = toggle.getBoundingClientRect();
      var w = Math.max(list.offsetWidth, 260);
      var left = Math.min(window.innerWidth - w - 8, Math.max(8, r.right - w));
      list.style.left = left + "px";
      list.style.top = (r.bottom + 6) + "px";
    }
    function openMenu() {
      list.hidden = false;
      toggle.setAttribute("aria-expanded", "true");
      place();
      items()[0].focus();
      document.addEventListener("click", outside, true);
      window.addEventListener("scroll", onScroll, true);
      window.addEventListener("resize", onScroll);
    }
    function closeMenu(focusToggle) {
      if (list.hidden) return;
      list.hidden = true;
      toggle.setAttribute("aria-expanded", "false");
      document.removeEventListener("click", outside, true);
      window.removeEventListener("scroll", onScroll, true);
      window.removeEventListener("resize", onScroll);
      if (focusToggle) toggle.focus();
    }
    function outside(e) {
      if (!wrap.contains(e.target)) closeMenu(false);
    }
    function onScroll() {
      closeMenu(false);
    }
    toggle.addEventListener("click", function () {
      if (list.hidden) openMenu();
      else closeMenu(true);
    });
    toggle.addEventListener("keydown", function (e) {
      if (e.key === "ArrowDown" && list.hidden) {
        e.preventDefault();
        openMenu();
      }
    });
    list.addEventListener("keydown", function (e) {
      var all = items();
      var i = all.indexOf(document.activeElement);
      if (e.key === "Escape") {
        e.preventDefault();
        closeMenu(true);
      } else if (e.key === "ArrowDown") {
        e.preventDefault();
        all[(i + 1) % all.length].focus();
      } else if (e.key === "ArrowUp") {
        e.preventDefault();
        all[(i - 1 + all.length) % all.length].focus();
      } else if (e.key === "Home") {
        e.preventDefault();
        all[0].focus();
      } else if (e.key === "End") {
        e.preventDefault();
        all[all.length - 1].focus();
      } else if (e.key === "Tab") {
        closeMenu(false);
      }
    });
  }

  /* ---------- Fenêtre « Coller un code » ---------- */

  var pasteHandler = null;

  function pasteDialog() {
    var dlg = document.querySelector("[data-paste-dialog]");
    if (dlg) return dlg;
    dlg = document.createElement("dialog");
    dlg.className = "af-dialog";
    dlg.setAttribute("data-paste-dialog", "");
    dlg.setAttribute("aria-labelledby", "af-paste-title");
    dlg.innerHTML =
      '<form class="af-dialog-body" method="dialog" data-paste-form>' +
        '<h2 class="af-dialog-title" id="af-paste-title">Coller un code</h2>' +
        '<p class="af-dialog-help">Collez un code AF1- (build de classe) ou AF1H- (héritage), copié sur le site ou dans l\'addon. Il sera rouvert à l\'identique, sur la bonne page.</p>' +
        '<label class="sr-only" for="af-paste-input">Code AF1- ou AF1H-</label>' +
        '<textarea id="af-paste-input" class="af-dialog-input" rows="3" spellcheck="false" autocomplete="off" ' +
          'placeholder="AF1-… ou AF1H-…" data-paste-input></textarea>' +
        '<p class="af-dialog-error" data-paste-error role="alert" hidden></p>' +
        '<div class="af-dialog-actions">' +
          '<button type="button" class="btn ghost" data-paste-cancel>Annuler</button>' +
          '<button type="submit" class="btn primary" data-paste-open>Ouvrir</button>' +
        '</div>' +
      '</form>';
    document.body.appendChild(dlg);
    var input = dlg.querySelector("[data-paste-input]");
    var error = dlg.querySelector("[data-paste-error]");
    dlg.querySelector("[data-paste-cancel]").addEventListener("click", function () { closeDialog(dlg); });
    dlg.querySelector("[data-paste-form]").addEventListener("submit", function (e) {
      e.preventDefault();
      var msg = pasteHandler ? pasteHandler(input.value) : "";
      if (msg) {
        error.textContent = msg;
        error.hidden = false;
        input.focus();
        return;
      }
      error.hidden = true;
      closeDialog(dlg);
    });
    return dlg;
  }

  // onSubmit(texte) : renvoie un message d'erreur, ou "" / null si le code est accepté.
  function openPasteDialog(onSubmit) {
    pasteHandler = onSubmit;
    var dlg = pasteDialog();
    var input = dlg.querySelector("[data-paste-input]");
    input.value = "";
    dlg.querySelector("[data-paste-error]").hidden = true;
    if (typeof dlg.showModal === "function") dlg.showModal();
    else dlg.setAttribute("open", "");
    setTimeout(function () { input.focus(); }, 30);
  }

  function closeDialog(dlg) {
    if (typeof dlg.close === "function") dlg.close();
    else dlg.removeAttribute("open");
  }

  window.WF.shareUI = {
    toast: toast,
    copyText: copyText,
    routeCode: routeCode,
    mountMenu: mountMenu,
    openPasteDialog: openPasteDialog
  };
})();
