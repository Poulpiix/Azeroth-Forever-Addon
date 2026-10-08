(function () {
  "use strict";

  window.WF = window.WF || {};
  if (window.WF.initSaveBuild) return;

  var API = "/api/builds.php";
  var MY_BUILDS_KEY = "wf-my-builds";
  var AUTHOR_KEY = "wf-build-author";
  var VIS_KEY = "wf-build-visibility";
  var DESC_MAX = 3000;

  function adminKey() {
    if (window.WF.adminKey) return window.WF.adminKey();
    var k = null;
    try { k = localStorage.getItem("wf-admin-key"); } catch (e) {}
    return k && /^[a-f0-9]{40}$/.test(k) ? k : null;
  }

  var slug = null;

  function lsGet(key, fallback) {
    try {
      var v = localStorage.getItem(key);
      return v === null ? fallback : v;
    } catch (e) { return fallback; }
  }
  function lsSet(key, value) {
    try { localStorage.setItem(key, value); } catch (e) {}
  }
  function myBuilds() {
    try { return JSON.parse(lsGet(MY_BUILDS_KEY, "[]")) || []; } catch (e) { return []; }
  }
  function findMine(id) {
    return myBuilds().filter(function (b) { return b.id === id; })[0] || null;
  }
  function rememberMine(build, token) {
    var list = myBuilds().filter(function (b) { return b.id !== build.id; });
    var prev = findMine(build.id);
    list.unshift({
      id: build.id,
      token: token || (prev && prev.token),
      class: build.class,
      name: build.name,
      public: build.public,
      created: build.created,
    });
    lsSet(MY_BUILDS_KEY, JSON.stringify(list.slice(0, 200)));
  }

  // Rangs FINAUX du build (jamais l'état affiché par le curseur de niveau).
  function currentBuild() {
    if (window.WF.calc && window.WF.calc.getBuildString) {
      var fromCalc = window.WF.calc.getBuildString();
      if (fromCalc) return fromCalc;
    }
    var trees = Array.prototype.slice.call(document.querySelectorAll(".tree[data-tree-idx]"));
    trees.sort(function (a, b) { return a.dataset.treeIdx - b.dataset.treeIdx; });
    return trees.map(function (tree) {
      return Array.prototype.map.call(tree.querySelectorAll(".talent .rank-badge"), function (badge) {
        return parseInt(badge.textContent, 10) || 0;
      }).join("");
    }).join("-");
  }
  // Ordre des points (?path=) du build affiché ; "" si l'ordre n'est pas valide.
  function currentPath() {
    return window.WF.calc && window.WF.calc.getPathString ? window.WF.calc.getPathString() : "";
  }
  // Vrai si l'ordre affiché diffère de celui du build sauvegardé
  // (un ancien build sans path correspond à l'ordre automatique).
  function pathModified(saved) {
    if (!window.WF.calc || !window.WF.calc.isAutoOrder) return false;
    if (saved.path) return currentPath() !== saved.path;
    return !window.WF.calc.isAutoOrder();
  }
  function pointsOf(build) {
    return build.replace(/-/g, "").split("").reduce(function (s, d) { return s + (+d || 0); }, 0);
  }
  function splitOf(build) {
    return build.split("-").map(pointsOf).join(" / ");
  }
  function shortUrl(id) {
    return location.origin + "/b/" + id;
  }
  function editUrl(id, token) {
    return shortUrl(id) + "#modifier=" + token;
  }
  function editTokenFromHash() {
    var m = /(?:^#|&)modifier=([a-f0-9]{32})(?:&|$)/.exec(location.hash || "");
    return m ? m[1] : null;
  }
  function clearHash() {
    if (!location.hash) return;
    history.replaceState(history.state, "", location.pathname + location.search);
  }
  function mineToken() {
    var m = loaded && findMine(loaded.id);
    return m && m.token ? m.token : null;
  }
  function updateSaveButton() {
    var btn = document.querySelector("[data-save-build]");
    if (btn) btn.textContent = mineToken() ? "Enregistrer les modifications" : "Sauvegarder le build";
  }

  function api(method, body, query) {
    var opts = { method: method, headers: { Accept: "application/json" }, credentials: "same-origin" };
    if (body) {
      opts.headers["Content-Type"] = "application/json";
      opts.body = JSON.stringify(body);
    }
    return fetch(API + (query || ""), opts).then(function (res) {
      return res.json().catch(function () {
        throw new Error("La sauvegarde est indisponible pour le moment.");
      }).then(function (data) {
        if (!res.ok || !data.ok) throw new Error(data.error || "Erreur inattendue.");
        return data;
      });
    }, function () {
      throw new Error("Connexion impossible, vérifie ta connexion internet.");
    });
  }

  var loaded = null;

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }

  function renderBanner() {
    var host = document.querySelector("[data-saved-build]");
    if (!host) {
      host = el("div", "saved-build");
      host.setAttribute("data-saved-build", "");
      var head = document.querySelector(".calc-head");
      if (!head) return;
      head.parentNode.insertBefore(host, head.nextSibling);
    }
    host.innerHTML = "";
    if (!loaded) { host.hidden = true; return; }
    host.hidden = false;

    var modified = currentBuild() !== loaded.build || pathModified(loaded);
    var title = el("div", "saved-build-title");
    var own = !!mineToken();
    title.appendChild(el("span", "saved-build-kicker" + (own ? " is-mine" : ""),
      (own ? "Ton build " : "Build ") + (loaded.public ? "public" : "privé")));
    title.appendChild(el("strong", null, loaded.name));
    if (loaded.author) title.appendChild(el("span", "saved-build-author", "par " + loaded.author));

    var meta = el("div", "saved-build-meta");
    meta.appendChild(el("span", null, splitOf(loaded.build)));
    meta.appendChild(el("span", null, "Niveau " + loaded.level));
    meta.appendChild(el("span", null, loaded.views + (loaded.views > 1 ? " vues" : " vue")));
    meta.appendChild(bannerLike());
    if (modified) meta.appendChild(el("span", "saved-build-modified", own ? "Modifié, pense à enregistrer" : "Modifié"));
    if (own) {
      var edit = el("button", "saved-build-edit", modified ? "Enregistrer" : "Modifier");
      edit.type = "button";
      edit.title = "Modifier le nom, la description ou la visibilité, et enregistrer les talents affichés";
      edit.addEventListener("click", openDialog);
      meta.appendChild(edit);
    }

    host.appendChild(title);
    host.appendChild(meta);

    var mine = findMine(loaded.id);
    var delToken = (mine && mine.token) || adminKey();
    if (delToken) {
      var del = el("button", "saved-build-delete", adminKey() && !(mine && mine.token) ? "Supprimer (admin)" : "Supprimer ce build");
      del.type = "button";
      del.addEventListener("click", function () {
        if (del.dataset.confirm !== "1") {
          del.dataset.confirm = "1";
          del.textContent = "Confirmer la suppression ?";
          setTimeout(function () { if (del.isConnected) { del.dataset.confirm = ""; del.textContent = "Supprimer ce build"; } }, 4000);
          return;
        }
        del.disabled = true;
        api("POST", { id: loaded.id, token: delToken, action: "delete" }).then(function () {
          var url = new URL(location.href);
          url.searchParams.delete("b");
          history.replaceState(null, "", url.toString());
          loaded = null;
          renderBanner();
          renderDescription();
          renderComments();
        }).catch(function (err) { del.disabled = false; del.textContent = err.message; });
      });
      meta.appendChild(del);
    }
  }

  function setLikedLocal(id, on) {
    var m;
    try { m = JSON.parse(localStorage.getItem("wf-liked") || "{}") || {}; } catch (e) { m = {}; }
    if (on) m[id] = 1; else delete m[id];
    try { localStorage.setItem("wf-liked", JSON.stringify(m)); } catch (e) {}
  }
  function bannerLike() {
    var b = loaded;
    var btn = el("button", "build-like" + (b.liked ? " on" : ""));
    btn.type = "button";
    btn.innerHTML = '<svg viewBox="0 0 24 24" width="14" height="14" aria-hidden="true" focusable="false"><path d="M12 21s-7.5-4.6-10-9.3C.3 8.4 2.2 4.5 6 4.5c2.2 0 3.6 1.2 4.4 2.4h3.2c.8-1.2 2.2-2.4 4.4-2.4 3.8 0 5.7 3.9 4 7.2C19.5 16.4 12 21 12 21z"/></svg>';
    btn.appendChild(el("span", "build-like-count", (b.likes || 0) + " J'aime"));
    btn.setAttribute("aria-pressed", b.liked ? "true" : "false");
    btn.title = b.liked ? "Tu aimes ce build (cliquer pour retirer)" : "J'aime ce build";
    btn.addEventListener("click", function () {
      btn.disabled = true;
      api("POST", { action: "like", id: b.id, like: !b.liked }).then(function (d) {
        b.liked = d.liked;
        b.likes = d.likes;
        setLikedLocal(b.id, d.liked);
        if (loaded === b) renderBanner();
      }).catch(function () { btn.disabled = false; });
    });
    return btn;
  }

  var COMMENTS_JS = "js/comments.js?v=2";
  var commentsScript = null;
  function loadCommentsScript() {
    if (window.WF.initComments) return Promise.resolve();
    if (commentsScript) return commentsScript;
    commentsScript = new Promise(function (resolve, reject) {
      var sc = document.createElement("script");
      sc.src = COMMENTS_JS;
      sc.onload = resolve;
      sc.onerror = function () { commentsScript = null; reject(); };
      document.head.appendChild(sc);
    });
    return commentsScript;
  }
  function renderComments() {
    var host = document.querySelector("[data-comments]");
    if (!loaded || !loaded.public) {
      if (host) host.remove();
      return;
    }
    var build = loaded;
    loadCommentsScript().then(function () {
      if (loaded !== build) return;
      var h = document.querySelector("[data-comments]");
      if (!h) {
        var trees = document.querySelector("[data-trees]");
        if (!trees) return;
        h = document.createElement("section");
        h.setAttribute("data-comments", "");
        trees.parentNode.insertBefore(h, trees.nextSibling);
      }
      window.WF.initComments(h, build, { ownerToken: mineToken(), adminKey: adminKey() });
    }).catch(function () {});
  }

  function renderDescription() {
    var host = document.querySelector("[data-build-desc]");
    if (!loaded || !loaded.description_html) {
      if (host) host.remove();
      return;
    }
    if (!host) {
      var banner = document.querySelector("[data-saved-build]");
      if (!banner) return;
      host = el("section", "build-desc");
      host.setAttribute("data-build-desc", "");
      banner.parentNode.insertBefore(host, banner.nextSibling);
    }
    host.innerHTML = "";
    host.appendChild(el("h2", "build-desc-title", "Description du build"));
    var body = el("div", "rich-text");
    body.innerHTML = loaded.description_html;
    host.appendChild(body);
  }

  function loadSavedBuild() {
    var id = new URL(location.href).searchParams.get("b");
    if (!id || !/^[A-Za-z0-9]{8}$/.test(id)) return;
    api("GET", null, "?id=" + encodeURIComponent(id)).then(function (data) {
      if (data.build.class !== slug) return;
      loaded = data.build;
      var url = new URL(location.href);
      if (url.searchParams.get("build") !== loaded.build) {
        url.searchParams.set("build", loaded.build);
        if (loaded.path) url.searchParams.set("path", loaded.path);
        else url.searchParams.delete("path");
        location.replace(url.toString());
        return;
      }
      // Build sauvegardé avec un ordre : on l'applique s'il diffère de celui affiché.
      if (loaded.path && currentPath() !== loaded.path && window.WF.calc && window.WF.calc.setBuildAndPath) {
        window.WF.calc.setBuildAndPath(loaded.build, loaded.path);
      }
      renderBanner();
      renderDescription();
      renderComments();
      updateSaveButton();
      claimFromEditLink();
    }).catch(function () {  });
  }

  function claimFromEditLink() {
    var token = editTokenFromHash();
    if (!token || !loaded) return;
    var build = loaded;
    api("POST", { action: "verify", id: build.id, token: token }).then(function () {
      rememberMine(build, token);
      clearHash();
      if (loaded !== build) return;
      renderBanner();
      updateSaveButton();
      var host = document.querySelector("[data-saved-build]");
      if (host) {
        var note = el("div", "saved-build-note", "Tu peux modifier ce build depuis ce navigateur : change les talents puis clique sur « Enregistrer ».");
        host.appendChild(note);
        setTimeout(function () { if (note.isConnected) note.remove(); }, 8000);
      }
    }).catch(function () {
      clearHash();
      var host = document.querySelector("[data-saved-build]");
      if (host) host.appendChild(el("div", "saved-build-note warn", "Ce lien de modification n'est pas valide pour ce build."));
    });
  }

  var bannerTimer = null;
  function queueBannerRefresh() {
    if (!loaded) return;
    clearTimeout(bannerTimer);
    bannerTimer = setTimeout(renderBanner, 120);
  }
  ["click", "contextmenu"].forEach(function (evt) {
    document.addEventListener(evt, function (e) {
      if (e.target.closest && e.target.closest("[data-trees], [data-reset-all], [data-planner]")) queueBannerRefresh();
    });
  });

  var dialog = null;
  var f = {};

  function buildDialog() {
    dialog = el("dialog", "save-dialog");
    dialog.setAttribute("aria-labelledby", "save-dialog-title");
    dialog.innerHTML =
      '<form method="dialog" class="save-form" novalidate>' +
        '<div class="save-head">' +
          '<h2 id="save-dialog-title" data-dialog-title>Sauvegarder le build</h2>' +
          '<button type="button" class="save-close" data-close aria-label="Fermer">×</button>' +
        "</div>" +
        '<p class="save-summary" data-summary></p>' +

        '<div class="save-step" data-step-form>' +
          '<label class="save-update" data-update-row hidden>' +
            '<input type="checkbox" data-update checked>' +
            '<span>Mettre à jour <b data-update-name></b> au lieu d\'en créer un nouveau</span>' +
          "</label>" +
          '<label class="save-field"><span>Nom du build</span>' +
            '<input type="text" data-name maxlength="60" required placeholder="Ex. Farouche tank raid" autocomplete="off"></label>' +
          '<label class="save-field"><span>Auteur <em>(facultatif)</em></span>' +
            '<input type="text" data-author maxlength="30" placeholder="Ton pseudo" autocomplete="nickname"></label>' +
          '<div class="save-field"><span id="save-desc-label">Description <em>(facultatif)</em></span>' +
            '<div class="rich-editor">' +
              '<div class="rich-toolbar" role="toolbar" aria-label="Mise en forme" data-toolbar></div>' +
              '<textarea data-desc rows="6" maxlength="' + DESC_MAX + '" aria-labelledby="save-desc-label" ' +
                'placeholder="Rotation, stats à privilégier, points clés du build…"></textarea>' +
              '<div class="rich-text rich-preview" data-desc-preview hidden></div>' +
            "</div>" +
            '<div class="rich-foot">' +
              '<details class="rich-help"><summary>Aide à la mise en forme</summary>' +
                "<table>" +
                  "<tr><td><code>**gras**</code></td><td><strong>gras</strong></td></tr>" +
                  "<tr><td><code>*italique*</code></td><td><em>italique</em></td></tr>" +
                  "<tr><td><code>__souligné__</code></td><td><u>souligné</u></td></tr>" +
                  "<tr><td><code>~~barré~~</code></td><td><s>barré</s></td></tr>" +
                  "<tr><td><code>`code`</code></td><td><code>code</code></td></tr>" +
                  "<tr><td><code>- élément</code></td><td>liste à puces</td></tr>" +
                  "<tr><td><code>1. élément</code></td><td>liste numérotée</td></tr>" +
                  "<tr><td><code>&gt; texte</code></td><td>citation</td></tr>" +
                "</table>" +
                "<p>Les liens ne sont pas cliquables et le HTML s'affiche tel quel.</p>" +
              "</details>" +
              '<span class="rich-counter" data-desc-count></span>' +
            "</div>" +
          "</div>" +
          '<input type="text" name="website" data-hp tabindex="-1" autocomplete="off" class="save-hp" aria-hidden="true">' +
          '<fieldset class="save-vis">' +
            "<legend>Visibilité</legend>" +
            '<label class="save-vis-opt"><input type="radio" name="vis" value="public" data-vis-public>' +
              "<span><b>Public</b><small>Visible par tous dans la liste des builds.</small></span></label>" +
            '<label class="save-vis-opt"><input type="radio" name="vis" value="private" data-vis-private>' +
              "<span><b>Privé</b><small>Accessible uniquement avec le lien. N'apparaît jamais dans les listes.</small></span></label>" +
          "</fieldset>" +
          '<p class="save-error" data-error role="alert" hidden></p>' +
          '<div class="save-actions">' +
            '<button type="button" class="btn ghost" data-close>Annuler</button>' +
            '<button type="submit" class="btn primary" data-submit>Sauvegarder</button>' +
          "</div>" +
        "</div>" +

        '<div class="save-step" data-step-done hidden>' +
          '<p class="save-ok" data-done-text></p>' +
          '<label class="save-link-label">Lien à partager</label>' +
          '<div class="save-link">' +
            '<input type="text" data-link readonly aria-label="Lien du build">' +
            '<button type="button" class="btn primary" data-copy-saved>Copier</button>' +
          "</div>" +
          '<div data-edit-block>' +
            '<label class="save-link-label">Lien de modification <em>(garde-le pour toi)</em></label>' +
            '<div class="save-link">' +
              '<input type="text" data-edit-link readonly aria-label="Lien de modification">' +
              '<button type="button" class="btn" data-copy-edit>Copier</button>' +
            "</div>" +
            '<p class="save-hint">Ce navigateur se souvient déjà de ton build (voir <a href="builds?vue=mes-builds">Mes builds</a>). ' +
              "Garde ce lien pour le modifier depuis un autre appareil ou si tu effaces les données du navigateur. " +
              "Toute personne qui l'a peut modifier ou supprimer le build.</p>" +
          "</div>" +
          '<div class="save-actions">' +
            '<button type="button" class="btn ghost" data-close>Fermer</button>' +
          "</div>" +
        "</div>" +
      "</form>";
    document.body.appendChild(dialog);

    function q(sel) { return dialog.querySelector(sel); }
    f = {
      form: q("form"), summary: q("[data-summary]"), title: q("[data-dialog-title]"),
      stepForm: q("[data-step-form]"), stepDone: q("[data-step-done]"),
      updateRow: q("[data-update-row]"), update: q("[data-update]"), updateName: q("[data-update-name]"),
      name: q("[data-name]"), author: q("[data-author]"), hp: q("[data-hp]"),
      desc: q("[data-desc]"), descPreview: q("[data-desc-preview]"), descCount: q("[data-desc-count]"),
      toolbar: q("[data-toolbar]"),
      pub: q("[data-vis-public]"), priv: q("[data-vis-private]"),
      error: q("[data-error]"), submit: q("[data-submit]"),
      doneText: q("[data-done-text]"), link: q("[data-link]"), copy: q("[data-copy-saved]"),
      editBlock: q("[data-edit-block]"), editLink: q("[data-edit-link]"), copyEdit: q("[data-copy-edit]"),
    };

    Array.prototype.forEach.call(dialog.querySelectorAll("[data-close]"), function (b) {
      b.addEventListener("click", closeDialog);
    });
    dialog.addEventListener("click", function (e) { if (e.target === dialog) closeDialog(); });
    f.form.addEventListener("submit", function (e) { e.preventDefault(); submit(); });
    f.update.addEventListener("change", function () {
      if (f.update.checked && loaded) fillFrom(loaded);
      syncMode();
    });
    f.copy.addEventListener("click", function () {
      copyText(f.link.value, f.copy);
    });
    f.link.addEventListener("focus", function () { f.link.select(); });
    f.copyEdit.addEventListener("click", function () { copyText(f.editLink.value, f.copyEdit, f.editLink); });
    f.editLink.addEventListener("focus", function () { f.editLink.select(); });
    dialog.querySelector('a[href="builds?vue=mes-builds"]').addEventListener("click", closeDialog);
    setupEditor();
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
  var previewBtn = null;

  function setupEditor() {
    TOOLS.forEach(function (t) {
      if (t.sep) { f.toolbar.appendChild(el("span", "rich-tool-sep")); return; }
      var b = el("button", "rich-tool" + (t.cls ? " " + t.cls : ""), t.label);
      b.type = "button";
      b.title = t.title;
      b.setAttribute("aria-label", t.title);
      b.addEventListener("click", function () { applyTool(t); });
      f.toolbar.appendChild(b);
    });
    previewBtn = el("button", "rich-tool rich-preview-btn", "Aperçu");
    previewBtn.type = "button";
    previewBtn.setAttribute("aria-pressed", "false");
    previewBtn.addEventListener("click", function () { setPreview(f.descPreview.hidden); });
    f.toolbar.appendChild(previewBtn);

    f.desc.addEventListener("input", updateCount);
    f.desc.addEventListener("keydown", function (e) {
      if (!(e.ctrlKey || e.metaKey)) return;
      var tool = TOOLS.filter(function (t) { return t.key === e.key.toLowerCase(); })[0];
      if (tool) { e.preventDefault(); applyTool(tool); }
    });
  }

  function applyTool(t) {
    if (!f.descPreview.hidden) setPreview(false);
    var ta = f.desc, v = ta.value, a = ta.selectionStart, z = ta.selectionEnd;
    if (t.wrap) {
      var sel = v.slice(a, z) || "texte";
      ta.value = v.slice(0, a) + t.wrap + sel + t.wrap + v.slice(z);
      ta.setSelectionRange(a + t.wrap.length, a + t.wrap.length + sel.length);
    } else {
      var start = v.lastIndexOf("\n", a - 1) + 1;
      var end = v.indexOf("\n", z);
      if (end === -1) end = v.length;
      var n = 0;
      var block = v.slice(start, end).split("\n").map(function (line) {
        n++;
        return (t.prefix === "#. " ? n + ". " : t.prefix) + line;
      }).join("\n");
      ta.value = v.slice(0, start) + block + v.slice(end);
      ta.setSelectionRange(start + block.length, start + block.length);
    }
    ta.focus();
    updateCount();
  }

  function updateCount() {
    var n = f.desc.value.length;
    f.descCount.textContent = n + " / " + DESC_MAX;
    f.descCount.classList.toggle("near", n > DESC_MAX * 0.9);
  }

  function setPreview(on) {
    f.descPreview.hidden = !on;
    f.desc.hidden = on;
    previewBtn.classList.toggle("on", on);
    previewBtn.setAttribute("aria-pressed", on ? "true" : "false");
    previewBtn.textContent = on ? "Écrire" : "Aperçu";
    if (!on) { f.desc.focus(); return; }
    if (!f.desc.value.trim()) { f.descPreview.innerHTML = '<p class="rich-empty">Rien à afficher.</p>'; return; }
    f.descPreview.textContent = "Chargement de l'aperçu…";
    api("POST", { action: "preview", body: f.desc.value }).then(function (d) {
      f.descPreview.innerHTML = d.html;
    }).catch(function (err) { f.descPreview.textContent = err.message; });
  }

  function syncMode() {
    var updating = !f.updateRow.hidden && f.update.checked;
    f.title.textContent = updating ? "Modifier ton build" : "Sauvegarder le build";
    if (!f.submit.disabled || f.submit.textContent !== "Sauvegarde…") {
      f.submit.textContent = updating ? "Enregistrer" : "Sauvegarder";
    }
  }

  function fillFrom(b) {
    f.name.value = b.name;
    f.author.value = b.author || lsGet(AUTHOR_KEY, "");
    f.desc.value = b.description || "";
    (b.public ? f.pub : f.priv).checked = true;
    updateCount();
  }

  function openDialog() {
    if (!dialog) buildDialog();
    var build = currentBuild();
    var pts = pointsOf(build);

    f.stepForm.hidden = false;
    f.stepDone.hidden = true;
    showError("");
    f.submit.disabled = false;
    f.submit.textContent = "Sauvegarder";

    var cls = document.querySelector("[data-class-name]");
    f.summary.textContent = (cls ? cls.textContent : slug) + " · " + splitOf(build) + " · " + pts + " point" + (pts > 1 ? "s" : "");

    var mine = loaded && findMine(loaded.id);
    f.updateRow.hidden = !(mine && mine.token);
    if (mine && mine.token) {
      f.update.checked = true;
      f.updateName.textContent = "« " + loaded.name + " »";
      fillFrom(loaded);
    } else {
      f.name.value = "";
      f.author.value = lsGet(AUTHOR_KEY, "");
      f.desc.value = "";
      (lsGet(VIS_KEY, "public") === "private" ? f.priv : f.pub).checked = true;
    }
    if (!f.descPreview.hidden) setPreview(false);
    updateCount();

    if (pts < 1) showError("Place au moins un point de talent avant de sauvegarder.");
    f.submit.disabled = pts < 1;

    syncMode();
    if (typeof dialog.showModal === "function") dialog.showModal();
    else dialog.setAttribute("open", "");
    setTimeout(function () { (f.name.value ? f.submit : f.name).focus(); }, 30);
  }

  function closeDialog() {
    if (!dialog) return;
    if (typeof dialog.close === "function") dialog.close();
    else dialog.removeAttribute("open");
  }

  function showError(msg) {
    f.error.textContent = msg;
    f.error.hidden = !msg;
  }

  function submit() {
    var name = f.name.value.trim();
    if (name.length < 3) {
      showError("Donne un nom d'au moins 3 caractères à ton build.");
      f.name.focus();
      return;
    }
    var build = currentBuild();
    var isPublic = f.pub.checked;
    var author = f.author.value.trim();
    lsSet(AUTHOR_KEY, author);
    lsSet(VIS_KEY, isPublic ? "public" : "private");

    var payload = {
      class: slug, build: build, path: currentPath(), name: name, author: author,
      public: isPublic, website: f.hp.value, description: f.desc.value,
    };
    var mine = loaded && findMine(loaded.id);
    var updating = !f.updateRow.hidden && f.update.checked && mine && mine.token;
    if (updating) { payload.id = mine.id; payload.token = mine.token; }

    showError("");
    f.submit.disabled = true;
    f.submit.textContent = "Sauvegarde…";

    api("POST", payload).then(function (data) {
      var saved = data.build;
      if (loaded && loaded.id === saved.id) saved.liked = loaded.liked;
      rememberMine(saved, data.token);
      loaded = saved;

      var url = new URL(location.href);
      url.searchParams.set("build", saved.build);
      if (saved.path) url.searchParams.set("path", saved.path);
      url.searchParams.set("b", saved.id);
      history.replaceState(null, "", url.toString());
      renderBanner();
      renderDescription();
      renderComments();

      f.doneText.textContent = (updating ? "Build mis à jour" : "Build sauvegardé") +
        (saved.public ? " et publié. Il apparaîtra dans la liste des builds publics." : " en privé. Seules les personnes ayant le lien pourront le voir.");
      f.link.value = shortUrl(saved.id);
      var tok = mineToken();
      f.editBlock.hidden = !tok;
      f.editLink.value = tok ? editUrl(saved.id, tok) : "";
      updateSaveButton();
      f.stepForm.hidden = true;
      f.stepDone.hidden = false;
      f.copy.focus();
    }).catch(function (err) {
      showError(err.message);
      f.submit.disabled = false;
      syncMode();
    });
  }

  function copyText(text, btn, input) {
    input = input || f.link;
    function done() {
      var old = btn.textContent;
      btn.textContent = "Copié !";
      setTimeout(function () { btn.textContent = old; }, 1500);
    }
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).then(done, function () { input.select(); });
    } else {
      input.select();
      try { document.execCommand("copy"); done(); } catch (e) {}
    }
  }

  function init() {
    slug = document.body.getAttribute("data-class");
    loaded = null;
    if (!slug) return;
    var copy = document.querySelector("[data-copy-link]");
    if (!copy) return;
    var btn = document.querySelector("[data-save-build]");
    if (!btn) {
      btn = el("button", "btn", "Sauvegarder le build");
      btn.type = "button";
      btn.setAttribute("data-save-build", "");
      var anchor = copy.closest("[data-share-menu]") || copy;
      anchor.parentNode.insertBefore(btn, anchor);
    }
    if (btn.dataset.bound) return;
    btn.dataset.bound = "1";
    btn.addEventListener("click", openDialog);

    if (!document.querySelector("[data-class-builds]")) {
      var cls = document.querySelector("[data-class-name]");
      var link = el("a", "btn ghost", "Builds publics" + (cls ? " " + cls.textContent : ""));
      link.href = "builds?classe=" + slug;
      link.setAttribute("data-class-builds", "");
      // « Partager » range « Copier le lien » dans un menu : on ajoute le lien à la barre elle-même.
      (copy.closest(".tb-actions") || copy.parentNode).appendChild(link);
    }
    loadSavedBuild();
  }

  window.WF.initSaveBuild = init;
  document.addEventListener("wf:admin", function () { if (loaded) renderBanner(); });

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
