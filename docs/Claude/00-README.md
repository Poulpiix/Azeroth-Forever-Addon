# Instructions pour Claude — Azeroth Forever

Tu travailles sur https://azerothforever.info/ (outils FR pour World of Warcraft: Forever).

## Ordre de lecture obligatoire
1. Ce fichier
2. `01-brief-produit.md`
3. `02-etat-actuel.md`
4. `03-codec-builds.md`
5. `04-phases.md`

## Règles
- Ne code rien avant la Phase 0 (audit).
- Une phase à la fois. Ne commence jamais guildes + addon + donjons en même temps.
- Langue UI : français.
- Noms Classic : officiels FR. Noms Forever non traduits : `Nom FR provisoire (English Name)` + badge « traduction non officielle ».
- N’invente pas tooltips, bosses, quêtes, loot, IDs. Si inconnu : `TBD` + source + date.
- Ne casse pas les liens existants `?build=`.
- Pas de lien Discord nulle part dans l’annuaire de guildes. Contact = BattleTag uniquement.
- L’addon V1 n’a pas d’HTTP live vers le site. Data snapshot embarquée.
- Pas de refonte graphique. On étend l’existant.

## Mission par défaut si l’humain ne précise pas
Phase en cours indiquée dans `04-phases.md`. Sinon : Phase 0.

## Format de réponse
- Ce qui a été fait
- Fichiers touchés
- Données encore TBD
- Risques