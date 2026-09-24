// Tests de l'annuaire de guildes (Phase 5).
// Lancer depuis la racine du site :  node --test "tools/tests/*.test.mjs"
//
// isForbidden() et isValidBattletag() (js/guilds.js) sont le miroir client de
// wf_guild_forbidden() / wf_valid_battletag() (api/_lib.php, source de vérité serveur).
// Les mêmes vecteurs ont été rejoués contre l'API PHP pendant le développement
// (voir packages/schema/GUILDS.md) ; ce fichier fige le comportement côté client.
import { test } from "node:test";
import assert from "node:assert/strict";
import path from "node:path";
import { createRequire } from "node:module";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, "..", "..");
const require = createRequire(import.meta.url);
const G = require(path.join(root, "js", "guilds.js"));

test("isForbidden : liens Discord, bruts et obfusqués", () => {
  const refusal = G.GUILD_REFUSAL;
  assert.equal(G.isForbidden("rejoins-nous sur discord.gg/abc123"), refusal);
  assert.equal(G.isForbidden("DISCORD.GG/ABC"), refusal);
  assert.equal(G.isForbidden("discord . gg / abc"), refusal);
  assert.equal(G.isForbidden("discord(dot)gg/abc"), refusal);
  assert.equal(G.isForbidden("rejoins discordapp.com/invite/x"), refusal);
  assert.equal(G.isForbidden("dsc.gg/xyz"), refusal);
});

test("isForbidden : email et téléphone", () => {
  const refusal = G.GUILD_REFUSAL;
  assert.equal(G.isForbidden("contacte-moi : chef@guilde.fr"), refusal);
  assert.equal(G.isForbidden("appelle le 06 12 34 56 78"), refusal);
  assert.equal(G.isForbidden("+33 6 12 34 56 78"), refusal);
});

test("isForbidden : liens externes bloqués, lien du site autorisé", () => {
  const refusal = G.GUILD_REFUSAL;
  assert.equal(G.isForbidden("voir https://exemple-guilde.xyz"), refusal);
  assert.equal(G.isForbidden("www.exemple-guilde.re"), refusal);
  assert.equal(G.isForbidden("notre fiche : https://azerothforever.info/guildes?voir=abc"), null);
});

test("isForbidden : texte normal, aucun faux positif", () => {
  assert.equal(G.isForbidden("Guilde PvE sympa, premiere fois sur Forever. Soirs 20h-23h."), null);
  assert.equal(G.isForbidden(""), null);
  assert.equal(G.isForbidden("Zug, Poulpix, Ana"), null);
});

test("isValidBattletag : format Nom#1234 uniquement", () => {
  assert.equal(G.isValidBattletag("Poulpix#1234"), true);
  assert.equal(G.isValidBattletag("Ana#12345"), true);
  assert.equal(G.isValidBattletag("Ana"), false);
  assert.equal(G.isValidBattletag("Ana#12"), false);
  assert.equal(G.isValidBattletag("ana#1234"), true); // pas de contrainte de casse
  assert.equal(G.isValidBattletag("A#1234"), false); // 1 caractère avant # : trop court (3 minimum)
  assert.equal(G.isValidBattletag("discord.gg#1234"), false);
});

test("matchesFilters : faction, recrutement, ambiance, recherche", () => {
  const g = { name: "Les Gardiens d'Azeroth", faction: "alliance", region: "EU", recruitment: "ouvert", vibes: ["pve", "casual"] };
  assert.equal(G.matchesFilters(g, {}), true);
  assert.equal(G.matchesFilters(g, { faction: "alliance" }), true);
  assert.equal(G.matchesFilters(g, { faction: "horde" }), false);
  assert.equal(G.matchesFilters(g, { recruitment: "ouvert" }), true);
  assert.equal(G.matchesFilters(g, { recruitment: "ferme" }), false);
  assert.equal(G.matchesFilters(g, { vibe: "pve" }), true);
  assert.equal(G.matchesFilters(g, { vibe: "hardcore" }), false);
  assert.equal(G.matchesFilters(g, { q: "gardiens" }), true);
  assert.equal(G.matchesFilters(g, { q: "flamme" }), false);
});
