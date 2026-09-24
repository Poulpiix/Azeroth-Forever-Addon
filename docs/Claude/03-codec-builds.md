# Codec des builds

Spec à finaliser pendant / juste après la Phase 0, puis à implémenter en Phase 1–2.
Ne change pas le format `?build=` actuel.

## Compatibilité obligatoire

Les vieux liens doivent ouvrir le même arbre.

Exemple vivant : /guerrier?build=35325213132100000-555500000000000000-000000000000000000

Interprétation attendue (à vérifier dans le code en Phase 0) :

- 3 arbres dans l’ordre de l’UI (Guerrier : Armes, Fureur, Protection)
- chaque caractère = rang du talent dans l’ordre de lecture de l’arbre
- `0` = aucun point

## Nouveau paramètre `path`

`path` représente `order` : la liste ordonnée des achats, un rang à la fois.

Exigences :

- déterministe
- court
- sûr dans une URL
- versionné
- checksum pour l’addon (détecter un copier-coller cassé)

## Proposition de code addon

AF1 <version> <kind> <classId> <flags> <finalRanks> <order> <crc8>

- kind : `C` classe, `H` héritage, `X` combo
- flags : rangs Talentueux 0–7
- finalRanks : même info que `?build=`
- order : suite d’index de talents dans un catalogue stable par classe ; un index = +1 rang

Claude peut ajuster l’alphabet après l’audit, mais doit écrire le choix final dans `packages/schema/BUILD_CODEC.md`.

## Règles de validation d’un ordre

À chaque étape de `order` :

1. le talent existe
2. le rang actuel est < maxRank
3. les prérequis sont au rang max
4. les points déjà mis dans CET arbre débloquent la rangée (palier de 5)
5. total ≤ 51
6. si un niveau cible est imposé : total ≤ pointsDisponibles(niveau, talentedRanks)

## Génération d’ordre automatique (mode Fin)

Quand `path` est absent :

1. lire les rangs finaux de `build`
2. remplir rangée par rangée, arbre par arbre, gauche vers droite
3. insérer d’abord les talents prérequis
4. algorithme stable : le même `build` produit toujours le même `path`

## Cas de tests obligatoires

- vieux lien sans `path`
- `path` corrompu
- `path` en conflit avec `build` → `build` gagne + toast
- tentative de dépasser 51
- Talentueux décale le premier point
- prérequis manquant
- palier de 5 non atteint

## Partage à brancher en Phase 2

- Copier le lien long (`build` + `path`)
- Copier le lien court
- Copier le code `AF1-...`
- QR du lien court uniquement

