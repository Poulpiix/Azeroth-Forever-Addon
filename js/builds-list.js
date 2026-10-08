(function () {
  "use strict";

  window.WF = window.WF || {};
  if (window.WF.initBuildsLists) return;

  var API = "/api/builds.php";
  var ICON = "/img/class/";

  var CLASSES = [
    { slug: "guerrier", name: "Guerrier", color: "#C79C6E", icon: "class_warrior" },
    { slug: "paladin", name: "Paladin", color: "#F58CBA", icon: "class_paladin" },
    { slug: "chasseur", name: "Chasseur", color: "#ABD473", icon: "class_hunter" },
    { slug: "voleur", name: "Voleur", color: "#FFF569", icon: "class_rogue" },
    { slug: "pretre", name: "Prêtre", color: "#FFFFFF", icon: "class_priest" },
    { slug: "chaman", name: "Chaman", color: "#0070DE", icon: "class_shaman" },
    { slug: "mage", name: "Mage", color: "#69CCF0", icon: "class_mage" },
    { slug: "demoniste", name: "Démoniste", color: "#9482C9", icon: "class_warlock" },
    { slug: "druide", name: "Druide", color: "#FF7D0A", icon: "class_druid" },
  ];
  var BY_SLUG = {};
  CLASSES.forEach(function (c) { BY_SLUG[c.slug] = c; });

  var SORTS = [
    { id: "likes", label: "Les plus aimés", param: null },
    { id: "views", label: "Les plus vus", param: "vues" },
    { id: "recent", label: "Les plus récents", param: "recent" },
  ];

  var LIKED_KEY = "wf-liked";
  function likedSet() {
    try { return JSON.parse(localStorage.getItem(LIKED_KEY) || "{}") || {}; } catch (e) { return {}; }
  }
  function setLiked(id, on) {
    var m = likedSet();
    if (on) m[id] = 1; else delete m[id];
    try { localStorage.setItem(LIKED_KEY, JSON.stringify(m)); } catch (e) {}
  }
  var HEART = '<svg viewBox="0 0 24 24" width="14" height="14" aria-hidden="true" focusable="false"><path d="M12 21s-7.5-4.6-10-9.3C.3 8.4 2.2 4.5 6 4.5c2.2 0 3.6 1.2 4.4 2.4h3.2c.8-1.2 2.2-2.4 4.4-2.4 3.8 0 5.7 3.9 4 7.2C19.5 16.4 12 21 12 21z"/></svg>';

  function likeButton(b) {
    var btn = el("button", "build-like");
    btn.type = "button";
    var count = el("span", "build-like-count", String(b.likes || 0));
    btn.innerHTML = HEART;
    btn.appendChild(count);
    function paint(on, n) {
      btn.classList.toggle("on", on);
      btn.setAttribute("aria-pressed", on ? "true" : "false");
      btn.title = on ? "Tu aimes ce build (cliquer pour retirer)" : "J'aime ce build";
      btn.setAttribute("aria-label", (on ? "Retirer mon j'aime" : "J'aime") + " (" + n + ")");
      count.textContent = String(n);
    }
    var n = b.likes || 0;
    paint(!!likedSet()[b.id], n);
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();
      if (btn.disabled) return;
      var on = !btn.classList.contains("on");
      btn.disabled = true;
      paint(on, Math.max(0, n + (on ? 1 : -1)));
      fetch(API, {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify({ action: "like", id: b.id, like: on }),
      }).then(function (r) { return r.json(); }).then(function (d) {
        if (!d.ok) throw new Error(d.error);
        n = d.likes;
        setLiked(b.id, d.liked);
        paint(d.liked, n);
      }).catch(function () {
        paint(!on, n);
      }).then(function () { btn.disabled = false; });
    });
    return btn;
  }

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }

  function timeAgo(ts) {
    var s = Math.max(0, Date.now() / 1000 - ts);
    if (s < 60) return "à l'instant";
    if (s < 3600) return "il y a " + Math.floor(s / 60) + " min";
    if (s < 86400) return "il y a " + Math.floor(s / 3600) + " h";
    if (s < 86400 * 30) return "il y a " + Math.floor(s / 86400) + " j";
    return new Date(ts * 1000).toLocaleDateString("fr-FR", { day: "numeric", month: "short", year: "numeric" });
  }

  function fmtViews(n) {
    return n.toLocaleString("fr-FR") + (n > 1 ? " vues" : " vue");
  }

  function adminKey() {
    return window.WF.adminKey ? window.WF.adminKey() : null;
  }

  var TRASH = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M4 7h16M10 11v6M14 11v6M6 7l1 12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2l1-12M9 7V4h6v3"/></svg>';
  function adminDelete(b, wrap) {
    var del = el("button", "build-admin-del");
    del.type = "button";
    del.innerHTML = TRASH;
    var label = el("span", "del-label");
    del.appendChild(label);
    function idle() {
      del.dataset.confirm = "";
      del.classList.remove("is-error");
      label.textContent = "";
      del.title = "Supprimer ce build (admin)";
      del.setAttribute("aria-label", "Supprimer le build « " + b.name + " » (admin)");
    }
    idle();
    del.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();
      if (del.dataset.confirm !== "1") {
        del.dataset.confirm = "1";
        del.classList.remove("is-error");
        label.textContent = "Confirmer ?";
        del.setAttribute("aria-label", "Confirmer la suppression de « " + b.name + " »");
        setTimeout(function () { if (del.isConnected && !del.disabled && del.dataset.confirm === "1") idle(); }, 4000);
        return;
      }
      del.disabled = true;
      label.textContent = "…";
      fetch(API, {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify({ action: "delete", id: b.id, token: adminKey() }),
      }).then(function (r) { return r.json(); }).then(function (d) {
        if (!d.ok) throw new Error(d.error || "Erreur");
        wrap.classList.add("is-deleted");
        setTimeout(function () { wrap.remove(); }, 250);
      }).catch(function (err) {
        del.disabled = false;
        del.dataset.confirm = "";
        del.classList.add("is-error");
        label.textContent = err.message || "Erreur";
      });
    });
    return del;
  }

  // compact (cartes de la home, data-compact) : structure à hauteur fixe, la même sur
  // toutes les cartes, pour que le bouton « J'aime » ne saute jamais d'une carte à l'autre.
  //  - build-sub : une seule ligne (classe/spec + auteur réunis, tronqués avec …)
  //  - build-meta : toujours 2 lignes (niveau/vues/commentaires, puis la date)
  function renderRow(b, rank, plain, compact) {
    var c = BY_SLUG[b.class] || { name: b.class, color: "#ccc", icon: "inv_misc_questionmark" };
    var a = el("a", "build-row");
    a.href = "/" + b.class + "?build=" + encodeURIComponent(b.build) +
      (b.path ? "&path=" + encodeURIComponent(b.path) : "") + "&b=" + b.id;
    a.style.setProperty("--row-class", c.color);

    a.appendChild(el("span", "build-rank", rank ? String(rank) : ""));

    var img = el("img", "build-icon");
    img.src = ICON + c.icon + ".webp";
    img.alt = "";
    img.width = 36;
    img.height = 36;
    img.loading = "lazy";
    a.appendChild(img);

    var main = el("span", "build-main");
    main.appendChild(el("span", "build-name", b.name));
    var sub = el("span", "build-sub");
    if (compact) {
      var subText = c.name + " · " + b.split.join(" / ") + (b.author ? " · par " + b.author : "");
      var subSpan = el("span", "build-class", subText);
      subSpan.title = subText; // nom d'auteur tronqué (…) : le texte complet reste au survol
      sub.appendChild(subSpan);
    } else {
      sub.appendChild(el("span", "build-class", c.name + " · " + b.split.join(" / ")));
      if (b.author) sub.appendChild(el("span", "build-author", "par " + b.author));
    }
    main.appendChild(sub);
    a.appendChild(main);

    var meta = el("span", "build-meta");
    if (compact) {
      var line1 = "Niv. " + b.level + " · " + fmtViews(b.views);
      if (b.comments > 0) line1 += " · " + b.comments + (b.comments > 1 ? " commentaires" : " commentaire");
      meta.appendChild(el("span", "build-meta-line", line1));
      meta.appendChild(el("span", "build-meta-line build-date", timeAgo(b.created)));
    } else {
      meta.appendChild(el("span", null, "Niveau " + b.level));
      meta.appendChild(el("span", null, fmtViews(b.views)));
      if (plain) meta.appendChild(el("span", null, (b.likes || 0) + " j'aime"));
      if (b.comments > 0) meta.appendChild(el("span", "build-comments", b.comments + (b.comments > 1 ? " commentaires" : " commentaire")));
      meta.appendChild(el("span", "build-date", timeAgo(b.created)));
    }
    a.appendChild(meta);
    if (plain) return a;
    var wrap = el("div", "build-row-wrap");
    wrap.appendChild(a);
    wrap.appendChild(likeButton(b));
    if (adminKey()) wrap.appendChild(adminDelete(b, wrap));
    return wrap;
  }

  function setupList(root) {
    if (root.dataset.bound) return;
    root.dataset.bound = "1";
    var limit = parseInt(root.getAttribute("data-limit"), 10) || 20;
    var withControls = root.hasAttribute("data-controls");
    var urlState = root.hasAttribute("data-url-state");

    var state = { class: "", sort: root.getAttribute("data-sort") || "likes", offset: 0, loading: false, req: 0 };
    var compact = root.hasAttribute("data-compact");
    if (compact) root.classList.add("is-compact");
    if (urlState) {
      var qs = new URL(location.href).searchParams;
      if (BY_SLUG[qs.get("classe")]) state.class = qs.get("classe");
      SORTS.forEach(function (s) { if (s.param && qs.get("tri") === s.param) state.sort = s.id; });
    }

    var controls, classBtns = [], sortBtns = [];
    if (withControls) {
      controls = el("div", "builds-controls");

      var classBar = el("div", "builds-filter");
      classBar.setAttribute("role", "group");
      classBar.setAttribute("aria-label", "Filtrer par classe");
      [{ slug: "", name: "Toutes" }].concat(CLASSES).forEach(function (c) {
        var b = el("button", "builds-chip");
        b.type = "button";
        b.dataset.slug = c.slug;
        if (c.icon) {
          var i = el("img");
          i.src = ICON + c.icon + ".webp";
          i.alt = "";
          i.width = 20;
          i.height = 20;
          b.appendChild(i);
          b.style.setProperty("--chip-class", c.color);
        }
        b.appendChild(el("span", null, c.name));
        b.addEventListener("click", function () {
          if (state.class === c.slug) return;
          state.class = c.slug;
          reload();
        });
        classBtns.push(b);
        classBar.appendChild(b);
      });

      var sortBar = el("div", "builds-sort");
      sortBar.setAttribute("role", "group");
      sortBar.setAttribute("aria-label", "Trier");
      SORTS.forEach(function (s) {
        var b = el("button", "builds-sort-btn", s.label);
        b.type = "button";
        b.dataset.sort = s.id;
        b.addEventListener("click", function () {
          if (state.sort === s.id) return;
          state.sort = s.id;
          reload();
        });
        sortBtns.push(b);
        sortBar.appendChild(b);
      });

      controls.appendChild(classBar);
      controls.appendChild(sortBar);
      root.appendChild(controls);
    }

    var list = el("div", "builds-rows");
    list.setAttribute("aria-live", "polite");
    root.appendChild(list);

    var more = null;
    if (withControls) {
      more = el("button", "btn ghost builds-more", "Afficher plus de builds");
      more.type = "button";
      more.hidden = true;
      more.addEventListener("click", function () { load(false); });
      root.appendChild(more);
    }

    function syncControls() {
      classBtns.forEach(function (b) {
        var on = b.dataset.slug === state.class;
        b.classList.toggle("on", on);
        b.setAttribute("aria-pressed", on ? "true" : "false");
      });
      sortBtns.forEach(function (b) {
        var on = b.dataset.sort === state.sort;
        b.classList.toggle("on", on);
        b.setAttribute("aria-pressed", on ? "true" : "false");
      });
      if (urlState) {
        var url = new URL(location.href);
        if (state.class) url.searchParams.set("classe", state.class); else url.searchParams.delete("classe");
        var sortDef = SORTS.filter(function (x) { return x.id === state.sort; })[0];
        if (sortDef && sortDef.param) url.searchParams.set("tri", sortDef.param); else url.searchParams.delete("tri");
        history.replaceState(null, "", url.toString());
      }
    }

    function message(text, linkHref, linkText) {
      var p = el("p", "builds-empty", text);
      if (linkHref) {
        p.appendChild(document.createTextNode(" "));
        var a = el("a", null, linkText);
        a.href = linkHref;
        p.appendChild(a);
      }
      list.appendChild(p);
    }

    function reload() {
      state.offset = 0;
      syncControls();
      load(true);
    }

    function load(reset) {
      var reqId = ++state.req;
      state.loading = true;
      root.classList.add("is-loading");
      if (more) more.disabled = true;

      var q = "?list=1&limit=" + limit + "&offset=" + (reset ? 0 : state.offset) + "&sort=" + state.sort +
        (state.class ? "&class=" + state.class : "");

      fetch(API + q, { headers: { Accept: "application/json" }, cache: adminKey() ? "no-store" : "default" })
        .then(function (r) { return r.json(); })
        .then(function (data) {
          if (reqId !== state.req) return;
          if (!data.ok) throw new Error(data.error);
          if (reset) { list.innerHTML = ""; state.offset = 0; }

          if (!data.builds.length && state.offset === 0) {
            var c = BY_SLUG[state.class];
            if (c) message("Aucun build public " + (/^[AEIOUÉÈÊ]/i.test(c.name) ? "d'" : "de ") + c.name + " pour l'instant.", "/" + c.slug, "Crée le premier !");
            else message("Aucun build public pour l'instant. Choisis une classe, place tes points et clique sur « Sauvegarder le build ».");
          }

          data.builds.forEach(function (b, i) {
            list.appendChild(renderRow(b, state.offset + i + 1, false, compact));
          });
          state.offset += data.builds.length;
          if (more) { more.hidden = !data.hasMore; more.disabled = false; }
        })
        .catch(function () {
          if (reqId !== state.req) return;
          if (reset) list.innerHTML = "";
          message("Impossible de charger les builds pour le moment.");
          if (more) more.hidden = true;
        })
        .then(function () {
          if (reqId !== state.req) return;
          state.loading = false;
          root.classList.remove("is-loading");
        });
    }

    reload();
  }

  var MY_KEY = "wf-my-builds";
  function myBuilds() {
    try { return JSON.parse(localStorage.getItem(MY_KEY) || "[]") || []; } catch (e) { return []; }
  }
  function saveMyBuilds(list) {
    try { localStorage.setItem(MY_KEY, JSON.stringify(list.slice(0, 200))); } catch (e) {}
  }
  function editUrl(id, token) {
    return location.origin + "/b/" + id + "#modifier=" + token;
  }
  function post(body) {
    return fetch(API, {
      method: "POST",
      headers: { "Content-Type": "application/json", Accept: "application/json" },
      body: JSON.stringify(body),
    }).then(function (r) {
      return r.json().catch(function () { throw new Error("Service indisponible."); })
        .then(function (d) { if (!r.ok || !d.ok) throw new Error(d.error || "Erreur inattendue."); return d; });
    });
  }
  function copy(text, btn) {
    function done() { var t = btn.textContent; btn.textContent = "Copié !"; setTimeout(function () { btn.textContent = t; }, 1500); }
    if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(text).then(done, function () { window.prompt("Copie ce lien :", text); });
    else window.prompt("Copie ce lien :", text);
  }

  function setupMine(root) {
    if (root.dataset.bound) return;
    root.dataset.bound = "1";
    var list = el("div", "builds-rows");
    list.setAttribute("aria-live", "polite");
    root.appendChild(list);

    var claim = el("form", "my-claim");
    claim.noValidate = true;
    claim.appendChild(el("label", "save-link-label", "Tu as un lien de modification ? Colle-le ici pour retrouver ton build sur cet appareil."));
    var row = el("div", "save-link");
    var input = el("input");
    input.type = "text";
    input.placeholder = location.origin + "/b/…#modifier=…";
    input.setAttribute("aria-label", "Lien de modification");
    var go = el("button", "btn", "Ajouter");
    go.type = "submit";
    row.appendChild(input);
    row.appendChild(go);
    claim.appendChild(row);
    var msg = el("p", "save-hint");
    claim.appendChild(msg);
    root.appendChild(claim);

    claim.addEventListener("submit", function (e) {
      e.preventDefault();
      var m = /\/b\/([A-Za-z0-9]{8})\/?#modifier=([a-f0-9]{32})/.exec(input.value.trim()) ||
              /[?&]b=([A-Za-z0-9]{8})[^#]*#modifier=([a-f0-9]{32})/.exec(input.value.trim());
      if (!m) { msg.textContent = "Ce n'est pas un lien de modification valide."; return; }
      go.disabled = true;
      post({ action: "verify", id: m[1], token: m[2] }).then(function () {
        var mine = myBuilds().filter(function (b) { return b.id !== m[1]; });
        mine.unshift({ id: m[1], token: m[2] });
        saveMyBuilds(mine);
        input.value = "";
        msg.textContent = "Build ajouté à « Mes builds ».";
        load();
      }).catch(function (err) { msg.textContent = err.message; })
        .then(function () { go.disabled = false; });
    });

    function empty(text) {
      list.innerHTML = "";
      list.appendChild(el("p", "builds-empty", text));
    }

    function load() {
      var mine = myBuilds().filter(function (b) { return b && b.id && b.token; });
      updateCount(mine.length);
      if (!mine.length) {
        empty("Tu n'as encore sauvegardé aucun build depuis ce navigateur. Choisis une classe, place tes points et clique sur « Sauvegarder le build ».");
        return;
      }
      root.classList.add("is-loading");
      var tokens = {};
      mine.forEach(function (b) { tokens[b.id] = b.token; });
      fetch(API + "?ids=" + mine.map(function (b) { return b.id; }).join(","), { headers: { Accept: "application/json" }, cache: "no-store" })
        .then(function (r) { return r.json(); })
        .then(function (d) {
          if (!d.ok) throw new Error();
          var found = {};
          d.builds.forEach(function (b) { found[b.id] = true; });
          saveMyBuilds(myBuilds().filter(function (b) { return found[b.id]; }));
          updateCount(d.builds.length);
          list.innerHTML = "";
          if (!d.builds.length) { empty("Tes builds ont été supprimés."); return; }
          d.builds.forEach(function (b) { list.appendChild(mineRow(b, tokens[b.id])); });
        })
        .catch(function () { empty("Impossible de charger tes builds pour le moment."); })
        .then(function () { root.classList.remove("is-loading"); });
    }

    function mineRow(b, token) {
      var wrap = el("div", "build-row-wrap my-build");
      var a = renderRow(b, 0, true);
      a.querySelector(".build-meta").insertBefore(
        el("span", "my-vis " + (b.public ? "is-public" : "is-private"), b.public ? "Public" : "Privé"),
        a.querySelector(".build-meta").firstChild
      );
      wrap.appendChild(a);

      var actions = el("div", "my-actions");
      var edit = el("a", "my-btn", "Modifier");
      edit.href = a.getAttribute("href");
      edit.title = "Ouvrir le build : change les talents puis clique sur « Enregistrer les modifications »";
      var link = el("button", "my-btn", "Lien de modif.");
      link.type = "button";
      link.title = "Copier le lien de modification (pour un autre appareil)";
      link.addEventListener("click", function () { copy(editUrl(b.id, token), link); });
      var del = el("button", "my-btn danger", "Supprimer");
      del.type = "button";
      del.addEventListener("click", function () {
        if (del.dataset.confirm !== "1") {
          del.dataset.confirm = "1";
          del.textContent = "Confirmer ?";
          setTimeout(function () { if (del.isConnected && !del.disabled) { del.dataset.confirm = ""; del.textContent = "Supprimer"; } }, 4000);
          return;
        }
        del.disabled = true;
        post({ action: "delete", id: b.id, token: token }).then(function () {
          saveMyBuilds(myBuilds().filter(function (x) { return x.id !== b.id; }));
          wrap.classList.add("is-deleted");
          setTimeout(function () { wrap.remove(); updateCount(myBuilds().length); if (!list.children.length) load(); }, 250);
        }).catch(function (err) { del.disabled = false; del.dataset.confirm = ""; del.textContent = err.message; });
      });
      actions.appendChild(edit);
      actions.appendChild(link);
      actions.appendChild(del);
      wrap.appendChild(actions);
      return wrap;
    }

    root.reload = load;
    load();
  }

  function updateCount(n) {
    Array.prototype.forEach.call(document.querySelectorAll("[data-my-count]"), function (c) {
      c.textContent = n ? "(" + n + ")" : "";
    });
  }

  function setupTabs(bar) {
    if (bar.dataset.bound) return;
    bar.dataset.bound = "1";
    var tabs = bar.querySelectorAll("[data-tab]");
    function show(name, push) {
      Array.prototype.forEach.call(tabs, function (t) {
        var on = t.dataset.tab === name;
        t.classList.toggle("on", on);
        t.setAttribute("aria-selected", on ? "true" : "false");
      });
      Array.prototype.forEach.call(document.querySelectorAll("[data-tab-panel]"), function (p) {
        p.hidden = p.dataset.tabPanel !== name;
      });
      if (push) {
        var url = new URL(location.href);
        if (name === "mine") { url.searchParams.set("vue", "mes-builds"); url.searchParams.delete("classe"); url.searchParams.delete("tri"); }
        else url.searchParams.delete("vue");
        history.replaceState(history.state, "", url.toString());
      }
      if (name === "mine") {
        var mine = document.querySelector("[data-my-builds]");
        if (mine && mine.reload && push) mine.reload();
      }
    }
    Array.prototype.forEach.call(tabs, function (t) {
      t.addEventListener("click", function () { show(t.dataset.tab, true); });
    });
    show(new URL(location.href).searchParams.get("vue") === "mes-builds" ? "mine" : "public", false);
    updateCount(myBuilds().filter(function (b) { return b && b.token; }).length);
  }

  function init() {
    Array.prototype.forEach.call(document.querySelectorAll("[data-builds-tabs]"), setupTabs);
    Array.prototype.forEach.call(document.querySelectorAll("[data-builds-list]"), setupList);
    Array.prototype.forEach.call(document.querySelectorAll("[data-my-builds]"), setupMine);
  }
  window.WF.initBuildsLists = init;

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
