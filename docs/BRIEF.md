# Phase 6 — Addon Azeroth Forever

Jeu : World of Warcraft Forever (client 1.60.x).
Auteur : Poulpix
Licence : fichier LICENSE.md à la racine de l’addon (texte court MIT, auteur Poulpix).
Nom dossier / TOC : AzerothForever
Slash : /af
Thème visuel : celui du SITE azerothforever.info (fond sombre, or discret).
PAS le skin doré « Talents Forever ». La capture concurrente sert de STRUCTURE
(arbres + panneau droit + barre de niveaux), pas de copie graphique.

## But
Dans le jeu :
- builder de talents de classe
- liste / grimoire des sorts
- builder d’Héritage
- chemin niveau par niveau identique au site
- partage aller-retour site ↔ addon via AF1- / AF1H-
- QR qui ouvre le SITE (URL HTTPS)
- lien visible vers https://azerothforever.info/

## Partage
- Export : Copier le code → AF1-… (classe) ou AF1H-… (héritage)
- Checksum identique à docs/BUILD_CODEC.md
- Import : coller AF1- / AF1H- = même build + même ordre
- Un build fait en jeu s’ouvre sur le site (Coller un code)
- Un build fait sur le site s’ouvre dans l’addon
- Si le catalogue talents a changé : message « mets à jour l’addon », ne pas charger à l’aveugle
- QR : uniquement une URL HTTPS du site
  - lien court /b/xxxx si disponible
  - sinon https://azerothforever.info/{classe}?build=…&path=…
- Pas de Discord. Pas d’HTTP vers une API maison en V1.
- Data en snapshot dans l’addon.

## UI
Fenêtre unique /af
Gauche : 3 arbres de la classe + rangs
Droite, onglets :
- Accueil : résumé spec, prochain point, points non dépensés
- Plan : curseur niveau 10–60 + liste courte des prochains points
- Héritage : 16 points, Métiers / Aventure / Ingéniosité
- Sorts : sorts de la classe (rangs, niveau si data dispo)
- Builds : import / export, lien site
Bas : frise de niveaux liée au même ordre que le site
Boutons : Appliquer le prochain, Appliquer tout (confirmation), Reset, Undo, Import, Partager, QR, Site

Modes, mêmes noms que le site :
- Build au niveau 60
- Build niveau par niveau

## Talents
- Planifier sans dépenser tant que le joueur n’applique pas
- LearnTalent seulement sur clic (Apply next / Apply all)
- Auto-apply à la montée de niveau : OFF par défaut
- Overlay plan vs points réellement dépensés
- Pas de bot

## Data
Tables Lua générées depuis :
- data/talents-data.js
- data/heritage-data.js ou data/heritage-calculator.js
Script d’export possible dans tools/, à lancer avant zip.
Interdit d’inventer un tooltip.

## Fichiers
addon/AzerothForever/
  AzerothForever.toc
  LICENSE.md
  README.md
  Core.lua
  UI.xml
  UI.lua
  Talents.lua
  Heritage.lua
  Spellbook.lua
  Share.lua
  QR.lua
  data/*.lua

Simple. Pas de framework lourd.

## TOC
## Interface: numéro Forever 1.60 si tu le trouves dans les fichiers fournis, sinon TBD clairement indiqué
## Title: Azeroth Forever
## Author: Poulpix
## Version: 0.1.0
## Notes: Builds, héritage et partage AF1 pour WoW Forever

## Hors V1
- Annuaire guildes
- HTTP live
- Auto-apply sans case
- Copie pixel-perfect de Talents Forever
- Loot / donjons

## Livrable
1. Dossier chargeable dans Interface/AddOns
2. Exemple : AF1-CB10AAABBBBBCCCDDEEEEEFFGHHHIJJJKKLRRRRRSSSSSTTTTTUUUUU-A7
   = Guerrier 31/20/0 + ordre auto
3. Description des onglets
4. Liste TBD (surtout ## Interface:)