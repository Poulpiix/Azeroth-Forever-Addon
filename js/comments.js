(function () {
  "use strict";

  window.WF = window.WF || {};
  if (window.WF.initComments) return;

  var API = "/api/comments.php";
  var MAX = 1500;
  var AVATAR_RE = /^https:\/\/static-cdn\.jtvnw\.net\/[\w./-]+$/;
  var TWITCH_ICON = '<svg viewBox="0 0 24 24" width="16" height="16" aria-hidden="true" focusable="false"><path fill="currentColor" d="M11.571 4.714h1.715v5.143H11.57zm4.715 0H18v5.143h-1.714zM6 0L1.714 4.286v15.428h5.143V24l4.286-4.286h3.428L22.286 12V0zm14.571 11.143l-3.428 3.428h-3.429l-3 3v-3H6.857V1.714h13.714Z"/></svg>';

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }

  function post(url, body) {
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

  function fmtDate(ts) {
    var s = Math.max(0, Date.now() / 1000 - ts);
    if (s < 60) return "à l'instant";
    if (s < 3600) return "il y a " + Math.floor(s / 60) + " min";
    if (s < 86400) return "il y a " + Math.floor(s / 3600) + " h";
    if (s < 86400 * 30) return "il y a " + Math.floor(s / 86400) + " j";
    return new Date(ts * 1000).toLocaleDateString("fr-FR", { day: "numeric", month: "short", year: "numeric" });
  }

  function avatar(src, size) {
    var img = el("img", "cmt-avatar");
    img.alt = "";
    img.width = size;
    img.height = size;
    img.loading = "lazy";
    img.referrerPolicy = "no-referrer";
    if (src && AVATAR_RE.test(src)) img.src = src; else img.classList.add("is-empty");
    return img;
  }

  function loginUrl() {
    return "/api/auth.php?login=1&return=" + encodeURIComponent(location.pathname + location.search);
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

  var TOOLS = [
    { key: "b", label: "G", title: "Gras (Ctrl+B)", wrap: "**", cls: "t-bold" },
    { key: "i", label: "I", title: "Italique (Ctrl+I)", wrap: "*", cls: "t-ital" },
    { key: "u", label: "S", title: "Souligné (Ctrl+U)", wrap: "__", cls: "t-under" },
    { label: "abc", title: "Barré", wrap: "~~", cls: "t-strike" },
    { sep: true },
    { label: "• Liste", title: "Liste à puces", prefix: "- " },
    { label: "1. Liste", title: "Liste numérotée", prefix: "#. " },
    { label: "❝ Citation", title: "Citation", prefix: "> " },
    { label: "</>", title: "Code", wrap: "`", cls: "t-code" },
  ];

  function makeEditor() {
    var box = el("div", "rich-editor");
    var bar = el("div", "rich-toolbar");
    bar.setAttribute("role", "toolbar");
    bar.setAttribute("aria-label", "Mise en forme");
    var ta = el("textarea");
    ta.rows = 4;
    ta.maxLength = MAX;
    ta.placeholder = "Ton avis, une variante, un conseil de rotation…";
    ta.setAttribute("aria-label", "Ton commentaire");
    var preview = el("div", "rich-text rich-preview");
    preview.hidden = true;
    var previewBtn = el("button", "rich-tool rich-preview-btn", "Aperçu");
    previewBtn.type = "button";

    function apply(t) {
      if (!preview.hidden) setPreview(false);
      var v = ta.value, a = ta.selectionStart, z = ta.selectionEnd;
      if (t.wrap) {
        var sel = v.slice(a, z) || "texte";
        ta.value = v.slice(0, a) + t.wrap + sel + t.wrap + v.slice(z);
        ta.setSelectionRange(a + t.wrap.length, a + t.wrap.length + sel.length);
      } else {
        var start = v.lastIndexOf("\n", a - 1) + 1, end = v.indexOf("\n", z);
        if (end === -1) end = v.length;
        var n = 0;
        var block = v.slice(start, end).split("\n").map(function (l) { n++; return (t.prefix === "#. " ? n + ". " : t.prefix) + l; }).join("\n");
        ta.value = v.slice(0, start) + block + v.slice(end);
        ta.setSelectionRange(start + block.length, start + block.length);
      }
      ta.focus();
      ta.dispatchEvent(new Event("input"));
    }
    function setPreview(on) {
      preview.hidden = !on;
      ta.hidden = on;
      previewBtn.classList.toggle("on", on);
      previewBtn.textContent = on ? "Écrire" : "Aperçu";
      if (!on) { ta.focus(); return; }
      if (!ta.value.trim()) { preview.innerHTML = '<p class="rich-empty">Rien à afficher.</p>'; return; }
      preview.textContent = "Chargement de l'aperçu…";
      post("/api/builds.php", { action: "preview", body: ta.value }).then(function (d) {
        preview.innerHTML = d.html;
      }).catch(function (e) { preview.textContent = e.message; });
    }
    TOOLS.forEach(function (t) {
      if (t.sep) { bar.appendChild(el("span", "rich-tool-sep")); return; }
      var b = el("button", "rich-tool" + (t.cls ? " " + t.cls : ""), t.label);
      b.type = "button";
      b.title = t.title;
      b.setAttribute("aria-label", t.title);
      b.addEventListener("click", function () { apply(t); });
      bar.appendChild(b);
    });
    previewBtn.addEventListener("click", function () { setPreview(preview.hidden); });
    bar.appendChild(previewBtn);
    ta.addEventListener("keydown", function (e) {
      if (!(e.ctrlKey || e.metaKey)) return;
      var t = TOOLS.filter(function (x) { return x.key === e.key.toLowerCase(); })[0];
      if (t) { e.preventDefault(); apply(t); }
    });
    box.appendChild(bar);
    box.appendChild(ta);
    box.appendChild(preview);
    return { box: box, textarea: ta, reset: function () { ta.value = ""; setPreview(false); ta.dispatchEvent(new Event("input")); } };
  }

  function initComments(host, build, opts) {
    opts = opts || {};
    host.innerHTML = "";
    host.className = "comments";
    var state = { sort: "best", data: null, authEnabled: true };

    var head = el("div", "comments-head");
    var h2 = el("h2", null, "Commentaires");
    var count = el("span", "comments-count");
    h2.appendChild(count);
    head.appendChild(h2);
    var sortBar = el("div", "builds-sort");
    [["best", "Les meilleurs"], ["recent", "Les plus récents"]].forEach(function (s) {
      var b = el("button", "builds-sort-btn" + (s[0] === state.sort ? " on" : ""), s[1]);
      b.type = "button";
      b.addEventListener("click", function () {
        state.sort = s[0];
        Array.prototype.forEach.call(sortBar.children, function (x) { x.classList.toggle("on", x === b); });
        load();
      });
      sortBar.appendChild(b);
    });
    head.appendChild(sortBar);
    host.appendChild(head);

    var notice = el("p", "cmt-notice");
    notice.hidden = true;
    host.appendChild(notice);
    var modBar = el("div", "cmt-modbar");
    modBar.hidden = true;
    host.appendChild(modBar);
    var account = el("div", "cmt-account");
    host.appendChild(account);
    var list = el("div", "cmt-list");
    list.setAttribute("aria-live", "polite");
    host.appendChild(list);
    var formWrap = el("div", "cmt-form-wrap");
    host.appendChild(formWrap);
    var rules = el("p", "cmt-rules");
    host.appendChild(rules);

    var m = /connexion=(\w+)/.exec(location.hash || "");
    if (m) {
      notice.hidden = false;
      notice.textContent = { annulee: "Connexion Twitch annulée.", expiree: "La connexion a expiré, réessaie.", erreur: "La connexion Twitch a échoué, réessaie dans un instant." }[m[1]] || "La connexion Twitch a échoué.";
      history.replaceState(history.state, "", location.pathname + location.search);
    }

    function base() {
      return { build: build.id, owner_token: opts.ownerToken || undefined, admin_key: opts.adminKey || undefined };
    }

    function load() {
      list.classList.add("is-loading");
      var body = base();
      body.action = "list";
      body.sort = state.sort;
      Promise.all([
        post(API, body),
        fetch("/api/auth.php?me=1", { credentials: "same-origin", headers: { Accept: "application/json" } }).then(function (r) { return r.json(); }).catch(function () { return {}; }),
      ]).then(function (res) {
        state.data = res[0];
        state.authEnabled = res[1].enabled !== false;
        render();
      }).catch(function (e) {
        list.innerHTML = "";
        list.appendChild(el("p", "comment-empty", e.message || "Impossible de charger les commentaires."));
      }).then(function () { list.classList.remove("is-loading"); });
    }

    function render() {
      var d = state.data;
      var me = d.me;
      var visible = d.comments.filter(function (c) { return c.status === "visible"; }).length;
      count.textContent = visible ? " (" + visible + ")" : "";
      renderModBar(d);
      renderAccount(me);
      list.innerHTML = "";
      if (!d.comments.length) {
        list.appendChild(el("p", "comment-empty", d.build.comments_enabled
          ? "Aucun commentaire pour l'instant. Partage ton avis, une variante ou un conseil de rotation !"
          : "Les commentaires sont désactivés sur ce build."));
      }
      d.comments.forEach(function (c) { list.appendChild(renderComment(c, d)); });
      renderForm(d, me);
      rules.textContent = "Reste courtois : insultes et liens sont bloqués automatiquement. Un commentaire signalé par " +
        d.rules.report_threshold + " joueurs est masqué en attente de vérification. Pour commenter, ton compte Twitch doit avoir au moins " +
        d.rules.min_account_days + " jours. En te connectant, le site enregistre uniquement ton pseudo, ton avatar et ton identifiant Twitch, pour afficher tes commentaires.";
    }

    function renderModBar(d) {
      modBar.innerHTML = "";
      modBar.hidden = !d.build.can_moderate;
      if (!d.build.can_moderate) return;
      modBar.appendChild(el("span", null, opts.adminKey || (d.me && d.me.admin) ? "Modération (admin)" : "Tu modères les commentaires de ton build"));
      var t = el("button", "cmt-btn", d.build.comments_enabled ? "Désactiver les commentaires" : "Activer les commentaires");
      t.type = "button";
      t.addEventListener("click", function () {
        t.disabled = true;
        var body = base();
        body.action = "toggle";
        body.enabled = !d.build.comments_enabled;
        post(API, body).then(load).catch(function (e) { t.disabled = false; t.textContent = e.message; });
      });
      modBar.appendChild(t);
    }

    function renderAccount(me) {
      account.innerHTML = "";
      if (!state.authEnabled) {
        account.appendChild(el("span", "cmt-muted", "La connexion Twitch n'est pas encore activée sur le site."));
        return;
      }
      if (!me) {
        account.appendChild(el("span", "cmt-muted", "Connecte-toi pour commenter, voter ou signaler."));
        var a = el("a", "cmt-twitch");
        a.href = loginUrl();
        a.setAttribute("data-no-router", "");
        a.innerHTML = TWITCH_ICON;
        a.appendChild(document.createTextNode(" Se connecter avec Twitch"));
        account.appendChild(a);
        return;
      }
      account.appendChild(avatar(me.avatar, 24));
      var who = el("span", "cmt-who");
      who.appendChild(document.createTextNode("Connecté en tant que "));
      who.appendChild(el("strong", null, me.name));
      account.appendChild(who);
      var out = el("button", "cmt-link", "Se déconnecter");
      out.type = "button";
      out.addEventListener("click", function () {
        post("/api/auth.php", { action: "logout" }).then(load, load);
      });
      account.appendChild(out);
      var forget = el("button", "cmt-link danger", "Supprimer mes données");
      forget.type = "button";
      forget.title = "Supprime ton compte, tes commentaires et tes votes sur ce site";
      twoStep(forget, "Supprimer mes données", "Confirmer : tout supprimer ?", function () {
        post("/api/auth.php", { action: "forget" }).then(load, function (e) { forget.textContent = e.message; });
      });
      account.appendChild(forget);
    }

    function renderComment(c, d) {
      var art = el("article", "cmt" + (c.status !== "visible" ? " is-hidden" : ""));
      art.appendChild(avatar(c.author.avatar, 32));
      var main = el("div", "cmt-main");
      var top = el("header", "cmt-top");
      top.appendChild(el("strong", "cmt-author" + (c.author.build_author ? " is-owner" : ""), c.author.name));
      if (c.author.build_author) top.appendChild(el("span", "cmt-badge owner", "Auteur du build"));
      if (c.author.admin) top.appendChild(el("span", "cmt-badge admin", "Admin"));
      var t = el("time", "cmt-date", fmtDate(c.created));
      t.dateTime = new Date(c.created * 1000).toISOString();
      top.appendChild(t);
      main.appendChild(top);

      if (c.status === "reported") main.appendChild(el("p", "cmt-status", "Masqué automatiquement après " + (c.reports || "plusieurs") + " signalements, en attente de vérification."));
      if (c.status === "hidden") main.appendChild(el("p", "cmt-status", "Masqué par un modérateur" + (c.mine ? " : les autres joueurs ne le voient plus." : ".")));

      var body = el("div", "rich-text cmt-body");
      body.innerHTML = c.html;
      main.appendChild(body);

      var actions = el("div", "cmt-actions");
      actions.appendChild(voteBox(c, d));
      if (!c.mine && d.me && c.status === "visible") actions.appendChild(reportBox(c));
      if (c.mine) {
        var del = el("button", "cmt-link", "Supprimer");
        del.type = "button";
        twoStep(del, "Supprimer", "Confirmer ?", function () {
          post(API, { action: "delete", id: c.id }).then(load, function (e) { del.textContent = e.message; });
        });
        actions.appendChild(del);
      }
      if (d.build.can_moderate) {
        var mod = el("span", "cmt-mod");
        if (c.status === "visible") mod.appendChild(modButton(c, "hide", "Masquer"));
        else mod.appendChild(modButton(c, "show", "Réafficher"));
        mod.appendChild(modButton(c, "delete", "Supprimer", "Confirmer ?"));
        actions.appendChild(mod);
      }
      main.appendChild(actions);
      art.appendChild(main);
      return art;
    }

    function modButton(c, action, label, confirmLabel) {
      var b = el("button", "cmt-link" + (action === "delete" ? " danger" : ""), label);
      b.type = "button";
      function run() {
        var body = base();
        body.action = "moderate";
        body.id = c.id;
        body.do = action;
        post(API, body).then(load, function (e) { b.disabled = false; b.textContent = e.message; });
      }
      if (confirmLabel) twoStep(b, label, confirmLabel, run);
      else b.addEventListener("click", function () { b.disabled = true; run(); });
      return b;
    }

    function voteBox(c, d) {
      var box = el("span", "cmt-vote");
      var up = el("button", "cmt-vote-btn up" + (c.my_vote === 1 ? " on" : ""), "▲");
      var score = el("span", "cmt-score", String(c.score));
      var down = el("button", "cmt-vote-btn down" + (c.my_vote === -1 ? " on" : ""), "▼");
      up.type = down.type = "button";
      up.setAttribute("aria-label", "Utile");
      down.setAttribute("aria-label", "Pas utile");
      up.title = "Utile";
      down.title = "Pas utile";
      var locked = !d.me || c.mine;
      up.disabled = down.disabled = locked;
      if (!d.me) box.title = "Connecte-toi avec Twitch pour voter";
      if (c.mine) box.title = "Tu ne peux pas voter pour ton propre commentaire";
      function send(v) {
        var value = c.my_vote === v ? 0 : v;
        up.disabled = down.disabled = true;
        post(API, { action: "vote", id: c.id, value: value }).then(function (r) {
          c.my_vote = r.my_vote;
          c.score = r.score;
          score.textContent = String(r.score);
          up.classList.toggle("on", r.my_vote === 1);
          down.classList.toggle("on", r.my_vote === -1);
        }).catch(function () {}).then(function () { up.disabled = down.disabled = false; });
      }
      up.addEventListener("click", function () { send(1); });
      down.addEventListener("click", function () { send(-1); });
      box.appendChild(up);
      box.appendChild(score);
      box.appendChild(down);
      return box;
    }

    function reportBox(c) {
      var wrap = el("span", "cmt-report");
      if (c.reported) { wrap.appendChild(el("span", "cmt-muted", "Signalé")); return wrap; }
      var b = el("button", "cmt-link", "Signaler");
      b.type = "button";
      b.addEventListener("click", function () {
        wrap.innerHTML = "";
        wrap.appendChild(el("span", "cmt-muted", "Motif :"));
        ["Insulte", "Spam", "Hors sujet", "Autre"].forEach(function (reason) {
          var r = el("button", "cmt-chip", reason);
          r.type = "button";
          r.addEventListener("click", function () {
            post(API, { action: "report", id: c.id, reason: reason }).then(function () {
              wrap.innerHTML = "";
              wrap.appendChild(el("span", "cmt-muted", "Merci, signalement envoyé."));
            }, function (e) { wrap.textContent = e.message; });
          });
          wrap.appendChild(r);
        });
      });
      wrap.appendChild(b);
      return wrap;
    }

    function renderForm(d, me) {
      formWrap.innerHTML = "";
      if (!d.build.public) {
        formWrap.appendChild(el("p", "cmt-muted", "Les commentaires sont réservés aux builds publics."));
        return;
      }
      if (!d.build.comments_enabled) return;
      if (!me) return;
      if (me.banned) {
        formWrap.appendChild(el("p", "cmt-muted", "Ton compte ne peut plus participer aux commentaires."));
        return;
      }
      var form = el("form", "cmt-form");
      form.noValidate = true;
      var ed = makeEditor();
      form.appendChild(ed.box);
      var err = el("p", "save-error");
      err.hidden = true;
      err.setAttribute("role", "alert");
      form.appendChild(err);
      var foot = el("div", "comment-actions");
      var counter = el("span", "rich-counter", "0 / " + MAX);
      var submit = el("button", "btn primary", "Publier");
      submit.type = "submit";
      foot.appendChild(counter);
      foot.appendChild(submit);
      form.appendChild(foot);
      ed.textarea.addEventListener("input", function () {
        counter.textContent = ed.textarea.value.length + " / " + MAX;
        counter.classList.toggle("near", ed.textarea.value.length > MAX * 0.9);
      });
      ed.textarea.addEventListener("keydown", function (e) {
        if ((e.ctrlKey || e.metaKey) && e.key === "Enter") { e.preventDefault(); send(); }
      });
      function send() {
        var text = ed.textarea.value.trim();
        if (text.length < 2) { err.hidden = false; err.textContent = "Ton commentaire est vide."; return; }
        err.hidden = true;
        submit.disabled = true;
        submit.textContent = "Publication…";
        post(API, { action: "create", build: build.id, body: text }).then(function () {
          ed.reset();
          state.sort = "recent";
          Array.prototype.forEach.call(sortBar.children, function (x, i) { x.classList.toggle("on", i === 1); });
          load();
        }).catch(function (e) {
          err.hidden = false;
          err.textContent = e.message;
        }).then(function () {
          submit.disabled = false;
          submit.textContent = "Publier";
        });
      }
      form.addEventListener("submit", function (e) { e.preventDefault(); send(); });
      formWrap.appendChild(form);
    }

    list.appendChild(el("p", "comment-empty", "Chargement des commentaires…"));
    load();
  }

  window.WF.initComments = initComments;
})();
