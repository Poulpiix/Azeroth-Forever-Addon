(function () {
  "use strict";

  window.WF = window.WF || {};
  if (window.WF.initModeration) return;

  var API = "/api/comments.php";
  var AVATAR_RE = /^https:\/\/static-cdn\.jtvnw\.net\/[\w./-]+$/;
  var CLASS_NAMES = { guerrier: "Guerrier", paladin: "Paladin", chasseur: "Chasseur", voleur: "Voleur", pretre: "Prêtre", chaman: "Chaman", mage: "Mage", demoniste: "Démoniste", druide: "Druide" };

  function el(tag, cls, text) {
    var n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text != null) n.textContent = text;
    return n;
  }
  function adminKey() {
    if (window.WF.adminKey) return window.WF.adminKey();
    try { var k = localStorage.getItem("wf-admin-key"); return /^[a-f0-9]{40}$/.test(k || "") ? k : null; } catch (e) { return null; }
  }
  function post(body) {
    body.admin_key = adminKey() || undefined;
    return fetch(API, {
      method: "POST", credentials: "same-origin",
      headers: { "Content-Type": "application/json", Accept: "application/json" },
      body: JSON.stringify(body),
    }).then(function (r) {
      return r.json().catch(function () { throw new Error("Service indisponible."); })
        .then(function (d) { if (!r.ok || !d.ok) { var e = new Error(d.error || "Erreur"); e.status = r.status; throw e; } return d; });
    });
  }
  function avatar(src) {
    var img = el("img", "cmt-avatar");
    img.alt = "";
    img.width = img.height = 32;
    img.referrerPolicy = "no-referrer";
    if (src && AVATAR_RE.test(src)) img.src = src; else img.classList.add("is-empty");
    return img;
  }
  function button(label, cls, confirmLabel, action) {
    var b = el("button", "cmt-btn" + (cls ? " " + cls : ""), label);
    b.type = "button";
    b.addEventListener("click", function () {
      if (confirmLabel && b.dataset.confirm !== "1") {
        b.dataset.confirm = "1";
        b.textContent = confirmLabel;
        setTimeout(function () { if (b.isConnected && !b.disabled) { b.dataset.confirm = ""; b.textContent = label; } }, 4000);
        return;
      }
      b.disabled = true;
      action().catch(function (e) { b.disabled = false; b.textContent = e.message; });
    });
    return b;
  }

  function init() {
    var root = document.querySelector("[data-mod-root]");
    if (!root || root.dataset.bound) return;
    root.dataset.bound = "1";

    function load() {
      post({ action: "queue" }).then(render).catch(function (e) {
        root.innerHTML = "";
        if (e.status === 403) {
          var p = el("p", "comment-empty", "Page réservée aux administrateurs. Connecte-toi avec ton compte Twitch admin, ou ouvre une page du site avec ?admin=TA_CLÉ.");
          root.appendChild(p);
          var a = el("a", "cmt-twitch", "Se connecter avec Twitch");
          a.href = "/api/auth.php?login=1&return=%2Fmoderation";
          a.setAttribute("data-no-router", "");
          root.appendChild(a);
        } else {
          root.appendChild(el("p", "comment-empty", e.message));
        }
      });
    }

    function render(d) {
      root.innerHTML = "";
      root.appendChild(el("p", "mod-stats", d.stats.total + " commentaires sur le site · " + d.stats.reported + " masqués automatiquement · " + d.items.length + " à regarder"));

      if (!d.items.length) root.appendChild(el("p", "comment-empty", "Rien à modérer. Tout est calme en Azeroth."));
      d.items.forEach(function (c) {
        var card = el("article", "cmt mod-item" + (c.status !== "visible" ? " is-hidden" : ""));
        card.appendChild(avatar(c.author.avatar));
        var main = el("div", "cmt-main");
        var top = el("header", "cmt-top");
        top.appendChild(el("strong", "cmt-author", c.author.name));
        top.appendChild(el("span", "cmt-muted", "@" + c.author.login));
        if (c.author.banned) top.appendChild(el("span", "cmt-badge banned", "Banni"));
        top.appendChild(el("span", "cmt-badge " + (c.status === "reported" ? "warn" : c.status === "hidden" ? "hidden" : "ok"),
          c.status === "reported" ? "Masqué auto" : c.status === "hidden" ? "Masqué" : "Visible"));
        main.appendChild(top);

        var ctx = el("p", "mod-context");
        ctx.appendChild(document.createTextNode("Sur "));
        var link = el("a", null, c.build.name);
        link.href = "/" + c.build.class + "?build=" + encodeURIComponent(c.build.code) + "&b=" + c.build.id;
        ctx.appendChild(link);
        ctx.appendChild(document.createTextNode(" (" + (CLASS_NAMES[c.build.class] || c.build.class) + ") · " +
          new Date(c.created * 1000).toLocaleString("fr-FR") + " · " + c.reports + " signalement" + (c.reports > 1 ? "s" : "")));
        if (c.reasons) ctx.appendChild(document.createTextNode(" · motifs : " + c.reasons));
        main.appendChild(ctx);

        var body = el("div", "rich-text cmt-body");
        body.innerHTML = c.html;
        main.appendChild(body);

        var actions = el("div", "cmt-actions");
        if (c.status !== "visible" || c.reports > 0) {
          actions.appendChild(button("Rétablir", "", null, function () { return post({ action: "moderate", id: c.id, do: "show" }).then(load); }));
        }
        if (c.status === "visible") {
          actions.appendChild(button("Masquer", "", null, function () { return post({ action: "moderate", id: c.id, do: "hide" }).then(load); }));
        }
        actions.appendChild(button("Supprimer", "danger", "Confirmer ?", function () { return post({ action: "moderate", id: c.id, do: "delete" }).then(load); }));
        if (!c.author.banned) {
          actions.appendChild(button("Bannir l'auteur", "danger", "Bannir et supprimer tous ses commentaires ?", function () {
            return post({ action: "ban", user_id: c.author.id, ban: true }).then(load);
          }));
        }
        main.appendChild(actions);
        card.appendChild(main);
        root.appendChild(card);
      });

      var h = el("h2", "mod-subtitle", "Comptes bannis (" + d.banned.length + ")");
      root.appendChild(h);
      if (!d.banned.length) root.appendChild(el("p", "cmt-muted", "Aucun compte banni."));
      d.banned.forEach(function (u) {
        var row = el("div", "mod-banned");
        row.appendChild(avatar(u.avatar));
        row.appendChild(el("strong", null, u.display_name));
        row.appendChild(el("span", "cmt-muted", "@" + u.login));
        row.appendChild(button("Débannir", "", null, function () { return post({ action: "ban", user_id: u.id, ban: false }).then(load); }));
        root.appendChild(row);
      });
    }

    load();
  }

  window.WF.initModeration = init;
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
