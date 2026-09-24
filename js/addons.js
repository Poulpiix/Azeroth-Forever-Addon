(function () {
  "use strict";

  var SRC = "js/addons.json";

  function esc(s) {
    return String(s == null ? "" : s).replace(/[&<>"']/g, function (c) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c];
    });
  }

  function isSafeUrl(u) { return /^https:\/\//i.test(String(u || "")); }
  function iconName(n) { return /^[a-z0-9_]+$/i.test(String(n || "")) ? n : "trade_engineering"; }

  function item(a) {
    return '<a href="' + esc(a.url) + '" target="_blank" rel="noopener">' +
      '<img class="ui-ico" src="img/icons-webp/32/' + iconName(a.icon) + '.webp" alt="" width="32" height="32">' +
      '<span>' + esc(a.name) +
      '<small class="nav-addon-by">par ' + esc(a.author) + ' · CurseForge</small>' +
      '<small>' + esc(a.blurb) + '</small>' +
      '<span class="sr-only"> (nouvel onglet)</span></span></a>';
  }

  function render(list) {
    list = (Array.isArray(list) ? list : []).filter(function (a) { return a && a.name && isSafeUrl(a.url); });
    if (!list.length) return;
    window.WF = window.WF || {};
    window.WF.ADDONS = list;
    document.querySelectorAll("[data-addons-list]").forEach(function (el) {
      el.innerHTML = list.map(item).join("");
    });
    document.querySelectorAll("[data-addons-footer]").forEach(function (el) {
      el.innerHTML = list.map(function (a) {
        return '<li><a href="' + esc(a.url) + '" target="_blank" rel="noopener">' + esc(a.name) +
          '<span class="sr-only"> (nouvel onglet)</span></a></li>';
      }).join("");
    });
  }

  if (!window.fetch) return;
  fetch(SRC, { cache: "no-cache", credentials: "same-origin" })
    .then(function (r) { if (!r.ok) throw new Error("HTTP " + r.status); return r.json(); })
    .then(function (list) {
      if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", function () { render(list); });
      else render(list);
    })
    .catch(function () {  });
})();
