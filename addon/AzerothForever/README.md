# Azeroth Forever (addon)

Addon pour **World of Warcraft Forever** (client 1.60.x). Builder de talents de
classe, grimoire des sorts, builder d'Héritage et partage aller-retour avec
[azerothforever.info](https://azerothforever.info/), en jeu, sans dépenser un
seul point tant que vous n'avez pas cliqué sur Appliquer.

Auteur : Poulpix — voir `LICENSE.md`.

## Installation

Copiez le dossier `AzerothForever` (celui qui contient `AzerothForever.toc`)
dans `Interface/AddOns/` de votre client WoW Forever, puis `/reload` ou
relancez le jeu. Voir la section « Copier l'addon » plus bas pour le détail.

## Utilisation

`/af` ouvre ou ferme la fenêtre.

### Fenêtre

- **Gauche** : les 3 arbres de talents de votre classe. Clic gauche = planifier
  un point, clic droit = le retirer. Rien n'est appris en jeu tant que vous ne
  cliquez pas sur un bouton Appliquer.
- **Droite**, onglets :
  - **Accueil** : résumé des points planifiés par arbre, points non dépensés,
    prochain point à apprendre.
  - **Plan** : bascule entre **Build au niveau 60** (vous fixez les rangs
    finaux, l'ordre est recalculé automatiquement) et **Build niveau par
    niveau** (chaque clic ajoute le point à la fin de votre parcours, comme
    sur le site) ; curseur de niveau 10-60 et liste des prochains points.
  - **Héritage** : les 16 points d'Héritage (Métiers / Aventure /
    Ingéniosité), avec 3 préréglages.
  - **Sorts** : grimoire en lecture seule de la classe (descriptions reprises
    telles quelles depuis les données, sans invention).
  - **Builds** : coller un code `AF1-` (classe) ou `AF1H-` (héritage), copier
    le code du plan actuel, lien vers le site, QR code du build.
- **Bas** : frise des niveaux 10 à 60, dans le même ordre que le site.
- **Barre d'outils** : Appliquer suivant, Appliquer tout (confirmation),
  Reset (recharge le plan depuis ce qui est réellement appris en jeu), Undo,
  Import, Partager, QR, Site.

### Partage AF1- / AF1H-

Les codes utilisent exactement le même format et la même somme de contrôle
que le site (voir `docs/BUILD_CODEC.md`) : un build fait dans l'addon se
colle sur le site, et inversement. Si le catalogue de talents a changé entre
le site et votre version de l'addon, l'import est refusé avec un message
plutôt que de charger un plan faux.

Le QR code encode toujours un lien **HTTPS** vers le site
(`https://azerothforever.info/{classe}?build=…&path=…` pour un build de
classe, `https://azerothforever.info/arbre-heritage?code=AF1H-…` pour
l'Héritage) : il n'y a pas de QR pointant vers autre chose que le site.

### Ce que l'addon ne fait pas (V1)

- Pas d'annuaire de guildes, pas d'appel HTTP vers une API en jeu.
- Pas d'auto-apply à la montée de niveau (à activer explicitement — voir le
  code, désactivé par défaut).
- Pas de bot : Appliquer suivant / Appliquer tout ne s'exécutent que sur un
  clic du joueur.
- Pas de tooltip inventé : les descriptions viennent telles quelles de
  `data/talents-data.js` / `data/heritage-data.js`.

## Fichiers

```
AzerothForever.toc   Métadonnées de l'addon (voir TBD ci-dessous)
LICENSE.md           Licence (MIT courte), auteur Poulpix
README.md            Ce fichier
Core.lua             Init, utilitaires bas niveau (bit/CRC), SavedVariables, /af
Talents.lua          Portage de build-path.js (catalogue, ?build=, ?path=, règles,
                      ordre automatique) + état du plan + application en jeu (LearnTalent)
Share.lua            Portage de share-code.js (CRC-8, code AF1-)
Heritage.lua         Portage de heritage-path.js (code AF1H-) + état du plan d'Héritage
Spellbook.lua        Grimoire en lecture seule
QR.lua               Générateur de QR code pur Lua (mode Octet, ECC L)
UI.lua               Construction et logique de la fenêtre
UI.xml               Cadre XML minimal de la fenêtre (le contenu est fait par UI.lua)
Data/Constants.lua   Constantes du codec (générées)
Data/Talents.lua     Catalogue des talents de classe (généré)
Data/Heritage.lua    Catalogue de l'arbre d'Héritage (généré)
```

Les fichiers sous `Data/` sont générés par `tools/export-lua.mjs` (à la racine
du dépôt, hors du dossier addon) depuis `data/talents-data.js` et
`data/heritage-data.js`. Relancez-le avant de zipper l'addon si ces fichiers
JS changent :

```
node tools/export-lua.mjs
```

## TBD

Voir le TOC : `## Interface: 60100` est un **calcul**, pas une valeur trouvée
dans les fichiers fournis (`docs/BRIEF.md`, `docs/BUILD_CODEC.md`,
`data/*.js` ne donnent aucun numéro `Interface:` officiel pour le client
Forever 1.60.1.69893). Si le jeu affiche l'addon comme « non à jour » et le
bloque, corrigez cette valeur avec le vrai numéro d'interface de votre client
(ou cochez « Charger les extensions non à jour » dans le menu AddOns).
