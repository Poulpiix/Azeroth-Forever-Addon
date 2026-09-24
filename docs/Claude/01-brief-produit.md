# Brief produit — Azeroth Forever (site + addon)

## 1. Objectif

Étendre https://azerothforever.info/ et livrer une partie équivalente dans un addon WoW Forever simple d’utilisation.

### Dans l’addon et sur le site

- Builder de classe
- Builder d’héritage
- Liste des donjons / raids

Avec partage : lien + code collable in-game + QR code.

Référence concurrent addon :
- https://x.com/baldwinbuilds/status/2102790811721081200
- https://www.curseforge.com/wow/addons/talents-forever
- Slash concurrent : `/tf`
- Comportements à viser : planifier sans dépenser un point, voir le build à n’importe quel niveau, tester un build populaire en overlay, partager par lien ou collage.

### À ajouter aussi sur le site

1. Builder de classe : ordre d’affectation des points selon le niveau, avec un curseur à déplacer vers le niveau désiré.
2. Listing des quêtes et bosses de chaque raid / donjon, modèle : https://wowforevertalents.com/dungeons/
3. Annuaire de guildes : nom, officiers, effectif, recrutement, ambiance, etc. Pour la sécurité, aucun lien Discord. Tout contact se fait par BattleTag.

## 2. Contexte jeu

- World of Warcraft: Forever (Classic Era + ajouts Forever)
- Cap niveau 60
- Lancement 4 novembre 2026
- 51 points de talents de classe au niveau 60 (1 point par niveau à partir du niveau 10)
- Le perk d’Héritage « Talentueux / Talented » peut avancer le premier point de talent, sans augmenter le cap de 51
- Héritage : 16 points dépensables par personnage au lancement, 3 arbres = Métiers / Aventure / Ingéniosité
- Points d’Héritage gagnés sur le compte, dépensés séparément par personnage
- Client cible de l’addon : 1.60.x
- HTTP sortant addon souvent absent ou très limité en Classic : l’addon embarque un snapshot de données, mis à jour via CurseForge / Wago

## 3. Existant à ne pas jeter

- Calculateur de talents, exemple :
  https://azerothforever.info/guerrier?build=35325213132100000-555500000000000000-000000000000000000
- Clic = apprendre un point, clic droit = oublier
- Calculateur d’Héritage 16 points + partage par lien
- Raciales Classic vs Forever
- Métiers passifs
- Builds de la communauté (publics seulement)
- Pages feuille de route et à-quoi-attendre
- /donjons : liste plate de 28 instances (19 Classic + 9 nouveaux), niveaux seulement, pas de fiches boss/quêtes
- Environ 469 talents documentés, données vers le 21/09/2026
- Marque : Azeroth Forever by Poulpix (FR)

Pages utiles :
- https://azerothforever.info/
- https://azerothforever.info/competences
- https://azerothforever.info/metiers
- https://azerothforever.info/builds
- https://azerothforever.info/a-quoi-attendre
- https://azerothforever.info/feuille-de-route
- https://azerothforever.info/races
- https://azerothforever.info/donjons

## 4. Encoder un build

Aujourd’hui ?build= ne contient que les rangs finaux. Il faut ajouter l’ordre d’achat des points.

### Modèle JSON interne

{
  "v": 1,
  "kind": "class",
  "class": "warrior",
  "dataBuild": "1.60.1.69977",
  "levelCap": 60,
  "final": {
    "arms": [3, 5, 3, 2, 5, 2, 1, 3, 1, 3, 2, 1, 0, 0, 0, 0, 0],
    "fury": [],
    "prot": []
  },
  "order": [
    { "tree": "arms", "talentId": "improved_heroic_strike", "rank": 1 }
  ],
  "assumptions": { "talentedRanks": 0 }
}

### URL

- Garder ?build= pour la rétrocompatibilité.
- Ajouter ?path= pour l’ordre compact.
- Si path est absent : générer un ordre automatique déterministe à partir de build.
- Si path est incompatible avec build : build gagne, on régénère path, toast FR « parcours recalculé ».
- Lien court optionnel : /b/xxxx qui redirige vers l’URL longue.

### Codes partage

- Classe : préfixe AF1- + checksum
- Héritage : AF1H-
- Combo plus tard : AF1C-<class>-<path>-H-<heritage>-R-<race>

Le QR code encode uniquement l’URL courte HTTPS du site, jamais l’URL longue.

Détail codec : voir 03-codec-builds.md.

## 5. Builder de classe — curseur de niveau

Feature prioritaire du site.

- Slider de 10 à 60, défaut 60.
- Si Talentueux > 0, le minimum du slider descend (exemple : 9).
- Afficher en live : niveau simulé, points disponibles / dépensés / restants à CE niveau.
- Talents déjà achetés à ce niveau = pleins. Talents pas encore achetés = overlay / opacité.

### Deux modes d’édition

1. Mode Fin (défaut actuel) : le joueur clique les rangs cibles. Le système génère un ordre valide (prérequis, puis palier de 5 points par arbre, puis ordre déterministe).
2. Mode Parcours : chaque clic ajoute à la fin de order. Clic droit retire le dernier rang de CE talent dans order, pas forcément le dernier point global.

### Boutons

- Recalculer un ordre propre
- Réinitialiser l’ordre (garder les rangs)
- Réinitialiser tout

### Liste latérale « Parcours de montée »

Exemple de ligne :
Niv. 10 — Armes : Frappe héroïque améliorée 1/3

Clic sur une ligne = le slider saute à ce niveau.

Validation en temps réel. Interdire un ordre qui casse prérequis, palier ou cap 51. Message français clair.

### Formule de points (à recaler si le client dit autrement)

pointsDisponibles(niveau, talentedRanks) = clamp(niveau - (10 - talentedRanks), 0, 51)

Ne jamais dépasser 51.

## 6. Builder d’héritage

- 16 points, 3 arbres : Métiers, Aventure, Ingéniosité.
- Pas de slider de niveau personnage.
- Curseur « points dépensés » de 0 à 16.
- Presets : Premier perso leveling / Replays métiers / Qualité de vie niveau 60.
- Même système de partage (lien, code, QR).
- Texte obligatoire : les points sont gagnés sur le compte et dépensés par personnage.

## 7. Annuaire donjons / raids / BG

Remplacer /donjons par un vrai directory. Garder une redirection /donjons vers /instances.

Modèle de contenu (sans copier le texte) :
- https://wowforevertalents.com/dungeons/
- https://wowforevertalents.com/dungeons/ragefire-chasm/

### Index /instances

Filtres :
- Type : Donjon | Raid | Champ de bataille | Arène
- Origine : Classic | Nouveau Forever | Modifié | Annoncé
- Niveau du joueur : verrouille visuellement les instances hors portée
- Taille : 5 / 10 / 20 / 40 / 15v15
- Recherche nom FR et EN

Carte / ligne :
- Nom FR + EN
- Niveau Group Finder + niveau d’entrée
- Nombre de joueurs
- Nombre de bosses / quêtes
- Lockout si connu
- Badges nouveau / modifié

### Fiche /instances/[slug]

Slug stable, alias EN accepté. Exemple : gouffre-de-ragefeu et ragefire-chasm.

Sections :
1. En-tête : type, taille, niveaux, lockout, build des données
2. Comment entrer
3. Bosses dans l’ordre de progression (nom FR/EN, one-liner si on l’a, note Forever vs Classic)
4. Quêtes liées (nom, niveau, donneur / rendu, objectifs courts, XP / argent / réput / item si connu)
5. Comparatif Classic si l’instance existait
6. Sources + date + « sujet à changement bêta »

Pas de table de loot inventée. Si inconnu : « Loot non publié ».

### Fichier data

data/instances/{slug}.json

Champs minimaux :
- id
- slugs
- names.fr / names.en
- type
- origin
- levelFinder
- levelEntry
- players
- lockout
- mapId
- bosses
- quests
- classicDiff
- clientBuild
- confidence

V1 acceptable :
- les 28 donjons déjà listés
- 3 raids de décembre 2026 : Fosses de Barrow (10), Sommet du Hyjal (20), Repaire d’Onyxia (40)
- raids Classic avec statut confirmé / non confirmé

Fiche modèle à faire en premier : Gouffre de Ragefeu.
L’UI doit accepter des listes bosses/quests vides sans casser.

## 8. Annuaire de guildes /guildes

### Champs publics

- Nom de guilde
- Faction
- Région EU / US
- Langue
- Effectif par fourchette : 10–20 / 20–50 / 50–100 / 100+
- Officiers (pseudos jeu, pas forcément leurs BattleTag)
- Recrutement : ouvert / preview / fermé
- Classes / rôles recherchés
- Tags d’ambiance fermés : casual, semi-heavy, hardcore, RP, PvP, PvE, first perso, soirs seulement
- Horaires + fuseau
- Progression souhaitée (instances à cocher)
- Description 800 caractères max
- BattleTag de contact unique au format Nom#1234
- Date de mise à jour

Forever est annoncé sans realms classiques : pas de champ realm obligatoire. Utiliser région + langue + communauté.

### Sécurité

Filtrer côté client ET serveur :
- discord.gg
- discord.com
- discordapp.com
- dsc.gg
- invites obfusquées
- tout lien http hors azerothforever.info
- emails
- numéros de téléphone

Message de refus : « Contact uniquement par BattleTag ».

Compte requis pour créer / éditer.
Une fiche active par compte.
Bouton Signaler.
Admin : masquer / bannir.

Pas d’annuaire guildes dans l’addon V1.

## 9. Addon in-game

Nom : AzerothForever
Slash : /af

### V1 obligatoire

1. Talents : overlay du plan vs talents réels. Ne dépense rien tant que le joueur n’appuie pas sur « Appliquer ce palier » ou « Appliquer tout ce qui est apprenable ».
2. Curseur de niveau identique au site, basé sur le même order.
3. Héritage : preview des 16 points. Application seulement si l’API client le permet. Sinon preview + « ouvre l’interface officielle ».
4. Import / export du code AF1-. Popup avec le lien site pour scanner le QR hors jeu.
5. Instances : liste + fiche offline issues du snapshot. Bouton « instance actuelle » si GetInstanceInfo() correspond.
6. Builds communautaires embarqués : top 20 par classe, régénérés à chaque release de l’addon.

### V1 souhaitable

- Auto-learn à PLAYER_LEVEL_UP selon order, opt-in, désactivé par défaut
- Rappel maître : petite carte « ton plan débloque X »
- Comparer un build populaire en overlay
- Mini QR in-game si le temps le permet

### Hors V1

- Simulation DPS
- Loot live
- Discord
- HTTP polling du site
- Annuaire guildes live

### Contraintes techniques addon

- Lua 5.1 + FrameXML Classic 1.60
- Data dans addon/AzerothForever/data/*.lua générée depuis les mêmes JSON que le site
- Script obligatoire : scripts/export-addon-data.ts
- TOC avec Interface Forever
- Pas de bot. LearnTalent seulement sur clic joueur ou opt-in level-up
- Si le dataBuild de l’addon est plus vieux que le code importé : warning « mets à jour l’addon »

## 10. Architecture recommandée

data/talents/{class}.json
data/heritage.json
data/races.json
data/instances/{slug}.json
data/community-builds.snapshot.json
web/
addon/
packages/schema/
scripts/validate-data.ts
scripts/encode-build.ts
scripts/export-addon-data.ts

Une seule source de vérité pour les tooltips et les arbres.
Tests unitaires du codec : encode puis decode puis égalité.

API site minimale :
- shortlinks
- publication builds communauté (auth)
- CRUD guildes + modération
- liste instances

Les talents peuvent rester statiques au build du site.

## 11. Textes FR à utiliser

- Planifier sans dépenser
- Voir mon build au niveau X
- Parcours de montée
- Recalculer un ordre propre
- Copier le lien
- Copier le code addon
- Afficher le QR
- Contact par BattleTag uniquement — pas de Discord
- Données client Forever, build …. Sujet à changement.
- Traduction FR non officielle

Design : garder le look actuel du site. Accessibilité clavier pour le slider. Mobile : tap = +1, appui long = -1.

## 12. Interdit

- Lien Discord « pour cette fois »
- Promettre un loot exact
- Appliquer les talents tout seul sans confirmation
- Réécrire tout le site
- App live addon vers serveur en V1
- Inventer les quêtes des 9 nouveaux donjons si le client ne les a pas