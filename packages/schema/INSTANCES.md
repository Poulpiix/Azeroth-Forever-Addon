# Fiches d'instances (v1, Phase 4)

Une fiche par instance : `data/instances/<slug>.json`. Elles s'affichent sur `/donjons` seulement : un clic sur une carte déplie la fiche sous la carte (`js/dungeons.js`, fonction `renderDetail()`). Il n'y a pas de page par instance.

Après toute modification d'une fiche, relancer :

```
node tools/instances/build.mjs          # écrit _fiches.json, _index.json et la version dans donjons.html
node tools/instances/build.mjs --check  # vérifie qu'ils sont à jour (utilisé par les tests)
```

Fichiers produits : `data/instances/_fiches.json` (toutes les fiches, lu par `/donjons`), `data/instances/_index.json` (statut par slug), attribut `data-instances-src` de `donjons.html` (empreinte pour le cache). Chaque carte de `donjons.html` porte `data-id` et `data-slug` de sa fiche ; le script refuse un décalage.

Une ligne sans source s'affiche « — » (TBD) mais reste visible. Si `_fiches.json` manque, `/donjons` affiche quand même un bloc minimal lu sur la carte.

## Règles de contenu

1. Sources autorisées, dans l'ordre : les pages et données du site ; les fichiers fournis dans `data/` ; pour une instance Classic, une donnée Classic avec `confidence: "classic"` (affichée « Donnée Classic, à revérifier en Forever »).
2. Rien d'inventé. Une information sans source reste `null` (affichée « — ») ; un boss ou une quête sans source n'est pas ajouté (`bosses: []`, `quests: []`, affiché « À compléter »).
3. Pas de texte ni de liste copiés de wowforevertalents.com ou de Wowhead.
4. Pas de table de butin inventée : `loot: null` affiche « Loot non publié. ».

## Champs

| Champ | Type | Notes |
|---|---|---|
| `schema` | `1` | version du format |
| `id` | texte | identifiant court de la carte `/donjons` (`rfc`, `hot`…) |
| `slug` | texte | slug français stable, nom du fichier, valeur de `?ouvrir=` |
| `slugs` | texte[] | `slugs[0]` = `slug`, puis alias (anglais) acceptés par `?ouvrir=` |
| `order` | entier | ordre d'affichage (celui de `/donjons`) |
| `names.fr` / `names.en` | texte / texte ou null | `en: null` = TBD |
| `names.frOfficial` | booléen | `false` = traduction non officielle |
| `aliases` | texte[] | autres noms français utilisés sur le site |
| `type` | `dungeon` \| `raid` \| `bg` | |
| `origin` | `classic` \| `new` | |
| `note` | texte ou null | précision de la carte (« Toutes les ailes. »…) |
| `levels` | `{min,max}` ou null | tranche annoncée ; obligatoire pour un donjon |
| `levelFinder`, `levelEntry` | entier ou null | niveau Group Finder, niveau d'entrée |
| `players` | entier, `"15v15"` ou null | |
| `lockout` | texte ou null | |
| `mapId` | entier ou null | |
| `availability` | `{text,date}` ou null | « Ouverture 9 déc. », « Pas encore ouvert »… |
| `summary` + `summarySource` | texte ou null + id de source | présentation |
| `entry` | `{where, how, source}` | emplacement, chemin et prérequis, source |
| `bosses` | tableau | voir ci-dessous, dans l'ordre de progression |
| `quests` | tableau | voir ci-dessous |
| `loot` | texte ou null | null = « Loot non publié. » |
| `classicDiff` | texte ou null | Classic seulement |
| `image` | nom de fichier ou null | dans `img/instances-webp/` (non affiché dans la fiche : la carte a déjà l'image) |
| `clientBuild` | texte ou null | build du client où les données ont été relevées |
| `confidence` | `confirme` \| `annonce` \| `classic` \| `tbd` | |
| `sources` | `{id,label,ref,date}`[] | au moins une ; `ref` = chemin du site ou URL |
| `updated` | `AAAA-MM-JJ` | date de la fiche |

Boss : `{ names:{fr,en}, oneLiner, foreverNote, confidence, source }` (`source` = un `id` de `sources`).

Quête : `{ names:{fr,en}, level, minLevel, faction: alliance|horde|both, giver, turnIn, objectives, rewards:{xp,money,reputation,items[]}, confidence, source }`. Tout champ absent ou null s'affiche TBD.

## Statut (`_index.json`)

Calculé, jamais saisi :

- **complet** : boss, quêtes et `entry.how` renseignés, et `classicDiff` pour une instance Classic (champ de bataille : `summary` + `entry.how`) ;
- **partiel** : au moins une information de contenu sourcée (présentation, accès, boss, quêtes, comparatif) ;
- **vide** : nom, niveaux et type seulement.

`?ouvrir=<slug>` (slug français ou alias de `slugs[]`) ouvre la fiche au chargement de `/donjons`. Les anciennes adresses `/donjons-<slug>` redirigent vers `/donjons?ouvrir=<slug>` (`.htaccess`).
