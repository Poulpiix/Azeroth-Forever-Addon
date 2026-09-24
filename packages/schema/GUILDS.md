# Annuaire de guildes (v1, Phase 5)

Une fiche de guilde = une ligne de la table SQLite `guilds` (`api/data/builds.sqlite`, créée par `wf_db()` dans `api/_lib.php`, comme les autres tables du site). Pas de fichier JSON statique ici : contrairement aux instances, le contenu est fourni par les joueurs, modifiable, et doit passer par la modération.

Forever n'a pas de royaume (realm) obligatoire : une fiche se repère par région + langue, pas par royaume.

## Règles produit

- Compte requis (login Twitch existant, `api/auth.php`) pour créer, éditer ou signaler.
- **1 fiche active par compte** : `owner_user_id` est `UNIQUE` en base. Sauvegarder crée la fiche si elle n'existe pas, sinon met à jour la fiche existante (upsert), toujours avec le même `id` public.
- Bouton Signaler : après `report_threshold` signalements (même compteur que les commentaires, `api/data/config.json`), la fiche passe `status = reported` et disparaît de la liste publique en attendant un modérateur.
- Modération (`status`) : `visible` | `reported` | `hidden`. Seul un administrateur (login dans `admins` ou clé admin 40 car.) peut rétablir une fiche `reported`, masquer (`hidden`) ou supprimer n'importe quelle fiche. Bannir l'auteur réutilise l'action `ban` existante de `api/comments.php` (même table `users`) ; bannir supprime aussi sa fiche de guilde (voir `forget_guild()` / ban() dans `comments.php`).
- Un compte supprimé (RGPD, `action: forget` de `api/auth.php`) supprime aussi sa fiche de guilde.

## Sécurité : pas de Discord, contact = BattleTag uniquement

Filtré **côté client** (`js/guilds.js`, avant envoi, retour immédiat) **et côté serveur** (`wf_guild_forbidden()` dans `api/_lib.php`, source de vérité) sur les champs texte libres (nom, officiers, horaires, description) :

- `discord.gg`, `discord.com`, `discordapp.com`, `dsc.gg`, avec variantes obfusquées (espaces, `(dot)`, `[dot]`, `discord dot gg`…) : détecté en comparant le texte compacté (minuscule, ponctuation retirée) aux séquences `discordgg`, `discordcom`, `discordappcom`, `dscgg`.
- Tout lien `http(s)://` dont l'hôte n'est pas `azerothforever.info` (ou un sous-domaine).
- Tout `www.…` ou domaine à risque (`.gg`, `.xyz`, `.ly`, `.me`, `.shop`, `.site`, `.online`, `.link`, `.tk`, `.ru`, `.cn`…).
- Adresse email (`texte@texte.tld`).
- Numéro de téléphone (8 chiffres ou plus, séparateurs espace/point/tiret tolérés).

Message de refus, toujours le même : **« Contact uniquement par BattleTag »**.

Le champ `battletag` n'est pas filtré par cette liste : son format (`^[A-Za-z][A-Za-z0-9]{2,11}#[0-9]{4,6}$`) ne permet de toute façon ni lien ni symbole. Assumé : format BattleTag standard (nom 3 à 12 caractères ASCII, `#` puis 4 à 6 chiffres) ; à recaler si Blizzard publie une règle différente pour Forever.

Cette détection est heuristique (regex), pas un CDN de vérification de liens : elle peut laisser passer une obfuscation inédite ou bloquer un faux positif. À affiner si contourné en usage réel (TBD).

## Champs (table `guilds`)

| Colonne | Type | Notes |
|---|---|---|
| `id` | texte (8 car.) | identifiant public, `/guildes?voir=<id>` |
| `owner_user_id` | texte, unique | identifiant Twitch du créateur (`users.id`) |
| `name` | texte | 3 à 60 caractères |
| `faction` | `alliance` \| `horde` | |
| `region` | `EU` \| `US` | |
| `language` | `FR` \| `EN` \| `DE` \| `ES` \| `Autre` | liste fermée (évite tout texte libre à filtrer) |
| `size_range` | `10-20` \| `20-50` \| `50-100` \| `100+` | effectif en fourchette |
| `officers` | texte | pseudos jeu, séparés par virgule, jusqu'à 10, 40 car. chacun |
| `recruitment` | `ouvert` \| `preview` \| `ferme` | |
| `roles_wanted` | JSON texte[] | sous-ensemble fermé : 9 classes (`WF_CLASSES`) + `tank`, `heal`, `dps` |
| `vibe_tags` | JSON texte[] | ambiance, sous-ensemble fermé, voir plus bas |
| `game_modes` | JSON texte[] | mode de jeu, sous-ensemble fermé, voir plus bas |
| `schedule` | texte | horaires + fuseau, libre, 120 car. max |
| `progression` | JSON texte[] | **retiré du formulaire le 24/09/2026** (voir note ci-dessous) |
| `description` | texte | 800 caractères max, texte brut (pas de mise en forme riche) |
| `battletag` | texte | format `Nom#1234` |
| `status` | `visible` \| `reported` \| `hidden` | |
| `reports` | entier | nombre de signalements actifs |
| `created_at` / `updated_at` | entier (unix) | `updated_at` = « Date de mise à jour » affichée |

### Ambiance et mode de jeu (correctif du 24/09/2026)

Deux listes fermées distinctes, séparées après retour d'usage (hardcore/PvE/PvP/RP ne sont pas une « ambiance ») :

- **Ambiance** (`vibe_tags`) : `casual`, `tryhard`, `first`, `soirs` — Casual, Try hard, First perso, Soirs seulement. `semi-heavy` a été renommé `tryhard` (« Try hard »).
- **Mode de jeu** (`game_modes`) : `pve`, `pvp`, `rp`, `hardcore` — PvE, PvP, RP, Hardcore. Plusieurs modes possibles par fiche.

`game_modes` a été ajouté par une migration (`ALTER TABLE`, guardée par `PRAGMA table_info`, dans `wf_db()`) qui répartit aussi les fiches déjà créées : `hardcore`/`pve`/`pvp`/`rp` sortent de `vibe_tags` vers `game_modes`, `semi-heavy` devient `tryhard`.

### Progression retirée du formulaire

Le bloc « Progression visée » (checklist d'instances) a été retiré du formulaire de création/édition et de l'affichage public le 24/09/2026. La colonne `progression` reste en base pour les fiches déjà créées (gelée, plus jamais modifiée ni affichée) : `api/guilds.php` ne la lit ni ne l'écrit plus.

## API — `api/guilds.php`

- `GET ?list=1` : fiches publiques (`status = visible`), pas d'authentification, cache 30 s.
- `GET ?id=<id>` : une fiche publique.
- `POST action=mine` : la fiche du compte connecté, quel que soit son statut (pour l'éditer).
- `POST action=save` : upsert. Authentifié, compte non banni. Revalide tous les champs et la liste noire.
- `POST action=delete` : supprime sa propre fiche.
- `POST action=report` : signale une fiche (pas la sienne).
- `POST action=queue` : réservé admin, fiches `reported`/`hidden`.
- `POST action=moderate` (`do: show|hide|delete`) : réservé admin.

Mêmes conventions que `api/comments.php` : origine vérifiée (`wf_check_origin()`), erreurs en français, `wf_current_user()` pour l'auth par cookie de session.
