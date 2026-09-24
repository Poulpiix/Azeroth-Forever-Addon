window.WF = window.WF || {};
(function () {
  "use strict";

  function day(iso, endOfDay) {
    if (!iso) return null;
    var d = new Date(iso + (endOfDay ? "T23:59:59" : "T00:00:00"));
    return isNaN(d.getTime()) ? null : d;
  }

  function daysUntil(now, target) {
    var a = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    var b = new Date(target.getFullYear(), target.getMonth(), target.getDate());
    return Math.round((b - a) / 864e5);
  }

  function badge(cls, text) {
    var b = document.createElement("span");
    b.className = "badge " + cls;
    b.textContent = text;
    return b;
  }

  function init() {
    var root = document.querySelector("[data-rm-timeline]");
    if (!root) return;
    var items = Array.prototype.slice.call(root.querySelectorAll(".rm-item"));
    var now = new Date();
    var passed = 0;
    var next = null;

    items.forEach(function (it) {
      it.classList.remove("is-next");
      var start = day(it.getAttribute("data-start"), false);
      var end = day(it.getAttribute("data-end") || it.getAttribute("data-start"), true);
      var slot = it.querySelector("[data-rm-status]");
      var status = "à venir";
      var label = null;

      if (start && end) {
        if (now > end) { status = "passé"; passed++; label = badge("badge--done", "✓ Passé"); }
        else if (now >= start) { status = "en cours"; label = badge("badge--live", "● En cours"); }
        else {
          var n = daysUntil(now, start);
          label = badge("badge--soon", n <= 0 ? "Aujourd'hui" : n === 1 ? "Demain" : "Dans " + n + " jours");
        }
      }
      it.setAttribute("data-status", status);
      if (slot && label) { slot.textContent = ""; slot.appendChild(label); }
      if (!next && status !== "passé") next = it;
    });

    var count = document.querySelector("[data-rm-count]");
    if (count) count.textContent = passed + " / " + items.length;

    var card = document.querySelector("[data-rm-next]");
    if (!card) return;
    if (!next) { card.hidden = true; return; }
    next.classList.add("is-next");
    var title = card.querySelector("[data-rm-next-title]");
    var h = next.querySelector("h3");
    var date = next.querySelector(".rm-date");
    var first = next.querySelector("ul li");
    var icon = next.querySelector(".rm-card > .ui-ico");
    var cardIcon = card.querySelector(".ui-ico");
    var metaEl = card.querySelector("[data-rm-next-meta]");
    if (title && h) title.textContent = h.textContent + (next.getAttribute("data-status") === "en cours" ? " · en cours" : "");
    if (metaEl) {
      var parts = [];
      if (date) parts.push(date.textContent);
      if (first) parts.push(first.textContent.replace(/^Jouable /, ""));
      metaEl.textContent = parts.join(" · ");
    }
    if (icon && cardIcon) cardIcon.src = icon.getAttribute("src");
  }

  window.WF.initRoadmap = init;
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
