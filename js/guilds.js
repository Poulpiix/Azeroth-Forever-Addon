/*
 * Azeroth Forever : annuaire de guildes (Phase 5, page /guildes).
 * Schéma et règles : packages/schema/GUILDS.md.
 *
 *  - liste publique + filtres client (faction, recrutement, mode de jeu, ambiance, recherche)
 *  - chaque carte est un <details> natif : sa fiche se déplie sous son résumé
 *  - ?voir=<id> ouvre une fiche au chargement
 *  - compte requis (login Twitch existant) pour créer / éditer / signaler, 1 fiche par compte
 *  - aucun lien Discord ni autre contact : filtré ici ET dans api/guilds.php (source de vérité)
 *  - la même fonction sert aussi la file de modération sur /moderation ([data-guild-mod-root])
 *
 * isForbidden() et isValidBattletag() sont pures et testées sous Node
 * (tools/tests/guilds.test.mjs) : ne pas leur faire toucher au DOM.
 */
(function (root, factory) {
  var api = factory();
  if (typeof module === "object" && module.exports) module.exports = api;
  // Chargé statiquement (page complète) et par le routeur de main.js (navigation interne,
  // guildes.html et moderation.html) : main.js rappelle window.WF.initGuilds() à chaque fois
  // (comme initModeration()), donc boot() doit pouvoir s'exécuter plusieurs fois sans dupliquer
  // ses écouteurs — chaque section se protège avec `dataset.bound`.
  if (root && root.document) {
    root.WF = root.WF || {};
    root.WF.initGuilds = function () { api.boot(root); };
    root.WF.initGuilds();
  }
})(typeof window !== "undefined" ? window : null, function () {
  "use strict";

  var API = "/api/guilds.php";
  var AUTH_API = "/api/auth.php";
  var COMMENTS_API = "/api/comments.php";

  var CLASS_NAMES = { guerrier: "Guerrier", paladin: "Paladin", chasseur: "Chasseur", voleur: "Voleur", pretre: "Prêtre", chaman: "Chaman", mage: "Mage", demoniste: "Démoniste", druide: "Druide" };
  var CLASS_ORDER = ["guerrier", "paladin", "chasseur", "voleur", "pretre", "chaman", "mage", "demoniste", "druide"];
  // Mêmes icônes de classe que le reste du site (class-strip, accueil, js/builds-list.js) :
  // CDN Wowhead déjà utilisé partout ailleurs, aucune image inventée.
  var CLASS_ICON_BASE = "/img/class/";
  var CLASS_ICONS = {
    guerrier: "class_warrior", paladin: "class_paladin", chasseur: "class_hunter", voleur: "class_rogue",
    pretre: "class_priest", chaman: "class_shaman", mage: "class_mage", demoniste: "class_warlock", druide: "class_druid",
  };
  var ROLE_NAMES = { tank: "Tank", heal: "Soin", dps: "Dégâts" };
  var ROLE_ORDER = ["tank", "heal", "dps"];
  // Ambiance et mode de jeu sont deux listes fermées distinctes (correctif du 24/09/2026) :
  // hardcore/pve/pvp/rp ne sont plus dans l'ambiance, « semi-heavy » est devenu « tryhard ».
  var VIBE_NAMES = { casual: "Casual", tryhard: "Try hard", first: "1 seul perso", soirs: "Soirs seulement" };
  var VIBE_ORDER = ["casual", "tryhard", "first", "soirs"];
  var MODE_NAMES = { pve: "PvE", pvp: "PvP", rp: "RP", hardcore: "Hardcore" };
  var MODE_ORDER = ["pve", "pvp", "rp", "hardcore"];
  var FACTION_NAMES = { alliance: "Alliance", horde: "Horde" };
  var RECRUIT_NAMES = { ouvert: "Ouvert", preview: "Preview", ferme: "Fermé" };
  var RECRUIT_BADGE = { ouvert: "badge--live", preview: "badge--soon", ferme: "" };
  var LANGS = ["FR", "EN", "DE", "ES", "Autre"];
  var SIZES = ["10-20", "20-50", "50-100", "100+"];
  var GUILD_REFUSAL = "Contact uniquement par BattleTag";
  var BATTLETAG_RE = /^[A-Za-z][A-Za-z0-9]{2,11}#[0-9]{4,6}$/;

  /* ---------- Validation pure (miroir de wf_guild_forbidden / wf_valid_battletag) ---------- */

  function isForbidden(text) {
    if (typeof text !== "string" || !text.trim()) return null;
    var lower = text.toLowerCase();
    // "discord (dot) gg", "discord dot gg" : le mot « dot »/« point » compte comme un point.
    lower = lower.replace(/\(dot\)|\[dot\]|\bdot\b|\bpoint\b/g, ".");
    var compact = lower.replace(/[^a-z0-9]/g, "");
    var needles = ["discordgg", "discordcom", "discordappcom", "dscgg"];
    for (var i = 0; i < needles.length; i++) {
      if (compact.indexOf(needles[i]) !== -1) return GUILD_REFUSAL;
    }
    if (/[\w.+-]+@[\w-]+\.[a-z]{2,}/i.test(text)) return GUILD_REFUSAL;
    if (/(?:\+?\d[\s.-]?){8,}/.test(text)) return GUILD_REFUSAL;
    var m = text.match(/https?:\/\/\S+/i);
    if (m) {
      var host = "";
      try { host = new URL(m[0]).hostname.toLowerCase(); } catch (e) { host = ""; }
      if (!host || !/(^|\.)azerothforever\.info$/i.test(host)) return GUILD_REFUSAL;
    }
    if (/\bwww\.[a-z0-9-]+\.[a-z]{2,}/i.test(text)) return GUILD_REFUSAL;
    if (/\b[a-z0-9-]{2,}\.(gg|xyz|ru|cn|tk|ly|me|shop|site|online|link)\b/i.test(text)) return GUILD_REFUSAL;
    return null;
  }

  function isValidBattletag(tag) {
    return typeof tag === "string" && BATTLETAG_RE.test(tag);
  }

  var pure = { isForbidden: isForbidden, isValidBattletag: isValidBattletag, GUILD_REFUSAL: GUILD_REFUSAL };
  if (typeof window === "undefined") {
    // Sous Node (tests) : pas de DOM, on s'arrête aux fonctions pures.
    return Object.assign({ boot: function () {} }, pure, {
      CLASS_NAMES: CLASS_NAMES, ROLE_NAMES: ROLE_NAMES, VIBE_NAMES: VIBE_NAMES, MODE_NAMES: MODE_NAMES,
      FACTION_NAMES: FACTION_NAMES, RECRUIT_NAMES: RECRUIT_NAMES, LANGS: LANGS, SIZES: SIZES,
      matchesFilters: matchesFilters,
    });
  }

  /* ---------- Utilitaires DOM ---------- */

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }

  function esc(v) {
    return String(v).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
  }

  function frDate(ts) {
    if (!ts) return "—";
    return new Date(ts * 1000).toLocaleDateString("fr-FR", { day: "numeric", month: "long", year: "numeric" });
  }

  function adminKey() {
    if (window.WF && window.WF.adminKey) return window.WF.adminKey();
    try { var k = localStorage.getItem("wf-admin-key"); return /^[a-f0-9]{40}$/.test(k || "") ? k : null; } catch (e) { return null; }
  }

  function post(url, body, withAdmin) {
    if (withAdmin) body.admin_key = adminKey() || undefined;
    return fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json", Accept: "application/json" },
      credentials: "same-origin",
      body: JSON.stringify(body),
    }).then(function (r) {
      return r.json().catch(function () { throw new Error("Service indisponible pour le moment."); })
        .then(function (d) { if (!r.ok || !d.ok) { var e = new Error(d.error || "Erreur inattendue."); e.status = r.status; throw e; } return d; });
    }, function () { throw new Error("Connexion impossible, vérifie ta connexion internet."); });
  }

  function loginUrl(back) {
    return "/api/auth.php?login=1&return=" + encodeURIComponent(back || (location.pathname + location.search));
  }

  function twoStep(btn, label, confirmLabel, action) {
    btn.addEventListener("click", function () {
      if (btn.dataset.confirm !== "1") {
        btn.dataset.confirm = "1";
        btn.textContent = confirmLabel;
        setTimeout(function () { if (btn.isConnected && !btn.disabled) { btn.dataset.confirm = ""; btn.textContent = label; } }, 4000);
        return;
      }
      btn.disabled = true;
      action();
    });
  }

  function badgeList(map, order, keys) {
    var frag = document.createDocumentFragment();
    (keys || []).forEach(function (k) {
      if (order.indexOf(k) === -1) return;
      frag.appendChild(el("span", "badge gd-tag", map[k] || k));
    });
    return frag;
  }

  /* ---------- Rendu d'une carte ---------- */

  function factionIcon(faction) {
    var img = el("img", "gd-faction-ico");
    img.width = 20; img.height = 20; img.alt = "";
    img.src = "img/icons-webp/32/inv_bannerpvp_" + (faction === "horde" ? "01" : "02") + ".webp";
    return img;
  }

  function renderCard(g, state) {
    var d = el("details", "gd-card");
    d.id = "guilde-" + g.id;
    d.dataset.id = g.id;

    var s = el("summary", "gd-summary");
    s.appendChild(factionIcon(g.faction));
    var head = el("div", "gd-summary-head");
    head.appendChild(el("strong", "gd-name", g.name));
    var meta = el("p", "gd-meta");
    meta.textContent = FACTION_NAMES[g.faction] + " · " + g.region + " · " + g.language + " · " + g.size + " joueurs";
    head.appendChild(meta);
    s.appendChild(head);
    var rb = el("span", "badge" + (RECRUIT_BADGE[g.recruitment] ? " " + RECRUIT_BADGE[g.recruitment] : ""), RECRUIT_NAMES[g.recruitment] || g.recruitment);
    s.appendChild(rb);
    d.appendChild(s);

    var body = el("div", "gd-body");

    if ((g.modes && g.modes.length) || (g.vibes && g.vibes.length)) {
      var tags = el("div", "gd-tags");
      tags.appendChild(badgeList(MODE_NAMES, MODE_ORDER, g.modes));
      tags.appendChild(badgeList(VIBE_NAMES, VIBE_ORDER, g.vibes));
      body.appendChild(tags);
    }

    var facts = el("dl", "gd-facts");
    function fact(label, value) {
      if (!value) return;
      var dt = el("dt", null, label);
      var dd = el("dd", null, value);
      facts.appendChild(dt);
      facts.appendChild(dd);
    }
    fact("Officiers", g.officers);
    if (g.roles && g.roles.length) {
      fact("Recherche", g.roles.map(function (r) { return CLASS_NAMES[r] || ROLE_NAMES[r] || r; }).join(", "));
    }
    fact("Horaires", g.schedule);
    facts.appendChild(el("dt", null, "Mise à jour"));
    facts.appendChild(el("dd", null, frDate(g.updated)));
    body.appendChild(facts);

    if (g.description) {
      body.appendChild(el("p", "gd-desc", g.description));
    }

    var contact = el("div", "gd-contact");
    contact.appendChild(el("span", "gd-contact-label", "Contact"));
    contact.appendChild(el("code", "gd-battletag", g.battletag));
    body.appendChild(contact);

    var actions = el("div", "gd-actions");
    if (!state.mine || state.mine.id !== g.id) {
      var report = el("button", "cmt-btn", "Signaler");
      report.type = "button";
      actions.appendChild(report);
      var reportBox = el("div", "gd-report", null);
      reportBox.hidden = true;
      body.appendChild(reportBox);
      report.addEventListener("click", function () {
        if (!reportBox.hidden) return;
        if (!state.me) {
          reportBox.hidden = false;
          reportBox.innerHTML = "";
          var p = el("p", "cmt-muted", "Connecte-toi avec Twitch pour signaler une fiche.");
          reportBox.appendChild(p);
          var a = el("a", "cmt-twitch", "Se connecter avec Twitch");
          a.href = loginUrl();
          a.setAttribute("data-no-router", "");
          reportBox.appendChild(a);
          return;
        }
        reportBox.hidden = false;
        reportBox.innerHTML = "";
        var input = el("input", "gd-report-input");
        input.type = "text";
        input.maxLength = 120;
        input.placeholder = "Raison (facultatif)";
        var send = el("button", "cmt-btn", "Envoyer le signalement");
        send.type = "button";
        var msg = el("p", "cmt-muted");
        send.addEventListener("click", function () {
          send.disabled = true;
          post(API, { action: "report", id: g.id, reason: input.value }, false).then(function () {
            reportBox.innerHTML = "";
            reportBox.appendChild(el("p", "cmt-muted", "Merci, la fiche a été signalée."));
          }).catch(function (e) { send.disabled = false; msg.textContent = e.message; });
        });
        reportBox.appendChild(input);
        reportBox.appendChild(send);
        reportBox.appendChild(msg);
      });
    }
    body.appendChild(actions);

    d.appendChild(body);
    return d;
  }

  /* ---------- Filtres ---------- */

  function matchesFilters(g, f) {
    if (f.faction && g.faction !== f.faction) return false;
    if (f.region && g.region !== f.region) return false;
    if (f.recruitment && g.recruitment !== f.recruitment) return false;
    if (f.mode && (!g.modes || g.modes.indexOf(f.mode) === -1)) return false;
    if (f.vibe && (!g.vibes || g.vibes.indexOf(f.vibe) === -1)) return false;
    if (f.q) {
      var q = f.q.toLowerCase();
      if (g.name.toLowerCase().indexOf(q) === -1) return false;
    }
    return true;
  }

  /* ---------- Dialogue création / édition ---------- */

  var dialog = null;
  var formEls = {};

  // icons (optionnel) : clé -> nom d'icône Wowhead (CLASS_ICONS), affichée à gauche du texte.
  function checkboxGrid(name, map, order, cls, icons) {
    var wrap = el("div", "gd-checks " + (cls || ""));
    order.forEach(function (key) {
      var label = el("label", "gd-check");
      var input = document.createElement("input");
      input.type = "checkbox";
      input.name = name;
      input.value = key;
      label.appendChild(input);
      if (icons && icons[key]) {
        var img = el("img", "gd-check-ico");
        img.src = CLASS_ICON_BASE + icons[key] + ".webp";
        img.alt = ""; img.width = 18; img.height = 18; img.loading = "lazy";
        label.appendChild(img);
      }
      label.appendChild(document.createTextNode(" " + (map[key] || key)));
      wrap.appendChild(label);
    });
    return wrap;
  }

  function selectField(labelText, name, options, labels) {
    var label = el("label", "save-field");
    label.appendChild(el("span", null, labelText));
    var select = document.createElement("select");
    select.name = name;
    options.forEach(function (opt) {
      var o = document.createElement("option");
      o.value = opt;
      o.textContent = labels ? labels[opt] || opt : opt;
      select.appendChild(o);
    });
    label.appendChild(select);
    return { label: label, select: select };
  }

  function buildDialog() {
    dialog = el("dialog", "save-dialog gd-dialog");
    dialog.setAttribute("aria-labelledby", "gd-dialog-title");

    var form = el("form", "save-form");
    form.setAttribute("novalidate", "");
    form.method = "dialog";

    var head = el("div", "save-head");
    head.appendChild(el("h2", null, "Ma fiche de guilde"));
    head.id = "gd-dialog-title";
    var close = el("button", "save-close", "×");
    close.type = "button";
    close.setAttribute("data-close", "");
    close.setAttribute("aria-label", "Fermer");
    head.appendChild(close);
    form.appendChild(head);

    var step = el("div", "save-step");

    var name = el("label", "save-field");
    name.appendChild(el("span", null, "Nom de la guilde"));
    var nameInput = document.createElement("input");
    nameInput.type = "text"; nameInput.maxLength = 60; nameInput.required = true; nameInput.autocomplete = "off";
    name.appendChild(nameInput);
    step.appendChild(name);

    var factionSel = selectField("Faction", "faction", ["alliance", "horde"], FACTION_NAMES);
    var regionSel = selectField("Région", "region", ["EU", "US"]);
    var langSel = selectField("Langue", "language", LANGS);
    var sizeSel = selectField("Effectif", "size", SIZES);
    var recruitSel = selectField("Recrutement", "recruitment", ["ouvert", "preview", "ferme"], RECRUIT_NAMES);
    var row1 = el("div", "gd-row");
    [factionSel, regionSel].forEach(function (f) { row1.appendChild(f.label); });
    var row2 = el("div", "gd-row");
    [langSel, sizeSel, recruitSel].forEach(function (f) { row2.appendChild(f.label); });
    step.appendChild(row1);
    step.appendChild(row2);

    var officers = el("label", "save-field");
    officers.appendChild(el("span", null, "Officiers (pseudos jeu, séparés par une virgule)"));
    var officersInput = document.createElement("input");
    officersInput.type = "text"; officersInput.maxLength = 300; officersInput.placeholder = "Ex. Poulpix, Zug";
    officers.appendChild(officersInput);
    step.appendChild(officers);

    step.appendChild(el("p", "save-field-label", "Classes / rôles recherchés"));
    var roleKeys = CLASS_ORDER.concat(ROLE_ORDER);
    var roleMap = Object.assign({}, CLASS_NAMES, ROLE_NAMES);
    var rolesBox = checkboxGrid("roles", roleMap, roleKeys, "gd-checks--roles", CLASS_ICONS);
    step.appendChild(rolesBox);

    step.appendChild(el("p", "save-field-label", "Mode de jeu"));
    var modesBox = checkboxGrid("modes", MODE_NAMES, MODE_ORDER, "gd-checks--modes");
    step.appendChild(modesBox);

    step.appendChild(el("p", "save-field-label", "Ambiance"));
    var vibesBox = checkboxGrid("vibes", VIBE_NAMES, VIBE_ORDER, "gd-checks--vibes");
    step.appendChild(vibesBox);

    var schedule = el("label", "save-field");
    schedule.appendChild(el("span", null, "Horaires + fuseau"));
    var scheduleInput = document.createElement("input");
    scheduleInput.type = "text"; scheduleInput.maxLength = 120; scheduleInput.placeholder = "Ex. Soirs 20h-23h CET";
    schedule.appendChild(scheduleInput);
    step.appendChild(schedule);

    var desc = el("label", "save-field");
    var descLabel = el("span", null, "Description (800 caractères max)");
    desc.appendChild(descLabel);
    var descArea = document.createElement("textarea");
    descArea.maxLength = 800; descArea.rows = 5;
    descArea.placeholder = "Ambiance, objectifs, ce que tu recherches…";
    desc.appendChild(descArea);
    step.appendChild(desc);

    var tag = el("label", "save-field");
    tag.appendChild(el("span", null, "BattleTag de contact"));
    var tagInput = document.createElement("input");
    tagInput.type = "text"; tagInput.maxLength = 20; tagInput.placeholder = "Nom#1234"; tagInput.autocomplete = "off";
    tag.appendChild(tagInput);
    step.appendChild(tag);

    var hp = document.createElement("input");
    hp.type = "text"; hp.name = "website"; hp.className = "save-hp"; hp.tabIndex = -1; hp.autocomplete = "off"; hp.setAttribute("aria-hidden", "true");
    step.appendChild(hp);

    var error = el("p", "save-error");
    error.setAttribute("role", "alert"); error.hidden = true;
    step.appendChild(error);

    var actions = el("div", "save-actions");
    var cancel = el("button", "btn ghost", "Annuler");
    cancel.type = "button"; cancel.setAttribute("data-close", "");
    var deleteBtn = el("button", "btn ghost danger", "Supprimer ma fiche");
    deleteBtn.type = "button"; deleteBtn.hidden = true;
    var submit = el("button", "btn primary", "Publier ma fiche");
    submit.type = "submit";
    actions.appendChild(deleteBtn);
    actions.appendChild(cancel);
    actions.appendChild(submit);
    step.appendChild(actions);

    form.appendChild(step);
    dialog.appendChild(form);
    document.body.appendChild(dialog);

    formEls = {
      form: form, name: nameInput, faction: factionSel.select, region: regionSel.select,
      language: langSel.select, size: sizeSel.select, recruitment: recruitSel.select,
      officers: officersInput, rolesBox: rolesBox, modesBox: modesBox, vibesBox: vibesBox, schedule: scheduleInput,
      desc: descArea, tag: tagInput, hp: hp, error: error, submit: submit, deleteBtn: deleteBtn,
    };

    Array.prototype.forEach.call(dialog.querySelectorAll("[data-close]"), function (b) {
      b.addEventListener("click", function () { dialog.close(); });
    });
    dialog.addEventListener("click", function (e) { if (e.target === dialog) dialog.close(); });
    return formEls;
  }

  function setChecks(box, values) {
    var set = {};
    (values || []).forEach(function (v) { set[v] = true; });
    Array.prototype.forEach.call(box.querySelectorAll("input[type=checkbox]"), function (c) {
      c.checked = !!set[c.value];
    });
  }
  function getChecks(box) {
    return Array.prototype.filter.call(box.querySelectorAll("input[type=checkbox]"), function (c) { return c.checked; })
      .map(function (c) { return c.value; });
  }

  function fillDialog(g) {
    formEls.name.value = g ? g.name : "";
    formEls.faction.value = g ? g.faction : "alliance";
    formEls.region.value = g ? g.region : "EU";
    formEls.language.value = g ? g.language : "FR";
    formEls.size.value = g ? g.size : "10-20";
    formEls.recruitment.value = g ? g.recruitment : "ouvert";
    formEls.officers.value = g ? g.officers : "";
    formEls.schedule.value = g ? g.schedule : "";
    formEls.desc.value = g ? g.description : "";
    formEls.tag.value = g ? g.battletag : "";
    setChecks(formEls.rolesBox, g ? g.roles : []);
    setChecks(formEls.modesBox, g ? g.modes : []);
    setChecks(formEls.vibesBox, g ? g.vibes : []);
    formEls.deleteBtn.hidden = !g;
    formEls.submit.textContent = g ? "Mettre à jour ma fiche" : "Publier ma fiche";
    formEls.error.hidden = true;
    formEls.error.textContent = "";
  }

  function collectPayload() {
    return {
      name: formEls.name.value.trim(),
      faction: formEls.faction.value,
      region: formEls.region.value,
      language: formEls.language.value,
      size: formEls.size.value,
      recruitment: formEls.recruitment.value,
      officers: formEls.officers.value,
      roles: getChecks(formEls.rolesBox),
      modes: getChecks(formEls.modesBox),
      vibes: getChecks(formEls.vibesBox),
      schedule: formEls.schedule.value.trim(),
      description: formEls.desc.value.trim(),
      battletag: formEls.tag.value.trim(),
      website: formEls.hp.value,
    };
  }

  function localCheck(payload) {
    if (payload.name.length < 3) return "Donne un nom de guilde d'au moins 3 caractères.";
    if (!isValidBattletag(payload.battletag)) return "BattleTag invalide : format attendu Nom#1234.";
    var fields = [payload.name, payload.officers, payload.schedule, payload.description];
    for (var i = 0; i < fields.length; i++) {
      var problem = isForbidden(fields[i]);
      if (problem) return problem;
    }
    return null;
  }

  /* ---------- Page publique /guildes ---------- */

  function boot(win) {
    var doc = win.document;
    if (doc.readyState === "loading") { doc.addEventListener("DOMContentLoaded", function () { run(win); }); }
    else run(win);
  }

  function run(win) {
    var doc = win.document;
    initDirectory(doc);
    initModQueue(doc);
  }

  function initDirectory(doc) {
    var root = doc.querySelector("[data-guild-root]");
    if (!root || root.dataset.bound) return;
    root.dataset.bound = "1";

    var accountBox = root.querySelector("[data-guild-account]");
    var filtersBox = root.querySelector("[data-guild-filters]");
    var grid = root.querySelector("[data-guild-grid]");
    var empty = root.querySelector("[data-guild-empty]");

    var state = { guilds: [], me: null, mine: null, filters: { faction: "", region: "", recruitment: "", mode: "", vibe: "", q: "" } };

    function applyUrlFilters() {
      var u = new URL(location.href);
      ["faction", "region", "recruitment", "mode", "vibe", "q"].forEach(function (k) {
        state.filters[k] = u.searchParams.get(k) || "";
      });
    }
    function writeUrlFilters() {
      var u = new URL(location.href);
      Object.keys(state.filters).forEach(function (k) {
        if (state.filters[k]) u.searchParams.set(k, state.filters[k]); else u.searchParams.delete(k);
      });
      history.replaceState(history.state, "", u.pathname + u.search + u.hash);
    }

    // Construit la barre de filtres une seule fois (l'input de recherche garde le focus
    // pendant la frappe) ; updateFilterUI() se contente ensuite de rafraîchir aria-pressed.
    var chipButtons = []; // { name, value, btn }
    var searchInput = null;

    // Une seule barre compacte, groupes visuellement séparés (label + pastilles), qui
    // wrappent proprement sur mobile (correctif du 24/09/2026).
    function renderFiltersOnce() {
      filtersBox.innerHTML = "";
      chipButtons = [];
      var form = el("form", "gd-filterbar");
      form.addEventListener("submit", function (e) { e.preventDefault(); });

      var searchGroup = el("div", "gd-filter-group gd-filter-group--search");
      searchInput = document.createElement("input");
      searchInput.type = "search"; searchInput.placeholder = "Chercher une guilde…"; searchInput.value = state.filters.q;
      searchInput.className = "gd-search";
      searchInput.setAttribute("aria-label", "Chercher une guilde");
      searchInput.addEventListener("input", function () { state.filters.q = searchInput.value; refresh(); });
      searchGroup.appendChild(searchInput);
      form.appendChild(searchGroup);

      function chipGroup(label, name, map, order) {
        var group = el("div", "gd-filter-group");
        group.appendChild(el("span", "gd-filter-label", label));
        var box = el("div", "ig-filters");
        function chip(value, chipLabel) {
          var b = el("button", "ig-chip", chipLabel);
          b.type = "button";
          b.addEventListener("click", function () {
            state.filters[name] = state.filters[name] === value ? "" : value;
            refresh();
          });
          chipButtons.push({ name: name, value: value, btn: b });
          box.appendChild(b);
        }
        chip("", "Tous");
        order.forEach(function (k) { chip(k, map[k]); });
        group.appendChild(box);
        return group;
      }

      form.appendChild(chipGroup("Faction", "faction", FACTION_NAMES, ["alliance", "horde"]));
      form.appendChild(chipGroup("Recrutement", "recruitment", RECRUIT_NAMES, ["ouvert", "preview", "ferme"]));
      form.appendChild(chipGroup("Mode de jeu", "mode", MODE_NAMES, MODE_ORDER));
      form.appendChild(chipGroup("Ambiance", "vibe", VIBE_NAMES, VIBE_ORDER));
      filtersBox.appendChild(form);
      updateFilterUI();
    }

    function updateFilterUI() {
      chipButtons.forEach(function (c) {
        c.btn.setAttribute("aria-pressed", state.filters[c.name] === c.value ? "true" : "false");
      });
      if (searchInput && searchInput.value !== state.filters.q) searchInput.value = state.filters.q;
    }

    function renderAccount() {
      accountBox.innerHTML = "";
      if (!state.me) {
        accountBox.appendChild(el("span", "cmt-muted", "Connecte-toi avec Twitch pour publier la fiche de ta guilde."));
        var a = el("a", "cmt-twitch", "Se connecter avec Twitch");
        a.href = loginUrl();
        a.setAttribute("data-no-router", "");
        accountBox.appendChild(a);
        return;
      }
      var who = el("span", "cmt-who");
      who.appendChild(document.createTextNode("Connecté en tant que "));
      who.appendChild(el("strong", null, state.me.name));
      accountBox.appendChild(who);
      var btn = el("button", "btn primary", state.mine ? "Modifier ma fiche" : "Créer ma fiche");
      btn.type = "button";
      btn.addEventListener("click", openDialog);
      accountBox.appendChild(btn);
      if (state.mine) {
        var upd = el("span", "cmt-muted", "Fiche « " + state.mine.name + " », mise à jour le " + frDate(state.mine.updated) + ".");
        accountBox.appendChild(upd);
      }
    }

    function openDialog() {
      if (!dialog) buildDialog();
      fillDialog(state.mine);
      formEls.deleteBtn.onclick = function () {
        twoStepDelete();
      };
      formEls.form.onsubmit = function (e) {
        e.preventDefault();
        submitDialog();
      };
      if (typeof dialog.showModal === "function") dialog.showModal();
    }

    // state.guilds vient d'un fetch antérieur : après save/delete, on le recharge
    // depuis le serveur plutôt que de bricoler la liste en local (ordre, statut à jour).
    function reloadGuilds() {
      // L'API répond avec Cache-Control: max-age=30 (bon pour le chargement initial) ; juste
      // après une sauvegarde ou une suppression, on veut la version fraîche, pas le cache HTTP.
      return fetch(API + "?list=1", { credentials: "same-origin", cache: "no-store" }).then(function (r) { return r.json(); })
        .then(function (d) { state.guilds = d.guilds || []; refresh(); })
        .catch(function () {});
    }

    function twoStepDelete() {
      var btn = formEls.deleteBtn;
      if (btn.dataset.confirm !== "1") {
        btn.dataset.confirm = "1";
        btn.textContent = "Confirmer la suppression ?";
        setTimeout(function () { btn.dataset.confirm = ""; btn.textContent = "Supprimer ma fiche"; }, 4000);
        return;
      }
      btn.disabled = true;
      post(API, { action: "delete" }, false).then(function () {
        state.mine = null;
        dialog.close();
        renderAccount();
        reloadGuilds();
      }).catch(function (e) {
        btn.disabled = false;
        formEls.error.hidden = false;
        formEls.error.textContent = e.message;
      });
    }

    function submitDialog() {
      var payload = collectPayload();
      var problem = localCheck(payload);
      if (problem) {
        formEls.error.hidden = false;
        formEls.error.textContent = problem;
        return;
      }
      formEls.submit.disabled = true;
      post(API, Object.assign({ action: "save" }, payload), false).then(function (d) {
        formEls.submit.disabled = false;
        state.mine = d.guild;
        dialog.close();
        renderAccount();
        reloadGuilds();
      }).catch(function (e) {
        formEls.submit.disabled = false;
        formEls.error.hidden = false;
        formEls.error.textContent = e.message;
      });
    }

    function refresh() {
      writeUrlFilters();
      updateFilterUI();
      grid.innerHTML = "";
      var visible = state.guilds.filter(function (g) { return matchesFilters(g, state.filters); });
      empty.hidden = visible.length > 0;
      visible.forEach(function (g) { grid.appendChild(renderCard(g, state)); });
      var wanted = new URL(location.href).searchParams.get("voir");
      if (wanted) {
        var target = grid.querySelector('[data-id="' + CSS.escape(wanted) + '"]');
        if (target) { target.open = true; target.scrollIntoView({ block: "start", behavior: "smooth" }); }
      }
    }

    applyUrlFilters();
    renderFiltersOnce();
    Promise.all([
      fetch(API + "?list=1", { credentials: "same-origin" }).then(function (r) { return r.json(); }).catch(function () { return { guilds: [] }; }),
      fetch(AUTH_API + "?me=1", { credentials: "same-origin", headers: { Accept: "application/json" } }).then(function (r) { return r.json(); }).catch(function () { return {}; }),
    ]).then(function (res) {
      state.guilds = res[0].guilds || [];
      state.me = res[1].user || null;
      renderAccount();
      refresh();
      if (!state.me) return null;
      return post(API, { action: "mine" }, false).then(function (d) { state.mine = d.guild; renderAccount(); }).catch(function () {});
    }).catch(function () {
      grid.innerHTML = "";
      empty.hidden = false;
      empty.textContent = "Impossible de charger l'annuaire pour le moment.";
    });
  }

  /* ---------- File de modération (/moderation) ---------- */

  function initModQueue(doc) {
    var root = doc.querySelector("[data-guild-mod-root]");
    if (!root || root.dataset.bound) return;
    root.dataset.bound = "1";

    function load() {
      post(API, { action: "queue" }, true).then(render).catch(function (e) {
        root.innerHTML = "";
        root.appendChild(el("p", "comment-empty", e.message));
      });
    }

    function render(d) {
      root.innerHTML = "";
      if (!d.items.length) {
        root.appendChild(el("p", "comment-empty", "Aucune fiche de guilde à modérer."));
        return;
      }
      d.items.forEach(function (g) {
        var card = el("article", "cmt mod-item" + (g.status !== "visible" ? " is-hidden" : ""));
        var top = el("header", "cmt-top");
        top.appendChild(el("strong", "cmt-author", g.name));
        top.appendChild(el("span", "cmt-muted", "@" + g.author.login));
        if (g.author.banned) top.appendChild(el("span", "cmt-badge banned", "Banni"));
        top.appendChild(el("span", "cmt-badge " + (g.status === "reported" ? "warn" : g.status === "hidden" ? "hidden" : "ok"),
          g.status === "reported" ? "Masqué auto" : g.status === "hidden" ? "Masqué" : "Visible"));
        card.appendChild(top);

        var ctx = el("p", "mod-context", (FACTION_NAMES[g.faction] || g.faction) + " · " + g.region + " · " + g.reports + " signalement" + (g.reports > 1 ? "s" : "") + (g.reasons ? " · motifs : " + g.reasons : ""));
        card.appendChild(ctx);
        if (g.description) card.appendChild(el("p", "rich-text cmt-body", g.description));
        card.appendChild(el("p", "gd-battletag-line", "Contact : " + g.battletag));

        var actions = el("div", "cmt-actions");
        if (g.status !== "visible" || g.reports > 0) {
          actions.appendChild(modBtn("Rétablir", "", null, function () { return post(API, { action: "moderate", id: g.id, do: "show" }, true).then(load); }));
        }
        if (g.status === "visible") {
          actions.appendChild(modBtn("Masquer", "", null, function () { return post(API, { action: "moderate", id: g.id, do: "hide" }, true).then(load); }));
        }
        actions.appendChild(modBtn("Supprimer", "danger", "Confirmer ?", function () { return post(API, { action: "moderate", id: g.id, do: "delete" }, true).then(load); }));
        if (!g.author.banned) {
          actions.appendChild(modBtn("Bannir l'auteur", "danger", "Bannir et supprimer sa fiche ?", function () {
            return post(COMMENTS_API, { action: "ban", user_id: g.owner_user_id, ban: true }, true).then(load);
          }));
        }
        card.appendChild(actions);
        root.appendChild(card);
      });
    }

    function modBtn(label, cls, confirmLabel, action) {
      var b = el("button", "cmt-btn" + (cls ? " " + cls : ""), label);
      b.type = "button";
      if (confirmLabel) { twoStep(b, label, confirmLabel, function () { action().catch(function (e) { b.disabled = false; b.textContent = e.message; }); }); }
      else b.addEventListener("click", function () { b.disabled = true; action().catch(function (e) { b.disabled = false; b.textContent = e.message; }); });
      return b;
    }

    load();
  }

  return Object.assign({ boot: boot }, pure, {
    CLASS_NAMES: CLASS_NAMES, ROLE_NAMES: ROLE_NAMES, VIBE_NAMES: VIBE_NAMES,
    FACTION_NAMES: FACTION_NAMES, RECRUIT_NAMES: RECRUIT_NAMES, LANGS: LANGS, SIZES: SIZES,
    matchesFilters: matchesFilters,
  });
});
