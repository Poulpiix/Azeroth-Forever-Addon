#!/usr/bin/env node
/*
 * Azeroth Forever : export des données JS (data/talents-data.js, data/heritage-data.js)
 * vers des tables Lua utilisables par l'addon (addon/AzerothForever/Data/*.lua).
 *
 * A lancer avant de zipper l'addon :
 *   node tools/export-lua.mjs
 *
 * Ne fait aucune invention : copie les champs existants (id, name, icon, row,
 * col, maxRank, requires, descriptions de rangs, spellId). Les champs
 * documentaires (status, sources, classic, background) ne sont pas repris
 * dans l'addon : ils ne servent pas au jeu.
 */
import fs from "node:fs";
import path from "node:path";
import vm from "node:vm";
import { fileURLToPath } from "node:url";

const ROOT = path.dirname(path.dirname(fileURLToPath(import.meta.url)));
const OUT_DIR = path.join(ROOT, "addon", "AzerothForever", "Data");

function loadWindowScript(file) {
  const code = fs.readFileSync(path.join(ROOT, "data", file), "utf8");
  const sandbox = { window: {}, module: undefined };
  vm.createContext(sandbox);
  vm.runInContext(code, sandbox, { filename: file });
  return sandbox.window;
}

const win = loadWindowScript("talents-data.js");
const TALENTS_FR = win.TALENTS_FR;
if (!Array.isArray(TALENTS_FR)) throw new Error("TALENTS_FR introuvable dans data/talents-data.js");

const winH = loadWindowScript("heritage-data.js");
const HERITAGE_FR = winH.HERITAGE_FR;
if (!HERITAGE_FR || !Array.isArray(HERITAGE_FR.trees)) throw new Error("HERITAGE_FR introuvable dans data/heritage-data.js");

// ---------- Lua serialization ----------

const LUA_IDENT = /^[A-Za-z_][A-Za-z0-9_]*$/;
const LUA_KEYWORDS = new Set([
  "and", "break", "do", "else", "elseif", "end", "false", "for", "function",
  "if", "in", "local", "nil", "not", "or", "repeat", "return", "then",
  "true", "until", "while"
]);

function luaKey(key) {
  if (LUA_IDENT.test(key) && !LUA_KEYWORDS.has(key)) return key;
  return "[" + luaString(key) + "]";
}

function luaString(s) {
  return "\"" + String(s).replace(/\\/g, "\\\\").replace(/"/g, "\\\"").replace(/\n/g, "\\n") + "\"";
}

function luaValue(v, indent) {
  if (v === null || v === undefined) return "nil";
  if (typeof v === "number") return String(v);
  if (typeof v === "boolean") return v ? "true" : "false";
  if (typeof v === "string") return luaString(v);
  if (Array.isArray(v)) return luaArray(v, indent);
  if (typeof v === "object") return luaObject(v, indent);
  throw new Error("Type non supporté : " + typeof v);
}

function luaArray(arr, indent) {
  if (arr.length === 0) return "{}";
  const pad = "  ".repeat(indent + 1);
  const items = arr.map((item) => pad + luaValue(item, indent + 1));
  return "{\n" + items.join(",\n") + "\n" + "  ".repeat(indent) + "}";
}

function luaObject(obj, indent) {
  const keys = Object.keys(obj);
  if (keys.length === 0) return "{}";
  const pad = "  ".repeat(indent + 1);
  const items = keys.map((k) => pad + luaKey(k) + " = " + luaValue(obj[k], indent + 1));
  return "{\n" + items.join(",\n") + "\n" + "  ".repeat(indent) + "}";
}

// ---------- Réduction des talents (aucune invention, juste un tri des champs) ----------

function reduceRequires(reqs) {
  return (reqs || []).map((r) => ({ id: r.id, qty: r.qty }));
}

function reduceRanks(ranks) {
  return (ranks || []).map((r) => ({
    spellId: r.spellId || 0,
    desc: r.description || ""
  }));
}

function reduceTalent(t) {
  return {
    id: t.id,
    name: t.name,
    icon: t.icon,
    row: t.row,
    col: t.col,
    maxRank: t.maxRank,
    requires: reduceRequires(t.requires),
    ranks: reduceRanks(t.ranks)
  };
}

function reduceTree(tree) {
  return {
    id: tree.id,
    name: tree.name,
    slug: tree.slug,
    order: tree.order,
    icon: tree.icon,
    talents: tree.talents.map(reduceTalent)
  };
}

function reduceClass(cls) {
  return {
    id: cls.id,
    slug: cls.slug,
    name: cls.name,
    color: cls.color,
    icon: cls.icon,
    trees: cls.trees.map(reduceTree)
  };
}

const classes = TALENTS_FR.map(reduceClass);

let totalTalents = 0;
classes.forEach((c) => c.trees.forEach((t) => { totalTalents += t.talents.length; }));

fs.mkdirSync(OUT_DIR, { recursive: true });

// ---------- Data/Talents.lua ----------

const talentsLua =
`-- Azeroth Forever : catalogue des talents de classe.
-- Généré par tools/export-lua.mjs depuis data/talents-data.js. Ne pas éditer à la main.
-- Champs conservés tels quels (aucune invention) : id, name, icon, row, col, maxRank,
-- requires, ranks (spellId + desc). Les champs documentaires (status, sources, classic,
-- background) du site ne sont pas repris ici.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Talents = ${luaValue(classes, 0)}
`;

fs.writeFileSync(path.join(OUT_DIR, "Talents.lua"), talentsLua);

// ---------- Data/Heritage.lua ----------

function reduceHeritageNode(n) {
  if (n.placeholder) return null;
  return {
    id: n.id,
    name: n.name,
    icon: n.icon,
    maxRank: n.maxRank,
    tier: n.tier || 0,
    row: n.row,
    col: n.col,
    desc: n.desc || ""
  };
}

function reduceHeritageTree(tree) {
  return {
    id: tree.id,
    name: tree.name,
    icon: tree.icon,
    desc: tree.desc || "",
    nodes: tree.nodes.map(reduceHeritageNode).filter(Boolean)
  };
}

const heritageTrees = HERITAGE_FR.trees.map(reduceHeritageTree);
const heritagePresets = (HERITAGE_FR.presets || []).map((p) => ({
  id: p.id,
  name: p.name,
  desc: p.desc || "",
  ranks: p.ranks || {}
}));

const heritageLua =
`-- Azeroth Forever : catalogue de l'arbre d'Héritage (16 points, 3 arbres).
-- Généré par tools/export-lua.mjs depuis data/heritage-data.js. Ne pas éditer à la main.
-- Les nœuds « placeholder » (cases vides de la grille) ne sont pas repris : ils ne
-- portent aucune donnée et ne comptent pas dans l'ordre AF1H-/?hbuild=.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Heritage = {
  trees = ${luaValue(heritageTrees, 1)},
  presets = ${luaValue(heritagePresets, 1)}
}
`;

fs.writeFileSync(path.join(OUT_DIR, "Heritage.lua"), heritageLua);

// ---------- Data/Constants.lua ----------

const CLASS_SLUGS = { 1: "guerrier", 2: "paladin", 3: "chasseur", 4: "voleur", 5: "pretre", 7: "chaman", 8: "mage", 9: "demoniste", 11: "druide" };

// Table indexée par id de classe WoW (nombre) : clés Lua numériques non
// quottées, pas la sérialisation générique (qui quotterait "1", "2"...).
function luaClassSlugsTable(map, indent) {
  const pad = "  ".repeat(indent + 1);
  const items = Object.keys(map).map((id) => pad + "[" + id + "] = " + luaString(map[id]));
  return "{\n" + items.join(",\n") + "\n" + "  ".repeat(indent) + "}";
}

const constantsLua =
`-- Azeroth Forever : constantes du codec, partagées avec le site (docs/BUILD_CODEC.md).
-- Généré par tools/export-lua.mjs. Ne pas éditer à la main (sauf SITE_URL).
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Constants = {
  ALPHABET = ${luaString("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")},
  PATH_VERSION = "1",
  MAX_POINTS = 51,
  MAX_LEVEL = 60,
  MIN_LEVEL = 10,
  TALENTED_KNOWN_MAX = 1,
  TALENTED_MAX_STORED = 7,
  HERITAGE_MAX_POINTS = 16,
  HERITAGE_CODE_VERSION = "1",
  DATA_BUILD = ${luaString("1.60.1.69893")},
  TALENT_COUNT = ${totalTalents},
  PREFIX_CLASS = "AF1-",
  PREFIX_HERITAGE = "AF1H-",
  KIND_CLASS = "C",
  SITE_URL = "https://azerothforever.info/",
  CLASS_SLUGS = ${luaClassSlugsTable(CLASS_SLUGS, 1)}
}
`;

fs.writeFileSync(path.join(OUT_DIR, "Constants.lua"), constantsLua);

console.log("OK : " + classes.length + " classes, " + totalTalents + " talents, " + heritageTrees.reduce((n, t) => n + t.nodes.length, 0) + " nœuds d'Héritage.");
