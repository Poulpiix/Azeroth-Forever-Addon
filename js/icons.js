(function () {
  "use strict";

  var WF = (window.WF = window.WF || {});
  if (WF.icon) return;

  var BASE = "/img/icons-webp/";
  var PNG_BASE = "/img/icons/";
  var CDN = "https://wow.zamimg.com/images/wow/icons/";
  var RE = /(?:^|\/)img\/icons-webp\/(32|64)\/([a-z0-9_-]+)\.webp(?:[?#].*)?$/;

  function icon(slug, size) {
    return BASE + (size === 32 ? 32 : 64) + "/" + String(slug).toLowerCase() + ".webp";
  }

  function iconImg(slug, size, alt) {
    var img = document.createElement("img");
    img.className = "ui-ico";
    img.src = icon(slug, size);
    img.alt = alt || "";
    img.width = img.height = size === 32 ? 32 : 64;
    img.loading = "lazy";
    img.decoding = "async";
    return img;
  }

  var manifest = null;
  function loadManifest() {
    if (!manifest) {
      manifest = fetch(BASE + "manifest.json", { credentials: "same-origin" })
        .then(function (r) { return r.ok ? r.json() : { icons: {} }; })
        .then(function (d) { return d.icons || {}; })
        .catch(function () { return {}; });
    }
    return manifest;
  }

  function cdn(slug, size) {
    return CDN + (size === "32" ? "medium" : "large") + "/" + slug + ".jpg";
  }

  document.addEventListener("error", function (e) {
    var img = e.target;
    if (!img || img.tagName !== "IMG") return;
    var step = img.getAttribute("data-icon-fallback");
    if (step === "cdn") return;
    if (step === "png") {
      img.setAttribute("data-icon-fallback", "cdn");
      img.src = cdn(img.getAttribute("data-icon-slug"), img.getAttribute("data-icon-size"));
      return;
    }
    var m = RE.exec(img.getAttribute("src") || "");
    if (!m) return;
    var size = m[1], slug = m[2];
    img.setAttribute("data-icon-slug", slug);
    img.setAttribute("data-icon-size", size);
    loadManifest().then(function (icons) {
      if (icons[slug]) {
        img.setAttribute("data-icon-fallback", "png");
        img.src = PNG_BASE + icons[slug].split("/").map(encodeURIComponent).join("/");
      } else {
        img.setAttribute("data-icon-fallback", "cdn");
        img.src = cdn(slug, size);
      }
    });
  }, true);

  WF.icon = icon;
  WF.iconImg = iconImg;
  if (typeof window.icon === "undefined") window.icon = icon;
})();
