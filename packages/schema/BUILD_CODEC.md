# Codec des builds de classe (v1)

Référence du format utilisé par le site (Phase 1). Implémentation : `js/build-path.js`. Tests : `tools/tests/build-path.test.mjs` (`node --test "tools/tests/*.test.mjs"` depuis la racine du site).

Données : `js/talents-data.js`, build client **1.60.1.69893** (constante `DATA_BUILD`). Le brief cite 1.60.1.69977 : écart noté, non utilisé.

## 1. `?build=` (inchangé)

- Un bloc par arbre, séparés par `-`, dans l'ordre de `TALENTS_FR[classe].trees` (ordre de l'UI).
- Un caractère par talent, dans l'ordre du tableau `talents` (trié rangée puis colonne), valeur = rang final `0` à `5`.
- Décodage tolérant, identique à l'ancien : caractère non numérique ignoré, rang borné à `[0, maxRank]`, bloc manquant = 0, caractères en trop ignorés.
- `?build=` contient toujours les rangs **finaux**. C'est ce que « Sauvegarder » enregistre, quel que soit le niveau affiché par le curseur.

Exemple : `/guerrier?build=35325213132100000-555500000000000000-000000000000000000`

## 2. Catalogue stable par classe

Les talents d'une classe mis à plat, arbre par arbre, dans l'ordre de `?build=`. L'index d'un talent dans cette liste (0 à 53 aujourd'hui, 64 au maximum) est son code dans `?path=`.

Conséquence : comme `?build=`, `?path=` dépend de l'ordre des talents dans `talents-data.js`. Ajouter ou retirer un talent au milieu d'une classe décale les deux formats. Un changement de version de `?path=` sera nécessaire à ce moment-là.

## 3. `?path=` (nouveau)

```
path = <version> <talentueux> <1 caractère par point>
```

| Partie | Taille | Valeurs |
|---|---|---|
| version | 1 | `1` |
| talentueux | 1 | `0` à `7` (rangs de Talentueux, Héritage) |
| points | 0 à 51 | alphabet URL-safe, 1 caractère = +1 rang du talent d'index correspondant |

Alphabet (index 0 à 63) : `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_`

Exemple (ordre automatique de l'exemple Guerrier, sans Talentueux) :
`?path=10AAABBBBBCCCDDEEEEEFFGHHHIJJJKKLRRRRRSSSSSTTTTTUUUUU`

`?path=` n'est écrit que si l'ordre est valide. Pour un build invalide (lien fabriqué à plus de 51 points, par exemple), l'URL garde seulement `?build=`.

## 4. Niveaux et Talentueux

```
premierNiveau(t)          = 10 - min(t, 1)
pointsDisponibles(niv, t) = clamp(niv - premierNiveau(t) + 1, 0, 51)
niveauDuPoint(n, t)       = min(60, premierNiveau(t) - 1 + n)
```

- Sans Talentueux : 1 point au niveau 10, 51 au niveau 60. C'est la formule déjà affichée par le site (niveau requis = 9 + points, `wf_required_level` côté PHP).
- La formule du brief `clamp(niveau - (10 - t), 0, 51)` donne 0 point au niveau 10 et 50 au niveau 60. Elle a été recalée sur le site.
- Talentueux rang 1 : premier point au niveau 9, jamais plus de 51 points. **Rangs 2 à 5 : TBD.** Le code les stocke mais ne leur prête aucun effet (`TALENTED_KNOWN_MAX = 1`). Le builder de classe n'expose pas Talentueux pour l'instant : il ignore ce chiffre à la lecture et écrit toujours `0`.

## 5. Règles de validation d'un ordre

Chaque point de l'ordre est rejoué ; il est refusé si :

1. le talent n'existe pas dans le catalogue ;
2. le talent est déjà à son rang maximum ;
3. 51 points sont déjà dépensés ;
4. un prérequis (`requires[].id`) n'est pas au rang `qty` ;
5. l'arbre n'a pas encore `5 × row` points **à ce moment du parcours**.

Messages en français, par exemple : « Maîtrise de la Rage nécessite Maîtrise tactique améliorée au rang 5. »

## 6. Ordre automatique (Mode Fin, ou `?path=` absent)

1. Arbre par arbre dans l'ordre de l'UI : on termine un arbre avant de passer au suivant, sans jamais alterner.
2. Dans un arbre : rangée par rangée, de gauche à droite.
3. Un prérequis passe avant le talent qui en dépend, même dans la même rangée (cas réels : Paladin Horion sacré avant Précision divine, Prêtre Fouet mental avant Fouet mental amélioré).
4. Chaque talent est monté jusqu'à son rang final avant le suivant.

Exemple Guerrier : Armes du niveau 10 au 40, puis Fureur du 41 au 60. Le même `?build=` donne toujours le même `?path=`.

## 7. Chargement d'une URL

| Cas | Résultat |
|---|---|
| `build` seul (vieux lien) | Ordre automatique, pas de message. |
| `build` + `path` valide et cohérent | L'ordre du lien est gardé. |
| `path` corrompu (version, alphabet, longueur) | `build` gagne, ordre automatique, message « Parcours recalculé ». |
| `path` dont les rangs diffèrent de `build` | Idem. |
| `path` aux bons rangs mais ordre illégal | Idem. |
| `path` seul, valide | Les rangs viennent du parcours. |

## 8. Édition

- **Mode Fin** : le clic modifie les rangs finaux (mêmes règles qu'avant), l'ordre est recalculé automatiquement. Un retrait qui rendrait le build impossible à obtenir point par point est refusé avec un message.
- **Mode Parcours** : un clic ajoute le rang à la fin de l'ordre. Un clic droit ou un appui long retire le **dernier rang de ce talent** dans l'ordre, pas forcément le dernier point global. Le retrait est refusé s'il casse un prérequis ou un palier plus loin dans le parcours.
- **Recalculer un ordre propre** : remplace l'ordre par l'ordre automatique en gardant les rangs.

## 9. Code addon `AF1-` (Phase 2)

Implémentation : `js/share-code.js`. Tests : `tools/tests/share-code.test.mjs`.

```
AF1-C<classe><path>-<crc>
```

| Partie | Taille | Valeur |
|---|---|---|
| `AF1-` | 4 | préfixe, version 1 du code (insensible à la casse à la lecture) |
| `C` | 1 | type : `C` build de classe. Réservés : `AF1H-` héritage, `X` combo (plus tard) |
| classe | 1 | `ALPHABET[id de classe WoW]` : Guerrier 1 `B`, Paladin 2 `C`, Chasseur 3 `D`, Voleur 4 `E`, Prêtre 5 `F`, Chaman 7 `H`, Mage 8 `I`, Démoniste 9 `J`, Druide 11 `L` |
| path | 2 à 53 | exactement la valeur de `?path=` (section 3) |
| `-` | 1 | séparateur (le path peut lui-même contenir `-` : on coupe sur le **dernier** tiret) |
| crc | 2 | CRC-8 en hexadécimal majuscule, polynôme `0x07`, init `0x00`, sans réflexion (CRC-8/SMBUS), calculé sur le texte ASCII `C<classe><path>` |

- Les rangs finaux ne sont pas répétés dans le code : ils se déduisent de l'ordre (`ranksFromOrder`). Le code ne peut donc décrire qu'un build montable point par point ; pour un build invalide, « Copier le code addon » refuse avec un message.
- À la lecture : espaces et retours à la ligne ignorés, checksum vérifié (toute faute de frappe d'un caractère est détectée), classe connue, path lisible, ordre valide. Chaque refus a un message en français.
- CRC-8/SMBUS : valeur de contrôle `0xF4` pour `123456789`. Facile à réimplémenter en Lua 5.1 pour l'addon (Phase 6).
- Exemple, Guerrier 31/20/0 (`?build=35325213132100000-555500000000000000-000000000000000000`, ordre automatique) :
  `AF1-CB10AAABBBBBCCCDDEEEEEFFGHHHIJJJKKLRRRRRSSSSSTTTTTUUUUU-A7`

## 10. Lien court `/b/XXXXXXXX` et builds sauvegardés

- Colonne `builds.path` (texte, vide par défaut) ajoutée automatiquement au démarrage de l'API.
- « Sauvegarder » envoie `path` en plus de `build`. Le serveur ne garde `path` que s'il est bien formé et compte autant de points que `build` ; sinon il enregistre une valeur vide (la sauvegarde n'est jamais refusée pour ça).
- `/b/XXXXXXXX` redirige vers `/{classe}?build=…&path=…&b=XXXXXXXX`. Un build enregistré avant la Phase 2 (path vide) garde exactement l'ancienne redirection et s'ouvre avec l'ordre automatique.
- Les builds de la communauté (`/builds`) pointent aussi vers `build` + `path`.
- Pas de QR sur le site : il viendra avec l'addon (Phase 6).

## 11. Héritage : `?hbuild=` et code `AF1H-` (Phase 3)

Implémentation : `js/heritage-path.js` (règles, code) et `js/heritage-data.js` (nœuds, presets). Tests : `tools/tests/heritage-path.test.mjs`.

- `?hbuild=` est inchangé : 3 blocs séparés par `-` (Métiers, Aventure, Ingéniosité), 1 chiffre par nœud dans l'ordre du tableau `nodes` hors placeholders (7 nœuds par arbre, 21 en tout). Lecture tolérante comme avant.
- Pas de `path` pour l'Héritage : le curseur « points dépensés » (0 à 16) suit un ordre toujours calculé automatiquement. Arbre par arbre (ordre de l'UI) ; dans un arbre, nœud disponible de plus petit palier (`tier`), puis rangée, puis colonne, monté jusqu'à son rang final.
- Code :

```
AF1H-1<21 chiffres>-<crc>
```

| Partie | Valeur |
|---|---|
| `AF1H-` | préfixe (insensible à la casse à la lecture) |
| `1` | version du code d'Héritage (ordre des 21 nœuds) |
| 21 chiffres | rangs, même ordre que `?hbuild=` sans les tirets |
| crc | CRC-8/SMBUS (poly `0x07`, init `0x00`) du texte `1<21 chiffres>`, 2 chiffres hexa |

- À la lecture : checksum, version, 21 chiffres, rang ≤ rang max du nœud, 16 points au plus, paliers respectés point par point. Chaque refus a un message en français.
- Exemple réel (lien de la page d'accueil `?hbuild=5200000-0200000-0200000`) : `AF1H-1520000002000000200000-41`
- Routage : sur n'importe quelle page, « Coller un code » envoie un `AF1-` vers la bonne classe et un `AF1H-` vers `/arbre-heritage`, via `?code=` (le paramètre est retiré après lecture).
