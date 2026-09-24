# Phases — une seule à la fois

Phase courante : **5 terminée, en attente de validation**

## Phase 0 : Audit (validée)
DoD :
- [x] Framework, auth, fichiers builder listés
- [x] `?build=` expliqué avec l'exemple Guerrier réel
- [x] Routes de toutes les classes
- [x] URL exacte héritage
- [x] Reco fichiers pour Phase 1
Interdit : coder des features.

## Phase 1 : Curseur + ordre (site)
DoD :
- [x] Composant générique activé sur les 9 classes, Guerrier comme cas de test principal
- [x] Slider 10–60 (9 avec Talentueux rang 1)
- [x] `?path=` persisté
- [x] Liste parcours de montée
- [x] Ordre auto valide (arbre par arbre, prérequis d'abord)
- [x] Tests codec + rules (`tools/tests/build-path.test.mjs`)
- [x] Vieux `?build=` intact

## Phase 2 — Partage site
DoD :
- [x] Lien court (`/b/…` stocke `path`, anciens `/b/` intacts)
- [x] ~~QR~~ : retiré du site par décision, viendra avec l'addon (Phase 6)
- [x] Code `AF1-` avec checksum (copier + coller)
- [x] Boutons « Copier le lien » / « Copier le code addon » / « Coller un code »
- [x] Builds communauté acceptent `path`

## Phase 3 : Héritage aligné
DoD :
- [x] Curseur 0–16 + 3 presets (Premier perso leveling, Métiers, Qualité de vie niveau 60)
- [x] Même partage (bouton « Partager » : lien, code, coller un code ; routage AF1- / AF1H-)
- [x] Code `AF1H-` avec checksum
- [x] Texte « Les points sont gagnés sur le compte et dépensés par personnage. »
- [x] Talentueux : phrase discrète sur l'Héritage seulement (aucune case sur les pages classe)

## Phase 4 — Instances
DoD (périmètre validé : structure des fiches, pas une base complète) :
- [x] Schéma JSON (`data/instances/<slug>.json`, `packages/schema/INSTANCES.md`)
- [x] Une seule page publique `/donjons` : filtres gardés, clic sur une carte = fiche dépliée sur place (`?ouvrir=<slug>`), anciennes adresses `/donjons-<slug>` redirigées. Pas de `/instances` séparé.
- [x] Fiche modèle Ragefeu : toutes les sections en place, **TBD assumé** (aucune source de boss ni de quête dans le repo)
- [x] 41 instances en fiche minimale (28 donjons, 9 raids, 4 BG), `bosses[]` et `quests[]` vides acceptés
- [x] Raids décembre + Classic statutés (texte du repo : « Ouverture 9 déc. », « Pas encore ouvert »)
- [x] `data/instances/_index.json` : complet | partiel | vide par slug (0 / 12 / 29 au 24/09/2026)

## Phase 5 — Guildes (terminée, en attente de validation)
DoD :
- [x] CRUD + BattleTag (page `/guildes`, compte Twitch requis, 1 fiche par compte, upsert par `owner_user_id`)
- [x] Blacklist Discord / liens (`wf_guild_forbidden()` côté serveur, miroir `isForbidden()` côté client, testés à l'identique)
- [x] Filtres (faction, recrutement, ambiance, recherche texte, client-side)
- [x] Signalement + 1 fiche / compte (bouton Signaler, seuil `report_threshold`, file de modération sur `/moderation`)
- [x] Bonus non demandé au départ mais couvert par le brief §8-9 : modération admin (masquer/rétablir/supprimer/bannir), suppression en cascade RGPD et bannissement

## Phase 6 — Addon V1
DoD :
- [ ] TOC 1.60 + `/af`
- [ ] Import code + preview + slider
- [ ] Apply confirmé
- [ ] Script export JSON → Lua
- [ ] Instances offline
- [ ] Zip CurseForge alpha

## Phase 7 — Polish
DoD :
- [ ] Overlay builds communautaires
- [ ] Auto-learn opt-in
- [ ] Mini QR in-game si simple
- [ ] Snapshot top builds à chaque release