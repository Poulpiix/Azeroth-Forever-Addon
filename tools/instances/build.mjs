#!/usr/bin/env node
/*
 * Azeroth Forever : fiches d'instances (Phase 4).
 *
 * Source : data/instances/<slug>.json (une fiche par instance, schéma dans
 * packages/schema/INSTANCES.md). Rien n'est inventé : une donnée sans source reste null.
 *
 * L'affichage se fait en JS sur /donjons (js/dungeons.js) : un clic sur une carte
 * déplie sa fiche sous la carte. Il n'y a plus de page HTML par instance.
 * Ce script produit seulement :
 *   - data/instances/_fiches.json   : toutes les fiches en un fichier (lu par /donjons) ;
 *   - data/instances/_index.json   : statut de chaque fiche (complet | partiel | vide) ;
 *   - l'attribut data-instances-src de donjons.html (numéro de version pour le cache).
 *
 * Usage, depuis la racine du site :
 *   node tools/instances/build.mjs          écrit les fichiers
 *   node tools/instances/build.mjs --check  vérifie seulement (code 1 si un fichier n'est pas à jour)
 *
 * Aucune dépendance. Sortie déterministe (la date vient des fiches).
 */
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const HERE = path.dirname(fileURLToPath(import.meta.url));
export const ROOT = path.resolve(HERE, "..", "..");
export const DATA_DIR = path.join(ROOT, "data", "instances");
export const OLD_PAGE_PREFIX = "donjons-";

const TYPES = { dungeon: "Donjon", raid: "Raid", bg: "Champ de bataille" };
const ORIGINS = { classic: "Classic", new: "Nouveau Forever" };
const CONFIDENCE = {
  confirme: "Confirmé en jeu",
  annonce: "Annonce officielle (BlizzCon), pas encore vérifiée en jeu",
  classic: "Donnée Classic, à revérifier en Forever",
  tbd: "Non vérifié"
};
export const STATUS_LEGEND = {
  complet: "Boss, quêtes et accès renseignés et sourcés.",
  partiel: "Quelques informations sourcées (présentation, accès, boss ou quêtes), mais la fiche n'est pas complète.",
  vide: "Nom, niveaux et type seulement. Le reste est TBD, faute de source."
};

/* ---------- Lecture et validation ---------- */

export function loadInstances(dir = DATA_DIR) {
  return fs.readdirSync(dir)
    .filter((f) => f.endsWith(".json") && !f.startsWith("_"))
    .map((f) => ({ file: f, data: JSON.parse(fs.readFileSync(path.join(dir, f), "utf8")) }))
    .sort((a, b) => a.data.order - b.data.order);
}

const isStr = (v) => typeof v === "string" && v.trim() !== "";
const isOptStr = (v) => v === null || isStr(v);

// Renvoie la liste des erreurs (vide si la fiche est valide).
export function validate(inst, file) {
  const e = [];
  const need = (cond, msg) => { if (!cond) e.push((file || inst.slug || "?") + " : " + msg); };
  const srcIds = new Set((Array.isArray(inst.sources) ? inst.sources : []).map((s) => s && s.id));
  need(inst.schema === 1, "schema doit valoir 1");
  need(isStr(inst.id), "id manquant");
  need(isStr(inst.slug) && /^[a-z0-9]+(-[a-z0-9]+)*$/.test(inst.slug), "slug invalide");
  need(!file || file === inst.slug + ".json", "le nom du fichier doit être <slug>.json");
  need(Array.isArray(inst.slugs) && inst.slugs[0] === inst.slug, "slugs[0] doit être le slug");
  need(Array.isArray(inst.slugs) && inst.slugs.every((s) => /^[a-z0-9]+(-[a-z0-9]+)*$/.test(s)), "alias de slug invalide");
  need(Number.isInteger(inst.order), "order manquant");
  need(inst.names && isStr(inst.names.fr), "names.fr manquant");
  need(inst.names && isOptStr(inst.names.en), "names.en doit être un texte ou null");
  need(inst.names && typeof inst.names.frOfficial === "boolean", "names.frOfficial manquant");
  need(Array.isArray(inst.aliases), "aliases doit être un tableau");
  need(TYPES[inst.type], "type inconnu");
  need(ORIGINS[inst.origin], "origin inconnue");
  need(isOptStr(inst.note), "note doit être un texte ou null");
  need(inst.levels === null || (inst.levels && Number.isInteger(inst.levels.min) && Number.isInteger(inst.levels.max) && inst.levels.min <= inst.levels.max), "levels invalide");
  need(inst.type !== "dungeon" || inst.levels, "un donjon doit avoir une tranche de niveaux");
  ["levelFinder", "levelEntry"].forEach((k) => need(inst[k] === null || Number.isInteger(inst[k]), k + " doit être un entier ou null"));
  need(inst.players === null || Number.isInteger(inst.players) || inst.players === "15v15", "players invalide");
  need(isOptStr(inst.lockout), "lockout doit être un texte ou null");
  need(inst.mapId === null || Number.isInteger(inst.mapId), "mapId doit être un entier ou null");
  need(inst.availability === null || (inst.availability && isStr(inst.availability.text)), "availability invalide");
  need(isOptStr(inst.summary), "summary doit être un texte ou null");
  need(!inst.summary || srcIds.has(inst.summarySource), "summarySource absente de sources[]");
  need(inst.entry && isOptStr(inst.entry.where) && isOptStr(inst.entry.how), "entry invalide");
  need(!inst.entry || !(inst.entry.where || inst.entry.how) || srcIds.has(inst.entry.source), "entry.source absente de sources[]");
  need(Array.isArray(inst.bosses), "bosses doit être un tableau (vide si inconnu)");
  need(Array.isArray(inst.quests), "quests doit être un tableau (vide si inconnu)");
  need(isOptStr(inst.loot), "loot doit être un texte ou null");
  need(isOptStr(inst.classicDiff), "classicDiff doit être un texte ou null");
  need(inst.origin === "classic" || inst.classicDiff === null, "classicDiff réservé aux instances Classic");
  need(isOptStr(inst.image), "image doit être un nom de fichier ou null");
  need(isOptStr(inst.clientBuild), "clientBuild doit être un texte ou null");
  need(CONFIDENCE[inst.confidence], "confidence inconnue");
  need(Array.isArray(inst.sources) && inst.sources.length > 0, "au moins une source");
  (inst.sources || []).forEach((s, i) => need(isStr(s.id) && isStr(s.label) && isStr(s.ref), "source " + i + " incomplète"));
  need(/^\d{4}-\d{2}-\d{2}$/.test(inst.updated || ""), "updated doit être une date AAAA-MM-JJ");
  (inst.bosses || []).forEach((b, i) => {
    need(b && b.names && isStr(b.names.fr), "boss " + i + " : names.fr manquant");
    need(b && CONFIDENCE[b.confidence], "boss " + i + " : confidence inconnue");
    need(b && srcIds.has(b.source), "boss " + i + " : source absente de sources[]");
  });
  (inst.quests || []).forEach((q, i) => {
    need(q && q.names && isStr(q.names.fr), "quête " + i + " : names.fr manquant");
    need(q && CONFIDENCE[q.confidence], "quête " + i + " : confidence inconnue");
    need(q && srcIds.has(q.source), "quête " + i + " : source absente de sources[]");
  });
  return e;
}

// complet | partiel | vide, calculé à partir du contenu (jamais saisi à la main).
export function statusOf(inst) {
  const hasBosses = inst.bosses.length > 0;
  const hasQuests = inst.quests.length > 0;
  const hasHow = !!(inst.entry && inst.entry.how);
  const hasWhere = !!(inst.entry && inst.entry.where);
  const classicOk = inst.origin !== "classic" || !!inst.classicDiff;
  const complete = inst.type === "bg"
    ? !!inst.summary && hasHow && classicOk
    : hasBosses && hasQuests && hasHow && classicOk;
  if (complete) return "complet";
  if (hasBosses || hasQuests || hasHow || hasWhere || inst.summary || inst.classicDiff) return "partiel";
  return "vide";
}

/* ---------- Fichiers dérivés ---------- */

export const BUNDLE = "data/instances/_fiches.json";

export function buildBundle(list) {
  return {
    version: 1,
    date: list.reduce((max, x) => (x.data.updated > max ? x.data.updated : max), ""),
    instances: list.map((x) => Object.assign({}, x.data, { statut: statusOf(x.data) }))
  };
}

export function buildIndex(list) {
  return {
    version: 1,
    date: list.reduce((max, x) => (x.data.updated > max ? x.data.updated : max), ""),
    legende: STATUS_LEGEND,
    total: list.length,
    compte: ["complet", "partiel", "vide"].reduce((o, k) => { o[k] = list.filter((x) => statusOf(x.data) === k).length; return o; }, {}),
    instances: list.map((x) => ({ slug: x.data.slug, id: x.data.id, statut: statusOf(x.data) }))
  };
}

// Pose data-instances-src="data/instances/_fiches.json?v=<empreinte>" sur la liste de /donjons.
export function stampDonjons(html, bundleText) {
  const v = crypto.createHash("sha1").update(bundleText).digest("hex").slice(0, 10);
  const attr = 'data-instances-src="' + BUNDLE + "?v=" + v + '"';
  if (/data-instances-src="[^"]*"/.test(html)) return html.replace(/data-instances-src="[^"]*"/, attr);
  if (html.indexOf("<div data-ig-list>") < 0) throw new Error("donjons.html : <div data-ig-list> introuvable");
  return html.replace("<div data-ig-list>", "<div data-ig-list " + attr + ">");
}

// Calcule tous les fichiers à écrire : { chemin relatif: contenu }.
export function plan(root = ROOT) {
  const list = loadInstances(path.join(root, "data", "instances"));
  const errors = [];
  list.forEach((x) => errors.push(...validate(x.data, x.file)));
  const seen = new Map();
  list.forEach((x) => x.data.slugs.forEach((s) => {
    if (seen.has(s)) errors.push("slug en double : " + s + " (" + seen.get(s) + ", " + x.data.slug + ")");
    seen.set(s, x.data.slug);
  }));
  const donjons = fs.readFileSync(path.join(root, "donjons.html"), "utf8");
  const cards = [...donjons.matchAll(/<li class="ig-card" data-id="(\w+)" data-slug="([a-z0-9-]+)"/g)];
  const byId = new Map(list.map((x) => [x.data.id, x.data.slug]));
  if (cards.length !== list.length) errors.push("donjons.html : " + cards.length + " cartes pour " + list.length + " fiches");
  cards.forEach(([, id, slug]) => {
    if (byId.get(id) !== slug) errors.push("donjons.html : carte " + id + " pointe vers " + slug + " au lieu de " + byId.get(id));
  });
  if (errors.length) return { errors, files: {} };
  const bundleText = JSON.stringify(buildBundle(list), null, 1) + "\n";
  const files = {};
  files[BUNDLE] = bundleText;
  files["data/instances/_index.json"] = JSON.stringify(buildIndex(list), null, 2) + "\n";
  files["donjons.html"] = stampDonjons(donjons, bundleText);
  return { errors, files, list };
}

// Anciennes pages par instance (première version de la Phase 4), à supprimer.
export function leftovers(root = ROOT) {
  return fs.readdirSync(root).filter((f) => f.startsWith(OLD_PAGE_PREFIX) && f.endsWith(".html"));
}

function main() {
  const check = process.argv.includes("--check");
  const { errors, files } = plan();
  if (errors.length) {
    console.error("Fiches invalides :\n  " + errors.join("\n  "));
    process.exit(1);
  }
  const stale = [];
  for (const [rel, content] of Object.entries(files)) {
    const abs = path.join(ROOT, rel);
    const old = fs.existsSync(abs) ? fs.readFileSync(abs, "utf8") : null;
    if (old === content) continue;
    stale.push(rel);
    if (!check) fs.writeFileSync(abs, content);
  }
  const old = leftovers();
  if (old.length) console.log("Anciennes pages à supprimer (redirigées vers /donjons?ouvrir=… par .htaccess) : " + old.length);
  if (check) {
    if (stale.length) {
      console.error("Pas à jour : " + stale.join(", ") + "\nLancez : node tools/instances/build.mjs");
      process.exit(1);
    }
    console.log("Fiches d'instances à jour (" + Object.keys(files).length + " fichiers).");
  } else {
    console.log(stale.length ? "Écrit : " + stale.join(", ") : "Rien à changer.");
  }
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) main();
