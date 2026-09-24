# État actuel du site (audit Phase 0 du 23/09/2026, mis à jour après la Phase 5)

Audit fait par lecture du dossier `Version prod` (code tel qu'il est déployable). Section 8 (Phase 5, annuaire de guildes) testée de bout en bout dans une copie isolée (serveur PHP local + Playwright), sans toucher `api/data/` du dépôt réel. Le reste n'a pas été testé en navigateur ni sur le serveur de production. Quand une info n'est pas vérifiable depuis le code : `TBD`.

## 1. Stack

| Sujet | Constat |
|---|---|
| Framework front | **Aucun.** HTML statique écrit à la main (une page `.html` par route) + JS vanilla ES5 dans `js/`. Pas de bundler, pas de `package.json`, pas de tests dans ce dossier. |
| JS minifié | À l'audit, `calculator.js`, `heritage-calculator.js`, `competences.js`, `main.js` et `talents-data.js` étaient minifiés, sans source lisible. Depuis : `calculator.js` (Phase 1) et `heritage-calculator.js` (Phase 3) sont réécrits en clair, comportement vérifié identique. Les autres fichiers de `js/` sont lisibles. |
| Navigation | Mini routeur maison dans `main.js` : intercepte les clics internes, `fetch` la page, remplace `#contenu`, puis charge les scripts nécessaires. Les URLs des scripts (avec `?v=`) sont **codées en dur dans `main.js`** (`js/calculator.js?v=2`, `js/builds.js?v=8`, `js/heritage-calculator.js?v=2`…). |
| CSS | `css/style.css?v=18`, `css/forever.css?v=2`, `css/pages.css?v=12`. |
| Serveur | Apache + `.htaccess` (mod_rewrite : URLs sans `.html`, HTTPS forcé, blocage bots IA). PHP 8+ (`declare(strict_types=1)`, `str_starts_with`). |
| Base de données | SQLite : `api/data/builds.sqlite` (tables `builds`, `build_views`, `build_likes`, `users`, `sessions`, `build_comments`, `comment_votes`, `comment_reports`). Dossier `api/data/` interdit en HTTP (`.htaccess` dédié + règle globale). |
| Sécurité HTTP | CSP stricte : `script-src 'self'` + un seul hash (le petit script inline du thème Horde). **Tout nouveau JS doit être un fichier servi par le site, aucun script inline, aucun CDN.** `img-src` accepte `data:` (utile pour un QR en Phase 2). |
| Cache | JS et CSS en `max-age` 1 mois : toute modif d'un JS/CSS exige un bump `?v=` dans **chaque** page qui l'inclut **et** dans `main.js` pour les scripts chargés par le routeur. |
| Hébergeur | TBD (non visible dans le code). |
| Autre dossier | Un dossier voisin `Version live (pas toucher)` existe. Non audité (hors accès). Lequel est réellement en ligne : TBD. |

## 2. Auth et comptes

- Connexion **Twitch OAuth** (`api/auth.php?login=1`, retour `api/twitch-callback.php`). Pas de mot de passe, pas de BattleTag.
- Session : cookie `wf_session` (httpOnly, 30 jours), hash du token en base.
- Admins : liste de logins Twitch dans `api/data/config.json` (`admins`) **ou** clé admin 40 caractères (`api/data/admin.key`), passée via `?admin=` puis gardée en `localStorage` (`wf-admin-key`).
- Actions compte : `logout`, `forget` (suppression RGPD, les builds deviennent orphelins).
- **Sauvegarde d'un build : anonyme** (token de modification par build, limite 15/h par IP hashée). Le compte Twitch sert aux commentaires et à rattacher un build (`owner_user_id`).
- Page `moderation` (commentaires signalés).

## 3. Builder de classe

| Élément | Fichier |
|---|---|
| Pages | `guerrier.html`, `paladin.html`, `chasseur.html`, `voleur.html`, `pretre.html`, `chaman.html`, `mage.html`, `demoniste.html`, `druide.html` (identiques sauf `data-class`, titres, meta) |
| Logique | `js/calculator.js?v=8` : **lisible depuis la Phase 1** (plus minifié), générique, lit `body[data-class]` |
| Codec et règles de parcours | `js/build-path.js?v=1` (pur, testable sous Node) |
| Interface du planificateur | `js/level-planner.js?v=4` (curseur, modes, ordre des points, toasts) |
| Sauvegarde / bannière build / commentaires | `js/builds.js?v=11`, `js/comments.js`, `api/builds.php`, `api/comments.php` |
| Données | `js/talents-data.js` (`window.TALENTS_FR`, 433 Ko) |
| Spécification | `packages/schema/BUILD_CODEC.md` |
| Tests | `tools/tests/build-path.test.mjs` (`node --test "tools/tests/*.test.mjs"`) |

Comportement (depuis la Phase 1, sur les 9 classes) :

- Clic / Entrée / `+` = +1 rang. Clic droit / Retour arrière / Suppr / `-` / Maj+Entrée = -1 rang. Mobile : tap = +1, appui long 500 ms = -1.
- Panneau « Planifier sans dépenser » sous la barre d'outils :
  - curseur « Voir mon build au niveau X » de 10 à 60, défaut 60, 1er point au niveau 10, 51 points au 60, utilisable au clavier (flèches, Début, Fin) ;
  - points disponibles / dépensés / restants **au niveau choisi** ;
  - 2 modes : « Build niveau 60 » (défaut, ordre calculé tout seul) et « Choisir l'ordre moi-même » (chaque clic = prochain point), avec une phrase d'aide sous les boutons ;
  - bouton « Remettre l'ordre automatique », affiché seulement quand l'ordre n'est plus l'ordre auto ;
  - refus (plafond, prérequis, palier, retrait impossible) affichés en **toast** fixe (bas gauche sur ordinateur, haut sur mobile), 2 s, sans pousser le contenu ; avis au chargement (« Parcours recalculé », build impossible) en toast de 4 s.
- Aucune case Talentueux sur le builder de classe (retirée après la Phase 1). Le chiffre Talentueux de `?path=` est lu mais ignoré, le lien est réécrit avec `10`. À relier en Phase 3 seulement, avec le libellé exact d'un nœud de `heritage-calculator.js` et un lien vers `/arbre-heritage`.
- Au niveau simulé, le badge d'un talent montre le rang **à ce niveau**. Les points prévus plus tard sont en pointillés, icône atténuée, avec un petit badge `→rang final`. Le compteur d'arbre affiche `rang au niveau / rang final`.
- La barre du haut (Points dépensés / Restants / Niveau requis) décrit toujours le build **final**.
- Ordre des points : rien en « Build niveau 60 ». En « Choisir l'ordre moi-même », un lien discret « Voir l'ordre des points » (replié par défaut) ouvre un **panneau flottant** en position fixe (bas droite sur ordinateur, feuille du bas sur mobile), hauteur fixe, défilement interne, fermeture par × ou Échap. Liste regroupée par arbre, niveau actuel surligné, clic = le curseur saute à ce niveau. Ajouter un point ne l'ouvre jamais.
- Le lien et le bouton « Remettre l'ordre automatique » gardent toujours leur place (masqués par `visibility`) : le panneau a la même hauteur dans tous les états, **les 3 arbres ne bougent jamais** (vérifié : 15 points d'affilée, liste ouverte/fermée, changement de mode, 9 classes, 1400 / 1101 / 390 px).
- En-tête des arbres : une seule ligne, même hauteur sur les 3 cartes. « Réinitialiser » est une icône seule (title « Réinitialiser cet arbre »).
- Règles à l'ajout inchangées. Au retrait (Mode Fin), en plus des règles historiques, un retrait qui rendrait le build impossible à monter point par point est refusé avec un message.
- Boutons historiques inchangés : Version Classic, Réinitialiser (tout), Réinitialiser (par arbre), Sauvegarder, Copier le lien, « Builds publics ».
- L'URL est réécrite 400 ms après chaque rendu : `?build=` (rangs finaux) + `?path=` (ordre, seulement s'il est valide). Les autres paramètres (`b`, etc.) sont conservés.
- « Sauvegarder » lit les rangs finaux via `window.WF.calc.getBuildString()`, plus via les badges du DOM.
- Partage (Phase 2) : un seul bouton « Partager » dans la barre (même place que l'ancien « Copier le lien », barre sur une ligne dès 1024 px) ouvre un menu avec « Copier le lien » (lien page `build` + `path`), « Copier le code addon » (code `AF1-…`, format `packages/schema/BUILD_CODEC.md` §9) et « Coller un code » (fenêtre qui rouvre le même build et le même ordre, sur la bonne classe). Menu au clavier (flèches, Échap), confirmation de copie par toast. Code : `js/share-code.js?v=2`, menu : `js/share-ui.js?v=1`. Un code `AF1H-` collé sur une page classe ouvre `/arbre-heritage`.
- « Sauvegarder » envoie aussi `path` ; `/b/XXXXXXXX` et la liste `/builds` rouvrent l'ordre enregistré. Changer seulement l'ordre d'un build sauvegardé affiche « Modifié ».

## 4. Encodage `?build=`

Écriture (`calculator.js`, fonction `k`) :
```
build = trees.map(tree => tree.talents.map(t => ranks[t.id] || 0).join("")).join("-")
```
Lecture : `build.split("-")`, bloc `i` = arbre `i` de `TALENTS_FR[classe].trees`, caractère `j` = talent `j` du tableau `talents`.

- Ordre des arbres = ordre du tableau `trees` (= ordre UI).
- Ordre des talents = ordre du tableau `talents`, **vérifié trié rangée puis colonne pour les 469 talents** (lecture gauche à droite, haut en bas).
- 1 caractère = 1 rang (0 à 5, aucun talent n'a plus de 5 rangs).
- Tolérances du décodeur : caractère non numérique ignoré (0), rang > max ramené au max, bloc manquant = 0, caractères en trop ignorés.
- **Aucune validation au chargement** : un lien fabriqué peut afficher plus de 51 points ou un talent sans prérequis. Le serveur, lui, exige `^[0-5]{1,30}-[0-5]{1,30}-[0-5]{1,30}$` et 1 à 51 points à la sauvegarde (pas de contrôle prérequis / paliers).
- Le format est **positionnel** : si un talent est ajouté ou retiré au milieu d'un arbre dans `talents-data.js`, tous les anciens liens de la classe sont décalés.

### Exemple réel Guerrier

`/guerrier?build=35325213132100000-555500000000000000-000000000000000000`

Armes (17 talents, bloc `35325213132100000`, 31 pts) :

| # | Car. | Pos. | Talent | Rang |
|---|---|---|---|---|
| 0 | 3 | r0 c0 | Frappe héroïque améliorée | 3/3 |
| 1 | 5 | r0 c1 | Déviation | 5/5 |
| 2 | 3 | r0 c2 | Pourfendre amélioré | 3/3 |
| 3 | 2 | r1 c0 | Charge améliorée | 2/2 |
| 4 | 5 | r1 c1 | Maîtrise tactique améliorée | 5/5 |
| 5 | 2 | r1 c3 | Fulgurance améliorée | 2/2 |
| 6 | 1 | r2 c1 | Maîtrise de la Rage (prérequis Maîtrise tactique 5) | 1/1 |
| 7 | 3 | r2 c2 | Blessures profondes (prérequis Pourfendre 3) | 3/3 |
| 8 | 1 | r3 c0 | Frappe transperçante | 1/1 |
| 9 | 3 | r3 c1 | Spécialisation Arme 2M | 3/3 |
| 10 | 2 | r3 c2 | Empaler | 2/2 |
| 11 | 1 | r4 c0 | Exaltation sanguinaire | 1/5 |
| 12 à 16 | 0 | r4 à r6 | Attaques circulaires, Maître d'armes, Heurtoir amélioré, Brise-genou amélioré, Frappe mortelle | 0 |

Fureur (18 talents, bloc `555500000000000000`, 20 pts) : Voix tonitruante 5/5, Cruauté 5/5, Volonté de fer 5/5, Colère déchaînée 5/5, le reste à 0.

Protection (18 talents, bloc de 18 zéros) : 0 pt.

Total 51, niveau requis affiché 60. Le build respecte paliers et prérequis.

## 5. Données talents

- `js/talents-data.js` : 9 classes, 27 arbres, **469 talents** (111 `new`, 284 `changed`, 74 `unchanged`).
- Champs talent : `id` (numérique, unique), `name`, `icon`, `row`, `col`, `maxRank`, `requires: [{id, qty}]`, `req` (points requis = `5 × row`), `ranks[].description` (+ `spellId`), `status`, `sources`, `classic`, parfois `cost`, `aura`.
- Champs classe : `id`, `slug` (FR), `slug_en`, `name`, `color`, `icon`, `trees[]` (`id`, `name`, `slug`, `order`, `icon`, `talents`).
- Build client cité dans les sources : **1.60.1.69893**. Le brief cite `1.60.1.69977` : écart TBD.
- Nombre de talents par arbre (données) :

| Classe | Arbre 1 | Arbre 2 | Arbre 3 | Total |
|---|---|---|---|---|
| guerrier | Armes 17 | Fureur 18 | Protection 18 | 53 |
| paladin | Sacré 18 | Protection 16 | Vindicte 18 | 52 |
| chasseur | Dressage 16 | Précision 17 | Survie 18 | 51 |
| voleur | Assassinat 17 | Combat 17 | Finesse 19 | 53 |
| pretre | Discipline 18 | Sacré 17 | Ombre 18 | 53 |
| chaman | Éléments 16 | Amélioration 18 | Restauration 16 | 50 |
| mage | Arcanes 18 | Feu 17 | Givre 19 | 54 |
| demoniste | Affliction 17 | Démonologie 19 | Destruction 16 | 52 |
| druide | Équilibre 16 | Farouche 19 | Restauration 16 | 51 |

- Incohérences meta description vs données : `guerrier.html` annonce Protection (19), `chasseur.html` Précision (16), `druide.html` Équilibre (17). Si ces chiffres reflètent une ancienne version des données, des builds sauvegardés à l'époque sont peut-être décalés (voir §4). À vérifier dans la base : TBD.
- Les pages `competences-*.html` embarquent leurs propres données de sorts en JSON inline (`<script type="application/json">`), séparées des talents.

## 6. Builder d'Héritage

- URL : **https://azerothforever.info/arbre-heritage** (fichier `arbre-heritage.html`). Redirections 301 existantes : `/arbre-historique.html`, `/systeme-heritage` et `/systeme-heritage.html` vers `/arbre-heritage`.
- Paramètre : `?hbuild=` inchangé (3 blocs séparés par `-`, un chiffre par nœud, ordre = ordre du tableau `nodes` hors placeholders, **pas** trié par rangée). Exemple de la home : `/arbre-heritage?hbuild=5200000-0200000-0200000`.
- Fichiers (Phase 3) : `js/heritage-calculator.js?v=3` (**lisible**, plus minifié), `js/heritage-data.js?v=1` (nœuds + presets, `window.HERITAGE_FR`), `js/heritage-path.js?v=1` (ordre auto, code `AF1H-`), `js/share-ui.js?v=1` (menu « Partager » commun aux classes et à l'Héritage).
- 16 points, 3 arbres : Métiers (7 nœuds), Aventure (7), Ingéniosité (7). Paliers par nœud : `tier` 0 / 5 / 10.
- Panneau sous la barre d'outils :
  - curseur « Voir mon héritage à N points dépensés » de 0 à 16, défaut 16 ; les nœuds achetés plus tard sont en overlay (pointillés, `→rang final`), comme les talents de classe ; la barre du haut et `?hbuild=` restent l'héritage final ;
  - 3 presets (16 points chacun, nœuds réels, paliers respectés) : « Premier perso leveling » (`0000000-2515012-0000000`), « Métiers » (`5201530-0000000-0000000`), « Qualité de vie niveau 60 » (`0000000-0000000-0322153`) ;
  - texte « Les points sont gagnés sur le compte et dépensés par personnage. » ;
  - si Talentueux a au moins 1 point : « Tes talents de classe commencent au niveau 9. » (place réservée, rien ne bouge).
- « Partager » : Copier le lien (`?hbuild=`), Copier le code addon (`AF1H-…`), Coller un code (un `AF1-` part vers la bonne classe). `?code=AF1H-…` est accepté à l'ouverture.
- Talentueux : nœud `talentueux`, arbre Aventure, **5 rangs**, palier 5. Seul texte connu : « dès le niveau 9 au lieu du niveau 10, sans jamais dépasser 51 points ». Effet des rangs 2 à 5 : TBD. Aucune case Talentueux sur les pages classe.

## 7. Page donjons

- `/donjons` (`donjons.html` + `js/dungeons.js?v=4`). Contenu en HTML statique : **41 cartes**, pas 28.
  - 28 donjons (19 Classic + 9 nouveaux), niveaux seulement : Gouffre de Ragefeu, Salle des Thanes (Hall of Thanes), Cavernes des Lamentations, Ruines de Lordaeron, Les Mortemines, Donjon d'Ombrecroc, La Prison, Profondeurs de Brassenoire, Site de fouilles (Excavation Site), Monastère écarlate, Cité de Dalaran, Gnomeregan, Kraal de Tranchebauge, La Cité engloutie (The Drowned City), Souilles de Tranchebauge, Bastion de Krol'Dok (Krol'Dok Stronghold), Uldaman, Zul'Farrak, Maraudon, Prison d'Alcaz (Alcaz Prison), Le Temple d'Atal'Hakkar, Profondeurs de Blackrock, Pic Rochenoire, Fort Mâchoire-Noire (Blackmaw Hold), Hache-Tripes, Scholomance, Stratholme, Terrasse des Façonneurs (The Shapers Terrace). Noms FR des nouveaux = traductions non officielles.
  - 9 raids : Fosses de Barrow (10, nouveau), Sommet du Hyjal (20, nouveau), Repaire d'Onyxia (40) ouverture 9 déc., puis MC, BWL, ZG, AQ20, AQ40, Naxxramas « Pas encore ouvert ».
  - 4 champs de bataille : Îles Pointe-Sombre (nouveau, 15v15), Goulet des Chanteguerres, Bassin d'Arathi, Vallée d'Alterac.
- Chaque carte : `data-id` (slug court : `rfc`, `hot`, `wc`…), `data-slug` (slug de la fiche), `data-kind` (`dungeon`/`raid`/`bg`), `data-origin` (`classic`/`new`).
- Filtres existants : Tous / Classic / Nouveau / Raid / BG, persistés dans `?filtre=`.
- Le titre de chaque carte est un bouton (`.ig-link`, zone de clic étendue à toute la carte) qui déplie sa fiche.

### Fiches d'instances (Phase 4)

- **Une seule page publique : `/donjons`.** Un clic sur une carte déplie sa fiche juste sous la rangée de cartes (accordéon pleine largeur), sans changement de page. Une seule fiche ouverte à la fois : un clic sur une autre carte ouvre celle-ci à la place ; reclic sur la carte, clic dans le vide (hors de la carte ouverte et de sa fiche, filtres exclus) ou Échap pour refermer. Pas de bouton « Fermer ». En changeant de carte, la carte cliquée ne bouge pas à l'écran.
- `?ouvrir=<slug>` ouvre une fiche au chargement (alias anglais acceptés, ex. `?ouvrir=ragefire-chasm`) et suit la fiche ouverte (`replaceState`, avec `?filtre=`). Si le filtre cache la carte demandée, on repasse sur « Tous ». Changer de filtre referme la fiche si sa carte disparaît.
- Contenu de la fiche (rendu en JS par `renderDetail()` de `js/dungeons.js`), identique pour les 41 cartes : nom FR (et EN), Type, Origine, Niveaux, Joueurs, Group Finder, Entrée, Lockout (toujours affichés, « — » si pas de source), présentation si sourcée, Bosses et Quêtes (« À compléter » si vide), puis butin (« Loot non publié. »), écarts avec Classic, sources et dates, « Sujet à changement pendant la bêta ».
- Jamais de message d'indisponibilité : tant que `_fiches.json` n'est pas chargé (ou s'il manque), le bloc est construit à partir de la carte elle-même (nom, EN, type, origine, niveaux, joueurs, ouverture), puis enrichi dès l'arrivée du JSON.
- Données : `data/instances/<slug>.json` (source, une fiche par instance, schéma `packages/schema/INSTANCES.md`). `node tools/instances/build.mjs` produit `data/instances/_fiches.json` (les 41 fiches en un fichier, ~5 Ko compressé, lu une fois par `/donjons`), `data/instances/_index.json` et le numéro de version `data-instances-src` de `donjons.html`.
- Les 41 pages `/donjons-<slug>` de la première version sont supprimées. `.htaccess` redirige en 301 toute adresse `/donjons-<slug>` vers `/donjons?ouvrir=<slug>`. Rien dans le sitemap à part `/donjons`.
- Contenu réel : seulement ce que le site contenait déjà (`/donjons`, onglet Donjons et raids de `/a-quoi-attendre`, `/feuille-de-route`). Aucun boss, aucune quête. Ragefeu : TBD assumé.
- `data/instances/_index.json` : 12 fiches partielles (9 nouveaux donjons, Fosses de Barrow, Sommet du Hyjal, Îles Pointe-Sombre), 29 vides.
- Noms qui diffèrent entre `/donjons` et `/a-quoi-attendre` (gardés en `aliases`) : Bastion de Krol'Dok / Krol'dor, Site de fouilles / Le site de fouilles titan, Prison d'Alcaz / Une prison Defias, Fort Mâchoire-Noire / Bastion de Gueule-Noire, Terrasse des Façonneurs / Terrasse du Sculpteur, Fosses de Barrow / Fosses ancestrales, Cité de Dalaran / Dalaran.

## 8. Annuaire de guildes (Phase 5)

- URL : `/guildes` (`guildes.html` + `js/guilds.js?v=1`). API : `api/guilds.php`. Schéma et règles : `packages/schema/GUILDS.md`. Table SQLite `guilds` (+ `guild_reports`), créées par `wf_db()` dans `api/_lib.php` comme les autres tables du site.
- Une seule page, pas d'annuaire séparé par guilde : chaque carte est un `<details>` natif qui déplie sa fiche (plusieurs peuvent être ouvertes en même temps, contrairement à l'accordéon exclusif de `/donjons`). `?voir=<id>` ouvre une fiche au chargement.
- Champs publics : nom, faction, région (EU/US), langue (liste fermée FR/EN/DE/ES/Autre — choix produit pour éviter un champ texte libre à filtrer), effectif en fourchette, officiers (texte libre filtré), recrutement (ouvert/preview/fermé), classes/rôles recherchés (9 classes + tank/heal/dps), tags d'ambiance fermés (casual, semi-heavy, hardcore, rp, pvp, pve, first, soirs), horaires + fuseau (texte libre filtré), progression (slugs d'instances cochés, validés contre `data/instances/_index.json`), description (800 car. max, texte brut, filtrée), BattleTag de contact (`Nom#1234`), date de mise à jour.
- Compte Twitch requis (même login que les commentaires) pour créer/éditer/signaler. 1 fiche par compte : `owner_user_id` unique en base, `action: save` fait un upsert (garde le même `id` public). `action: delete` supprime sa propre fiche.
- Sécurité, filtrée **côté client et serveur** (même liste, testée à l'identique — `tools/tests/guilds.test.mjs` pour le client, vérifié manuellement contre l'API pour le serveur) : `discord.gg`/`discord.com`/`discordapp.com`/`dsc.gg` (bruts et obfusqués, ex. `discord (dot) gg`), tout lien `http(s)://` hors `azerothforever.info`, `www.…`, domaines à risque (`.gg`, `.xyz`…), email, téléphone. Message de refus unique : « Contact uniquement par BattleTag ». Le format BattleTag (`^[A-Za-z][A-Za-z0-9]{2,11}#[0-9]{4,6}$`) est une hypothèse assumée (TBD si Blizzard publie une règle différente pour Forever).
- Modération : bouton Signaler (seuil `report_threshold` de `api/data/config.json`, comme les commentaires) → statut `reported`, masqué de la liste publique. Section dédiée sur `/moderation` (`[data-guild-mod-root]`, rendue par `js/guilds.js`) : rétablir / masquer / supprimer, et bannir l'auteur (réutilise l'action `ban` de `api/comments.php`, qui supprime alors sa fiche de guilde — cascade ajoutée à `ban()`). Suppression de compte (RGPD, `auth.php` → `forget`) supprime aussi la fiche via la contrainte `ON DELETE CASCADE` de `owner_user_id`.
- Pas d'annuaire de guildes dans l'addon V1 (hors scope Phase 5, prévu explicitement hors périmètre par le brief).

## 9. Routes

Toutes servies sans `.html` (`/x.html` redirige en 301 vers `/x`).

- Accueil : `/`
- Classes : `/guerrier`, `/paladin`, `/chasseur`, `/voleur`, `/pretre`, `/chaman`, `/mage`, `/demoniste`, `/druide`
- Compétences : `/competences`, `/competences-guerrier`, `/competences-paladin`, `/competences-chasseur`, `/competences-voleur`, `/competences-pretre`, `/competences-chaman`, `/competences-mage`, `/competences-demoniste`, `/competences-druide`
- Héritage : `/arbre-heritage`
- Builds : `/builds` (params `classe`, `tri`, `vue`), publics seulement, filtre classe, tri likes / vues / date
- Lien court de build sauvegardé : **`/b/XXXXXXXX`** (8 caractères) vers `api/go.php`, qui redirige en 302 vers `/{classe}?build=…&b=XXXXXXXX`. Existe déjà, uniquement pour les builds sauvegardés.
- Fiches d'instances : dépliées sur `/donjons` (`?ouvrir=<slug>`) ; les anciennes adresses `/donjons-<slug>` redirigent en 301
- Annuaire de guildes : `/guildes` (`?voir=<id>` ouvre une fiche)
- Autres : `/races`, `/metiers`, `/donjons`, `/a-quoi-attendre`, `/feuille-de-route`, `/moderation` (hors sitemap)
- API : `/api/builds.php`, `/api/comments.php`, `/api/auth.php`, `/api/twitch-callback.php`, `/api/go.php`, `/api/guilds.php`

## 10. Points d'attention pour la suite

1. ~~`currentBuild()` lit les badges du DOM~~ : corrigé en Phase 1 (`WF.calc.getBuildString()`).
2. Le routeur (`main.js`) doit connaître tout nouveau script. Chaîne actuelle pour une page classe : `build-path.js?v=1`, `share-code.js?v=2`, `share-ui.js?v=1`, `level-planner.js?v=4`, `calculator.js?v=8`, `talents-data.js`, `builds.js?v=11`.
3. ~~`?build=000…` ajouté aux pages `competences-*` après navigation interne~~ : corrigé en Phase 1 (`initCalculator` ne fait rien sans `[data-trees]`).
4. `docs/` et `packages/` sont bloqués en 403 par `.htaccess` depuis la Phase 1 (`tools/` l'était déjà).
5. `main.js`, `competences.js` et `talents-data.js` restent minifiés, sans source lisible (`heritage-calculator.js` est lisible depuis la Phase 3).
6. `?build=` et `?path=` sont positionnels : toute insertion de talent dans `talents-data.js` décale les anciens liens.
7. ~~Les builds sauvegardés ne stockent pas `path`~~ : corrigé en Phase 2 (colonne `builds.path`, anciens builds = ordre automatique).
8. Build client des données : 1.60.1.69893. Le brief cite 1.60.1.69977 : écart gardé en note, on ne mélange pas.

## Décisions produit déjà prises par l'humain
- FR first
- Partage + QR comme concurrent Talents Forever
- Guildes sans Discord
- Addon simple, pas un second Wowhead
