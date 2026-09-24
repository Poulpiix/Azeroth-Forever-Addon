/*
 * Azeroth Forever : page /donjons.
 *
 *  - filtres Tous / Classic / Nouveau / Raids / BG (?filtre=)
 *  - clic sur une carte : sa fiche se déplie sous la rangée de cartes (une seule à la fois) ;
 *    reclic, clic dans le vide ou Échap pour la refermer, clic sur une autre carte pour changer ;
 *    ?ouvrir=<slug> ouvre une fiche au chargement
 *  - fiches lues dans data/instances/_fiches.json (généré par tools/instances/build.mjs) ;
 *    si elles manquent, la fiche minimale est lue sur la carte (jamais de message d'erreur)
 *
 * Rien n'est inventé : une donnée sans source s'affiche « — » (TBD).
 * Aucun script inline, aucun CDN (CSP). renderDetail() est pur et testé sous Node.
 */
(function (root, factory) {
  var api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  if (root && root.document) api.boot(root);
})(typeof window !== "undefined" ? window : null, function () {
  "use strict";

  var TYPES = { dungeon: "Donjon", raid: "Raid", bg: "Champ de bataille" };
  var ORIGINS = { classic: "Classic", "new": "Nouveau Forever" };
  var CONFIDENCE = {
    confirme: "Confirmé en jeu",
    annonce: "Annonce officielle",
    classic: "Donnée Classic, à revérifier en Forever",
    tbd: "Non vérifié"
  };
  var FACTIONS = { alliance: "Alliance", horde: "Horde", both: "Les deux factions" };

  /* ---------- Rendu (pur) ---------- */

  function esc(v) {
    return String(v).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#x27;");
  }

  // Valeur absente : un tiret visible, « non renseigné » pour les lecteurs d'écran.
  var NA = '<span class="ig-na" title="TBD : pas encore de source">—<span class="sr-only"> non renseigné</span></span>';

  function val(v, fmt) {
    if (v === null || v === undefined || v === "") return NA;
    return fmt ? fmt(v) : esc(v);
  }

  function frDate(iso) {
    if (!iso) return "date non indiquée";
    var p = iso.split("-");
    return p[2] + "/" + p[1] + "/" + p[0];
  }

  function players(p) {
    return p === "15v15" ? "15 contre 15" : p + " joueurs";
  }

  function shortLabel(s) {
    var i = s.label.indexOf(" (");
    return i > 0 ? s.label.slice(0, i) : s.label;
  }

  function sourceRef(inst, id) {
    for (var i = 0; i < (inst.sources || []).length; i++) {
      var s = inst.sources[i];
      if (s.id !== id) continue;
      if (s.ref === "/donjons") return esc(shortLabel(s));
      var ext = /^https?:/.test(s.ref);
      return '<a href="' + esc(ext ? s.ref : s.ref.replace(/^\//, "")) + '"' + (ext ? ' target="_blank" rel="noopener"' : "") + ">" + esc(shortLabel(s)) + "</a>";
    }
    return NA;
  }

  function fact(label, value) {
    return "<div><dt>" + label + "</dt><dd>" + value + "</dd></div>";
  }

  var TODO = '<p class="ig-empty-line">À compléter</p>';

  function names(n) {
    return "<b>" + esc(n.fr) + "</b>" + (n.en && n.en !== n.fr ? ' <span class="ig-en">(' + esc(n.en) + ")</span>" : "");
  }

  function renderBoss(inst, b) {
    return "<li>" + names(b.names) +
      ' <span class="ig-conf">' + esc(CONFIDENCE[b.confidence] || "") + "</span>" +
      (b.oneLiner ? "<p>" + esc(b.oneLiner) + "</p>" : "") +
      (b.foreverNote ? "<p><small>Forever et Classic : " + esc(b.foreverNote) + "</small></p>" : "") +
      "<p><small>Source : " + sourceRef(inst, b.source) + "</small></p></li>";
  }

  function renderQuest(inst, q) {
    var r = q.rewards || {};
    var items = r.items && r.items.length ? r.items.map(esc).join(", ") : null;
    return "<li>" + names(q.names) +
      ' <span class="ig-conf">' + esc(CONFIDENCE[q.confidence] || "") + "</span>" +
      '<dl class="ig-facts ig-facts--mini">' +
        fact("Niveau", val(q.level)) +
        fact("Faction", val(FACTIONS[q.faction])) +
        fact("Donneur", val(q.giver)) +
        fact("Rendu", val(q.turnIn)) +
        fact("Objectifs", val(q.objectives)) +
        fact("Récompenses", [r.xp ? esc(r.xp) + " XP" : "", r.money ? esc(r.money) : "", r.reputation ? esc(r.reputation) : "", items || ""].filter(Boolean).join(", ") || NA) +
      "</dl><p><small>Source : " + sourceRef(inst, q.source) + "</small></p></li>";
  }

  // Contenu de la fiche dépliée. Marche avec bosses[] et quests[] vides.
  function renderDetail(inst) {
    var n = inst.names;
    var sub = [];
    if (n.en && n.en !== n.fr) sub.push('<span lang="en">' + esc(n.en) + "</span>");
    if (!n.frOfficial) sub.push('<i class="ig-unofficial">nom FR non officiel</i>');
    if (inst.availability) sub.push('<b class="ig-avail">' + esc(inst.availability.text) + "</b>");
    if (inst.note) sub.push(esc(inst.note));
    if (inst.aliases && inst.aliases.length) sub.push("Aussi appelé sur le site : " + inst.aliases.map(esc).join(", "));

    var e = inst.entry || {};
    var entree = [inst.levelEntry ? "niveau " + inst.levelEntry + "." : "", e.where ? esc(e.where) : "", e.how ? esc(e.how) : ""].filter(Boolean).join(" ");
    var facts =
      fact("Type", TYPES[inst.type]) +
      fact("Origine", ORIGINS[inst.origin]) +
      fact("Niveaux", val(inst.levels, function (l) { return '<b class="num">' + l.min + "–" + l.max + "</b>"; })) +
      fact("Joueurs", val(inst.players, players)) +
      fact("Group Finder", val(inst.levelFinder, function (v) { return "niveau " + v; })) +
      fact("Entrée", entree || NA) +
      fact("Lockout", val(inst.lockout));

    var bosses = inst.bosses || [];
    var quests = inst.quests || [];
    var cols =
      '<section class="ig-detail-block"><h4>Bosses' + (bosses.length ? " <small>" + bosses.length + "</small>" : "") + "</h4>" +
        (bosses.length ? '<ol class="ig-detail-list">' + bosses.map(function (b) { return renderBoss(inst, b); }).join("") + "</ol>" : TODO) + "</section>" +
      '<section class="ig-detail-block"><h4>Quêtes' + (quests.length ? " <small>" + quests.length + "</small>" : "") + "</h4>" +
        (quests.length ? '<ul class="ig-detail-list">' + quests.map(function (q) { return renderQuest(inst, q); }).join("") + "</ul>" : TODO) + "</section>";

    var foot = [];
    if (inst.type !== "bg") foot.push("Butin : " + esc(inst.loot || "Loot non publié."));
    if (inst.origin === "classic") foot.push("Écarts avec Classic : " + (inst.classicDiff ? esc(inst.classicDiff) : NA));
    var sources = inst.sources || [];
    if (sources.length) foot.push("Sources : " + sources.map(function (s) { return sourceRef(inst, s.id) + " (" + frDate(s.date) + ")"; }).join(", "));

    return (
      '<div class="ig-detail-box">' +
        '<header class="ig-detail-head">' +
          '<div class="ig-detail-titles"><h3 id="ig-detail-title">' + esc(n.fr) + "</h3>" +
          (sub.length ? '<p class="ig-detail-sub">' + sub.join(" · ") + "</p>" : "") + "</div>" +
        "</header>" +
        '<dl class="ig-facts">' + facts + "</dl>" +
        (inst.summary ? '<p class="ig-detail-lead">' + esc(inst.summary) + " <small>Source : " + sourceRef(inst, inst.summarySource) + "</small></p>" : "") +
        '<div class="ig-detail-cols">' + cols + "</div>" +
        '<p class="ig-detail-foot">' + foot.join(" · ") + ". « — » : pas encore de source. Sujet à changement pendant la bêta.</p>" +
      "</div>"
    );
  }

  /* ---------- Page ---------- */

  var FILTERS = {
    tous: function () { return true; },
    classic: function (c) { return c.getAttribute("data-origin") === "classic"; },
    "new": function (c) { return c.getAttribute("data-origin") === "new"; },
    raid: function (c) { return c.getAttribute("data-kind") === "raid"; },
    bg: function (c) { return c.getAttribute("data-kind") === "bg"; }
  };

  var page = null; // état de la page /donjons affichée (recréé à chaque visite via le routeur)

  function setParam(name, value) {
    try {
      var url = new URL(window.location.href);
      if (value) url.searchParams.set(name, value); else url.searchParams.delete(name);
      window.history.replaceState(window.history.state, "", url.pathname + url.search + url.hash);
    } catch (e) { /* navigateur ancien : l'URL ne suit pas */ }
  }

  function reducedMotion() {
    return window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  }

  function applyFilter(key, push) {
    if (!FILTERS[key]) key = "tous";
    var test = FILTERS[key];
    Array.prototype.forEach.call(document.querySelectorAll("[data-ig-filters] .ig-chip"), function (b) {
      b.setAttribute("aria-pressed", b.getAttribute("data-filter") === key ? "true" : "false");
    });
    var shown = 0;
    Array.prototype.forEach.call(document.querySelectorAll(".ig-section"), function (sec) {
      var n = 0;
      Array.prototype.forEach.call(sec.querySelectorAll(".ig-card"), function (c) {
        var ok = test(c);
        c.hidden = !ok;
        if (ok) n++;
      });
      sec.hidden = n === 0;
      shown += n;
    });
    var empty = document.querySelector("[data-ig-empty]");
    if (empty) empty.hidden = shown > 0;
    if (push) setParam("filtre", key === "tous" ? "" : key);
    if (page && page.open) {
      var card = cardOf(page.open);
      if (!card || card.hidden) close(false);
      else place(card);
    }
  }

  function upgradeMedia() {
    if (!window.fetch || !document.querySelector(".ig-ph")) return;
    fetch("img/instances-webp/instances-media.json", { credentials: "same-origin" })
      .then(function (r) { return r.ok ? r.json() : null; })
      .then(function (data) {
        if (!data || !data.instances) return;
        data.instances.forEach(function (m) {
          if (!m.file) return;
          var card = document.querySelector('.ig-card[data-id="' + m.id + '"]');
          var ph = card && card.querySelector(".ig-ph");
          if (!ph) return;
          var img = new Image();
          img.className = "ig-img";
          img.alt = "";
          img.width = 960;
          img.height = 540;
          img.decoding = "async";
          img.onload = function () { ph.replaceWith(img); };
          img.src = "img/instances-webp/" + m.file;
        });
      })
      .catch(function () {});
  }

  /* ---------- Fiches dépliables ---------- */

  function loadData(src) {
    if (!window.fetch || !src) return Promise.reject(new Error("fetch indisponible"));
    return fetch(src, { credentials: "same-origin" })
      .then(function (r) { if (!r.ok) throw new Error("HTTP " + r.status); return r.json(); })
      .then(function (data) {
        var bySlug = {};
        data.instances.forEach(function (inst) {
          inst.slugs.forEach(function (s) { bySlug[s] = inst; });
        });
        return bySlug;
      });
  }

  function cardOf(slug) {
    return page.list.querySelector('.ig-card[data-slug="' + slug + '"]');
  }

  function detailEl() {
    if (page.detail) return page.detail;
    var li = document.createElement("li");
    li.className = "ig-detail";
    li.id = "ig-detail";
    li.setAttribute("role", "region");
    li.setAttribute("aria-labelledby", "ig-detail-title");
    li.hidden = true;
    li.innerHTML = '<div class="ig-detail-inner"></div>';
    page.detail = li;
    return li;
  }

  // Place la fiche juste après la dernière carte visible de la rangée de `card`.
  function place(card) {
    var li = detailEl();
    var wasHidden = li.hidden;
    li.hidden = true; // mesure des rangées sans la fiche
    var grid = card.parentNode;
    var top = card.offsetTop;
    var last = card;
    Array.prototype.forEach.call(grid.querySelectorAll(".ig-card"), function (c) {
      if (!c.hidden && c.offsetTop === top) last = c;
    });
    if (last.nextSibling !== li) grid.insertBefore(li, last.nextSibling);
    li.hidden = wasHidden && !page.open;
  }

  // Fiche minimale lue sur la carte elle-même (nom, type, niveaux, joueurs…) :
  // sert tant que data/instances/_fiches.json n'est pas chargé, ou s'il manque.
  function cardInfo(card) {
    var kind = card.getAttribute("data-kind");
    var origin = card.getAttribute("data-origin");
    var title = card.querySelector(".ig-link, h3");
    var fr = title ? title.textContent.trim() : "";
    var enNode = card.querySelector(".ig-en");
    var raw = enNode ? enNode.textContent.trim() : "";
    var inner = (/^\(([^)]*)\)/.exec(raw) || [])[1] || "";
    var en = origin === "classic" ? fr : null;
    var note = null;
    if (inner) {
      if (/^[a-zà-ÿ]/.test(inner) || /^LBRS/.test(inner)) {
        note = inner.charAt(0).toUpperCase() + inner.slice(1) + ".";
        if (/^nom du champ/.test(inner) || /^LBRS/.test(inner)) en = null;
      } else if (inner.indexOf(", ") > 0) {
        en = inner.slice(0, inner.indexOf(", "));
        note = inner.charAt(inner.indexOf(", ") + 2).toUpperCase() + inner.slice(inner.indexOf(", ") + 3) + ".";
      } else {
        en = inner;
      }
    }
    var levels = null;
    var num = card.querySelector(".ig-meta .num");
    var m = num && /(\d+)\D+(\d+)/.exec(num.textContent);
    if (m) levels = { min: +m[1], max: +m[2] };
    var playersVal = null;
    var availability = null;
    Array.prototype.forEach.call(card.querySelectorAll(".ig-meta > span"), function (sp) {
      var t = sp.textContent.trim();
      var pm = /^(\d+) joueurs$/.exec(t);
      if (pm) playersVal = +pm[1];
      else if (t === "15 contre 15") playersVal = "15v15";
      else if (/^Ouverture|^Pas encore ouvert|^Champ de bataille/.test(t)) availability = { text: t };
    });
    return {
      slug: card.getAttribute("data-slug"),
      names: { fr: fr, en: en, frOfficial: raw.indexOf("nom FR non officiel") < 0 },
      aliases: [], type: kind, origin: origin, note: note,
      levels: levels, players: playersVal, availability: availability,
      levelFinder: null, levelEntry: null, lockout: null,
      entry: {}, bosses: [], quests: [], sources: []
    };
  }

  // Toujours un bloc d'infos : la fiche JSON si elle est là, sinon ce que dit la carte.
  function fill(slug) {
    var inst = (page.data && page.data[slug]) || cardInfo(cardOf(slug));
    detailEl().firstChild.innerHTML = renderDetail(inst);
  }

  function setExpanded(slug, on) {
    var card = cardOf(slug);
    if (!card) return;
    card.classList.toggle("is-open", on);
    var btn = card.querySelector(".ig-link");
    if (btn) btn.setAttribute("aria-expanded", on ? "true" : "false");
  }

  function open(slug, opts) {
    opts = opts || {};
    var card = cardOf(slug);
    if (!card) return;
    if (card.hidden) applyFilter("tous", true);
    var li = detailEl();
    var before = card.getBoundingClientRect().top;
    var switching = !!page.open;
    if (page.open) setExpanded(page.open, false);
    page.open = slug;
    setExpanded(slug, true);
    fill(slug);
    clearTimeout(page.hideTimer);
    place(card);
    li.hidden = false;
    // La carte cliquée ne bouge pas à l'écran quand la fiche change de rangée.
    var delta = card.getBoundingClientRect().top - before;
    if (switching && delta && !opts.scroll) window.scrollBy({ top: delta, behavior: "instant" });
    if (switching || reducedMotion()) {
      li.classList.add("is-open");
    } else {
      li.classList.remove("is-open");
      void li.offsetHeight; // repart de la hauteur 0 pour l'animation
      li.classList.add("is-open");
    }
    if (opts.url !== false) setParam("ouvrir", slug);
    var behavior = reducedMotion() ? "auto" : "smooth";
    if (opts.scroll) {
      var header = document.querySelector(".app-header");
      var offset = (header ? header.getBoundingClientRect().height : 0) + 12;
      window.scrollTo({ top: Math.max(0, card.getBoundingClientRect().top + window.pageYOffset - offset), behavior: "instant" });
    } else {
      setTimeout(function () {
        var r = li.getBoundingClientRect();
        if (r.bottom > window.innerHeight && page && page.open === slug) {
          window.scrollBy({ top: Math.min(r.bottom - window.innerHeight + 16, r.top - 80), behavior: behavior });
        }
      }, reducedMotion() ? 0 : 230);
    }
  }

  function close(focusCard) {
    if (!page || !page.open) return;
    var slug = page.open;
    var li = detailEl();
    var hadFocus = li.contains(document.activeElement);
    page.open = null;
    setExpanded(slug, false);
    li.classList.remove("is-open");
    clearTimeout(page.hideTimer);
    page.hideTimer = setTimeout(function () { if (!page.open) li.hidden = true; }, reducedMotion() ? 0 : 230);
    setParam("ouvrir", "");
    if (focusCard || hadFocus) {
      var card = cardOf(slug);
      var btn = card && card.querySelector(".ig-link");
      if (btn) btn.focus();
    }
  }

  function onResize() {
    if (!page || !page.open || !page.list.isConnected) return;
    var card = cardOf(page.open);
    if (card) place(card);
  }

  function init() {
    var bar = document.querySelector("[data-ig-filters]");
    var list = document.querySelector("[data-ig-list]");
    if (!bar || !list) return;
    page = { list: list, data: null, open: null, detail: null, hideTimer: 0 };
    var current = page;

    bar.addEventListener("click", function (e) {
      var b = e.target.closest(".ig-chip");
      if (b) applyFilter(b.getAttribute("data-filter"), true);
    });
    list.addEventListener("click", function (e) {
      var btn = e.target.closest(".ig-link");
      if (!btn) return;
      var slug = btn.closest(".ig-card").getAttribute("data-slug");
      if (page.open === slug) close(false);
      else open(slug);
    });

    var params = null;
    try { params = new URL(window.location.href).searchParams; } catch (e) {}
    var start = (params && params.get("filtre")) || "tous";
    if (start !== "tous") applyFilter(start, false);
    upgradeMedia();

    var wanted = params && params.get("ouvrir");
    if (wanted && /^[a-z0-9-]+$/.test(wanted) && cardOf(wanted)) {
      open(wanted, { scroll: true });
      wanted = null;
    }
    loadData(list.getAttribute("data-instances-src")).then(function (bySlug) {
      if (page !== current) return;
      page.data = bySlug;
      if (page.open) fill(page.open);
      if (wanted && !page.open) {
        var inst = bySlug[wanted]; // alias anglais
        if (inst && cardOf(inst.slug)) open(inst.slug, { scroll: true });
        else setParam("ouvrir", "");
      }
    }, function () {
      // Fiches JSON absentes : les cartes suffisent pour le bloc minimal.
      if (page !== current) return;
      if (wanted && !page.open) setParam("ouvrir", "");
    });
  }

  // Clic dans le vide (hors de la carte ouverte et de sa fiche) : on referme.
  // Un clic sur une autre carte est géré par la liste (elle s'ouvre à la place).
  function onDocClick(e) {
    if (!page || !page.open || !page.list.isConnected) return;
    var t = e.target;
    if (!t || !t.closest) return;
    if (t.closest(".ig-card") || t.closest("#ig-detail") || t.closest(".ig-chip")) return;
    close(false);
  }

  function onDocKey(e) {
    if (e.key === "Escape" && page && page.open && page.list.isConnected) {
      e.preventDefault();
      close(true);
    }
  }

  function boot(win) {
    // Le routeur du site peut réexécuter ce fichier : un seul écouteur, qui appelle la version courante.
    var first = !win.__wfDungeons;
    win.__wfDungeons = { resize: onResize, click: onDocClick, key: onDocKey };
    if (first) {
      var t = 0;
      win.addEventListener("resize", function () {
        clearTimeout(t);
        t = setTimeout(function () { win.__wfDungeons.resize(); }, 120);
      });
      win.document.addEventListener("click", function (e) { win.__wfDungeons.click(e); });
      win.document.addEventListener("keydown", function (e) { win.__wfDungeons.key(e); });
    }
    if (win.document.readyState === "loading") win.document.addEventListener("DOMContentLoaded", init);
    else init();
  }

  return { renderDetail: renderDetail, boot: boot };
});
