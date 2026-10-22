-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Instances = {
  date = "2026-09-26",
  list = {
    {
      id = "rfc",
      slug = "gouffre-de-ragefeu",
      order = 1,
      name = "Gouffre de Ragefeu",
      type = "dungeon",
      origin = "classic",
      nameEn = "Ragefire Chasm",
      levels = {
        min = 13,
        max = 18
      },
      levelFinder = 13,
      levelEntry = 10,
      players = "5",
      zone = "Orgrimmar",
      entry = "Faille de l'Ombre, Orgrimmar",
      faction = "Horde",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      bossCount = 4,
      questsInCache = 6,
      bosses = {
        {
          name = "Lorgnesilex",
          nameEn = "Oggleflint"
        },
        {
          name = "Taragaman l'Affameur",
          nameEn = "Taragaman the Hungerer"
        },
        {
          name = "Jergosh l'Invocateur",
          nameEn = "Jergosh the Invoker"
        },
        {
          name = "Bazzalan"
        }
      },
      quests = {
        {
          id = 5723,
          name = "Tester la force de l'ennemi",
          faction = "horde",
          nameEn = "Testing an Enemy's Strength",
          level = 15,
          minLevel = 9,
          giver = {
            name = "Rahauro",
            where = "Les Pitons-du-Tonnerre",
            coords = "70.4, 29.6"
          },
          turnIn = {
            name = "Rahauro",
            where = "Les Pitons-du-Tonnerre",
            coords = "70.4, 29.6"
          },
          summary = "Chercher le gouffre de Ragefeu dans Orgrimmar, puis tuer 8 Troggs Ragefeu et 8 Chamans Ragefeu avant de revenir auprès de Rahauro aux Pitons-du-Tonnerre.",
          objectives = {
            "Trogg Ragefeu tué (8)",
            "Chaman Ragefeu tué (8)"
          },
          xp = 1050,
          money = "7s",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 100
            }
          }
        },
        {
          id = 5728,
          name = "Ennemis cachés",
          faction = "horde",
          nameEn = "Hidden Enemies",
          level = 16,
          minLevel = 9,
          giver = {
            name = "Thrall",
            where = "Orgrimmar",
            coords = "32, 37.8"
          },
          turnIn = {
            name = "Thrall",
            where = "Orgrimmar",
            coords = "32, 37.8"
          },
          summary = "Tuer Bazzalan et Jergosh l'Invocateur avant de retourner voir Thrall à Orgrimmar.",
          objectives = {
            "Bazzalan tué (1)",
            "Jergosh l'Invocateur tué (1)"
          },
          xp = 1150,
          money = "8s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 5725,
          name = "Le pouvoir de détruire...",
          faction = "horde",
          nameEn = "The Power to Destroy...",
          level = 16,
          minLevel = 9,
          giver = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          turnIn = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          summary = "Apporter les livres de Sorts des Ombres et d’Incantations du Néant à Varimathras, à Fossoyeuse.",
          objectives = {
            "Sorts des Ombres (1)",
            "Incantations du Néant (1)"
          },
          xp = 1450,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 5724,
          name = "Rapporter la sacoche perdue",
          faction = "horde",
          nameEn = "Returning the Lost Satchel",
          level = 16,
          minLevel = 9,
          turnIn = {
            name = "Rahauro",
            where = "Cime des Anciens, Pitons-du-Tonnerre"
          },
          fromItem = "Sacoche du Totem-Sinistre",
          summary = "Apporter la sacoche trouvée sur Maur à Rahauro.",
          objectives = {
            "Sacoche du Totem-Sinistre"
          },
          xp = 1450,
          reputation = {
            {
              faction = "Thunder Bluff",
              amount = 150
            }
          },
          chain = "2/2",
          state = "beta"
        },
        {
          id = 5761,
          name = "Tuer la bête",
          faction = "horde",
          nameEn = "Slaying the Beast",
          level = 16,
          minLevel = 9,
          giver = {
            name = "Neeru Lamefeu",
            where = "Orgrimmar",
            coords = "49.6, 50.4"
          },
          turnIn = {
            name = "Neeru Lamefeu",
            where = "Orgrimmar",
            coords = "49.6, 50.4"
          },
          summary = "Pénétrer dans le Gouffre de Ragefeu et tuer Taragaman l'Affameur, puis rapporter son coeur à Neeru Lamefeu à Orgrimmar.",
          objectives = {
            "Coeur de Taragaman l'Affameur (1)"
          },
          xp = 1150,
          money = "8s"
        },
        {
          id = 5722,
          name = "À la recherche de la sacoche perdue",
          faction = "horde",
          nameEn = "Searching for the Lost Satchel",
          level = 16,
          minLevel = 9,
          giver = {
            name = "Rahauro",
            where = "Les Pitons-du-Tonnerre",
            coords = "70.4, 29.6"
          },
          turnIn = {
            name = "Maur Totem-sinistre",
            where = "Gouffre de Ragefeu"
          },
          summary = "Fouiller le Gouffre de Ragefeu pour trouver le cadavre de Maur Totem-sinistre et tout élément intéressant.",
          objectives = {
            "Cadavre de Maur Totem-Sinistre"
          },
          xp = 880,
          money = "Aucun",
          tags = {
            "Coordonnées à confirmer"
          }
        }
      }
    },
    {
      id = "hot",
      slug = "salle-des-thanes",
      order = 2,
      name = "La salle des Thanes",
      type = "dungeon",
      origin = "new",
      nameEn = "Hall of Thanes",
      levels = {
        min = 13,
        max = 18
      },
      levelFinder = 13,
      players = "5",
      zone = "Forgefer / Dun Morogh",
      entry = "Sous le Vieux Forgefer ; Haute-Salle vers 43, 51",
      faction = "Horde / Alliance",
      summary = "Sous Forgefer, niveaux 13 à 18. Un tombeau de rois nains anciens visiblement forcé par le clan Fer noir. L'Alliance doit nettoyer les lieux, la Horde doit s'y faufiler ou s'y frayer un chemin.",
      bossCount = 4,
      questsInCache = 4,
      bosses = {
        {
          name = "Faldrim Courbenclume",
          nameEn = "Faldrim Anvilmar"
        },
        {
          name = "Magmatus",
          isNew = true
        },
        {
          name = "Pilleur",
          nameEn = "Plunder"
        },
        {
          name = "Durgen Mornemartel",
          nameEn = "Durgen Dirgehammer"
        }
      },
      quests = {
        {
          id = 96394,
          name = "Les morts sans repos",
          faction = "alliance",
          nameEn = "The Restless Dead",
          isNew = true,
          level = 15,
          minLevel = 10,
          giver = {
            name = "Afadra Mur-de-Dun",
            where = "Forgefer",
            coords = "33.2, 47.8"
          },
          turnIn = {
            name = "Afadra Mur-de-Dun",
            where = "Forgefer",
            coords = "33.2, 47.8"
          },
          summary = "Tuez 15 apparitions enragées et 10 âmes tourmentées, puis accordez le repos à l’esprit de Courbenclume.",
          objectives = {
            "Apparition enragée tué (15)",
            "Ame tourmentée tué (10)"
          },
          xp = 1050,
          money = "7s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          }
        },
        {
          id = 96403,
          name = "Précieux héritages",
          faction = "alliance",
          nameEn = "Important Heirlooms",
          isNew = true,
          level = 15,
          minLevel = 10,
          giver = {
            name = "Thom Filch",
            where = "Forgefer",
            coords = "32.4, 44.8"
          },
          turnIn = {
            name = "Thom Filch",
            where = "Forgefer",
            coords = "32.4, 44.8"
          },
          summary = "Récupérez 8 héritages nains dans la salle des Thanes.",
          objectives = {
            "Héritage nain (8)"
          },
          xp = 1350,
          money = "7s",
          reputation = {
            {
              faction = "Gadgetzan",
              amount = 100
            }
          }
        },
        {
          id = 96395,
          name = "Une rancune ancestrale",
          faction = "both",
          nameEn = "An Ancient Grudge",
          isNew = true,
          level = 15,
          minLevel = 10,
          giver = {
            name = "Domestique fantomatique",
            where = "Salle des Thanes"
          },
          summary = "Accordez le repos à l’esprit de Faldrim Courbenclume dans la salle des Thanes.",
          objectives = {
            "Faldrim Courbenclume tué (1)"
          },
          xp = 1050,
          money = "Aucun"
        },
        {
          id = 96393,
          name = "Incursion dans le Vieux Forgefer",
          faction = "alliance",
          nameEn = "Old Ironforge Incursion",
          isNew = true,
          level = 16,
          minLevel = 9,
          giver = {
            name = "Terre-voyant Farsen",
            where = "Dun Morogh",
            coords = "64.8, 58.4"
          },
          turnIn = {
            name = "Roi Magni Barbe-de-bronze",
            where = "Forgefer",
            coords = "39.4, 55.8"
          },
          summary = "Pénétrez dans la salle des Thanes, sous le Vieux Forgefer, et emparez-vous de la tête de Durgen Mornemartel.",
          objectives = {
            "Tête de Durgen Mornemartel (1)"
          },
          xp = 1450,
          money = "8s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            },
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        },
        {
          id = 98423,
          name = "Le traité d’entente",
          faction = "alliance",
          isNew = true,
          level = 16,
          minLevel = 9,
          turnIn = {
            name = "Roi Magni Barbe-de-bronze",
            where = "Forgefer",
            coords = "39.4, 55.8"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Remettez le traité de l’entente à Magni Barbe-de-Bronze, à Forgefer.",
          objectives = {
            "Traité d’entente (Fourni) (1)"
          },
          xp = 1150,
          money = "16s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            },
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          },
          tags = {
            "Non partageable"
          }
        }
      }
    },
    {
      id = "wc",
      slug = "cavernes-des-lamentations",
      order = 3,
      name = "Cavernes des lamentations",
      type = "dungeon",
      origin = "classic",
      nameEn = "Wailing Caverns",
      levels = {
        min = 15,
        max = 25
      },
      levelFinder = 17,
      levelEntry = 10,
      players = "5",
      zone = "Tarides",
      entry = "Oasis aux abords des Cavernes, Tarides",
      faction = "Horde",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      bossCount = 8,
      questsInCache = 9,
      bosses = {
        {
          name = "Dame Anacondra",
          nameEn = "Lady Anacondra"
        },
        {
          name = "Seigneur Cobrahn",
          nameEn = "Lord Cobrahn"
        },
        {
          name = "Kresh"
        },
        {
          name = "Seigneur Pythas",
          nameEn = "Lord Pythas"
        },
        {
          name = "Skum"
        },
        {
          name = "Seigneur Serpentis",
          nameEn = "Lord Serpentis"
        },
        {
          name = "Verdan l'Immortel",
          nameEn = "Verdan the Everliving"
        },
        {
          name = "Mutanus le Dévoreur",
          nameEn = "Mutanus the Devourer"
        }
      },
      quests = {
        {
          id = 1489,
          name = "Hamuul Totem-Runique",
          faction = "horde",
          nameEn = "Hamuul Runetotem",
          level = 16,
          minLevel = 10,
          giver = {
            name = "Hamuul Totem-Runique",
            where = "Cime des Anciens, Pitons-du-Tonnerre"
          },
          summary = "Parler à Hamuul Totem-Runique.",
          objectives = {
            "Parler à Hamuul"
          },
          xp = 290,
          reputation = {
            {
              faction = "Thunder Bluff",
              amount = 25
            }
          },
          chain = "1/3 puis Nara Crin-Sauvage",
          state = "beta"
        },
        {
          id = 1490,
          name = "Nara Crin-Sauvage",
          faction = "horde",
          nameEn = "Nara Wildmane",
          level = 16,
          minLevel = 10,
          giver = {
            name = "Nara Crin-Sauvage",
            where = "Cime des Anciens, Pitons-du-Tonnerre"
          },
          summary = "Parler à Nara Crin-Sauvage.",
          objectives = {
            "Parler à Nara"
          },
          xp = 115,
          reputation = {
            {
              faction = "Thunder Bluff",
              amount = 10
            }
          },
          chain = "2/3 puis Les chefs du Fang",
          state = "beta"
        },
        {
          id = 1486,
          name = "Les peaux communes",
          faction = "both",
          nameEn = "Deviate Hides",
          level = 17,
          minLevel = 13,
          giver = {
            name = "Nalpak"
          },
          turnIn = {
            name = "Nalpak"
          },
          summary = "Napalk dans les Cavernes des lamentations veut 20 Peaux communes.",
          objectives = {
            "Peau de déviant (20)"
          },
          xp = 1600,
          money = "18s",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 962,
          name = "Fleur de serpent",
          faction = "horde",
          nameEn = "Serpentbloom",
          level = 18,
          minLevel = 14,
          giver = {
            name = "Apothicaire Zamah",
            where = "Les Pitons-du-Tonnerre",
            coords = "23, 21"
          },
          turnIn = {
            name = "Apothicaire Zamah",
            where = "Les Pitons-du-Tonnerre",
            coords = "23, 21"
          },
          summary = "L'Apothicaire Zamah aux Pitons-du-Tonnerre veut que vous récoltiez 10 Fleurs de serpent.",
          objectives = {
            "Fleur de serpent (10)"
          },
          xp = 1700,
          money = "20s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 959,
          name = "Fuite de porto aux docks",
          faction = "both",
          nameEn = "Trouble at the Docks",
          level = 18,
          minLevel = 14,
          giver = {
            name = "Grutier Bigglefuzz",
            where = "Les Tarides",
            coords = "63, 37.6"
          },
          turnIn = {
            name = "Grutier Bigglefuzz",
            where = "Les Tarides",
            coords = "63, 37.6"
          },
          summary = "Le grutier Bigglefuzz de Cabestan veut que vous repreniez la Bouteille de porto vieille de 99 ans à Magglish le Dingue, qui se cache dans les Cavernes des lamentations.",
          objectives = {
            "Porto vieux de 99 ans (1)"
          },
          xp = 1350,
          money = "10s",
          reputation = {
            {
              faction = "Cabestan",
              amount = 100
            }
          }
        },
        {
          id = 1491,
          name = "Les potions d'intelligence",
          faction = "both",
          nameEn = "Smart Drinks",
          level = 18,
          minLevel = 13,
          giver = {
            name = "Mebok Mizzyrix",
            where = "Les Tarides",
            coords = "62.4, 37.6"
          },
          turnIn = {
            name = "Mebok Mizzyrix",
            where = "Les Tarides",
            coords = "62.4, 37.6"
          },
          summary = "Apporter 6 doses d'Essence de lamentation à Mebok Mizzyrix, à Cabestan.",
          objectives = {
            "Essence de lamentation (6)"
          },
          xp = 1350,
          money = "10s",
          reputation = {
            {
              faction = "Cabestan",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 1487,
          name = "L'éradication des Déviants",
          faction = "both",
          nameEn = "Deviate Eradication",
          level = 21,
          minLevel = 15,
          giver = {
            name = "Ebru"
          },
          turnIn = {
            name = "Ebru"
          },
          summary = "Ebru, des Cavernes des lamentations, veut que vous tuiez 7 Ravageurs Déviant, 7 Vipères Déviant, 7 Glacials Déviant et 7 Crocs-d'effroi Déviant.",
          objectives = {
            "Ravageur déviant tué (7)",
            "Vipère déviante tué (7)",
            "Glacial déviant tué (7)",
            "Croc-d'effroi déviant tué (7)"
          },
          xp = 2050,
          money = "25s",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 914,
          name = "Les druides du Croc",
          faction = "horde",
          nameEn = "Leaders of the Fang",
          level = 22,
          minLevel = 10,
          giver = {
            name = "Nara Crin-sauvage",
            where = "Les Pitons-du-Tonnerre",
            coords = "75.6, 31.2"
          },
          turnIn = {
            name = "Nara Crin-sauvage",
            where = "Les Pitons-du-Tonnerre",
            coords = "75.6, 31.2"
          },
          summary = "Apporter les Gemmes de Cobrahn, d'Anacondra, de Pythas et de Serpentis à Nara Crin-sauvage aux Pitons-du-Tonnerre.",
          objectives = {
            "Gemme de Cobrahn (1)",
            "Gemme d'Anacondra (1)",
            "Gemme de Pythas (1)",
            "Gemme de Serpentis (1)"
          },
          xp = 2200,
          money = "Aucun",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 6981,
          name = "L'Eclat luminescent",
          faction = "both",
          nameEn = "The Glowing Shard",
          level = 26,
          minLevel = 15,
          turnIn = {
            name = "Falla Vent-de-sagesse",
            where = "Les Tarides",
            coords = "48.2, 32.8"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Allez à Cabestan pour trouver quelqu'un qui puisse vous en dire plus sur l'Eclat luminescent. Puis livrez l'Eclat, selon les instructions.",
          objectives = {
            "Eclat luminescent (Fourni) (1)",
            "Parler de l'Eclat luminescent à quelqu'un de Cabestan. (1)"
          },
          xp = 2650,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        }
      }
    },
    {
      id = "rol",
      slug = "ruines-de-lordaeron",
      order = 4,
      name = "Ruines de Lordaeron",
      type = "dungeon",
      origin = "new",
      nameEn = "Ruins of Lordaeron",
      levels = {
        min = 15,
        max = 20
      },
      levelFinder = 15,
      players = "5",
      zone = "Clairières de Tirisfal",
      entry = "Ruines au-dessus de Fossoyeuse",
      faction = "Horde / Alliance",
      summary = "Niveaux 15 à 20. Les Réprouvés récupèrent héritages et souvenirs dans leur capitale en ruine, pendant que le Fléau la tient encore et qu'un nécromancien prépare une attaque sur une autre cité.",
      bossCount = 7,
      questsInCache = 10,
      bosses = {
        {
          name = "Croc-Flétri",
          nameEn = "Witherfang"
        },
        {
          name = "L'Abandonné",
          nameEn = "The Abandoned"
        },
        {
          name = "Le Baron",
          nameEn = "The Baron"
        },
        {
          name = "Rath'mael"
        },
        {
          name = "Capitaine de Lordaeron",
          nameEn = "Lordaeron Captain",
          isNew = true
        },
        {
          name = "Viktor le Vil",
          nameEn = "Viktor the Vile"
        },
        {
          name = "Bjork"
        }
      },
      quests = {
        {
          id = 95250,
          name = "Abominables créatures",
          faction = "alliance",
          nameEn = "Abominable Creatures",
          isNew = true,
          level = 21,
          minLevel = 16,
          turnIn = {
            name = "Captain Truman"
          },
          summary = "Récupérez la tête du baron dans les ruines de Lordaeron et rapportez-la au capitaine Truman.",
          objectives = {
            "Tête du Baron (1)"
          },
          xp = 1650,
          money = "Aucun"
        },
        {
          id = 97288,
          name = "Tourment interminable",
          faction = "horde",
          nameEn = "Unending Torment",
          isNew = true,
          level = 21,
          minLevel = 16,
          turnIn = {
            name = "Maître apothicaire Faranell",
            where = "Fossoyeuse",
            coords = "48.4, 69.4"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Remettez la tête abominable à quelqu’un, à Fossoyeuse.",
          objectives = {
            "Tête abominable (Fourni) (1)",
            "Remettez la tête abominable à quelqu’un, à Fossoyeuse. (1)"
          },
          xp = 1650,
          money = "Aucun"
        },
        {
          id = 95204,
          name = "Blason de Lordaeron",
          faction = "horde",
          nameEn = "Crest of Lordaeron",
          isNew = true,
          level = 22,
          minLevel = 16,
          turnIn = {
            name = "Oran Snakewrithe",
            where = "Fossoyeuse"
          },
          fromItem = "Blason de Lordaeron (objet dans l'instance, souvent bâtiment NW toit bleu)",
          summary = "Rapporter le blason à Oran Snakewrithe.",
          objectives = {
            "Blason de Lordaeron"
          },
          xp = 2600,
          state = "beta"
        },
        {
          id = 95189,
          name = "Blason de Lordaeron",
          faction = "alliance",
          nameEn = "Crest of Lordaeron",
          isNew = true,
          level = 22,
          minLevel = 16,
          turnIn = {
            name = "Lady Dena Kennedy",
            where = "Hurlevent"
          },
          fromItem = "Blason de Lordaeron",
          summary = "Rapporter le blason à Lady Dena Kennedy.",
          objectives = {
            "Blason de Lordaeron"
          },
          xp = 2600,
          state = "beta"
        },
        {
          id = 95195,
          name = "Insigne ensanglanté",
          faction = "alliance",
          nameEn = "Bloodied Insignia",
          isNew = true,
          level = 22,
          minLevel = 16,
          turnIn = {
            name = "Général Marcus Jonathan",
            where = "Hurlevent",
            coords = "63.8, 75.4"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Récupérez 10 insignes ensanglantés et remettez-les au général Marcus Jonathan, à Hurlevent.",
          objectives = {
            "Insigne ensanglanté (Fourni) (10)"
          },
          xp = 2600,
          money = "45s"
        },
        {
          id = 92421,
          name = "Justice de la Lumière",
          faction = "horde",
          nameEn = "Light's Justice",
          isNew = true,
          level = 22,
          minLevel = 15,
          giver = {
            name = "Morbin Plaie-lumineuse",
            where = "Fossoyeuse",
            coords = "57.8, 89.8"
          },
          turnIn = {
            name = "Morbin Plaie-lumineuse",
            where = "Fossoyeuse",
            coords = "57.8, 89.8"
          },
          summary = "Récupérez 25 membres intacts dans les ruines de Lordaeron pour Morbin Plaie-lumineuse, à Fossoyeuse.",
          objectives = {
            "Membres intacts (25)"
          },
          xp = 2200,
          money = "45s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 92422,
          name = "La colère de Rath’mael",
          faction = "horde",
          nameEn = "The Wrath of Rath'mael",
          isNew = true,
          level = 22,
          minLevel = 15,
          giver = {
            name = "Nécrogarde Kristof",
            where = "Clairières de Tirisfal",
            coords = "65.2, 60.2"
          },
          turnIn = {
            name = "Nécrogarde Kristof",
            where = "Clairières de Tirisfal",
            coords = "65.2, 60.2"
          },
          summary = "Tuez Rath’mael, dans les ruines de Lordaeron, pour le nécrogarde Kristof, à Brill.",
          objectives = {
            "Rath'mael tué (1)"
          },
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 95216,
          name = "La peste nouvelle",
          faction = "horde",
          nameEn = "The New Plague",
          isNew = true,
          level = 22,
          minLevel = 16,
          giver = {
            name = "Theodore Griffs",
            where = "Fossoyeuse",
            coords = "46.6, 72"
          },
          turnIn = {
            name = "Theodore Griffs",
            where = "Fossoyeuse",
            coords = "46.6, 72"
          },
          summary = "Récupérez la souche hautement toxique auprès de Croc-Flétri dans les ruines de Lordaeron, pour Theodore Griffs, à Fossoyeuse.",
          objectives = {
            "Souche hautement toxique (1)"
          },
          xp = 2600,
          money = "Aucun"
        },
        {
          id = 92415,
          name = "N’oublie pas que je t’aime",
          faction = "alliance",
          nameEn = "Remember That I Love You",
          isNew = true,
          level = 22,
          minLevel = 15,
          turnIn = {
            name = "Directrice de l'orphelinat Rossignol",
            where = "Hurlevent",
            coords = "47.2, 38.4"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Apportez la lettre tachée de sang à la directrice de l’orphelinat Rossignol, à Hurlevent.",
          objectives = {
            "Lettre tachée de sang (Fourni) (1)"
          },
          xp = 2600,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 92401,
          name = "Une requête apeurée",
          faction = "horde",
          nameEn = "A Frightened Request",
          isNew = true,
          level = 22,
          minLevel = 15,
          giver = {
            name = "Tabitha Tissecœur",
            where = "Forêt des Pins-Argentés",
            coords = "44.4, 43"
          },
          turnIn = {
            name = "Tabitha Tissecœur",
            where = "Forêt des Pins-Argentés",
            coords = "44.4, 43"
          },
          summary = "Enquêtez sur la disparition d’Edward Tissecœur dans les ruines de Lordaeron.",
          objectives = {
            "Enquêtez sur la disparition d’Edward Tissecœur dans les ruines de Lordaeron. (1)"
          },
          xp = 2200,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        }
      }
    },
    {
      id = "dm",
      slug = "les-mortemines",
      order = 5,
      name = "Les Mortemines",
      type = "dungeon",
      origin = "classic",
      nameEn = "The Deadmines",
      levels = {
        min = 18,
        max = 23
      },
      levelFinder = 16,
      levelEntry = 10,
      players = "5",
      zone = "Marche de l'Ouest",
      entry = "Mine de Ruisselune, Marche de l'Ouest",
      faction = "Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      bossCount = 7,
      questsInCache = 7,
      bosses = {
        {
          name = "Rhahk'Zor"
        },
        {
          name = "Sneed"
        },
        {
          name = "Gilnid"
        },
        {
          name = "Capitaine Vertepeau",
          nameEn = "Captain Greenskin"
        },
        {
          name = "M. Smite",
          nameEn = "Mr. Smite"
        },
        {
          name = "Macaron",
          nameEn = "Cookie"
        },
        {
          name = "Edwin VanCleef"
        }
      },
      quests = {
        {
          id = 214,
          name = "Les masques rouges en soie",
          faction = "alliance",
          nameEn = "Red Silk Bandanas",
          level = 17,
          minLevel = 14,
          giver = {
            name = "Eclaireur Riell",
            where = "Marche de l'Ouest",
            coords = "56.6, 47.4"
          },
          turnIn = {
            name = "Eclaireur Riell",
            where = "Marche de l'Ouest",
            coords = "56.6, 47.4"
          },
          summary = "L'Eclaireur Riell de la tour de la Colline des sentinelles veut que vous lui rameniez 10 masques rouges en soie.",
          objectives = {
            "Masque rouge en soie (10)"
          },
          xp = 1250,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 92753,
          name = "Destruction dans les Mortemines",
          faction = "alliance",
          nameEn = "Destruction in Deadmines",
          isNew = true,
          level = 18,
          minLevel = 9,
          turnIn = {
            name = "Alba Fairmoon",
            where = "Sortie des Mortemines"
          },
          fromItem = "Explosifs extra-destructeurs (item 254553)",
          summary = "Trouver la forge cachée, y poser les explosifs, rejoindre Alba Fairmoon à la sortie.",
          objectives = {
            "Explosifs placés"
          },
          xp = 1350,
          reputation = {
            {
              faction = "Stormwind",
              amount = 50
            }
          },
          state = "beta"
        },
        {
          id = 168,
          name = "À la recherche de Cartes du Syndicat des Mineurs",
          faction = "alliance",
          nameEn = "Collecting Memories",
          level = 18,
          minLevel = 14,
          giver = {
            name = "Wilder Crispechardon",
            where = "Hurlevent",
            coords = "65.2, 21.2"
          },
          turnIn = {
            name = "Wilder Crispechardon",
            where = "Hurlevent",
            coords = "65.2, 21.2"
          },
          summary = "Récupérer 4 Cartes du Syndicat des mineurs et les apporter à Wilder Crispechardon à Hurlevent.",
          objectives = {
            "Carte du syndicat des mineurs (4)"
          },
          xp = 1350,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          }
        },
        {
          id = 2040,
          name = "Assaut souterrain",
          faction = "alliance",
          nameEn = "Underground Assault",
          level = 20,
          minLevel = 15,
          giver = {
            name = "Shoni la Silencieuse",
            where = "Hurlevent",
            coords = "55.4, 12.6"
          },
          turnIn = {
            name = "Shoni la Silencieuse",
            where = "Hurlevent",
            coords = "55.4, 12.6"
          },
          summary = "Récupérer l'Indicateur Gnoam dans les mortemines et le ramener à Shoni la Silencieuse à Hurlevent.",
          objectives = {
            "Indicateur Gnoam (1)"
          },
          xp = 1550,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            },
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        },
        {
          id = 167,
          name = "Oh, mon frère…",
          faction = "alliance",
          nameEn = "Oh Brother...",
          level = 20,
          minLevel = 15,
          giver = {
            name = "Wilder Crispechardon",
            where = "Hurlevent",
            coords = "65.2, 21.2"
          },
          turnIn = {
            name = "Wilder Crispechardon",
            where = "Hurlevent",
            coords = "65.2, 21.2"
          },
          summary = "Apporter l'Insigne de la Ligue des Explorateurs du contremaître Crispechardon à Wilder Crispechardon à Hurlevent.",
          objectives = {
            "Plaque de Crispechardon (1)"
          },
          xp = 1550,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          }
        },
        {
          id = 166,
          name = "La Confrérie défias",
          faction = "alliance",
          nameEn = "The Defias Brotherhood",
          level = 22,
          minLevel = 14,
          giver = {
            name = "Gryan Roidemantel",
            where = "Marche de l'Ouest",
            coords = "56.2, 47.6"
          },
          turnIn = {
            name = "Gryan Roidemantel",
            where = "Marche de l'Ouest",
            coords = "56.2, 47.6"
          },
          summary = "Tuer Edwin VanCleef et apporter sa Tête à Gryan Roidemantel.",
          objectives = {
            "Tête de VanCleef (1)"
          },
          xp = 2600,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 200
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 373,
          name = "La lettre non envoyée",
          faction = "alliance",
          nameEn = "The Unsent Letter",
          level = 22,
          minLevel = 16,
          turnIn = {
            name = "Baros Alexston",
            where = "Hurlevent",
            coords = "49, 30.2"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Livrer la lettre pour l'Architecte de la Cité à Baros Alexston à Hurlevent.",
          objectives = {
            "Une lettre qui n'a pas été envoyée. (Fourni) (1)"
          },
          xp = 870,
          money = "7s",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 50
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 1654,
          name = "Le test de droiture",
          faction = "alliance",
          level = 22,
          minLevel = 20,
          giver = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          turnIn = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          summary = "Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Morpuits à Forgefer.",
          objectives = {
            "Bois de chêne de blanchepierre (1)",
            "Cargaison de minerai raffiné de Jordan (1)",
            "Marteau de forge de Jordan (1)",
            "Gemme de Kor purifiée (1)",
            "Notes sur les armes de Jordan (1)"
          },
          xp = 870,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Réservée : Paladin"
          }
        }
      }
    },
    {
      id = "sfk",
      slug = "donjon-d-ombrecroc",
      order = 6,
      name = "Donjon d'Ombrecroc",
      type = "dungeon",
      origin = "classic",
      nameEn = "Shadowfang Keep",
      levels = {
        min = 22,
        max = 30
      },
      levelFinder = 18,
      levelEntry = 11,
      players = "5",
      zone = "Forêt des Pins-Argentés",
      entry = "Donjon au nord du Sépulcre",
      faction = "Horde / Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      bossCount = 8,
      questsInCache = 4,
      bosses = {
        {
          name = "Rethilgore"
        },
        {
          name = "Tranchegriffe le Boucher",
          nameEn = "Razorclaw the Butcher"
        },
        {
          name = "Baron d'Argelaine",
          nameEn = "Baron Silverlaine"
        },
        {
          name = "Commandant Springvale",
          nameEn = "Commander Springvale"
        },
        {
          name = "Odo l'Aveugle",
          nameEn = "Odo the Blindwatcher"
        },
        {
          name = "Fenrus le Dévoreur",
          nameEn = "Fenrus the Devourer"
        },
        {
          name = "Maître-loup Nandos",
          nameEn = "Wolf Master Nandos"
        },
        {
          name = "Archimage Arugal",
          nameEn = "Archmage Arugal"
        }
      },
      quests = {
        {
          id = 1654,
          name = "Le test de droiture",
          faction = "alliance",
          level = 22,
          minLevel = 20,
          giver = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          turnIn = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          summary = "Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Morpuits à Forgefer.",
          objectives = {
            "Bois de chêne de blanchepierre (1)",
            "Cargaison de minerai raffiné de Jordan (1)",
            "Marteau de forge de Jordan (1)",
            "Gemme de Kor purifiée (1)",
            "Notes sur les armes de Jordan (1)"
          },
          xp = 870,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Réservée : Paladin"
          }
        },
        {
          id = 1098,
          name = "Des Traqueurs noirs à Ombrecroc",
          faction = "horde",
          nameEn = "Deathstalkers in Shadowfang",
          level = 25,
          minLevel = 18,
          giver = {
            name = "Grand exécuteur Hadrec",
            where = "Forêt des Pins-Argentés",
            coords = "43.4, 40.8"
          },
          turnIn = {
            name = "Nécrotraqueur Vincent",
            where = "Donjon d'Ombrecroc"
          },
          summary = "Trouver les Traqueurs noirs Adamant et Vincent.",
          objectives = {
            "Deathstalker Adamant",
            "Deathstalker Vincent"
          },
          xp = 2000,
          money = "18s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 100
            }
          },
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 1740,
          name = "L'Orbe de Soran'ruk",
          faction = "both",
          nameEn = "The Orb of Soran'ruk",
          level = 25,
          minLevel = 20,
          giver = {
            name = "Doan Karhan",
            where = "Les Tarides",
            coords = "49.2, 57.2"
          },
          turnIn = {
            name = "Doan Karhan",
            where = "Les Tarides",
            coords = "49.2, 57.2"
          },
          summary = "Trouver 3 Fragments de Soran'ruk et 1 Grand Fragment de Soran'ruk et les rapporter à Doan Karhan dans les Tarides.",
          objectives = {
            "Fragment de Soran'ruk (3)",
            "Grand fragment de Soran'ruk (1)"
          },
          xp = 2550,
          money = "Aucun",
          tags = {
            "Réservée : Démoniste"
          }
        },
        {
          id = 1013,
          name = "Le Livre d'Ur",
          faction = "horde",
          nameEn = "The Book of Ur",
          level = 26,
          minLevel = 16,
          giver = {
            name = "Gardien Bel'dugur",
            where = "Fossoyeuse",
            coords = "53.6, 54"
          },
          turnIn = {
            name = "Gardien Bel'dugur",
            where = "Fossoyeuse",
            coords = "53.6, 54"
          },
          summary = "Apporter le \"Livre d'Ur\" au Gardien Bel'dugur à l'Apothicarium à Fossoyeuse.",
          objectives = {
            "Le Livre d'Ur (1)"
          },
          xp = 2100,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 100
            }
          }
        },
        {
          id = 1014,
          name = "Arugal doit mourir",
          faction = "horde",
          nameEn = "Arugal Must Die",
          level = 27,
          minLevel = 18,
          giver = {
            name = "Dalar Tisselaube",
            where = "Forêt des Pins-Argentés",
            coords = "44.2, 39.8"
          },
          turnIn = {
            name = "Dalar Tisselaube",
            where = "Forêt des Pins-Argentés",
            coords = "44.2, 39.8"
          },
          summary = "Tuer Arugal et apporter sa Tête à Dalar Tisselaube au Sépulcre.",
          objectives = {
            "Tête d'Arugal (1)"
          },
          xp = 3300,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 200
            }
          }
        }
      }
    },
    {
      id = "stocks",
      slug = "la-prison",
      order = 7,
      name = "La Prison",
      type = "dungeon",
      origin = "classic",
      nameEn = "The Stockade",
      levels = {
        min = 22,
        max = 30
      },
      levelFinder = 23,
      levelEntry = 15,
      players = "5",
      zone = "Hurlevent",
      entry = "Prison de Hurlevent, Vieille ville",
      faction = "Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      bossCount = 5,
      questsInCache = 5,
      bosses = {
        {
          name = "Targorr le Terrifiant",
          nameEn = "Targorr the Dread"
        },
        {
          name = "Kam Deepfury"
        },
        {
          name = "Hamhock"
        },
        {
          name = "Bazil Thredd"
        },
        {
          name = "Dextren Ward"
        }
      },
      quests = {
        {
          id = 386,
          name = "Ce qui se passait ailleurs…",
          faction = "alliance",
          level = 25,
          minLevel = 22,
          giver = {
            name = "Garde Berton",
            where = "Les Carmines",
            coords = "26.4, 46.6"
          },
          turnIn = {
            name = "Garde Berton",
            where = "Les Carmines",
            coords = "26.4, 46.6"
          },
          summary = "Ramener la tête de Targorr le Terrifiant au Garde Berton à Comté-du-Lac.",
          objectives = {
            "Tête de Targorr (1)"
          },
          xp = 2000,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          }
        },
        {
          id = nil,
          name = "Qui sème le vent…",
          faction = "alliance",
          nameEn = "What Comes Around...",
          level = 25,
          giver = {
            name = "Garde Berton",
            where = "Comté-du-Lac, Carmines"
          },
          summary = "Objectif Classic : tuer Dextren Ward.",
          state = "beta"
        },
        {
          id = 377,
          name = "Crime et Châtiments",
          faction = "alliance",
          level = 26,
          minLevel = 22,
          giver = {
            name = "Conseiller Millstipe",
            where = "Bois de la Pénombre",
            coords = "72, 47.8"
          },
          turnIn = {
            name = "Conseiller Millstipe",
            where = "Bois de la Pénombre",
            coords = "72, 47.8"
          },
          summary = "Le conseiller Millstipe de Sombre-Comté désire que vous lui rameniez la main de Dextren Ward.",
          objectives = {
            "Main de Dextren Ward (1)"
          },
          xp = 2100,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          }
        },
        {
          id = nil,
          name = "Crime et châtiment",
          faction = "alliance",
          nameEn = "Crime and Punishment",
          level = 26,
          giver = {
            name = "Conseiller Millstipe",
            where = "Sombre-Comté"
          },
          summary = "Objectif Classic : rapporter la tête de Targorr.",
          state = "beta"
        },
        {
          id = 388,
          name = "La couleur du Sang",
          faction = "alliance",
          level = 26,
          minLevel = 22,
          giver = {
            name = "Nikova Raskol",
            where = "Hurlevent",
            coords = "73.4, 46.6"
          },
          turnIn = {
            name = "Nikova Raskol",
            where = "Hurlevent",
            coords = "73.4, 46.6"
          },
          summary = "Rapporter 10 foulards en laine rouge à Nikova Raskol de Hurlevent.",
          objectives = {
            "Foulard en laine rouge (10)"
          },
          xp = 2650,
          money = "40s",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 150
            }
          }
        },
        {
          id = nil,
          name = "La couleur du sang",
          faction = "alliance",
          nameEn = "The Color of Blood",
          level = 26,
          giver = {
            name = "Nikova Raskol",
            where = "Hurlevent"
          },
          summary = "Objectif Classic : rapporter 10 bandanas en laine rouge.",
          state = "beta"
        },
        {
          id = 387,
          name = "Écraser la rébellion",
          faction = "alliance",
          level = 26,
          minLevel = 22,
          giver = {
            name = "Gardien Thelwater",
            where = "Hurlevent",
            coords = "41.2, 58"
          },
          turnIn = {
            name = "Gardien Thelwater",
            where = "Hurlevent",
            coords = "41.2, 58"
          },
          summary = "Tuer 10 Prisonniers défias, 8 Détenus défias et 8 Insurgés défias dans la Prison pour le Gardien Thelwater de Hurlevent.",
          objectives = {
            "Prisonnier défias tué (10)",
            "Détenu défias tué (8)",
            "Insurgé défias tué (8)"
          },
          xp = 2650,
          money = "40s",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 150
            }
          }
        },
        {
          id = nil,
          name = "Étouffer la révolte",
          faction = "alliance",
          nameEn = "Quell the Uprising",
          level = 26,
          giver = {
            name = "Gardien Thelwater",
            where = "Devant la Prison, Hurlevent"
          },
          summary = "Objectif Classic : tuer 10 prisonniers, 8 insurgés et 10 conjurés Defias.",
          state = "beta"
        },
        {
          id = 378,
          name = "Fureur dans les Profondeurs",
          faction = "alliance",
          level = 27,
          minLevel = 22,
          giver = {
            name = "Motley Garmaçon",
            where = "Les Paluns",
            coords = "49.6, 18.2"
          },
          turnIn = {
            name = "Motley Garmaçon",
            where = "Les Paluns",
            coords = "49.6, 18.2"
          },
          summary = "Rapportez la tête de Kam Furie-du-fond à Motley Garmaçon à Dun Modr.",
          objectives = {
            "Tête de Furie-du-fond (1)"
          },
          xp = 2750,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 391,
          name = "Les Emeutes de la Prison",
          faction = "alliance",
          nameEn = "The Stockade Riots",
          level = 29,
          minLevel = 16,
          giver = {
            name = "Gardien Thelwater",
            where = "Hurlevent",
            coords = "41.2, 58"
          },
          turnIn = {
            name = "Gardien Thelwater",
            where = "Hurlevent",
            coords = "41.2, 58"
          },
          summary = "Tuer Bazil Thredd et ramener sa tête au Gardien Thelwater à la Prison.",
          objectives = {
            "Tête de Bazil Thredd (1)"
          },
          xp = 2350,
          money = "25s",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        }
      }
    },
    {
      id = "bfd",
      slug = "profondeurs-de-brassenoire",
      order = 8,
      name = "Profondeurs de Brassenoire",
      type = "dungeon",
      origin = "classic",
      nameEn = "Blackfathom Deeps",
      levels = {
        min = 24,
        max = 32
      },
      levelFinder = 22,
      levelEntry = 15,
      players = "5",
      zone = "Orneval / Orneval",
      entry = "Ruines au nord-ouest d'Orneval, côte",
      faction = "Horde / Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      questsInCache = 10,
      bosses = {
        {
          name = "Ghamoo-ra"
        },
        {
          name = "Dame Sarevess",
          nameEn = "Lady Sarevess"
        },
        {
          name = "Gelihast"
        },
        {
          name = "Lorgus Jett"
        },
        {
          name = "Baron Aquanis"
        },
        {
          name = "Seigneur du crépuscule Kelris",
          nameEn = "Twilight Lord Kelris"
        },
        {
          name = "Vieux Serra'kis",
          nameEn = "Old Serra'kis"
        },
        {
          name = "Aku'mai"
        }
      },
      quests = {
        {
          id = nil,
          name = "Allégeance aux Dieux très anciens",
          faction = "both",
          nameEn = "Allegiance to the Old Gods",
          level = 22,
          fromItem = "Objet ramassé ou reçu en butin",
          chain = "oui",
          state = "beta"
        },
        {
          id = 6562,
          name = "Du grain à moudre",
          faction = "horde",
          nameEn = "Trouble in the Deeps",
          level = 22,
          giver = {
            name = "Tsunaman",
            where = "Refuge de Pierre-du-Pic / Orneval"
          },
          state = "beta"
        },
        {
          id = 6563,
          name = "L'Essence d'Aku'Mai",
          faction = "horde",
          nameEn = "The Essence of Aku'Mai",
          level = 22,
          minLevel = 17,
          giver = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          turnIn = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          summary = "Apporter 20 Saphirs d'Aku'Mai à Je'neu Sancrea, en Orneval.",
          objectives = {
            "Saphir d'Aku'Mai (20)"
          },
          xp = 1750,
          money = "14s",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 100
            },
            {
              faction = "Cercle terrestre",
              amount = 150
            }
          }
        },
        {
          id = 1654,
          name = "Le test de droiture",
          faction = "alliance",
          level = 22,
          minLevel = 20,
          giver = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          turnIn = {
            name = "Jordan Morpuits",
            where = "Dun Morogh",
            coords = "52.4, 36.8"
          },
          summary = "Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Morpuits à Forgefer.",
          objectives = {
            "Bois de chêne de blanchepierre (1)",
            "Cargaison de minerai raffiné de Jordan (1)",
            "Marteau de forge de Jordan (1)",
            "Gemme de Kor purifiée (1)",
            "Notes sur les armes de Jordan (1)"
          },
          xp = 870,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Réservée : Paladin"
          }
        },
        {
          id = 971,
          name = "La connaissance des profondeurs",
          faction = "alliance",
          nameEn = "Knowledge in the Deeps",
          level = 23,
          minLevel = 10,
          giver = {
            name = "Gerrig Poigne-d'os",
            where = "Forgefer",
            coords = "50.4, 6"
          },
          turnIn = {
            name = "Gerrig Poigne-d'os",
            where = "Forgefer",
            coords = "50.4, 6"
          },
          summary = "Apporter le « Manuscrit de Lorgalis » à Gerrig Poigne-d'os à Forgefer.",
          objectives = {
            "Manuscrit de Lorgalis (1)"
          },
          xp = 2750,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 50
            }
          }
        },
        {
          id = 1275,
          name = "Recherches sur la corruption",
          faction = "alliance",
          nameEn = "Researching the Corruption",
          level = 24,
          minLevel = 18,
          giver = {
            name = "Gershala Murmenuit",
            where = "Sombrivage",
            coords = "38.4, 43"
          },
          turnIn = {
            name = "Gershala Murmenuit",
            where = "Sombrivage",
            coords = "38.4, 43"
          },
          summary = "Gershala Murmenuit d'Auberdine veut 8 Souches de cerveau corrompu.",
          objectives = {
            "Souche de cerveau corrompu (8)"
          },
          xp = 2400,
          money = "35s",
          reputation = {
            {
              faction = "Darnassus",
              amount = 150
            }
          }
        },
        {
          id = 1198,
          name = "À la recherche de Thaelrid",
          faction = "alliance",
          nameEn = "In Search of Thaelrid",
          level = 24,
          minLevel = 18,
          giver = {
            name = "Veilleur de l'aube Shaedlass",
            where = "Darnassus",
            coords = "55.4, 24.6"
          },
          turnIn = {
            name = "Garde d'argent Thaelrid",
            where = "Profondeurs de Brassenoire"
          },
          summary = "Aller chercher le Garde d'argent Thaelrid dans les Profondeurs de Brassenoire.",
          xp = 2400,
          money = "Aucun",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 150
            },
            {
              faction = "Darnassus",
              amount = 150
            }
          },
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 1740,
          name = "L'Orbe de Soran'ruk",
          faction = "both",
          level = 25,
          minLevel = 20,
          giver = {
            name = "Doan Karhan",
            where = "Les Tarides",
            coords = "49.2, 57.2"
          },
          turnIn = {
            name = "Doan Karhan",
            where = "Les Tarides",
            coords = "49.2, 57.2"
          },
          summary = "Trouver 3 Fragments de Soran'ruk et 1 Grand Fragment de Soran'ruk et les rapporter à Doan Karhan dans les Tarides.",
          objectives = {
            "Fragment de Soran'ruk (3)",
            "Grand fragment de Soran'ruk (1)"
          },
          xp = 2550,
          money = "Aucun",
          tags = {
            "Réservée : Démoniste"
          }
        },
        {
          id = 1199,
          name = "Le crépuscule descend",
          faction = "alliance",
          nameEn = "Twilight Falls",
          level = 25,
          minLevel = 20,
          giver = {
            name = "Garde d'argent Manados",
            where = "Darnassus",
            coords = "55.2, 23.6"
          },
          turnIn = {
            name = "Garde d'argent Manados",
            where = "Darnassus",
            coords = "55.2, 23.6"
          },
          summary = "Apporter 10 Pendentifs du Crépuscule au Garde d'argent Manados à Darnassus.",
          objectives = {
            "Pendentif du crépuscule (10)"
          },
          xp = 2550,
          money = "Aucun",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 150
            },
            {
              faction = "Darnassus",
              amount = 150
            }
          }
        },
        {
          id = 6565,
          name = "Allégeance aux Dieux très anciens",
          faction = "horde",
          level = 26,
          minLevel = 17,
          giver = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          turnIn = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Tuer Lorgus Jett, dans les Profondeurs de Brassenoire et retourner voir Je'neu Sancrea, en Orneval.",
          objectives = {
            "Lorgus Jett tué (1)"
          },
          xp = 2650,
          money = "40s",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 150
            },
            {
              faction = "Cercle terrestre",
              amount = 150
            }
          }
        },
        {
          id = nil,
          name = "Allégeance aux Dieux très anciens",
          faction = "both",
          nameEn = "Allegiance to the Old Gods",
          level = 26,
          chain = "suite",
          state = "beta"
        },
        {
          id = 6561,
          name = "L'infamie de Brassenoire",
          faction = "horde",
          nameEn = "Blackfathom Villainy",
          level = 27,
          minLevel = 18,
          giver = {
            name = "Garde d'argent Thaelrid",
            where = "Profondeurs de Brassenoire"
          },
          turnIn = {
            name = "Bashana Totem-runique",
            where = "Les Pitons-du-Tonnerre",
            coords = "70.8, 33.8"
          },
          summary = "Apporter la tête du Seigneur du crépuscule Kelris à Bashana Totem-runique, aux Pitons-du-Tonnerre.",
          objectives = {
            "Tête de Kelris (1)"
          },
          xp = 3300,
          money = "65s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 200
            },
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 200
            }
          },
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 1200,
          name = "L'infamie de Brassenoire",
          faction = "alliance",
          nameEn = "Blackfathom Villainy",
          level = 27,
          minLevel = 18,
          giver = {
            name = "Garde d'argent Thaelrid",
            where = "Profondeurs de Brassenoire"
          },
          turnIn = {
            name = "Veilleur de l'aube Selgorm",
            where = "Darnassus",
            coords = "55.8, 24.2"
          },
          summary = "Apporter la Tête du Seigneur du crépuscule Kelris au Veilleur de l'aube Selgorm, à Darnassus.",
          objectives = {
            "Tête de Kelris (1)"
          },
          xp = 3300,
          money = "65s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 200
            },
            {
              faction = "Darnassus",
              amount = 200
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 6921,
          name = "Parmi les ruines",
          faction = "horde",
          level = 27,
          minLevel = 21,
          giver = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          turnIn = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          summary = "Apporter le Noyau de la brasse à Je'neu Sancrea, à l’Avant-poste de Zoram'gar, en Orneval.",
          objectives = {
            "Noyau de la Brasse (1)"
          },
          xp = 2750,
          money = "45s",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 150
            },
            {
              faction = "Cercle terrestre",
              amount = 150
            }
          }
        },
        {
          id = 6922,
          name = "Baron Aquanis",
          faction = "horde",
          level = 30,
          minLevel = 21,
          turnIn = {
            name = "Je'neu Sancrea",
            where = "Orneval",
            coords = "11.6, 34.2"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Apporter le Globe d'eau étrange à Je'neu Sancrea, à l’Avant-poste de Zoram'gar, en Orneval.",
          objectives = {
            "Globe d'eau étrange (Fourni) (1)"
          },
          xp = 3050,
          money = "Aucun",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 150
            }
          },
          tags = {
            "Non partageable"
          }
        }
      }
    },
    {
      id = "excav",
      slug = "site-de-fouilles",
      order = 9,
      name = "Excavations : les Paluns",
      type = "dungeon",
      origin = "new",
      nameEn = "Excavation Site",
      levels = {
        min = 24,
        max = 29
      },
      levelFinder = 26,
      players = "5",
      zone = "Les Paluns / Wetlands",
      entry = "Au-dessus du Site de fouilles de Whelgar",
      faction = "Horde / Alliance",
      summary = "Dans les Terres humides, niveaux 24 à 29, au-dessus de la Fouille de Whelgar. Brume étrange, éclairs de lumière, gardiens titans actifs et une zone comme figée dans le temps.",
      bossCount = 4,
      bosses = {
        {
          name = "Échine-de-sel",
          nameEn = "Saltspine",
          isNew = true
        },
        {
          name = "Dent-d'ombre",
          nameEn = "Shadetooth",
          isNew = true
        },
        {
          name = "Horreur des hautes-terres",
          nameEn = "Highland Horror"
        },
        {
          name = "Gardien des reliques",
          nameEn = "Relic Guardian",
          isNew = true
        }
      },
      quests = {}
    },
    {
      id = "sm",
      slug = "monastere-ecarlate",
      order = 10,
      name = "Monastère écarlate",
      type = "dungeon",
      origin = "classic",
      nameEn = "Scarlet Monastery",
      levels = {
        min = 26,
        max = 45
      },
      levelFinder = 30,
      levelEntry = 20,
      players = "5",
      zone = "Clairières de Tirisfal",
      entry = "Nord-est de Tirisfal, 4 ailes",
      faction = "Horde / Alliance",
      note = "Toutes les ailes.",
      wings = {
        {
          name = "Cimetière",
          min = 28,
          max = 38
        },
        {
          name = "Bibliothèque",
          min = 29,
          max = 39
        },
        {
          name = "Armurerie",
          min = 32,
          max = 42
        },
        {
          name = "Cathédrale",
          min = 35,
          max = 45
        }
      },
      bosses = {
        {
          name = "Interrogateur Vishas",
          nameEn = "Interrogator Vishas",
          wing = "Cimetière"
        },
        {
          name = "Mage de sang Thalnos",
          nameEn = "Bloodmage Thalnos",
          wing = "Cimetière"
        },
        {
          name = "Maître-chien Loksey",
          nameEn = "Houndmaster Loksey",
          wing = "Bibliothèque"
        },
        {
          name = "Arcaniste Doan",
          nameEn = "Arcanist Doan",
          wing = "Bibliothèque"
        },
        {
          name = "Herod",
          nameEn = "Herod",
          wing = "Armurerie"
        },
        {
          name = "Grand Inquisiteur Fairbanks",
          nameEn = "High Inquisitor Fairbanks",
          wing = "Cathédrale"
        },
        {
          name = "Commandant écarlate Mograine",
          nameEn = "Scarlet Commander Mograine",
          wing = "Cathédrale"
        },
        {
          name = "Grand Inquisiteur Whitemane",
          nameEn = "High Inquisitor Whitemane",
          wing = "Cathédrale"
        },
        {
          name = "Azshir le Sans-sommeil",
          nameEn = "Azshir the Sleepless",
          wing = "Cimetière"
        },
        {
          name = "Échine-de-fer",
          nameEn = "Ironspine",
          wing = "Cimetière"
        },
        {
          name = "Champion mort",
          nameEn = "Fallen Champion",
          wing = "Cimetière"
        }
      },
      quests = {
        {
          id = 1113,
          name = "Des cœurs zélés",
          faction = "horde",
          level = 33,
          minLevel = 30,
          giver = {
            name = "Maître apothicaire Faranell",
            where = "Fossoyeuse",
            coords = "48.4, 69.4"
          },
          turnIn = {
            name = "Maître apothicaire Faranell",
            where = "Fossoyeuse",
            coords = "48.4, 69.4"
          },
          summary = "Le maître apothicaire Faranell, à Fossoyeuse, veut 20 Cœurs zélés.",
          objectives = {
            "Coeur zélé (20)"
          },
          xp = 3300,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          },
          part = "Cimetière"
        },
        {
          id = 1051,
          name = "La vengeance de Vorrel",
          faction = "horde",
          level = 33,
          minLevel = 25,
          giver = {
            name = "Vorrel Sengutz",
            where = "Monastère écarlate"
          },
          turnIn = {
            name = "Monika Sengutz",
            where = "Contreforts de Hautebrande",
            coords = "62.6, 19"
          },
          summary = "Rapporter l'anneau de mariage de Vorrel Sengutz à Monica Sengutz à Moulin-de-Tarren.",
          objectives = {
            "Anneau de mariage de Vorrel (1)"
          },
          xp = 3300,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          },
          part = "Cimetière",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 1160,
          name = "L'épreuve de la Connaissance",
          faction = "horde",
          level = 36,
          minLevel = 25,
          giver = {
            name = "Parqual Fintallas",
            where = "Fossoyeuse",
            coords = "57.8, 65"
          },
          turnIn = {
            name = "Parqual Fintallas",
            where = "Fossoyeuse",
            coords = "57.8, 65"
          },
          summary = "Trouver « Les commencements de la menace des morts-vivants » et le rapporter à Parqual Fintallas à Fossoyeuse.",
          objectives = {
            "Naissance de la menace des morts-vivants (1)"
          },
          xp = 2100,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 75
            }
          },
          part = "Bibliothèque",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 1049,
          name = "Compendium des Déchus",
          faction = "horde",
          level = 38,
          minLevel = 28,
          giver = {
            name = "Sage Recherche-la-vérité",
            where = "Les Pitons-du-Tonnerre",
            coords = "34.6, 47.2"
          },
          turnIn = {
            name = "Sage Recherche-la-vérité",
            where = "Les Pitons-du-Tonnerre",
            coords = "34.6, 47.2"
          },
          summary = "Trouver le « Compendium des Déchus » au Monastère dans les Clairières de Tirisfal et retourner voir le Sage Recherche-la-vérité aux Pitons-du-Tonnerre.",
          objectives = {
            "Compendium des Déchus (1)"
          },
          xp = 3550,
          money = "Aucun",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 150
            }
          },
          part = "Bibliothèque"
        },
        {
          id = 1050,
          name = "Mythologie des Titans",
          faction = "alliance",
          level = 38,
          minLevel = 28,
          giver = {
            name = "Bibliothécaire Mae Blêmepoussière",
            where = "Forgefer",
            coords = "74.6, 12.6"
          },
          turnIn = {
            name = "Bibliothécaire Mae Blêmepoussière",
            where = "Forgefer",
            coords = "74.6, 12.6"
          },
          summary = "Reprendre « la Mythologie des Titans » au Monastère et le rapporter au Bibliothécaire Mae Blêmepoussière à Forgefer.",
          objectives = {
            "Mythologie des Titans (1)"
          },
          xp = 3550,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 150
            }
          },
          part = "Bibliothèque"
        },
        {
          id = 1053,
          name = "Au nom de la Lumière",
          faction = "alliance",
          level = 40,
          minLevel = 34,
          giver = {
            name = "Raleigh le Dévot",
            where = "Contreforts de Hautebrande",
            coords = "51.4, 58.4"
          },
          turnIn = {
            name = "Raleigh le Dévot",
            where = "Contreforts de Hautebrande",
            coords = "51.4, 58.4"
          },
          summary = "Tuer le grand inquisiteur Whitemane, le commandant Mograine de la Croisade, le champion Herod de la Croisade et le maître-chien Loksey, et retourner faire un rapport à Raleigh le Dévot à Austrivage.",
          objectives = {
            "Grand Inquisiteur Whitemane tué (1)",
            "Commandant écarlate Mograine tué (1)",
            "Herod tué (1)",
            "Maître-chien Loksey tué (1)"
          },
          xp = 4700,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 200
            }
          },
          part = "Toutes les ailes"
        },
        {
          id = 1951,
          name = "Rituels du Pouvoir",
          faction = "both",
          level = 40,
          minLevel = 30,
          giver = {
            name = "Magus Tirth",
            where = "Mille pointes",
            coords = "78.2, 75.8"
          },
          turnIn = {
            name = "Tabetha",
            where = "Marécage d'Âprefange",
            coords = "46, 57"
          },
          summary = "Apporter le livre des « Rituels du pouvoir » à Tabetha dans le marécage d'Âprefange.",
          objectives = {
            "Rituels du Pouvoir (1)"
          },
          xp = 3150,
          money = "Aucun",
          part = "Bibliothèque",
          tags = {
            "Prérequis",
            "Réservée : Mage"
          }
        },
        {
          id = 1048,
          name = "Au monastère écarlate",
          faction = "horde",
          level = 42,
          minLevel = 33,
          giver = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          turnIn = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          summary = "Tuer le grand inquisiteur Whitemane, le commandant Mograine de la Croisade, le champion Herod et le maître-chien Loksey, et retourner faire son rapport à Varimathras à Fossoyeuse.",
          objectives = {
            "Grand Inquisiteur Whitemane tué (1)",
            "Commandant écarlate Mograine tué (1)",
            "Herod tué (1)",
            "Maître-chien Loksey tué (1)"
          },
          xp = 5150,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 200
            }
          },
          part = "Toutes les ailes"
        },
        {
          id = nil,
          name = "Au nom de la Lumière",
          faction = "alliance",
          nameEn = "In the Name of the Light",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Cœurs de zèle",
          faction = "both",
          nameEn = "Hearts of Zeal",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Dans le Monastère écarlate",
          faction = "horde",
          nameEn = "Into The Scarlet Monastery",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Le Compendium des déchus",
          faction = "both",
          nameEn = "Compendium of the Fallen",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Mythologie des Titans",
          faction = "both",
          nameEn = "Mythology of the Titans",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Rituels de puissance",
          faction = "both",
          nameEn = "Rituals of Power",
          state = "classic-a-confirmer"
        },
        {
          id = nil,
          name = "Vorrel Sengutz",
          faction = "both",
          state = "classic-a-confirmer"
        }
      }
    },
    {
      id = "cod",
      slug = "cite-de-dalaran",
      order = 11,
      name = "Cité de Dalaran",
      type = "dungeon",
      origin = "new",
      nameEn = "City of Dalaran",
      levels = {
        min = 28,
        max = 33
      },
      levelFinder = 28,
      players = "5",
      zone = "Montagnes d'Alterac",
      entry = "Dalaran, barrière tombée",
      faction = "Horde / Alliance",
      summary = "Niveaux 28 à 33. La barrière de Kirin Tor étant tombée, les enchantements faiblissent et de l'énergie démoniaque s'infiltre. Bien plus qu'un simple donjon puisqu'on y explore une partie de la cité.",
      bossCount = 9,
      bosses = {
        {
          name = "Anomalie arcanique",
          nameEn = "Arcane Anomaly"
        },
        {
          name = "Ancien gangrené",
          nameEn = "Fel Ancient"
        },
        {
          name = "Dévoreur de mana",
          nameEn = "Mana Devourer"
        },
        {
          name = "Élémentaire de mana",
          nameEn = "Mana Elemental"
        },
        {
          name = "Sentinelle instable",
          nameEn = "Unstable Sentinel"
        },
        {
          name = "Ombre de l'archimage",
          nameEn = "Shade of the Archmage"
        },
        {
          name = "Lyn l'Ignorée",
          nameEn = "Lyn the Ignored"
        },
        {
          name = "Atrexis le Chevalier des tombes",
          nameEn = "Atrexis the Grave Knight"
        },
        {
          name = "Spectre de mana",
          nameEn = "Mana Wraith"
        }
      },
      quests = {}
    },
    {
      id = "gnomer",
      slug = "gnomeregan",
      order = 12,
      name = "Gnomeregan",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 29,
        max = 38
      },
      levelFinder = 25,
      levelEntry = 19,
      players = "5",
      zone = "Dun Morogh",
      entry = "Porte de Gnomeregan, ou téléporteur Scooty à Cabestan",
      faction = "Horde / Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      questsInCache = 8,
      bosses = {
        {
          name = "Grubbis"
        },
        {
          name = "Retombée visqueuse",
          nameEn = "Viscous Fallout"
        },
        {
          name = "Électrocuteur 6000",
          nameEn = "Electrocutioner 6000"
        },
        {
          name = "Faucheur de foule 9-60",
          nameEn = "Crowd Pummeler 9-60"
        },
        {
          name = "Mekgénieur Thermaplugg",
          nameEn = "Mekgineer Thermaplugg"
        }
      },
      quests = {
        {
          id = 2923,
          name = "Maître-artisan Overspark",
          faction = "alliance",
          nameEn = "Tinkmaster Overspark",
          level = 26,
          giver = {
            name = "Maître-artisan Overspark",
            where = "Forgefer"
          },
          state = "beta"
        },
        {
          id = 2922,
          name = "Sauver le cerveau de Techbot !",
          faction = "alliance",
          nameEn = "Save Techbot's Brain!",
          level = 26,
          minLevel = 20,
          giver = {
            name = "Maître-bricoleur Suprétincelle",
            where = "Forgefer",
            coords = "69.8, 50.2"
          },
          turnIn = {
            name = "Maître-bricoleur Suprétincelle",
            where = "Forgefer",
            coords = "69.8, 50.2"
          },
          summary = "Rapporter la Mémoire principale de Techbot au maître-artisan Overspark à Forgefer.",
          objectives = {
            "Mémoire de Techbot (1)"
          },
          xp = 2650,
          money = "20s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 150
            }
          }
        },
        {
          id = 2926,
          name = "Gnogaine",
          faction = "alliance",
          level = 27,
          minLevel = 20,
          giver = {
            name = "Ozzie Virevolt",
            where = "Dun Morogh",
            coords = "45.8, 49.2"
          },
          turnIn = {
            name = "Ozzie Virevolt",
            where = "Dun Morogh",
            coords = "45.8, 49.2"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Utiliser la Fiole de collecte plombée vide sur les Envahisseurs ou les Pilleurs irradiés pour recueillir des retombées radioactives. Une fois pleine, rapportez-la à Ozzie Virevolt à Kharanos.",
          objectives = {
            "Flasque plombée lourde remplie (1)",
            "Flasque plombée vide (1)"
          },
          xp = 2200,
          money = "22s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 2927,
          name = "Le lendemain",
          faction = "both",
          nameEn = "The Day After",
          level = 27,
          state = "beta"
        },
        {
          id = 2962,
          name = "Encore plus de Lueur verte !",
          faction = "alliance",
          level = 30,
          minLevel = 20,
          giver = {
            name = "Ozzie Virevolt",
            where = "Dun Morogh",
            coords = "45.8, 49.2"
          },
          turnIn = {
            name = "Ozzie Virevolt",
            where = "Dun Morogh",
            coords = "45.8, 49.2"
          },
          summary = "Voyager à Gnomeregan et rapporter de la Matière radioactive à haut potentiel. Attention, la matière radioactive est instable et se désactive rapidement. Après le travail, conserver la Flasque plombée lourde, pour Ozzie.",
          objectives = {
            "Matière radioactive à haut potentiel (1)",
            "Flasque plombée lourde (Fourni) (1)"
          },
          xp = 2450,
          money = "25s",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 2928,
          name = "Excavateurs gyrodrilmatiques",
          faction = "alliance",
          nameEn = "Gyrodrillmatic Excavationators",
          level = 30,
          minLevel = 20,
          giver = {
            name = "Shoni la Silencieuse",
            where = "Hurlevent",
            coords = "55.4, 12.6"
          },
          turnIn = {
            name = "Shoni la Silencieuse",
            where = "Hurlevent",
            coords = "55.4, 12.6"
          },
          summary = "Rapporter 24 Entrailles mécaniques de robot à Shoni à Hurlevent.",
          objectives = {
            "Entrailles mécaniques de robot (24)"
          },
          xp = 2450,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            },
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        },
        {
          id = 2951,
          name = "Le Décapeur 5200 !",
          faction = "both",
          level = 30,
          minLevel = 25,
          giver = {
            name = "Le Décapeur 5200",
            where = "Gnomeregan"
          },
          turnIn = {
            name = "Le Décapeur 5200",
            where = "Gnomeregan"
          },
          summary = "Insérer un Objet sali dans le Décapeur 5200, sans oublier de jeter trois pièces d'argent dans la fente, pour démarrer la machine.",
          objectives = {
            "Objet sali (1)"
          },
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 2924,
          name = "Les cerveaux mécaniques",
          faction = "alliance",
          level = 30,
          minLevel = 24,
          giver = {
            name = "Pléthorloge Cléventail",
            where = "Forgefer",
            coords = "68.2, 46.2"
          },
          turnIn = {
            name = "Pléthorloge Cléventail",
            where = "Forgefer",
            coords = "68.2, 46.2"
          },
          summary = "Rapporter 12 Cerveaux mécaniques à Pléthorloge Cléventail à Forgefer.",
          objectives = {
            "Cerveau mécanique (12)"
          },
          xp = 3050,
          money = "55s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 150
            }
          }
        },
        {
          id = 2930,
          name = "Sauvetage de données",
          faction = "alliance",
          level = 30,
          minLevel = 25,
          giver = {
            name = "Maître mécanicien Fontuyau",
            where = "Forgefer",
            coords = "69.8, 48.4"
          },
          turnIn = {
            name = "Maître mécanicien Fontuyau",
            where = "Forgefer",
            coords = "69.8, 48.4"
          },
          summary = "Apporter une Carte perforée prismatique au Maître mécanicien Fontuyau, à Forgefer.",
          objectives = {
            "Carte perforée prismatique (1)"
          },
          xp = 3650,
          money = "25s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 200
            }
          }
        },
        {
          id = nil,
          name = "Un sacré gâchis",
          faction = "both",
          nameEn = "A Fine Mess",
          level = 30,
          giver = {
            name = "Kernobee",
            where = "Intérieur Gnomeregan"
          },
          state = "beta"
        },
        {
          id = 2904,
          name = "Une jolie pagaille",
          faction = "both",
          level = 30,
          minLevel = 20,
          giver = {
            name = "Kernobee",
            where = "Gnomeregan"
          },
          turnIn = {
            name = "Scooty",
            where = "Vallée de Strangleronce",
            coords = "27.6, 77.4"
          },
          summary = "Escorter Kernobee jusqu’à la sortie de la Fuite du temps, puis faire un rapport à Scooty, à Baie-du-Butin.",
          objectives = {
            "Sauvetage de Kernobee (1)"
          },
          xp = 2450,
          money = "Aucun",
          tags = {
            "Escorte",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 2945,
          name = "Anneau sali",
          faction = "both",
          level = 34,
          minLevel = 28,
          turnIn = {
            name = "Le Décapeur 5200",
            where = "Gnomeregan"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Trouver un moyen de nettoyer l'Anneau sali.",
          objectives = {
            "Anneau sali (Fourni) (1)"
          },
          xp = 2700,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = nil,
          name = "Gnomer-gooooone !",
          faction = "both",
          nameEn = "Gnomer-gooooone!",
          level = 35,
          chain = "téléporteur",
          state = "beta"
        },
        {
          id = 2843,
          name = "Gnomer-paaarti !",
          faction = "horde",
          level = 35,
          minLevel = 20,
          giver = {
            name = "Scooty",
            where = "Vallée de Strangleronce",
            coords = "27.6, 77.4"
          },
          turnIn = {
            name = "Scooty",
            where = "Vallée de Strangleronce",
            coords = "27.6, 77.4"
          },
          summary = "Attendre que Scooty calibre le transpondeur des gobelins.",
          objectives = {
            "Le transpondeur des gobelins (1)"
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 2841,
          name = "Guerre des plates-formes",
          faction = "horde",
          level = 35,
          minLevel = 25,
          giver = {
            name = "Nogg",
            where = "Orgrimmar",
            coords = "75.8, 25.2"
          },
          turnIn = {
            name = "Nogg",
            where = "Orgrimmar",
            coords = "75.8, 25.2"
          },
          summary = "Obtenir la Combinaison du coffre de Thermaplugg, prendre les Plans de la plate-forme et les apporter à Nogg à Orgrimmar.",
          objectives = {
            "Plan de plateforme (1)",
            "Combinaison du coffre de Thermaplugg (1)"
          },
          xp = 2750,
          money = "Aucun",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 2842,
          name = "L'ingénieur en chef Scooty",
          faction = "horde",
          nameEn = "Chief Engineer Scooty",
          level = 35,
          minLevel = 20,
          giver = {
            name = "Sovik",
            where = "Orgrimmar",
            coords = "75.6, 25.2"
          },
          turnIn = {
            name = "Scooty",
            where = "Vallée de Strangleronce",
            coords = "27.6, 77.4"
          },
          summary = "Parler à Scooty à Baie-du-Butin.",
          xp = 275,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2929,
          name = "La grande trahison",
          faction = "alliance",
          level = 35,
          minLevel = 25,
          giver = {
            name = "Grand Bricoleur Mekkanivelle",
            where = "Forgefer",
            coords = "69, 49"
          },
          turnIn = {
            name = "Grand Bricoleur Mekkanivelle",
            where = "Forgefer",
            coords = "69, 49"
          },
          summary = "Aller à Gnomeregan et tuer le mekgénieur Thermaplugg. Puis retourner voir le Grand Bricoleur Mekkanivelle.",
          objectives = {
            "Mekgénieur Thermaplugg tué (1)"
          },
          xp = 2750,
          money = "35s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        }
      }
    },
    {
      id = "rfk",
      slug = "kraal-de-tranchebauge",
      order = 13,
      name = "Kraal de Tranchebauge",
      type = "dungeon",
      origin = "classic",
      nameEn = "Razorfen Kraul",
      levels = {
        min = 30,
        max = 40
      },
      levelFinder = 24,
      levelEntry = 25,
      players = "5",
      zone = "Tarides",
      entry = "Sud des Tarides, entrée du Kraal",
      faction = "Horde / Alliance",
      groupChange = "Taille de groupe passée de 10 joueurs (Classic Era) à 5.",
      classicDiff = "Donjon à 5 joueurs dans Forever, contre 10 dans Classic Era.",
      questsInCache = 2,
      bosses = {
        {
          name = "Roogug"
        },
        {
          name = "Aggem Mantépine",
          nameEn = "Aggem Thorncurse"
        },
        {
          name = "Nécrorateur Jargba",
          nameEn = "Death Speaker Jargba"
        },
        {
          name = "Seigneur Brusquebroche",
          nameEn = "Overlord Ramtusk"
        },
        {
          name = "Agathelos l'Enragé",
          nameEn = "Agathelos the Raging"
        },
        {
          name = "Charlga Trancheflanc",
          nameEn = "Charlga Razorflank"
        }
      },
      quests = {
        {
          id = 1221,
          name = "Racines de Feuillebleue",
          faction = "both",
          nameEn = "Blueleaf Tubers",
          level = 26,
          minLevel = 20,
          giver = {
            name = "Mebok Mizzyrix",
            where = "Les Tarides",
            coords = "62.4, 37.6"
          },
          turnIn = {
            name = "Mebok Mizzyrix",
            where = "Les Tarides",
            coords = "62.4, 37.6"
          },
          summary = "Prendre une Caisse percée. Prendre un Bâton de commandement de Sniffetarin. Lire le Manuel d'utilisateur de Sniffetarin. Au Kraal de Tranchebauge, utiliser la Caisse pour invoquer un Ecureuil Sniffetarin et utiliser le Bâton de commandement pour ordonner à l'Ecureuil de chercher les racines. Ramener 6 Racines de Feuillebleue, le Bâton de commandement de Sniffetarin et la Caisse percée à Mebok Mizzyrix, à Cabestan.",
          objectives = {
            "Racines de Feuillebleue (6)",
            "Caisse percée (1)",
            "Manuel d'utilisateur de Sniffetarin (1)",
            "Bâton de commandement de Sniffetarin (1)"
          },
          xp = 2100,
          money = "Aucun",
          reputation = {
            {
              faction = "Cabestan",
              amount = 100
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 1142,
          name = "Le déclin et la mort",
          faction = "alliance",
          level = 30,
          minLevel = 25,
          giver = {
            name = "Heralath Ruissefriche",
            where = "Kraal de Tranchebauge"
          },
          turnIn = {
            name = "Treshala Ruissefriche",
            where = "Darnassus",
            coords = "69.4, 67.4"
          },
          summary = "Trouver et rapporter le Pendentif de Treshala à Treshala Ruissefriche à Darnassus.",
          objectives = {
            "Pendentif de Treshala (1)"
          },
          xp = 3050,
          money = "Aucun",
          reputation = {
            {
              faction = "Darnassus",
              amount = 150
            }
          },
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 1144,
          name = "Willix l'Importateur",
          faction = "both",
          level = 30,
          minLevel = 22,
          giver = {
            name = "Willix l'Importateur",
            where = "Kraal de Tranchebauge"
          },
          turnIn = {
            name = "Willix l'Importateur",
            where = "Kraal de Tranchebauge"
          },
          summary = "Escorter Willix l'Importateur hors du Kraal de Tranchebauge.",
          objectives = {
            "Aider Willix l'Importateur à s'échapper du Kraal de Tranchebauge (1)"
          },
          xp = 3050,
          money = "Aucun",
          reputation = {
            {
              faction = "Cabestan",
              amount = 150
            }
          },
          tags = {
            "Escorte",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = nil,
          name = "Willix l'Importateur",
          faction = "both",
          nameEn = "Willix the Importer",
          level = 30,
          giver = {
            name = "Willix l'Importateur",
            where = "Intérieur du Kraal (escorte)"
          },
          state = "beta"
        },
        {
          id = 1109,
          name = "Corvée de guano",
          faction = "horde",
          level = 33,
          minLevel = 30,
          giver = {
            name = "Maître apothicaire Faranell",
            where = "Fossoyeuse",
            coords = "48.4, 69.4"
          },
          turnIn = {
            name = "Maître apothicaire Faranell",
            where = "Fossoyeuse",
            coords = "48.4, 69.4"
          },
          summary = "Apporter 1 tas de Guano du kraal au Maître Apothicaire Faranell à Fossoyeuse.",
          objectives = {
            "Guano du kraal (1)"
          },
          xp = 3300,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 1101,
          name = "La mégère du Kraal",
          faction = "alliance",
          level = 34,
          minLevel = 29,
          giver = {
            name = "Falfindel Gardevoie",
            where = "Féralas",
            coords = "89.6, 46.4"
          },
          turnIn = {
            name = "Falfindel Gardevoie",
            where = "Féralas",
            coords = "89.6, 46.4"
          },
          summary = "Apporter le Médaillon de Trancheflanc à Falfindel Gardevoie à Thalanaar.",
          objectives = {
            "Médaillon de Trancheflanc (1)"
          },
          xp = 3350,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 1102,
          name = "Un destin funeste",
          faction = "horde",
          level = 34,
          minLevel = 29,
          giver = {
            name = "Cime-de-pierre le Vieil",
            where = "Les Pitons-du-Tonnerre",
            coords = "36.2, 59.8"
          },
          turnIn = {
            name = "Cime-de-pierre le Vieil",
            where = "Les Pitons-du-Tonnerre",
            coords = "36.2, 59.8"
          },
          summary = "Apporter le Cœur de Trancheflanc à Cime-de-pierre le Vieil, aux Pitons-du-Tonnerre.",
          objectives = {
            "Coeur de Trancheflanc (1)"
          },
          xp = 4050,
          money = "Aucun",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 200
            }
          }
        },
        {
          id = 6522,
          name = "Une alliance impie",
          faction = "horde",
          level = 36,
          minLevel = 28,
          turnIn = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Apporter le Petit parchemin à Varimathras, à Fossoyeuse.",
          objectives = {
            "Petit parchemin (Fourni) (1)"
          },
          xp = 2800,
          money = "40s",
          tags = {
            "Non partageable"
          }
        }
      }
    },
    {
      id = "dc",
      slug = "la-cite-engloutie",
      order = 14,
      name = "La Cité engloutie",
      type = "dungeon",
      origin = "new",
      nameEn = "The Drowned City",
      levels = {
        min = 35,
        max = 40
      },
      players = "5",
      zone = "Vallée de Strangleronce",
      entry = "Ruines trolles au large de la côte",
      summary = "Niveaux 35 à 40. Des ruines trolls au large de Strangleronce qui viennent de resurgir de la mer, avec naga, trolls et une épave de pirates. C'est ce donjon qui était jouable à la BlizzCon.",
      bosses = {},
      quests = {}
    },
    {
      id = "rfd",
      slug = "souilles-de-tranchebauge",
      order = 15,
      name = "Souilles de Tranchebauge",
      type = "dungeon",
      origin = "classic",
      nameEn = "Razorfen Downs",
      levels = {
        min = 40,
        max = 50
      },
      levelFinder = 34,
      levelEntry = 35,
      players = "5",
      zone = "Tarides",
      faction = "Horde / Alliance",
      bosses = {
        {
          name = "Tuten'kash"
        },
        {
          name = "Mordresh Oeil-de-feu",
          nameEn = "Mordresh Fire Eye"
        },
        {
          name = "Glouton",
          nameEn = "Glutton"
        },
        {
          name = "Amnennar le Porte-froid",
          nameEn = "Amnennar the Coldbringer"
        }
      },
      quests = {
        {
          id = 6626,
          name = "L'hôte du mal",
          faction = "both",
          level = 35,
          minLevel = 28,
          giver = {
            name = "Myriam Chantelune",
            where = "Les Tarides",
            coords = "49, 94.8"
          },
          turnIn = {
            name = "Myriam Chantelune",
            where = "Les Tarides",
            coords = "49, 94.8"
          },
          summary = "Tuer 8 Gardes de guerre Tranchebauge, 8 Tisseurs d'épines Tranchebauge et 8 Sectateur de la Tête de mort, puis retourner voir Myriam Chantelune, à l’entrée des Souilles de Tranchebauge.",
          objectives = {
            "Garde de guerre de Tranchebauge tué (8)",
            "Tisseur d'épines de Tranchebauge tué (8)",
            "Sectateur de la Tête de Mort tué (8)"
          },
          xp = 3450,
          money = "75s"
        },
        {
          id = 6521,
          name = "Une alliance impie",
          faction = "horde",
          level = 36,
          minLevel = 28,
          giver = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          turnIn = {
            name = "Varimathras",
            where = "Fossoyeuse",
            coords = "56.2, 92.6"
          },
          summary = "Apporter la Tête de l'Ambassadeur Malcin à Varimathras, à Fossoyeuse.",
          objectives = {
            "Tête de l'Ambassadeur Malcin (1)"
          },
          xp = 3500,
          money = "20s",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 3525,
          name = "L'extinction de l'idole",
          faction = "both",
          level = 37,
          minLevel = 32,
          giver = {
            name = "Belnistrasz",
            where = "Souilles de Tranchebauge"
          },
          turnIn = {
            name = "Brasero de Belnistrasz",
            where = "Souilles de Tranchebauge"
          },
          summary = "Escorter Belnistrasz jusqu'à l'Idole des hurans dans les Souilles de Tranchebauge. Protéger Belnistrasz tandis qu'il exécute le rituel pour arrêter l'idole.",
          objectives = {
            "Protéger Belnistrasz pendant qu'il exécute le rituel pour désactiver l'idole (1)"
          },
          xp = 4250,
          money = "Aucun",
          tags = {
            "Escorte",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 3523,
          name = "Le Fléau des Souilles",
          faction = "both",
          level = 37,
          minLevel = 32,
          giver = {
            name = "Belnistrasz",
            where = "Souilles de Tranchebauge"
          },
          turnIn = {
            name = "Belnistrasz",
            where = "Souilles de Tranchebauge"
          },
          summary = "Pour aider Belnistrasz, lui parler de nouveau et lui rendre la Pierre de voeu qu’il vous avait donnée.",
          objectives = {
            "Pierre de voeu de Belnistrasz (Fourni) (1)"
          },
          xp = 285,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 3636,
          name = "Apportez la Lumière",
          faction = "alliance",
          level = 42,
          minLevel = 39,
          giver = {
            name = "Archevêque Benedictus",
            where = "Hurlevent",
            coords = "39.6, 27.4"
          },
          turnIn = {
            name = "Archevêque Benedictus",
            where = "Hurlevent",
            coords = "39.6, 27.4"
          },
          summary = "Tuer Amnennar le Porte-froid, aux Souilles de Tranchebauge, pour l’Archevêque Benedictus.",
          objectives = {
            "Amnennar le Porte-froid tué (1)"
          },
          xp = 4300,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 150
            }
          },
          tags = {
            "Non partageable"
          }
        },
        {
          id = 3341,
          name = "L'anéantissement",
          faction = "horde",
          level = 42,
          minLevel = 37,
          giver = {
            name = "Andrew Brownell",
            where = "Fossoyeuse",
            coords = "74, 32.8"
          },
          turnIn = {
            name = "Andrew Brownell",
            where = "Fossoyeuse",
            coords = "74, 32.8"
          },
          summary = "Andrew Brownell veut que vous tuiez Amnennar le Porte-froid et que vous lui rameniez son crâne.",
          objectives = {
            "Crâne du Porte-froid (1)"
          },
          xp = 4300,
          money = "Aucun",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        }
      }
    },
    {
      id = "krol",
      slug = "bastion-de-krol-dok",
      order = 16,
      name = "Bastion de Krol'Dok",
      type = "dungeon",
      origin = "new",
      nameEn = "Krol'dok Stronghold",
      levels = {
        min = 40,
        max = 45
      },
      levelsNote = "Corrigé officiellement à 40–45 (Kaivax, Blizzard, 15/09/2026). Le client et les premiers listings indiquaient encore 40–55.",
      players = "5",
      zone = "Prairie du Fleuve (Riverglades, nouvelle zone)",
      entry = "Donjon extérieur, dans la Prairie du Fleuve.",
      summary = "Niveaux 40 à 45. Un immense donjon extérieur dans la Prairie du Fleuve où des ogres razzient des campements et prennent des prisonniers, avec des chants nocturnes qui pointent vers le Marteau du crépuscule.",
      bosses = {},
      quests = {}
    },
    {
      id = "ulda",
      slug = "uldaman",
      order = 17,
      name = "Uldaman",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 42,
        max = 52
      },
      levelFinder = 35,
      levelEntry = 30,
      players = "5",
      zone = "Terres ingrates",
      faction = "Horde / Alliance",
      bosses = {
        {
          name = "Revelosh"
        },
        {
          name = "Baelog"
        },
        {
          name = "Eric « l'Agile »",
          nameEn = "Eric \"The Swift\""
        },
        {
          name = "Olaf"
        },
        {
          name = "Ironaya"
        },
        {
          name = "Sentinelle d'obsidienne",
          nameEn = "Obsidian Sentinel"
        },
        {
          name = "Ancien gardien des pierres",
          nameEn = "Ancient Stone Keeper"
        },
        {
          name = "Galgann Martel-de-feu",
          nameEn = "Galgann Firehammer"
        },
        {
          name = "Grimlok"
        },
        {
          name = "Archaedas"
        }
      },
      quests = {
        {
          id = 2418,
          name = "Les pierres de puissance",
          faction = "both",
          level = 36,
          minLevel = 30,
          giver = {
            name = "Rigglefuzz",
            where = "Terres ingrates",
            coords = "42.4, 52.8"
          },
          turnIn = {
            name = "Rigglefuzz",
            where = "Terres ingrates",
            coords = "42.4, 52.8"
          },
          summary = "Apporter 8 Pierres de puissance Dentrium et 8 Pierres de puissance An'Alleum à Rigglefuzz dans les Terres ingrates.",
          objectives = {
            "Pierre de puissance Dentrium (8)",
            "Pierre de puissance An'Alleum (8)"
          },
          xp = 3500,
          money = "Aucun",
          reputation = {
            {
              faction = "Baie-du-Butin",
              amount = 150
            },
            {
              faction = "La Voile sanglante",
              amount = -750
            }
          }
        },
        {
          id = 704,
          name = "Le destin d'Agmond",
          faction = "alliance",
          level = 38,
          minLevel = 30,
          giver = {
            name = "Prospecteur Baguefer",
            where = "Loch Modan",
            coords = "65.8, 65.6"
          },
          turnIn = {
            name = "Prospecteur Baguefer",
            where = "Loch Modan",
            coords = "65.8, 65.6"
          },
          summary = "Apporter 4 Urnes de pierre gravées au Prospecteur Baguefer au Loch Modan.",
          objectives = {
            "Urne de pierre gravée (4)"
          },
          xp = 2850,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 1956,
          name = "L'Energie d'Uldaman",
          faction = "both",
          level = 40,
          minLevel = 35,
          giver = {
            name = "Tabetha",
            where = "Marécage d'Âprefange",
            coords = "46, 57"
          },
          turnIn = {
            name = "Tabetha",
            where = "Marécage d'Âprefange",
            coords = "46, 57"
          },
          summary = "Récupérer une Source d'énergie en obsidienne et la rapporter à Tabetha dans le marécage d'Âprefange.",
          objectives = {
            "Source d'énergie en obsidienne (1)"
          },
          xp = 3900,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Réservée : Mage"
          }
        },
        {
          id = 2240,
          name = "La Chambre secrète",
          faction = "alliance",
          level = 40,
          minLevel = 35,
          giver = {
            name = "Baelog",
            where = "Uldaman"
          },
          turnIn = {
            name = "Prospecteur Foudrepique",
            where = "Forgefer",
            coords = "74.4, 12"
          },
          summary = "Lire le journal de Baelog, explorer la Chambre secrète, puis rendre compte au Prospecteur Foudrepique.",
          objectives = {
            "Explorer la zone (1)",
            "Explorer la Chambre secrète (1)"
          },
          xp = 3900,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 150
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 709,
          name = "La solution à la malédiction",
          faction = "both",
          level = 40,
          minLevel = 30,
          giver = {
            name = "Theldurin l'Egaré",
            where = "Terres ingrates",
            coords = "51.4, 76.8"
          },
          turnIn = {
            name = "Theldurin l'Egaré",
            where = "Terres ingrates",
            coords = "51.4, 76.8"
          },
          summary = "Rapporter la Tablette de Ryun'eh à Theldurin l'Egaré.",
          objectives = {
            "Tablette de Ryun'eh (1)"
          },
          xp = 3150,
          money = "Aucun"
        },
        {
          id = 2398,
          name = "Les nains perdus",
          faction = "alliance",
          level = 40,
          minLevel = 35,
          giver = {
            name = "Prospecteur Foudrepique",
            where = "Forgefer",
            coords = "74.4, 12"
          },
          turnIn = {
            name = "Baelog",
            where = "Uldaman"
          },
          summary = "Trouver Baelog dans Uldaman.",
          xp = 315,
          money = "5s",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 2198,
          name = "Le Collier brisé",
          faction = "alliance",
          level = 41,
          minLevel = 37,
          turnIn = {
            name = "Talvash del Kissel",
            where = "Forgefer",
            coords = "36, 4"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Chercher celui qui a fabriqué le Collier brisé pour découvrir sa valeur potentielle.",
          objectives = {
            "Collier brisé (Fourni) (1)"
          },
          xp = 3300,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 2283,
          name = "Réparer le Collier",
          faction = "horde",
          level = 41,
          minLevel = 37,
          giver = {
            name = "Dran Droffers",
            where = "Orgrimmar",
            coords = "59.4, 36.8"
          },
          turnIn = {
            name = "Dran Droffers",
            where = "Orgrimmar",
            coords = "59.4, 36.8"
          },
          summary = "Rechercher dans l'excavation d'Uldaman un Collier de prix et le rapporter à Dran Droffers à Orgrimmar. Ce Collier peut être endommagé.",
          objectives = {
            "Collier brisé (1)"
          },
          xp = 2450,
          money = "Aucun",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 75
            }
          }
        },
        {
          id = 2202,
          name = "Rechercher les composants à Uldaman",
          faction = "horde",
          level = 42,
          minLevel = 36,
          giver = {
            name = "Jarkal Fondemousse",
            where = "Terres ingrates",
            coords = "2.6, 46"
          },
          turnIn = {
            name = "Jarkal Fondemousse",
            where = "Terres ingrates",
            coords = "2.6, 46"
          },
          summary = "Apporter 12 Champignons magenta à Jarkal Fondemousse à Kargath.",
          objectives = {
            "Champignon magenta (12)"
          },
          xp = 3450,
          money = "55s",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 17,
          name = "Rechercher les composants à Uldaman",
          faction = "alliance",
          level = 42,
          minLevel = 38,
          giver = {
            name = "Ghak Touchesoins",
            where = "Loch Modan",
            coords = "37, 49.2"
          },
          turnIn = {
            name = "Ghak Touchesoins",
            where = "Loch Modan",
            coords = "37, 49.2"
          },
          summary = "Apporter 12 Champignons magenta à Ghak Touchesoins à Thelsamar.",
          objectives = {
            "Champignon magenta (12)"
          },
          xp = 3450,
          money = "55s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2342,
          name = "Des Trésors à recouvrer",
          faction = "horde",
          level = 43,
          minLevel = 33,
          giver = {
            name = "Patrick Garrett",
            where = "Fossoyeuse",
            coords = "62.6, 48.4"
          },
          turnIn = {
            name = "Patrick Garrett",
            where = "Fossoyeuse",
            coords = "62.6, 48.4"
          },
          summary = "Rapporter à Patrick Garrett, à Fossoyeuse, son Trésor de famille, qui se trouve dans le Coffre de famille dans le Hall commun sud d'Uldaman.",
          objectives = {
            "Trésor de la famille Garrett (1)"
          },
          xp = 3600,
          money = "60s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 100
            }
          }
        },
        {
          id = 1360,
          name = "Des Trésors à recouvrer",
          faction = "alliance",
          level = 43,
          minLevel = 33,
          giver = {
            name = "Krom Rudebras",
            where = "Forgefer",
            coords = "74.2, 9.8"
          },
          turnIn = {
            name = "Krom Rudebras",
            where = "Forgefer",
            coords = "74.2, 9.8"
          },
          summary = "Récupérer les biens de Krom Rudebras dans son coffre dans le hall commun nord d'Uldaman et les lui rapporter à Forgefer.",
          objectives = {
            "Trésor de Krom Rudebras (1)"
          },
          xp = 3600,
          money = "60s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          }
        },
        {
          id = 1139,
          name = "La tablette de volonté",
          faction = "alliance",
          level = 45,
          minLevel = 35,
          giver = {
            name = "Conseiller Belgrum",
            where = "Forgefer",
            coords = "77.2, 10"
          },
          turnIn = {
            name = "Conseiller Belgrum",
            where = "Forgefer",
            coords = "77.2, 10"
          },
          summary = "Trouver la Tablette de Volonté et la rapporter au Conseiller Belgrum à Forgefer.",
          objectives = {
            "Tablette de volonté (1)"
          },
          xp = 5850,
          money = "1g 30s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 200
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2278,
          name = "Les Disques de platine",
          faction = "both",
          level = 47,
          minLevel = 40,
          giver = {
            name = "Les Disques de Norgannon",
            where = "Uldaman"
          },
          turnIn = {
            name = "Les Disques de Norgannon",
            where = "Uldaman"
          },
          summary = "Parler au Gardien des pierres pour connaître le Savoir qu'il défend. Une fois découvert ce qu'ils peuvent offrir, activer les Disques de Norgannon.",
          objectives = {
            "Apprendre quelles connaissances le Gardien des pierres peut offrir (1)"
          },
          xp = 4200,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        }
      }
    },
    {
      id = "zf",
      slug = "zul-farrak",
      order = 18,
      name = "Zul'Farrak",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 44,
        max = 54
      },
      levelFinder = 42,
      levelEntry = 39,
      players = "5",
      zone = "Tanaris",
      faction = "Horde / Alliance",
      bosses = {
        {
          name = "Antu'sul"
        },
        {
          name = "Theka le Martyr",
          nameEn = "Theka the Martyr"
        },
        {
          name = "Sorcier-docteur Zum'rah",
          nameEn = "Witch Doctor Zum'rah"
        },
        {
          name = "Hydromancienne Velratha",
          nameEn = "Hydromancer Velratha"
        },
        {
          name = "Gahz'rilla"
        },
        {
          name = "Nekrum Mâchetripes",
          nameEn = "Nekrum Gutchewer"
        },
        {
          name = "Prêtre des ombres Sezz'ziz",
          nameEn = "Shadowpriest Sezz'ziz"
        },
        {
          name = "Chef Ukorz Scalpessable",
          nameEn = "Chief Ukorz Sandscalp"
        },
        {
          name = "Ruuzlu"
        }
      },
      quests = {
        {
          id = 3042,
          name = "Agent durcissant troll",
          faction = "both",
          level = 45,
          minLevel = 40,
          giver = {
            name = "Trenton Martelume",
            where = "Tanaris",
            coords = "51.4, 28.6"
          },
          turnIn = {
            name = "Trenton Martelume",
            where = "Tanaris",
            coords = "51.4, 28.6"
          },
          summary = "Apporter 20 Fioles d'agent durcissant troll à Trenton Martelume, dans Gadgetzan.",
          objectives = {
            "Agent durcissant troll (20)"
          },
          xp = 3900,
          money = "1g 95s"
        },
        {
          id = 2936,
          name = "Le dieu-araignée",
          faction = "horde",
          level = 45,
          minLevel = 40,
          giver = {
            name = "Maître Gadrin",
            where = "Durotar",
            coords = "56, 74.6"
          },
          turnIn = {
            name = "Maître Gadrin",
            where = "Durotar",
            coords = "56, 74.6"
          },
          summary = "Lire la Tablette de Theka pour connaître le véritable nom du dieu-araignée des Fanécorce, puis retourner voir Maître Gadrin.",
          objectives = {
            "Retrouver le nom du dieu-araignée (1)"
          },
          xp = 4850,
          money = "Aucun",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2865,
          name = "Les carapaces de Scarabées",
          faction = "both",
          level = 45,
          minLevel = 40,
          giver = {
            name = "Tran'rek",
            where = "Tanaris",
            coords = "51.6, 26.8"
          },
          turnIn = {
            name = "Tran'rek",
            where = "Tanaris",
            coords = "51.6, 26.8"
          },
          summary = "Rapporter 5 Carapaces de scarabée intactes à Tran'rek à Gadgetzan.",
          objectives = {
            "Carapace de scarabée intacte (5)"
          },
          xp = 3900,
          money = "65s",
          reputation = {
            {
              faction = "Gadgetzan",
              amount = 100
            }
          }
        },
        {
          id = 2846,
          name = "La tiare des abysses",
          faction = "both",
          level = 46,
          minLevel = 40,
          giver = {
            name = "Tabetha",
            where = "Marécage d'Âprefange",
            coords = "46, 57"
          },
          turnIn = {
            name = "Tabetha",
            where = "Marécage d'Âprefange",
            coords = "46, 57"
          },
          summary = "Rapporter la Tiare des abysses à Tabetha au marécage d'Âprefange.",
          objectives = {
            "Tiare des abysses (1)"
          },
          xp = 6050,
          money = "65s"
        },
        {
          id = 3527,
          name = "La prophétie de Mosh'aru",
          faction = "both",
          level = 47,
          minLevel = 40,
          giver = {
            name = "Yeh'kinya",
            where = "Tanaris",
            coords = "67, 22.4"
          },
          turnIn = {
            name = "Yeh'kinya",
            where = "Tanaris",
            coords = "67, 22.4"
          },
          summary = "Apporter les Première et Deuxième tablettes Mosh'Aru à Yeh'kinya, à Tanaris.",
          objectives = {
            "Première tablette Mosh'aru (1)",
            "Deuxième tablette Mosh'Aru (1)"
          },
          xp = 5250,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2768,
          name = "Le bâtonnet divino-matic",
          faction = "both",
          level = 47,
          minLevel = 40,
          giver = {
            name = "Ingénieur en chef Vizisanie",
            where = "Tanaris",
            coords = "52.4, 28.4"
          },
          turnIn = {
            name = "Ingénieur en chef Vizisanie",
            where = "Tanaris",
            coords = "52.4, 28.4"
          },
          summary = "Rapporter le Bâtonnet divino-matic à l'Ingénieur en chef Vizisanie, à Gadgetzan.",
          objectives = {
            "Bâtonnet divino-matic (1)"
          },
          xp = 6300,
          money = "Aucun",
          reputation = {
            {
              faction = "Gadgetzan",
              amount = 200
            }
          }
        },
        {
          id = 2991,
          name = "Médaillon de Nekrum",
          faction = "alliance",
          level = 47,
          minLevel = 40,
          giver = {
            name = "Thadius Sinissombre",
            where = "Terres foudroyées",
            coords = "67, 19.4"
          },
          turnIn = {
            name = "Thadius Sinissombre",
            where = "Terres foudroyées",
            coords = "67, 19.4"
          },
          summary = "Apporter le Médaillon de Nekrum à Thadius Sinissombre, dans les Terres foudroyées.",
          objectives = {
            "Médaillon de Nekrum (1)"
          },
          xp = 5250,
          money = "70s",
          reputation = {
            {
              faction = "Clan Marteau-Hardi",
              amount = 150
            },
            {
              faction = "Forgefer",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 2770,
          name = "Gahz'rilla",
          faction = "both",
          level = 50,
          minLevel = 40,
          giver = {
            name = "Lachnouf Zéboulon",
            where = "Mille pointes",
            coords = "78, 77"
          },
          turnIn = {
            name = "Lachnouf Zéboulon",
            where = "Mille pointes",
            coords = "78, 77"
          },
          summary = "Rapporter les Ecailles électrifiées de Gahz'rilla à Lachnouf Zéboulon dans les Salines.",
          objectives = {
            "Ecaille électrique de Gahz'rilla (1)"
          },
          xp = 7100,
          money = "75s"
        }
      }
    },
    {
      id = "mara",
      slug = "maraudon",
      order = 19,
      name = "Maraudon",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 46,
        max = 55
      },
      levelFinder = 42,
      levelEntry = 25,
      players = "5",
      zone = "Désolace",
      faction = "Horde / Alliance",
      note = "Toutes les ailes.",
      bosses = {
        {
          name = "Noxxion"
        },
        {
          name = "Tranchefouet",
          nameEn = "Razorlash"
        },
        {
          name = "Seigneur Vylelangue",
          nameEn = "Lord Vyletongue"
        },
        {
          name = "Celebras le Maudit",
          nameEn = "Celebras the Cursed"
        },
        {
          name = "Glissement de terrain",
          nameEn = "Landslide"
        },
        {
          name = "Artisan Gizlock",
          nameEn = "Tinkerer Gizlock"
        },
        {
          name = "Grippe-charogne",
          nameEn = "Rotgrip"
        },
        {
          name = "Princesse Theradras",
          nameEn = "Princess Theradras"
        }
      },
      quests = {
        {
          id = 7068,
          name = "Fragments d'Ombréclat",
          faction = "horde",
          level = 42,
          minLevel = 39,
          giver = {
            name = "Uthel'nay",
            where = "Orgrimmar",
            coords = "39, 86"
          },
          turnIn = {
            name = "Uthel'nay",
            where = "Orgrimmar",
            coords = "39, 86"
          },
          summary = "Collecter 10 Fragments d'Ombréclats dans Maraudon, et les ramener à Uthel'nay, à Orgrimmar.",
          objectives = {
            "Fragment Ombréclat (10)"
          },
          xp = 3450,
          money = "Aucun",
          reputation = {
            {
              faction = "Trolls Sombrelance",
              amount = 150
            }
          }
        },
        {
          id = 7070,
          name = "Fragments d'Ombréclat",
          faction = "alliance",
          level = 42,
          minLevel = 39,
          giver = {
            name = "Archimage Tervosh",
            where = "Marécage d'Âprefange",
            coords = "66.4, 49.2"
          },
          turnIn = {
            name = "Archimage Tervosh",
            where = "Marécage d'Âprefange",
            coords = "66.4, 49.2"
          },
          summary = "Collecter 10 Fragments d'Ombréclats, et les porter à l'archimage Tervosh, dans le marécage d'Âprefange.",
          objectives = {
            "Fragment Ombréclat (10)"
          },
          xp = 3450,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 150
            }
          }
        },
        {
          id = 7028,
          name = "Forces maléfiques retorses",
          faction = "both",
          level = 47,
          minLevel = 41,
          giver = {
            name = "Saule",
            where = "Désolace",
            coords = "62.2, 39.6"
          },
          turnIn = {
            name = "Saule",
            where = "Désolace",
            coords = "62.2, 39.6"
          },
          summary = "Collecter 25 Ciselures de Cristaux Théradriques pour Saule, en Désolace.",
          objectives = {
            "Gravure de cristal théradrique (25)"
          },
          xp = 5250,
          money = "Aucun"
        },
        {
          id = 7029,
          name = "La corruption de Vylelangue",
          faction = "horde",
          level = 47,
          minLevel = 41,
          giver = {
            name = "Vark Balafre-glorieuse",
            where = "Désolace",
            coords = "23.2, 70.2"
          },
          turnIn = {
            name = "Vark Balafre-glorieuse",
            where = "Désolace",
            coords = "23.2, 70.2"
          },
          summary = "Remplir la Fiole céruléenne renforcée, au Bassin de cristal orange, dans Maraudon. En faire usage sur les Vignes de Vylevrille pour forcer les Engeances de Noxxious corrompues à en sortir. Soigner 8 plantes en tuant les Engeances de Noxxious, puis retourner voir Vark Balafre-glorieuse, à Proie-de-l'Ombre.",
          objectives = {
            "Vignes de Vylevrille soignées (8)",
            "Fiole céruléenne remplie (1)",
            "Fiole céruléenne renforcée (1)"
          },
          xp = 5250,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 7041,
          name = "La corruption de Vylelangue",
          faction = "alliance",
          level = 47,
          minLevel = 41,
          giver = {
            name = "Talendria",
            where = "Désolace",
            coords = "68.4, 8.8"
          },
          turnIn = {
            name = "Talendria",
            where = "Désolace",
            coords = "68.4, 8.8"
          },
          summary = "Remplir la Fiole céruléenne renforcée, au Bassin de cristal orange dans Maraudon. En faire usage sur les vignes de Vylevrille pour forcer les Engeances de Noxxious corrompues à en sortir. Soigner 8 plantes en tuant les Engeances, puis retourner voir Taliendra, à la Combe de Nijel.",
          objectives = {
            "Vignes de Vylevrille soignées (8)",
            "Fiole céruléenne remplie (1)",
            "Fiole céruléenne renforcée (1)"
          },
          xp = 5250,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 7067,
          name = "Les instructions du paria",
          faction = "both",
          level = 48,
          minLevel = 39,
          giver = {
            name = "Paria centaure",
            where = "Désolace",
            coords = "50.4, 86.6"
          },
          turnIn = {
            name = "Paria centaure",
            where = "Désolace",
            coords = "50.4, 86.6"
          },
          summary = "Lire les instructions du paria. Après cela, obtenir l'Amulette d'union de Maraudon et la ramener au centaure renégat, dans le sud de Désolace.",
          objectives = {
            "Amulette d'union (1)",
            "Amulette des esprits (1)",
            "Les instructions du Paria (1)"
          },
          xp = 5450,
          money = "1g 40s",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 7046,
          name = "Le sceptre de Celebras",
          faction = "both",
          level = 49,
          minLevel = 41,
          giver = {
            name = "Celebras le Racheté",
            where = "Maraudon"
          },
          turnIn = {
            name = "Celebras le Racheté",
            where = "Maraudon"
          },
          summary = "Aidez Celebras le Racheté pendant qu'il recrée le Sceptre de Celebras. Parlez-lui après la réussite du rituel.",
          objectives = {
            "Créer le sceptre de Celebras (1)"
          },
          xp = 5700,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7044,
          name = "Légendes de Maraudon",
          faction = "both",
          level = 49,
          minLevel = 41,
          giver = {
            name = "Cavindra"
          },
          turnIn = {
            name = "Celebras le Racheté",
            where = "Maraudon"
          },
          summary = "Retrouver les deux parties du Sceptre de Celebras : le Bâtonnet de Celebras et le Diamant de Celebras. Trouvez un moyen de parler à Celebras.",
          objectives = {
            "Diamant de Celebras (1)",
            "Bâtonnet de Celebras (1)"
          },
          xp = 3400,
          money = "Aucun",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7065,
          name = "Corruption de la terre et de la Graine",
          faction = "alliance",
          level = 51,
          minLevel = 45,
          giver = {
            name = "Gardien Marandis",
            where = "Désolace",
            coords = "63.8, 10.6"
          },
          turnIn = {
            name = "Gardien Marandis",
            where = "Désolace",
            coords = "63.8, 10.6"
          },
          summary = "Tuer la princesse Theradras, et retourner voir le Gardien Marandis, à la Combe de Nijel en Désolace.",
          objectives = {
            "Princesse Theradras tué (1)"
          },
          xp = 6100,
          money = "Aucun",
          reputation = {
            {
              faction = "Cercle cénarien",
              amount = 150
            }
          }
        },
        {
          id = 7064,
          name = "Corruption de la terre et de la graine",
          faction = "horde",
          level = 51,
          minLevel = 45,
          giver = {
            name = "Selendra",
            where = "Désolace",
            coords = "26.8, 77.6"
          },
          turnIn = {
            name = "Selendra",
            where = "Désolace",
            coords = "26.8, 77.6"
          },
          summary = "Anéantir la princesse Theradras et retourner voir Selendra près de Proie-de-l'Ombre, en Désolace.",
          objectives = {
            "Princesse Theradras tué (1)"
          },
          xp = 6100,
          money = "Aucun",
          reputation = {
            {
              faction = "Cercle cénarien",
              amount = 150
            }
          }
        },
        {
          id = 7066,
          name = "Graine de vie",
          faction = "both",
          level = 51,
          minLevel = 39,
          giver = {
            name = "Esprit de Zaetar",
            where = "Maraudon"
          },
          turnIn = {
            name = "Gardien Remulos",
            where = "Reflet-de-Lune",
            coords = "36.2, 41.8"
          },
          summary = "Chercher Remulos à Reflet-de-Lune, et lui donner la Graine de vie.",
          objectives = {
            "Graine de vie (Fourni) (1)"
          },
          xp = 6100,
          money = "1g 50s",
          reputation = {
            {
              faction = "Cercle cénarien",
              amount = 150
            }
          },
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        }
      }
    },
    {
      id = "alcaz",
      slug = "prison-d-alcaz",
      order = 20,
      name = "Prison d'Alcaz",
      type = "dungeon",
      origin = "new",
      nameEn = "Alcaz Prison",
      levels = {
        min = 48,
        max = 53
      },
      players = "5",
      zone = "Marécage d'Âprefange",
      entry = "Île d'Alcaz, nord-est d'Âprefange",
      summary = "Niveaux 48 à 53, autrefois utilisée pour rançonner des nobles, où Varian Wrynn aurait été retenu. Defias et naga s'y affrontent désormais, ce qui ouvre une porte d'entrée.",
      bosses = {},
      quests = {}
    },
    {
      id = "st",
      slug = "le-temple-d-atal-hakkar",
      order = 21,
      name = "Le temple d'Atal'Hakkar",
      type = "dungeon",
      origin = "classic",
      nameEn = "Sunken Temple",
      levels = {
        min = 50,
        max = 60
      },
      levelFinder = 45,
      levelEntry = 45,
      players = "5",
      zone = "Marais des Chagrins",
      faction = "Horde / Alliance",
      bosses = {
        {
          name = "Atal'alarion"
        },
        {
          name = "Tisserand",
          nameEn = "Weaver"
        },
        {
          name = "Fauche-rêve",
          nameEn = "Dreamscythe"
        },
        {
          name = "Jammal'an le prophète",
          nameEn = "Jammal'an the Prophet"
        },
        {
          name = "Ogom le Misérable",
          nameEn = "Ogom the Wretched"
        },
        {
          name = "Morphaz"
        },
        {
          name = "Hazzas"
        },
        {
          name = "Avatar d'Hakkar",
          nameEn = "Avatar of Hakkar"
        },
        {
          name = "Ombre d'Eranikus",
          nameEn = "Shade of Eranikus"
        }
      },
      quests = {
        {
          id = 1475,
          name = "Dans le temple d'Atal'Hakkar",
          faction = "alliance",
          level = 50,
          minLevel = 38,
          giver = {
            name = "Brohann Ventrabière",
            where = "Hurlevent",
            coords = "64.2, 20.8"
          },
          turnIn = {
            name = "Brohann Ventrabière",
            where = "Hurlevent",
            coords = "64.2, 20.8"
          },
          summary = "Rassembler 10 Tablettes atal'ai pour Brohann Ventrabière à Hurlevent.",
          objectives = {
            "Tablette atal'ai (10)"
          },
          xp = 7100,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 200
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 1445,
          name = "Le temple d'Atal'Hakkar",
          faction = "horde",
          level = 50,
          minLevel = 38,
          giver = {
            name = "Fel'zerul",
            where = "Marais des Chagrins",
            coords = "48, 55"
          },
          turnIn = {
            name = "Fel'zerul",
            where = "Marais des Chagrins",
            coords = "48, 55"
          },
          summary = "Rassembler 20 Fétiches d'Hakkar et les apporter à Fel’Zerul à Pierrêche.",
          objectives = {
            "Fétiche d'Hakkar (20)"
          },
          xp = 5900,
          money = "Aucun",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 3446,
          name = "Dans les profondeurs",
          faction = "both",
          level = 51,
          minLevel = 46,
          giver = {
            name = "Marvon Chercherivet",
            where = "Tanaris",
            coords = "52.6, 45.8"
          },
          turnIn = {
            name = "Autel d'Hakkar",
            where = "Le temple d'Atal'Hakkar"
          },
          summary = "Trouver l'Autel d'Hakkar dans le Temple englouti du marais des Chagrins.",
          objectives = {
            "Cercle de pierres atal'ai (Fourni) (1)"
          },
          xp = 4900,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 3447,
          name = "Le secret du cercle",
          faction = "both",
          level = 51,
          minLevel = 46,
          giver = {
            name = "Marvon Chercherivet",
            where = "Tanaris",
            coords = "52.6, 45.8"
          },
          turnIn = {
            name = "Idole d'Hakkar",
            where = "Le temple d'Atal'Hakkar"
          },
          summary = "Voyager jusqu'au Temple englouti et découvrir le secret du cercle de statues.",
          xp = 6100,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4143,
          name = "Brouillard maléfique",
          faction = "alliance",
          level = 52,
          minLevel = 47,
          giver = {
            name = "Gregan Gerbebière",
            where = "Féralas",
            coords = "45, 25.4"
          },
          turnIn = {
            name = "Muigin",
            where = "Cratère d'Un'Goro",
            coords = "43, 9.6"
          },
          summary = "Récupérer 5 Echantillons de brume atal'ai puis retourner voir Muigin dans le cratère d'Un'Goro.",
          objectives = {
            "Brume atal'ai (5)"
          },
          xp = 5100,
          money = "75s",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4146,
          name = "Carburant de baguette",
          faction = "horde",
          level = 52,
          minLevel = 47,
          giver = {
            name = "Liv Rafistolier",
            where = "Les Tarides",
            coords = "62.4, 38.6"
          },
          turnIn = {
            name = "Larion",
            where = "Cratère d'Un'Goro",
            coords = "45.6, 8.6"
          },
          summary = "Remettre la Baguette déchargée et 5 Echantillons de brume atal'ai à Larion au refuge des Marshal.",
          objectives = {
            "Baguette déchargée (Fourni) (1)",
            "Brume atal'ai (5)"
          },
          xp = 5100,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 1446,
          name = "Jammal'an le Prophète",
          faction = "both",
          level = 53,
          minLevel = 38,
          giver = {
            name = "Exilé atal'ai",
            where = "Les Hinterlands",
            coords = "33.6, 75.2"
          },
          turnIn = {
            name = "Exilé atal'ai",
            where = "Les Hinterlands",
            coords = "33.6, 75.2"
          },
          summary = "L'Exilé atal'ai des Hinterlands veut la Tête de Jammal'an.",
          objectives = {
            "Tête de Jammal'an (1)"
          },
          xp = 6550,
          money = "Aucun"
        },
        {
          id = 3528,
          name = "Le dieu Hakkar",
          faction = "both",
          level = 53,
          minLevel = 40,
          giver = {
            name = "Yeh'kinya",
            where = "Tanaris",
            coords = "67, 22.4"
          },
          turnIn = {
            name = "Yeh'kinya",
            where = "Tanaris",
            coords = "67, 22.4"
          },
          summary = "Apporter l'Oeuf Rempli d'Hakkar à Yeh'kinya dans Tanaris.",
          objectives = {
            "Oeuf d'Hakkar rempli (1)",
            "Essence d'Hakkar (1)",
            "Oeuf d'Hakkar (1)"
          },
          xp = 7900,
          money = "2g 40s",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 3373,
          name = "L'Essence d'Eranikus",
          faction = "both",
          level = 55,
          minLevel = 48,
          turnIn = {
            name = "Réceptacle d'essence",
            where = "Le temple d'Atal'Hakkar"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Placer l'Essence d'Eranikus dans le Réceptacle d'essence situé dans son antre dans le Temple englouti.",
          objectives = {
            "Essence d'Eranikus (Fourni) (1)"
          },
          xp = 2800,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        }
      }
    },
    {
      id = "brd",
      slug = "profondeurs-de-blackrock",
      order = 22,
      name = "Profondeurs de Rochenoire",
      type = "dungeon",
      origin = "classic",
      nameEn = "Blackrock Depths",
      levels = {
        min = 52,
        max = 60
      },
      levelFinder = 48,
      levelEntry = 42,
      players = "5",
      zone = "Mont Rochenoire",
      faction = "Horde / Alliance",
      bossCount = 21,
      bosses = {
        {
          name = "Seigneur Roccor",
          nameEn = "Lord Roccor"
        },
        {
          name = "Bael'Gar"
        },
        {
          name = "Maître-chien Grebmar",
          nameEn = "Houndmaster Grebmar"
        },
        {
          name = "Grand Interrogateur Gerstahn",
          nameEn = "High Interrogator Gerstahn"
        },
        {
          name = "Anub'shiah, Éviscérateur, Gorosh le Derviche, Grison, Hedrum le Rampant ou Ok'thor le Briseur"
        },
        {
          name = "Pyromancien Blé-du-savoir",
          nameEn = "Pyromancer Loregrain"
        },
        {
          name = "Seigneur Incendius",
          nameEn = "Lord Incendius"
        },
        {
          name = "Gardien Stilgiss",
          nameEn = "Warder Stilgiss"
        },
        {
          name = "Verek"
        },
        {
          name = "Fineous Sombrevire",
          nameEn = "Fineous Darkvire"
        },
        {
          name = "Général Forgehargne",
          nameEn = "General Angerforge"
        },
        {
          name = "Seigneur golem Argelmach",
          nameEn = "Golem Lord Argelmach"
        },
        {
          name = "Hurley Soufflenoir",
          nameEn = "Hurley Blackbreath"
        },
        {
          name = "Phalange",
          nameEn = "Phalanx"
        },
        {
          name = "Lanfiche Brouillecircuit",
          nameEn = "Plugger Spazzring"
        },
        {
          name = "Ribbly Fermevanne",
          nameEn = "Ribbly Screwspigot"
        },
        {
          name = "Ambassadeur Cinglefouet",
          nameEn = "Ambassador Flamelash"
        },
        {
          name = "Les Sept : Haine'rel, Colé'rel, Ignobl'rel, Funéb'rel, Fulmi'rel, Tragi'rel, Demeu'rel"
        },
        {
          name = "Magmus"
        },
        {
          name = "Empereur Dagran Thaurissan",
          nameEn = "Emperor Dagran Thaurissan"
        },
        {
          name = "Princesse Moira Barbe-de-bronze",
          nameEn = "Princess Moira Bronzebeard"
        }
      },
      quests = {
        {
          id = 3906,
          name = "Discordance des flammes",
          faction = "horde",
          level = 52,
          minLevel = 48,
          giver = {
            name = "Cœur-de-tonnerre",
            where = "Terres ingrates",
            coords = "3.4, 48.2"
          },
          turnIn = {
            name = "Cœur-de-tonnerre",
            where = "Terres ingrates",
            coords = "3.4, 48.2"
          },
          summary = "Partir pour la carrière dans le mont Rochenoire et tuer le Grand maître Pyron. Retourner voir Cœur-de-tonnerre une fois votre mission accomplie.",
          objectives = {
            "Grand seigneur Pyron tué (1)"
          },
          xp = 5100,
          money = "1g 55s",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 100
            }
          }
        },
        {
          id = 4262,
          name = "Grand seigneur Pyron",
          faction = "alliance",
          level = 52,
          minLevel = 48,
          giver = {
            name = "Jalinda Brindille",
            where = "Steppes ardentes",
            coords = "85.4, 70"
          },
          turnIn = {
            name = "Jalinda Brindille",
            where = "Steppes ardentes",
            coords = "85.4, 70"
          },
          summary = "Tuer le Grand seigneur Pyron et retourner voir Jalinda Brindille. Jalinda vous a dit qu'il gardait la carrière. Peut-être devriez-vous chercher à cet endroit ?",
          objectives = {
            "Grand seigneur Pyron tué (1)"
          },
          xp = 5100,
          money = "1g 55s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        },
        {
          id = 3802,
          name = "Héritage Sombrefer",
          faction = "both",
          level = 52,
          minLevel = 48,
          giver = {
            name = "Franclorn Le Forgebusier"
          },
          turnIn = {
            name = "Monument de Franclorn Le Forgebusier",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Tuer Fineous Sombrevire et récupérer le grand marteau, Souillefer. Apporter Souillefer au sanctuaire de Thaurissan et le placer sur la statue de Franclorn Le Forgebusier.",
          objectives = {
            "Souillefer (1)"
          },
          xp = 5100,
          money = "2g 30s",
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 3981,
          name = "Le commandant Gor'shak",
          faction = "horde",
          level = 52,
          minLevel = 48,
          giver = {
            name = "Galamav le Tireur d'élite",
            where = "Terres ingrates",
            coords = "5.8, 47.6"
          },
          turnIn = {
            name = "Commandant Gor'shak",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Trouver le commandant Gor'shak dans les Profondeurs de Blackrock. Le dessin grossier représentait également des barreaux. Peut-être devriez-vous rechercher un genre de prison.",
          xp = 5100,
          money = "Aucun",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4081,
          name = "TUER A VUE : nains Sombrefer",
          faction = "horde",
          level = 52,
          minLevel = 48,
          giver = {
            name = "RECHERCHE",
            where = "Terres ingrates",
            coords = "3.8, 47.5"
          },
          turnIn = {
            name = "Seigneur de guerre Sangredent",
            where = "Terres ingrates",
            coords = "5.8, 47.4"
          },
          summary = "Pénétrer dans les Profondeurs de Blackrock et tuer les vils agresseurs ! Le seigneur de guerre Sangredent veut que vous tuiez 15 Gardes Ragenclumes, 10 Gardiens Ragenclumes et 5 Fantassins Ragenclumes. Retourner le voir une fois votre mission accomplie.",
          objectives = {
            "Garde Ragenclume tué (15)",
            "Gardien Ragenclume tué (10)",
            "Fantassin Ragenclume tué (5)"
          },
          xp = 5100,
          money = "1g 55s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          }
        },
        {
          id = 4136,
          name = "Ribbly Fermevanne",
          faction = "both",
          level = 53,
          minLevel = 48,
          giver = {
            name = "Yuka Fermevanne",
            where = "Steppes ardentes",
            coords = "66, 22"
          },
          turnIn = {
            name = "Yuka Fermevanne",
            where = "Steppes ardentes",
            coords = "66, 22"
          },
          summary = "Apporter la Tête de Ribbly à Yuka Fermevanne dans les Steppes ardentes.",
          objectives = {
            "Tête de Ribbly (1)"
          },
          xp = 2650,
          money = "60s"
        },
        {
          id = 7201,
          name = "Le dernier élément",
          faction = "horde",
          level = 54,
          minLevel = 48,
          giver = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          turnIn = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          summary = "Partir pour les Profondeurs de Blackrock et trouver 10 Essences des éléments. Commencer vos recherches par les golems et par les créateurs de golems. Vivian Lagrave a aussi marmonné quelque chose à propos d'élémentaires.",
          objectives = {
            "Essence des éléments (10)"
          },
          xp = 5450,
          money = "2g 45s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4201,
          name = "Le philtre d'amour",
          faction = "both",
          level = 54,
          minLevel = 50,
          giver = {
            name = "Gouvernante Nagmara",
            where = "Profondeurs de Rochenoire"
          },
          turnIn = {
            name = "Gouvernante Nagmara",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Apporter 4 Gromsang, 10 Veines d'argent de géant et la Fiole de Nagmara remplie à la gouvernante Nagmara dans les Profondeurs de Blackrock.",
          objectives = {
            "Gromsang (4)",
            "Veine d'argent de géant (10)",
            "Fiole de Nagmara remplie (1)",
            "Fiole de Nagmara (1)"
          },
          xp = 5450,
          money = "80s",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4241,
          name = "Maréchal Windsor",
          faction = "alliance",
          level = 54,
          minLevel = 48,
          giver = {
            name = "Maréchal Maxwell",
            where = "Steppes ardentes",
            coords = "84.6, 68.8"
          },
          turnIn = {
            name = "Maréchal Windsor",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Partir pour le mont Rochenoire au nord-ouest et pénétrer dans les Profondeurs de Blackrock. Découvrir ce qu'il est advenu du Maréchal Windsor. Vous vous souvenez que John le Loqueteux a dit que Windsor avait été traîné en prison.",
          xp = 5450,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4082,
          name = "TUER A VUE : Officiers de haut rang Sombrefer",
          faction = "horde",
          level = 54,
          minLevel = 50,
          giver = {
            name = "TUER A VUE",
            where = "Terres ingrates",
            coords = "4, 46.8"
          },
          turnIn = {
            name = "Seigneur de guerre Sangredent",
            where = "Terres ingrates",
            coords = "5.8, 47.4"
          },
          summary = "Pénétrer dans les Profondeurs de Blackrock et tuer les vils agresseurs ! Le Seigneur de guerre Sangredent veut que vous tuiez 10 Médecins Ragenclumes, 10 Soldats Ragenclumes et 10 Officiers Ragenclumes. Retourner le voir une fois votre mission accomplie.",
          objectives = {
            "Médecin Ragenclume tué (10)",
            "Soldat Ragenclume tué (10)",
            "Officier Ragenclume tué (10)"
          },
          xp = 5450,
          money = "1g 65s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4126,
          name = "Hurley Soufflenoir",
          faction = "alliance",
          level = 55,
          minLevel = 50,
          giver = {
            name = "Ragnar Tonnebière",
            where = "Dun Morogh",
            coords = "46.8, 52.4"
          },
          turnIn = {
            name = "Ragnar Tonnebière",
            where = "Dun Morogh",
            coords = "46.8, 52.4"
          },
          summary = "Apporter la Recette perdue de la Tonnebière à Ragnar Tonnebière à Kharanos.",
          objectives = {
            "Recette perdue de la Tonnebière (1)"
          },
          xp = 7050,
          money = "1g 65s"
        },
        {
          id = 4134,
          name = "La recette perdue de la Tonnebière",
          faction = "horde",
          level = 55,
          minLevel = 50,
          giver = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          turnIn = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          summary = "Apporter la Recette perdue de la Tonnebière à Vivian Lagrave à Kargath.",
          objectives = {
            "Recette perdue de la Tonnebière (1)"
          },
          xp = 5650,
          money = "85s"
        },
        {
          id = 4123,
          name = "Le Coeur de la montagne",
          faction = "both",
          level = 55,
          minLevel = 50,
          giver = {
            name = "Maxwort Uberbrille",
            where = "Steppes ardentes",
            coords = "65.2, 23.8"
          },
          turnIn = {
            name = "Maxwort Uberbrille",
            where = "Steppes ardentes",
            coords = "65.2, 23.8"
          },
          summary = "Apporter le Cœur de la montagne à Maxwort Uberbrille dans les Steppes ardentes.",
          objectives = {
            "Le Coeur de la montagne (1)"
          },
          xp = 5650,
          money = "85s"
        },
        {
          id = 3907,
          name = "Discordance des flammes",
          faction = "horde",
          level = 56,
          minLevel = 48,
          giver = {
            name = "Cœur-de-tonnerre",
            where = "Terres ingrates",
            coords = "3.4, 48.2"
          },
          turnIn = {
            name = "Cœur-de-tonnerre",
            where = "Terres ingrates",
            coords = "3.4, 48.2"
          },
          summary = "Pénétrer dans les Profondeurs de Blackrock et traquer le Seigneur Incendius. Le tuer puis donner tous les renseignements que vous pouvez trouver à Cœur-de-tonnerre.",
          objectives = {
            "Seigneur Incendius tué (1)",
            "Tablette de Kurniya (1)"
          },
          xp = 7300,
          money = "2g 55s",
          reputation = {
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 150
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4286,
          name = "Du beau matériel",
          faction = "alliance",
          level = 56,
          minLevel = 50,
          giver = {
            name = "Oralius",
            where = "Steppes ardentes",
            coords = "84.6, 68.6"
          },
          turnIn = {
            name = "Oralius",
            where = "Steppes ardentes",
            coords = "84.6, 68.6"
          },
          summary = "Se rendre dans les Profondeurs de Blackrock et trouver 20 Sacoches Sombrefer. Retourner voir Oralius lorsque vous aurez accompli cette tâche. Logiquement, ces sacoches devraient être sur les nains Sombrefer des Profondeurs de Blackrock.",
          objectives = {
            "Sacoche sombrefer (20)"
          },
          xp = 5800,
          money = "85s",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          }
        },
        {
          id = 4263,
          name = "Incendius !",
          faction = "alliance",
          level = 56,
          minLevel = 48,
          giver = {
            name = "Jalinda Brindille",
            where = "Steppes ardentes",
            coords = "85.4, 70"
          },
          turnIn = {
            name = "Jalinda Brindille",
            where = "Steppes ardentes",
            coords = "85.4, 70"
          },
          summary = "Trouver le Seigneur Incendius dans les Profondeurs de Blackrock et le détruire !",
          objectives = {
            "Seigneur Incendius tué (1)"
          },
          xp = 5800,
          money = "85s",
          reputation = {
            {
              faction = "Exilés de Gnomeregan",
              amount = 100
            }
          }
        },
        {
          id = 4322,
          name = "Evasion !",
          faction = "alliance",
          level = 58,
          minLevel = 50,
          giver = {
            name = "Maréchal Windsor",
            where = "Profondeurs de Rochenoire"
          },
          turnIn = {
            name = "Maréchal Maxwell",
            where = "Steppes ardentes",
            coords = "84.6, 68.8"
          },
          summary = "Aider le maréchal Windsor à récupérer son équipement et à libérer ses amis. Ensuite, retourner voir le maréchal Maxwell.",
          objectives = {
            "Evasion ! (1)"
          },
          xp = 7750,
          money = "1g 75s",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 150
            }
          },
          tags = {
            "Prérequis",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4063,
          name = "La révolte des machines",
          faction = "horde",
          level = 58,
          minLevel = 52,
          giver = {
            name = "Lotwil Veriatus",
            where = "Terres ingrates",
            coords = "25.8, 45"
          },
          turnIn = {
            name = "Lotwil Veriatus",
            where = "Terres ingrates",
            coords = "25.8, 45"
          },
          summary = "Trouver et tuer le seigneur des golems Argelmach. Rapporter sa tête à Lotwil. Collecter également 10 Noyaux d'élémentaire intacts sur les Golems ravarage et les Assemblages porteguerre qui protègent Argelmach. Vous savez cela car vous êtes médium.",
          objectives = {
            "Tête d'Argelmach (1)",
            "Noyau d'élémentaire intact (10)"
          },
          xp = 6200,
          money = "2g 65s",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4132,
          name = "Opération : Mort à Forgehargne",
          faction = "horde",
          level = 58,
          minLevel = 52,
          giver = {
            name = "Seigneur de guerre Sangredent",
            where = "Terres ingrates",
            coords = "5.8, 47.4"
          },
          turnIn = {
            name = "Seigneur de guerre Sangredent",
            where = "Terres ingrates",
            coords = "5.8, 47.4"
          },
          summary = "Voyagez jusqu'aux Profondeurs de Blackrock et tuez le général Forgehargne ! Une fois votre mission accomplie, retournez voir le seigneur de guerre Sangredent.",
          objectives = {
            "Général Forgehargne tué (1)"
          },
          xp = 7750,
          money = "2g 65s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 150
            }
          }
        },
        {
          id = 4024,
          name = "Un goût de flammes",
          faction = "both",
          level = 58,
          minLevel = 52,
          giver = {
            name = "Cyrus Lerepenti",
            where = "Steppes ardentes",
            coords = "94.8, 31.6"
          },
          turnIn = {
            name = "Cyrus Lerepenti",
            where = "Steppes ardentes",
            coords = "94.8, 31.6"
          },
          summary = "Partir pour les Profondeurs de Blackrock et tuer Bael'Gar. Vous savez seulement que le géant demeure à l'intérieur des Profondeurs de Blackrock. Se souvenir d'utiliser l'Ecaille des dragons noirs altérée pour capturer l'Essence ardente. Apporter l'Essence ardente recouverte à Cyrus Lerepenti.",
          objectives = {
            "Essence féerique enchâssée (1)",
            "Cuir de dragon noir altéré (1)"
          },
          xp = 6200,
          money = "2g 65s",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 4341,
          name = "Kharan Force-martel",
          faction = "alliance",
          level = 59,
          minLevel = 50,
          giver = {
            name = "Roi Magni Barbe-de-bronze",
            where = "Forgefer",
            coords = "39.4, 55.8"
          },
          turnIn = {
            name = "Kharan Force-martel",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Aller dans les Profondeurs de Blackrock et trouver Kharan Force-martel. Le roi a mentionné que Kharan était retenu prisonnier là-bas ; cherchez une prison.",
          xp = 6400,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 100
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4362,
          name = "Le destin du Royaume",
          faction = "alliance",
          level = 59,
          minLevel = 50,
          giver = {
            name = "Roi Magni Barbe-de-bronze",
            where = "Forgefer",
            coords = "39.4, 55.8"
          },
          turnIn = {
            name = "Princesse Moira Barbe-de-bronze",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Retourner dans les Profondeurs de Blackrock et secourir la Princesse Moira Barbe-de-bronze, prisonnière de l'Empereur Dagran Thaurissan.",
          objectives = {
            "Empereur Dagran Thaurissan tué (1)"
          },
          xp = 8050,
          money = "Aucun",
          reputation = {
            {
              faction = "Forgefer",
              amount = 150
            }
          },
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4003,
          name = "Un sauvetage royal",
          faction = "both",
          level = 59,
          minLevel = 48,
          giver = {
            name = "Thrall",
            where = "Orgrimmar",
            coords = "32, 37.8"
          },
          turnIn = {
            name = "Princesse Moira Barbe-de-bronze",
            where = "Profondeurs de Rochenoire"
          },
          summary = "Tuer l'Empereur Thaurissan et libérer la princesse Moira Barbe-de-bronze de son sort maléfique.",
          objectives = {
            "Empereur Dagran Thaurissan tué (1)"
          },
          xp = 8050,
          money = "Aucun",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7848,
          name = "Harmonisation avec le Cœur du Magma",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Lothos Ouvrefaille",
            where = "Steppes ardentes",
            coords = "26.4, 24.6"
          },
          turnIn = {
            name = "Lothos Ouvrefaille",
            where = "Steppes ardentes",
            coords = "26.4, 24.6"
          },
          summary = "Aventurez-vous jusqu'au portail d'entrée du Cœur du Magma dans les profondeurs de Blackrock et récupérez un Fragment du Magma. Lorsque ce sera fait, retournez voir Lothos Ouvrefaille au mont Rochenoire.",
          objectives = {
            "Fragment du Magma (1)"
          },
          xp = 6600,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        }
      }
    },
    {
      id = "brs",
      slug = "pic-rochenoire",
      order = 23,
      name = "Pic Rochenoire",
      type = "dungeon",
      origin = "classic",
      nameEn = "Blackrock Spire",
      levels = {
        min = 55,
        max = 60
      },
      levelFinder = 53,
      levelEntry = 48,
      players = "5",
      playersNote = "UBRS : 10 joueurs dans le client Forever",
      zone = "Mont Rochenoire",
      faction = "Horde / Alliance",
      note = "LBRS et UBRS, les deux ailes.",
      bossCount = 14,
      bosses = {
        {
          name = "Généralissime Omokk",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Chasseresse des ombres Vosh'gajin",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Maître de guerre Voone",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Matriarche Couveuse",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Urok Hurleruine",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Intendant Zigris",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Halycon",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Gizrul l'esclavagiste",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Seigneur Wyrmthalak",
          wing = "Pic Rochenoire inférieur"
        },
        {
          name = "Pyrogarde Prophète ardent",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "Solakar Voluteflamme",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "Goraluk Brisenclume",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "Gyth",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "Chef de guerre Rend Main-noire",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "La Bête",
          wing = "Pic Rochenoire supérieur"
        },
        {
          name = "Général Drakkisath",
          wing = "Pic Rochenoire supérieur"
        }
      },
      quests = {
        {
          id = 6502,
          name = "Amulette drakefeu",
          faction = "alliance",
          level = 60,
          minLevel = 50,
          giver = {
            name = "Haleh",
            where = "Berceau-de-l'Hiver",
            coords = "54.4, 51.2"
          },
          turnIn = {
            name = "Haleh",
            where = "Berceau-de-l'Hiver",
            coords = "54.4, 51.2"
          },
          summary = "Récupérer le Sang du Champion des dragons noirs sur le général Drakkisath. Il se trouve dans sa salle du trône, derrière les Halls d'Ascension, sur le Pic Rochenoire.",
          objectives = {
            "Sang du Champion des dragons noirs (1)"
          },
          xp = 8300,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 5047,
          name = "Finkle Einhorn, à votre service !",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Finkle Einhorn",
            where = "Pic Rochenoire"
          },
          turnIn = {
            name = "Malyfous Sombremartel",
            where = "Berceau-de-l'Hiver",
            coords = "61, 38.6"
          },
          summary = "Parler à Malyfous Sombremartel à Long-guet.",
          objectives = {
            "Morceau de chair de la Bête luminescent (Fourni) (1)"
          },
          xp = 6600,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4735,
          name = "La collecte d'oeufs",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Brikolette Toutevapeur",
            where = "Steppes ardentes",
            coords = "65.2, 23.8"
          },
          turnIn = {
            name = "Brikolette Toutevapeur",
            where = "Steppes ardentes",
            coords = "65.2, 23.8"
          },
          summary = "Apporter 8 Oeufs de dragon collectés et le Module collectronique à Brikolette Toutevapeur à la Corniche des flammes dans les Steppes Ardentes.",
          objectives = {
            "Oeuf de dragon collecté (8)",
            "Module collectronique (Fourni) (1)"
          },
          xp = 9950,
          money = "2g 70s",
          reputation = {
            {
              faction = "Cartel Gentepression",
              amount = 200
            }
          },
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 5127,
          name = "La forge démoniaque",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Lorax",
            where = "Berceau-de-l'Hiver",
            coords = "63.8, 73.8"
          },
          turnIn = {
            name = "Lorax",
            where = "Berceau-de-l'Hiver",
            coords = "63.8, 73.8"
          },
          summary = "Se rendre au pic Rochenoire et trouver Goraluk Brisenclume. Le tuer puis utiliser la Pique tachée de sang sur son cadavre. Après avoir siphonné son âme, la pique sera devenue Tachée d'âme. Trouver aussi la Cuirasse couverte de runes inachevée. Rapporter la Pique tachée d'âme et la Cuirasse couverte de runes inachevée à Lorax au Berceau-de-l'Hiver.",
          objectives = {
            "Pique tachée d'âme (1)",
            "Plastron couvert de runes inachevé (1)",
            "Pique tachée de sang (1)"
          },
          xp = 8300,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable",
            "Réservée : Forgeron (métier)"
          }
        },
        {
          id = 5102,
          name = "La reddition du général Drakkisath",
          faction = "alliance",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Maréchal Maxwell",
            where = "Steppes ardentes",
            coords = "84.6, 68.8"
          },
          turnIn = {
            name = "Maréchal Maxwell",
            where = "Steppes ardentes",
            coords = "84.6, 68.8"
          },
          summary = "Rendez-vous au Pic Rochenoire et tuez le général Drakkisath, puis retournez voir le maréchal Maxwell.",
          objectives = {
            "Général Drakkisath tué (1)"
          },
          xp = 9950,
          money = "2g 70s",
          reputation = {
            {
              faction = "Alliance",
              amount = 200
            }
          },
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4768,
          name = "La tablette de Sombrepierre",
          faction = "horde",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          turnIn = {
            name = "Ombremage Vivian Lagrave",
            where = "Terres ingrates",
            coords = "3, 47.6"
          },
          summary = "Apporter la Tablette de Sombrepierre à l'ombremage Vivian Lagrave à Kargath.",
          objectives = {
            "Tablette de Sombrepierre (1)"
          },
          xp = 8300,
          money = "2g 70s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 150
            }
          }
        },
        {
          id = 5160,
          name = "Le Protectorat de la matrone",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Awbee",
            where = "Pic Rochenoire"
          },
          turnIn = {
            name = "Haleh",
            where = "Berceau-de-l'Hiver",
            coords = "54.4, 51.2"
          },
          summary = "Aller jusqu’au Berceau-de-l'Hiver et trouver Haleh. Lui donner l’Ecaille d'Awbee.",
          objectives = {
            "Ecaille d'Awbee (Fourni) (1)"
          },
          xp = 6600,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4764,
          name = "Le fermoir de Frèteruine",
          faction = "alliance",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Mayara Luisaile",
            where = "Steppes ardentes",
            coords = "84.8, 69"
          },
          turnIn = {
            name = "Mayara Luisaile",
            where = "Steppes ardentes",
            coords = "84.8, 69"
          },
          summary = "Apporter le Fermoir de Frèteruine à Mayara Luisaile, dans les Steppes ardentes.",
          objectives = {
            "Fermoir de Frèteruine (1)"
          },
          xp = 1650,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 25
            }
          }
        },
        {
          id = 6602,
          name = "Le sang du champion des dragons noirs",
          faction = "horde",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Rokaro",
            where = "Féralas",
            coords = "45.2, 2.6"
          },
          turnIn = {
            name = "Rokaro",
            where = "Féralas",
            coords = "45.2, 2.6"
          },
          summary = "Aller au Pic Rochenoire, et tuer le général Drakkisath. Récupérer son sang et retourner voir Rokaro.",
          objectives = {
            "Sang du Champion des dragons noirs (1)"
          },
          xp = 9950,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 7761,
          name = "Les ordres de Main-noire",
          faction = "both",
          level = 60,
          minLevel = 55,
          turnIn = {
            name = "Marque de Drakkisath",
            where = "Pic Rochenoire"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Cet orc est stupide. Il semble que vous deviez trouver un moyen d’obtenir la Marque de Drakkisath pour accéder à l’Orbe de commandement. D’après la lettre, la Marque est gardée par le général Drakkisath. Vous devriez peut-être enquêter.",
          xp = 6600,
          money = "Aucun",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 6821,
          name = "Oeil du Prophète ardent",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Duc Hydraxis",
            where = "Azshara",
            coords = "79.2, 73.6"
          },
          turnIn = {
            name = "Duc Hydraxis",
            where = "Azshara",
            coords = "79.2, 73.6"
          },
          summary = "Apporter l’Oeil du Prophète ardent au duc Hydraxis, en Azshara.",
          objectives = {
            "Oeil du Prophète ardent (1)"
          },
          xp = 8300,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 4974,
          name = "Pour la Horde !",
          faction = "horde",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Thrall",
            where = "Orgrimmar",
            coords = "32, 37.8"
          },
          turnIn = {
            name = "Thrall",
            where = "Orgrimmar",
            coords = "32, 37.8"
          },
          summary = "Aller au Pic Rochenoire et tuer le Chef de guerre, Rend Main-noire. Prendre sa tête et retourner à Orgrimmar.",
          objectives = {
            "Tête de Rend Main-noire (1)"
          },
          xp = 9950,
          money = "2g 70s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 200
            },
            {
              faction = "Trolls Sombrelance",
              amount = 200
            },
            {
              faction = "Fossoyeuse",
              amount = 200
            },
            {
              faction = "Les Pitons-du-Tonnerre",
              amount = 200
            }
          },
          tags = {
            "Prérequis"
          }
        }
      }
    },
    {
      id = "bh",
      slug = "fort-machoire-noire",
      order = 24,
      name = "Fort Mâchoire-Noire",
      type = "dungeon",
      origin = "new",
      nameEn = "Blackmaw Hold",
      levels = {
        min = 55,
        max = 60
      },
      players = "5",
      zone = "Azshara",
      entry = "Derrière les portes furbolgs, nord d'Azshara",
      summary = "Niveaux 55 à 60, derrière la porte d'Azshara qui n'a jamais été ouverte. Une cité furbolg qui lutte contre sa propre corruption, avec des tunnels qui rejoignent les Fosses ancestrales.",
      bosses = {},
      quests = {}
    },
    {
      id = "dire",
      slug = "hache-tripes",
      order = 25,
      name = "Hache-tripes",
      type = "dungeon",
      origin = "classic",
      nameEn = "Dire Maul",
      levels = {
        min = 58,
        max = 60
      },
      levelFinder = 54,
      levelEntry = 31,
      players = "5",
      zone = "Féralas",
      faction = "Horde / Alliance",
      note = "Toutes les ailes.",
      bossCount = 19,
      bosses = {
        {
          name = "Pusillin",
          wing = "Est (quartier de Crochebois)"
        },
        {
          name = "Zevrim Sabot-de-ronce",
          nameEn = "Zevrim Thornhoof",
          wing = "Est (quartier de Crochebois)"
        },
        {
          name = "Hydrogénos",
          nameEn = "Hydrospawn",
          wing = "Est (quartier de Crochebois)"
        },
        {
          name = "Lethtendris",
          wing = "Est (quartier de Crochebois)"
        },
        {
          name = "Alzzin le Modeleur",
          nameEn = "Alzzin the Wildshaper",
          wing = "Est (quartier de Crochebois)"
        },
        {
          name = "Tendris Crochebois",
          nameEn = "Tendris Warpwood",
          wing = "Ouest (jardins de la Capitale)"
        },
        {
          name = "Illyanna Corvichêne",
          nameEn = "Illyanna Ravenoak",
          wing = "Ouest (jardins de la Capitale)"
        },
        {
          name = "Magistère Kalendris",
          nameEn = "Magister Kalendris",
          wing = "Ouest (jardins de la Capitale)"
        },
        {
          name = "Immol'thar",
          wing = "Ouest (jardins de la Capitale)"
        },
        {
          name = "Prince Tortheldrin",
          wing = "Ouest (jardins de la Capitale)"
        },
        {
          name = "Garde Mol'dar",
          nameEn = "Guard Mol'dar",
          wing = "Nord (quartiers gordok)"
        },
        {
          name = "Garde Fengus",
          nameEn = "Guard Fengus",
          wing = "Nord (quartiers gordok)"
        },
        {
          name = "Garde Slip'kik",
          nameEn = "Guard Slip'kik",
          wing = "Nord (quartiers gordok)"
        },
        {
          name = "Capitaine Kromcrush",
          nameEn = "Captain Kromcrush",
          wing = "Nord (quartiers gordok)"
        },
        {
          name = "Cho'Rush l'Observateur",
          nameEn = "Cho'Rush the Observer",
          wing = "Nord (quartiers gordok)"
        },
        {
          name = "Roi Gordok",
          nameEn = "King Gordok",
          wing = "Nord (quartiers gordok)"
        }
      },
      quests = {
        {
          id = 7489,
          name = "Le filet de Lethtendris",
          faction = "horde",
          level = 57,
          minLevel = 54,
          giver = {
            name = "Talo Sabot-de-ronce",
            where = "Féralas",
            coords = "76, 43.8"
          },
          turnIn = {
            name = "Talo Sabot-de-ronce",
            where = "Féralas",
            coords = "76, 43.8"
          },
          summary = "Ramenez le Filet de Lethtendris à Talo Sabot-de-ronce au Camp Mojache, en Féralas.",
          objectives = {
            "Filet de Lethtendris (1)"
          },
          xp = 7550,
          money = "1g 70s",
          reputation = {
            {
              faction = "Horde",
              amount = 150
            }
          },
          part = "Est (quartier de Crochebois)"
        },
        {
          id = 7488,
          name = "Le filet de Lethtendris",
          faction = "alliance",
          level = 57,
          minLevel = 54,
          giver = {
            name = "Latronicus Lancelune",
            where = "Féralas",
            coords = "30.4, 46"
          },
          turnIn = {
            name = "Latronicus Lancelune",
            where = "Féralas",
            coords = "30.4, 46"
          },
          summary = "Ramenez le Filet de Lethtendris à Latronicus Lancelune au bastion de Pennelune en Féralas.",
          objectives = {
            "Filet de Lethtendris (1)"
          },
          xp = 7550,
          money = "1g 70s",
          reputation = {
            {
              faction = "Alliance",
              amount = 150
            }
          },
          part = "Est (quartier de Crochebois)"
        },
        {
          id = 4788,
          name = "Les dernières tablettes",
          faction = "both",
          level = 58,
          minLevel = 40,
          giver = {
            name = "Prospecteur Botte-de-fer",
            where = "Tanaris",
            coords = "66.8, 24"
          },
          turnIn = {
            name = "Prospecteur Botte-de-fer",
            where = "Tanaris",
            coords = "66.8, 24"
          },
          summary = "Apporter la cinquième et la sixième Tablette Mosh'aru au Prospecteur Botte-de-fer à Tanaris.",
          objectives = {
            "Cinquième tablette Mosh'aru (1)",
            "Sixième tablette Mosh'aru (1)"
          },
          xp = 7750,
          money = "Aucun",
          part = "Nord (quartiers gordok)",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 7441,
          name = "Pusillin et l'Ancien Azj'Tordin",
          faction = "both",
          level = 58,
          minLevel = 54,
          giver = {
            name = "Azj'Tordin",
            where = "Féralas",
            coords = "76.8, 37.4"
          },
          turnIn = {
            name = "Azj'Tordin",
            where = "Féralas",
            coords = "76.8, 37.4"
          },
          summary = "Rendez-vous à Hache-tripes et trouvez le diablotin Pusillin. Persuadez-le par tous les moyens de vous rendre le Livre d’Incantations d’Azj’Tordin. Si vous parvenez à le récupérer, retournez voir Azj’Tordin au Pavillon de Lariss, en Féralas.",
          objectives = {
            "Livre des Incantations (1)"
          },
          xp = 7750,
          money = "1g 75s",
          reputation = {
            {
              faction = "Shen'dralar",
              amount = 200
            }
          },
          part = "Est (quartier de Crochebois)"
        },
        {
          id = 4701,
          name = "Abattez-la",
          faction = "alliance",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Helendis Ruissecorne",
            where = "Steppes ardentes",
            coords = "85.6, 69"
          },
          turnIn = {
            name = "Helendis Ruissecorne",
            where = "Steppes ardentes",
            coords = "85.6, 69"
          },
          summary = "Allez au Pic Rochenoire et anéantir la menace worg à sa source. Tandis que vous quittiez Helendis, il a crié un nom : Halycon. C'est ce que disent les orcs en parlant des worgs.",
          objectives = {
            "Halycon tué (1)"
          },
          xp = 6400,
          money = "1g 80s",
          reputation = {
            {
              faction = "Darnassus",
              amount = 100
            }
          },
          part = "Nord (quartiers gordok)"
        },
        {
          id = 4981,
          name = "Agent Bijou",
          faction = "horde",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Lexlort",
            where = "Terres ingrates",
            coords = "5.8, 47.6"
          },
          turnIn = {
            name = "Bijou",
            where = "Pic Rochenoire"
          },
          summary = "Aller au Pic Rochenoire et découvrir ce qui est arrivé à Bijou.",
          xp = 6400,
          money = "Aucun",
          reputation = {
            {
              faction = "Baie-du-Butin",
              amount = 100
            },
            {
              faction = "La Voile sanglante",
              amount = -500
            }
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4724,
          name = "La maîtresse de meute",
          faction = "horde",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Galamav le Tireur d'élite",
            where = "Terres ingrates",
            coords = "5.8, 47.6"
          },
          turnIn = {
            name = "Galamav le Tireur d'élite",
            where = "Terres ingrates",
            coords = "5.8, 47.6"
          },
          summary = "Tuer Halycon, la maîtresse de la meute des worgs Hache-sanglante.",
          objectives = {
            "Halycon tué (1)"
          },
          xp = 6400,
          money = "1g 80s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 100
            }
          },
          part = "Nord (quartiers gordok)"
        },
        {
          id = 4729,
          name = "Les animaux exotiques de Kibler",
          faction = "both",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Kibler",
            where = "Steppes ardentes",
            coords = "65.8, 22"
          },
          turnIn = {
            name = "Kibler",
            where = "Steppes ardentes",
            coords = "65.8, 22"
          },
          summary = "Aller au Pic Rochenoire et trouver de Jeunes worgs Hache-sanglante. Utiliser la cage pour transporter ces petites bêtes féroces. Rapporter un Jeune worg en cage à Kibler.",
          objectives = {
            "Jeune worg en cage (1)",
            "Cage de jeune worg vide (1)"
          },
          xp = 6400,
          money = "90s",
          part = "Nord (quartiers gordok)",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 5001,
          name = "Les effets de Bijou",
          faction = "alliance",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Bijou",
            where = "Pic Rochenoire"
          },
          turnIn = {
            name = "Bijou",
            where = "Pic Rochenoire"
          },
          summary = "Retrouver les Affaires de Bijou et les lui rapporter. Bonne chance !",
          objectives = {
            "Affaires de Bijou (1)"
          },
          xp = 6400,
          money = "Aucun",
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4862,
          name = "Mauvais",
          faction = "both",
          level = 59,
          minLevel = 55,
          giver = {
            name = "Kibler",
            where = "Steppes ardentes",
            coords = "65.8, 22"
          },
          turnIn = {
            name = "Kibler",
            where = "Steppes ardentes",
            coords = "65.8, 22"
          },
          summary = "Aller au Pic Rochenoire et ramasser 15 Oeuf d'araignée du pic pour Kibler. Ces oeufs peuvent être trouvés à proximité des araignées.",
          objectives = {
            "Oeuf d'araignée du pic (15)"
          },
          xp = 6400,
          money = "90s",
          part = "Nord (quartiers gordok)"
        },
        {
          id = 7703,
          name = "Affaires inachevées chez les Gordok",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Capitaine Kromcrush",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Capitaine Kromcrush",
            where = "Hache-tripes"
          },
          summary = "Trouvez le Gantelet de Puissance Gordok et rendez-le au capitaine Kromcrush à Hache-tripes. Selon Kromcrush, les histoires des « vieux » racontent que Tortheldrin – un « vilain » elfe qui se fait appeler prince – l’a volé à l’un des rois gordok.",
          objectives = {
            "Gantelet de puissance gordok (1)"
          },
          xp = 8300,
          money = "Aucun",
          part = "Nord (quartiers gordok)",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7461,
          name = "Folie intérieure",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Ancienne des Shen'Dralar",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Ancienne des Shen'Dralar",
            where = "Hache-tripes"
          },
          summary = "Vous devez détruire les gardiens qui protègent les 5 Pylônes qui alimentent la Prison d’Immol’thar. Une fois que les Pylônes seront coupés, le champ de force qui entoure Immol’thar se dissipera. Entrez dans la Prison d’Immol’thar et éradiquez l’infâme démon qui se trouve en son cœur. Enfin, affrontez le prince Tortheldrin à l’Athenaeum. Lorsque vous aurez terminé, retournez voir l’Ancienne des Shen’dralar dans la cour.",
          objectives = {
            "Immol'thar tué (1)",
            "Prince Tortheldrin tué (1)"
          },
          xp = 9950,
          money = "Aucun",
          part = "Ouest (jardins de la Capitale)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5526,
          name = "Fragment de la Gangrevigne",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Rabine Saturna",
            where = "Reflet-de-Lune",
            coords = "51.6, 44.8"
          },
          turnIn = {
            name = "Rabine Saturna",
            where = "Reflet-de-Lune",
            coords = "51.6, 44.8"
          },
          summary = "Trouvez la Gangrevigne à Hache-tripes et prenez-en un fragment. Il est probable que vous ne pourrez vous en emparer qu’après la mort d’Alzzin le Modeleur. Servez-vous du Reliquaire de Pureté pour conserver le fragment, et retournez à Reflet-de-Lune voir Rabine Saturna au village de Havrenuit.",
          objectives = {
            "Reliquaire de pureté scellé (1)",
            "Fragment de gangrevigne (1)",
            "Reliquaire de pureté (1)"
          },
          xp = 8300,
          money = "Aucun",
          reputation = {
            {
              faction = "Cercle cénarien",
              amount = 150
            }
          },
          part = "Est (quartier de Crochebois)",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 5528,
          name = "La dégustation gordok",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Kreeg le Marteleur",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Kreeg le Marteleur",
            where = "Hache-tripes"
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5518,
          name = "La tenue d'ogre gordok",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Noué Dédodevie",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Noué Dédodevie",
            where = "Hache-tripes"
          },
          summary = "Apportez 4 Rouleaux d'étoffe runique, 8 Cuirs robustes, 2 Fils runiques et du Tanin ogre à Noué Dédodevie. Il est actuellement enchaîné dans l’aile Gordok de Hache-tripes.",
          objectives = {
            "Rouleau d'étoffe runique (4)",
            "Cuir robuste (8)",
            "Fil runique (2)",
            "Tanin ogre (1)"
          },
          xp = 6600,
          money = "Aucun",
          reputation = {
            {
              faction = "Cartel Gentepression",
              amount = 100
            }
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7507,
          name = "Le guide de Dagharn",
          faction = "both",
          level = 60,
          minLevel = 60,
          turnIn = {
            name = "Gardien du savoir Lydros",
            where = "Hache-tripes"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Rendez “Le guide de Dagharn du tueur de dragons“ à l’Athenaeum.",
          objectives = {
            "Le guide de Nostro du tueur de dragons (Fourni) (1)"
          },
          xp = 9950,
          money = "Aucun",
          reputation = {
            {
              faction = "Shen'dralar",
              amount = 200
            }
          },
          part = "Ouest (jardins de la Capitale)",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4866,
          name = "Le lait matriarcal",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "John le Loqueteux",
            where = "Steppes ardentes",
            coords = "65, 23.6"
          },
          turnIn = {
            name = "John le Loqueteux",
            where = "Steppes ardentes",
            coords = "65, 23.6"
          },
          summary = "Vous trouverez la Matriarche Couveuse au coeur du pic Rochenoire. Attaquez-la et poussez-la à vous empoisonner. Vous devrez sans doute la tuer. Une fois <empoisonné/empoisonnée>, trouvez John le Loqueteux afin qu'il puisse prélever un échantillon.",
          objectives = {
            "Trait (1)"
          },
          xp = 9950,
          money = "1g 80s",
          part = "Nord (quartiers gordok)"
        },
        {
          id = 4742,
          name = "Le sceau de l'ascension",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Infiltrateur du Bouclier balafré",
            where = "Pic Rochenoire"
          },
          turnIn = {
            name = "Infiltrateur du Bouclier balafré",
            where = "Pic Rochenoire"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Trouver les trois gemmes de commandement : la Gemme de Brûleronce, la Gemme de Pierre-du-pic et la Gemme de Hache-sanglante. Rapportez-les, ainsi que le Sceau d'ascension non décoré, à Vaelan. Les généraux, comme vous l'a dit Vaelan, sont : le maître de guerre Voone de Brûleronce ; le généralissime Omokk des Pierres-du-pic ; et le seigneur Wyrmthalak de Hache-sanglante.",
          objectives = {
            "Gemme de Pierre-du-pic (1)",
            "Gemme de Brûleronce (1)",
            "Gemme de Hache-sanglante (1)",
            "Sceau d'ascension non décoré (1)"
          },
          xp = 8300,
          money = "Aucun",
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5525,
          name = "Libérez Knot !",
          faction = "both",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Noué Dédodevie",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Noué Dédodevie",
            where = "Hache-tripes"
          },
          objectives = {
            "Clé des menottes gordok (1)"
          },
          xp = 6600,
          money = "Aucun",
          reputation = {
            {
              faction = "Cartel Gentepression",
              amount = 150
            }
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 7481,
          name = "Légendes elfiques",
          faction = "horde",
          level = 60,
          minLevel = 54,
          giver = {
            name = "Sage Korolusk",
            where = "Féralas",
            coords = "75, 43.8"
          },
          turnIn = {
            name = "Sage Korolusk",
            where = "Féralas",
            coords = "75, 43.8"
          },
          summary = "Fouillez Hache-tripes à la recherche de Kariel Winthalus. Lorsque vous aurez des informations, donnez-les au Sage Korolusk de Camp Mojache.",
          objectives = {
            "Vous avez trouvé maître Kariel Winthalus (1)"
          },
          xp = 8300,
          money = "1g 80s",
          part = "Nord (quartiers gordok)"
        },
        {
          id = 7482,
          name = "Légendes elfiques",
          faction = "alliance",
          level = 60,
          minLevel = 54,
          giver = {
            name = "Erudite Roncerune",
            where = "Féralas",
            coords = "31.2, 43.4"
          },
          turnIn = {
            name = "Erudite Roncerune",
            where = "Féralas",
            coords = "31.2, 43.4"
          },
          summary = "Fouillez Hache-tripes à la recherche de Kariel Winthalus. Lorsque vous aurez des informations, donnez-les à l’Erudite Roncerune, à Pennelune.",
          objectives = {
            "Vous avez trouvé maître Kariel Winthalus (1)"
          },
          xp = 8300,
          money = "1g 80s",
          part = "Nord (quartiers gordok)"
        },
        {
          id = 4903,
          name = "Ordre du chef de guerre",
          faction = "horde",
          level = 60,
          minLevel = 55,
          turnIn = {
            name = "Seigneur de guerre Sangredent",
            where = "Terres ingrates",
            coords = "5.8, 47.4"
          },
          summary = "Tuer le généralissime Omokk, le maître de guerre Voone et le seigneur Wyrmthalak. Récupérer les Importants documents Rochenoire. Retourner voir le seigneur de guerre Sangredent à Kargath une fois la mission accomplie.",
          objectives = {
            "Seigneur Wyrmthalak tué (1)",
            "Généralissime Omokk tué (1)",
            "Maître de guerre Voone tué (1)",
            "Importants documents Rochenoire (1)"
          },
          xp = 8300,
          money = "1g 80s",
          reputation = {
            {
              faction = "Orgrimmar",
              amount = 150
            }
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 5089,
          name = "Ordres du général Drakkisath",
          faction = "alliance",
          level = 60,
          minLevel = 55,
          turnIn = {
            name = "Maréchal Maxwell",
            where = "Steppes ardentes",
            coords = "84.6, 68.8"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Remettre les Ordres du général Drakkisath au maréchal Maxwell dans les Steppes ardentes.",
          objectives = {
            "Ordres du général Drakkisath (Fourni) (1)"
          },
          xp = 6600,
          money = "Aucun",
          reputation = {
            {
              faction = "Hurlevent",
              amount = 100
            }
          },
          part = "Nord (quartiers gordok)",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 7463,
          name = "Rafraîchissement arcanique",
          faction = "both",
          level = 60,
          minLevel = 60,
          giver = {
            name = "Gardien du savoir Lydros",
            where = "Hache-tripes"
          },
          turnIn = {
            name = "Gardien du savoir Lydros",
            where = "Hache-tripes"
          },
          summary = "Rendez-vous dans le quartier de Crochebois de Hache-tripes et tuez Hydrogénos, l’élémentaire de l’eau. Retournez voir le Gardien du savoir Lydros à l’Athenaeum avec l’Essence d’Hydrogénos.",
          objectives = {
            "Essence d'Hydrogénos (1)"
          },
          xp = 6600,
          money = "Aucun",
          reputation = {
            {
              faction = "Shen'dralar",
              amount = 200
            }
          },
          part = "Est (quartier de Crochebois)",
          tags = {
            "Réservée : Mage",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 4867,
          name = "Urok Hurleruine",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Warosh",
            where = "Pic Rochenoire"
          },
          turnIn = {
            name = "Warosh",
            where = "Pic Rochenoire"
          },
          summary = "Lire le Parchemin de Warosh. Apporter le Mojo de Warosh à Warosh.",
          objectives = {
            "Mojo de Warosh (1)",
            "Parchemin de Warosh (1)"
          },
          xp = 9950,
          money = "Aucun",
          part = "Nord (quartiers gordok)",
          tags = {
            "Non partageable",
            "Coordonnées à confirmer"
          }
        }
      }
    },
    {
      id = "scholo",
      slug = "scholomance",
      order = 26,
      name = "Scholomance",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 58,
        max = 60
      },
      levelFinder = 57,
      levelEntry = 33,
      players = "5",
      zone = "Maleterres de l'ouest",
      faction = "Horde / Alliance",
      bossCount = 14,
      bosses = {
        {
          name = "Kirtonos le Héraut",
          nameEn = "Kirtonos the Herald"
        },
        {
          name = "Régisseuse sanglante de Kirtonos",
          nameEn = "Blood Steward of Kirtonos"
        },
        {
          name = "Jandice Barov"
        },
        {
          name = "Cliquettripes",
          nameEn = "Rattlegore"
        },
        {
          name = "Marduk Noirétang",
          nameEn = "Marduk Blackpool"
        },
        {
          name = "Vectus"
        },
        {
          name = "Ras Murmegivre",
          nameEn = "Ras Frostwhisper"
        },
        {
          name = "Instructeur Malicia",
          nameEn = "Instructor Malicia"
        },
        {
          name = "Docteur Theolen Krastinov",
          nameEn = "Doctor Theolen Krastinov"
        },
        {
          name = "Gardien du savoir Polkelt",
          nameEn = "Lorekeeper Polkelt"
        },
        {
          name = "Le Voracien",
          nameEn = "The Ravenian"
        },
        {
          name = "Seigneur Alexei Barov",
          nameEn = "Lord Alexei Barov"
        },
        {
          name = "Dame Illucia Barov",
          nameEn = "Lady Illucia Barov"
        },
        {
          name = "Sombre Maître Gandling",
          nameEn = "Darkmaster Gandling"
        }
      },
      quests = {
        {
          id = 5582,
          name = "L'écaille de dragon luisante",
          faction = "both",
          level = 58,
          minLevel = 55,
          turnIn = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Apporter l’Ecaille de dragon luisante à Betina Bigglezink à la chapelle de l’Espoir de Lumière dans les Maleterres de l’est.",
          objectives = {
            "Ecaille de dragon luisante (Fourni) (1)"
          },
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 50
            }
          },
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 5529,
          name = "Portée contaminée",
          faction = "both",
          level = 58,
          minLevel = 55,
          giver = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          turnIn = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          summary = "Tuer 20 Jeunes pestiférés, puis retourner auprès de Betina Bigglezink à la Chapelle de l’Espoir de Lumière.",
          objectives = {
            "Jeune pestiféré tué (20)"
          },
          xp = 6200,
          money = "90s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 100
            }
          }
        },
        {
          id = 5382,
          name = "Docteur Theolen Krastinov, le boucher",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          turnIn = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          summary = "Trouver le docteur Theolen Krastinov à l’intérieur de la Scholomance. Le tuer, puis brûler le Cadavre d’Eva Sarkhoff et le Cadavre de Lucien Sarkhoff. Retourner auprès d’Eva Sarkhoff quand la tâche est accomplie.",
          objectives = {
            "Docteur Theolen Krastinov tué (1)",
            "Restes d'Eva Sarkhoff brûlés (1)",
            "Restes de Lucien Sarkhoff brûlés (1)"
          },
          xp = 6600,
          money = "Aucun"
        },
        {
          id = 5341,
          name = "Fortune de la famille Barov",
          faction = "horde",
          level = 60,
          minLevel = 52,
          giver = {
            name = "Alexi Barov",
            where = "Clairières de Tirisfal",
            coords = "83, 71.4"
          },
          turnIn = {
            name = "Alexi Barov",
            where = "Clairières de Tirisfal",
            coords = "83, 71.4"
          },
          summary = "S’aventurer jusqu’à Scholomance et récupérer la fortune de la famille Barov. Cette fortune se compose de quatre titres de propriété : le titre de propriété de Caer Darrow ; le titre de propriété de Brill ; le titre de propriété de Moulin-de-Tarren ; et le titre de propriété de Austrivage. Revenir auprès d’Alexi Barov quand la tâche est accomplie.",
          objectives = {
            "Titre de propriété de Brill (1)",
            "Titre de propriété de Caer Darrow (1)",
            "Titre de propriété de Austrivage (1)",
            "Titre de propriété de Moulin-de-Tarren (1)"
          },
          xp = 6600,
          money = "1g 80s"
        },
        {
          id = 5343,
          name = "Fortune de la famille Barov",
          faction = "alliance",
          level = 60,
          minLevel = 52,
          giver = {
            name = "Weldon Barov",
            where = "Maleterres de l'Ouest",
            coords = "43.4, 83.6"
          },
          turnIn = {
            name = "Weldon Barov",
            where = "Maleterres de l'Ouest",
            coords = "43.4, 83.6"
          },
          summary = "S’aventurer jusqu’à la Scholomance et récupérer la fortune de la famille Barov. Cette fortune se compose de quatre titres de propriété : le titre de propriété de Caer Darrow ; le titre de propriété de Brill ; le titre de propriété de Moulin-de-Tarren ; et le titre de propriété de Austrivage. Revenir auprès de Weldon Barov quand la tâche est accomplie.",
          objectives = {
            "Titre de propriété de Brill (1)",
            "Titre de propriété de Caer Darrow (1)",
            "Titre de propriété de Austrivage (1)",
            "Titre de propriété de Moulin-de-Tarren (1)"
          },
          xp = 6600,
          money = "1g 80s"
        },
        {
          id = 5384,
          name = "Kirtonos le héraut",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          turnIn = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          summary = "Revenir à Scholomance avec le Sang des innocents. Trouver le porche et placer le Sang des innocents dans le brasero. Kirtonos viendra dévorer votre âme. Combattre vaillamment, sans perdre un pouce de terrain ! Détruire Kirtonos et revenir auprès d’Eva Sarkhoff.",
          objectives = {
            "Kirtonos le Héraut tué (1)",
            "Sang des innocents (1)"
          },
          xp = 8300,
          money = "Aucun",
          tags = {
            "Non partageable"
          }
        },
        {
          id = 5466,
          name = "La Liche, Ras Murmegivre",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Magistrat Marduke",
            where = "Maleterres de l'Ouest",
            coords = "70.4, 74"
          },
          turnIn = {
            name = "Magistrat Marduke",
            where = "Maleterres de l'Ouest",
            coords = "70.4, 74"
          },
          summary = "Trouver Ras Murmegivre dans Scholomance. Après l’avoir trouvé, utiliser le Souvenir lié sur son visage mort-vivant. Si sa transformation en mortel réussit, l’abattre et prendre la Tête humaine de Ras Murmegivre. Apporter la tête au Magistrat Marduke.",
          objectives = {
            "Tête humaine de Ras Murmegivre (1)",
            "Souvenir lié (1)"
          },
          xp = 9950,
          money = "Aucun",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 7668,
          name = "La menace de Ravassombre",
          faction = "horde",
          level = 60,
          minLevel = 58,
          giver = {
            name = "Sagorne Rôdeur-des-crêtes",
            where = "Orgrimmar",
            coords = "38.6, 36.2"
          },
          turnIn = {
            name = "Sagorne Rôdeur-des-crêtes",
            where = "Orgrimmar",
            coords = "38.6, 36.2"
          },
          summary = "Servez-vous du Clairvoyant au centre du sous-sol du Grand ossuaire de la Scholomance. Cela attirera des esprits que vous devrez combattre. Les vaincre fera apparaître le Chevalier de la mort Ravassombre. Tuez-le. Ramenez la Tête de Ravassombre à Sagorne Rôdeur-des-crêtes de la vallée de la Sagesse, à Orgrimmar.",
          objectives = {
            "Tête de Ravassombre (1)",
            "Clairvoyant (1)"
          },
          xp = 9950,
          money = "Aucun",
          reputation = {
            {
              faction = "Horde",
              amount = 200
            }
          },
          tags = {
            "Prérequis",
            "Non partageable",
            "Réservée : Chaman"
          }
        },
        {
          id = 4771,
          name = "Le gambit de l'aube",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          turnIn = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          summary = "Placer le Gambit de l'aube dans la Chambre des visions de Scholomance. Vaincre Vectus, puis retourner auprès de Betina Bigglezink.",
          objectives = {
            "Vectus tué (1)",
            "Placer le Gambit de l'aube (1)",
            "Gambit de l’aube (1)"
          },
          xp = 9950,
          money = "2g 70s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 200
            }
          },
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 5515,
          name = "Sac des horreurs de Krastinov",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          turnIn = {
            name = "Eva Sarkhoff",
            where = "Maleterres de l'Ouest",
            coords = "70.2, 73.8"
          },
          summary = "Trouver Jandice Barov dans Scholomance et la tuer. Sur son cadavre, récupérer le Sac des horreurs de Krastinov. Rapporter le sac à Eva Sarkhoff.",
          objectives = {
            "Sac des horreurs de Krastinov (1)"
          },
          xp = 6600,
          money = "Aucun",
          tags = {
            "Prérequis"
          }
        }
      }
    },
    {
      id = "strat",
      slug = "stratholme",
      order = 27,
      name = "Stratholme",
      type = "dungeon",
      origin = "classic",
      levels = {
        min = 58,
        max = 60
      },
      levelFinder = 55,
      levelEntry = 37,
      players = "5",
      zone = "Maleterres de l'est",
      faction = "Horde / Alliance",
      note = "Les deux ailes.",
      bossCount = 19,
      bosses = {
        {
          name = "Timmy le Cruel",
          nameEn = "Timmy the Cruel",
          wing = "Côté vivant"
        },
        {
          name = "Malor le Zélé",
          nameEn = "Malor the Zealous",
          wing = "Côté vivant"
        },
        {
          name = "Maître canonnier Willey",
          nameEn = "Cannon Master Willey",
          wing = "Côté vivant"
        },
        {
          name = "Archiviste Galford",
          nameEn = "Archivist Galford",
          wing = "Côté vivant"
        },
        {
          name = "Balnazzar",
          wing = "Côté vivant"
        },
        {
          name = "Magistrat Barthilas",
          nameEn = "Magistrate Barthilas",
          wing = "Côté mort-vivant"
        },
        {
          name = "Nerub'enkan",
          wing = "Côté mort-vivant"
        },
        {
          name = "Baronne Anastari",
          nameEn = "Baroness Anastari",
          wing = "Côté mort-vivant"
        },
        {
          name = "Maleki le Blafard",
          nameEn = "Maleki the Pallid",
          wing = "Côté mort-vivant"
        },
        {
          name = "Ramstein Grandgosier",
          nameEn = "Ramstein the Gorger",
          wing = "Côté mort-vivant"
        },
        {
          name = "Baron Vaillefendre",
          nameEn = "Baron Rivendare",
          wing = "Côté mort-vivant"
        },
        {
          name = "Le Condamné",
          nameEn = "The Unforgiven"
        }
      },
      quests = {
        {
          id = 5263,
          name = "Au-dessus et au-delà",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Duc Nicholas Zverenhoff",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.8"
          },
          turnIn = {
            name = "Duc Nicholas Zverenhoff",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.8"
          },
          summary = "S’aventurer dans Stratholme et tuer le baron Rivendare. Prendre sa tête et retourner auprès du duc Nicholas Zverenhoff.",
          objectives = {
            "Tête du baron Rivendare (1)"
          },
          xp = 8300,
          money = "Aucun",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 150
            }
          },
          part = "Côté mort-vivant",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 5848,
          name = "De l'amour et de la famille",
          faction = "both",
          level = 60,
          minLevel = 52,
          giver = {
            name = "Artiste Renfray",
            where = "Maleterres de l'Ouest",
            coords = "65.6, 75.4"
          },
          turnIn = {
            name = "Tirion Fordring",
            where = "Maleterres de l'Est",
            coords = "7.4, 43.6"
          },
          summary = "Se rendre à Stratholme, dans la partie nord des Maleterres. C’est dans le Bastion écarlate que se trouve le tableau De l'amour et de la famille, caché derrière une autre peinture représentant les lunes jumelles. Rapporter le tableau à Tirion Fordring.",
          objectives = {
            "De l'amour et de la famille (1)"
          },
          xp = 6600,
          money = "Aucun",
          part = "Côté vivant",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 5213,
          name = "L'agent actif",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          turnIn = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          summary = "Se rendre jusqu’à Stratholme et fouiller les ziggourats. Trouver et ramener de nouvelles informations sur le Fléau à Betina Bigglezink.",
          objectives = {
            "Donnée du Fléau (1)"
          },
          xp = 6600,
          money = "Aucun",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 100
            }
          },
          part = "Côté mort-vivant"
        },
        {
          id = 5251,
          name = "L'archiviste",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Duc Nicholas Zverenhoff",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.8"
          },
          turnIn = {
            name = "Duc Nicholas Zverenhoff",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.8"
          },
          summary = "Voyager jusqu’à Stratholme et trouver l’Archiviste Galford de la Croisade écarlate. L’abattre et brûler les Archives écarlates.",
          objectives = {
            "Archiviste Galford tué (1)",
            "Archives brûlées (1)"
          },
          xp = 8300,
          money = "1g 80s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 150
            }
          },
          part = "Côté vivant"
        },
        {
          id = 5125,
          name = "L'estimation d'Aurius",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Aurius",
            where = "Stratholme"
          },
          turnIn = {
            name = "Aurius",
            where = "Stratholme"
          },
          xp = 9950,
          money = "Aucun",
          part = "Côté mort-vivant",
          tags = {
            "Prérequis",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5212,
          name = "La chair ne ment pas",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          turnIn = {
            name = "Betina Bigglezink",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.6"
          },
          summary = "Récupérer 20 Echantillons de chair pestiférée à Stratholme puis les rapporter à Betina Bigglezink. Vous pensez que toutes les créatures de Stratholme possèdent de tels échantillons de chair.",
          objectives = {
            "Echantillon de chair pestiférée (20)"
          },
          xp = 6600,
          money = "1g 80s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 100
            }
          },
          part = "Côté mort-vivant",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 8945,
          name = "La supplique du mort",
          faction = "both",
          level = 60,
          minLevel = 58,
          giver = {
            name = "Anthion Harmon"
          },
          turnIn = {
            name = "Ysida Harmon",
            where = "Stratholme"
          },
          summary = "Entrez à Stratholme et sauvez Ysida Harmon du baron Rivendare.",
          objectives = {
            "Ysida est libérée (1)"
          },
          xp = 8300,
          money = "Aucun",
          part = "Côté mort-vivant",
          tags = {
            "Prérequis",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5262,
          name = "La vérité vient du ciel",
          faction = "both",
          level = 60,
          minLevel = 55,
          turnIn = {
            name = "Duc Nicholas Zverenhoff",
            where = "Maleterres de l'Est",
            coords = "81.4, 59.8"
          },
          fromItem = "Objet ramassé ou reçu en butin",
          summary = "Apporter la Tête de Balnazzar au duc Nicholas Zverenhoff dans les Maleterres de l’est.",
          objectives = {
            "Tête de Balnazzar (Fourni) (1)"
          },
          xp = 8300,
          money = "Aucun",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 150
            }
          },
          part = "Côté vivant",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        },
        {
          id = 5463,
          name = "Le cadeau de Menethil",
          faction = "both",
          level = 60,
          minLevel = 57,
          giver = {
            name = "Leonid Barthalomew le Révéré",
            where = "Maleterres de l'Est",
            coords = "81.6, 57.8"
          },
          turnIn = {
            name = "Don de Menethil",
            where = "Stratholme"
          },
          summary = "Voyager jusqu’à Stratholme et trouver le cadeau de Menethil. Placer le Souvenir de la mémoire sur le sol impie.",
          objectives = {
            "Livre du souvenir (Fourni) (1)"
          },
          xp = 6600,
          money = "Aucun",
          part = "Côté mort-vivant",
          tags = {
            "Prérequis",
            "Non partageable",
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5214,
          name = "Le grand Fras Siabi",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Smokey LaRue",
            where = "Maleterres de l'Est",
            coords = "80.6, 58"
          },
          turnIn = {
            name = "Smokey LaRue",
            where = "Maleterres de l'Est",
            coords = "80.6, 58"
          },
          summary = "Trouver le magasin de tabac de Fras Siabi dans Stratholme et récupérer une boîte de Tabac de Siabi. Retourner auprès de Smokey LaRue quand le travail est fait.",
          objectives = {
            "Tabac de Grimm (1)"
          },
          xp = 8300,
          money = "Aucun",
          part = "Côté vivant"
        },
        {
          id = 5122,
          name = "Le médaillon de foi",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Aurius",
            where = "Stratholme"
          },
          turnIn = {
            name = "Aurius",
            where = "Stratholme"
          },
          objectives = {
            "Médaillon de foi (1)"
          },
          part = "Côté vivant",
          tags = {
            "Coordonnées à confirmer"
          }
        },
        {
          id = 5243,
          name = "Les demeures du Sacré",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Leonid Barthalomew le Révéré",
            where = "Maleterres de l'Est",
            coords = "81.6, 57.8"
          },
          turnIn = {
            name = "Leonid Barthalomew le Révéré",
            where = "Maleterres de l'Est",
            coords = "81.6, 57.8"
          },
          summary = "Se rendre à Stratholme, au nord. Fouiller les caisses de fournitures qui encombrent la cité et récupérer 5 Eaux sacrées de Stratholme. Retourner auprès de Leonid Barthalomew le Révéré quand vous avez récolté assez de liquide béni.",
          objectives = {
            "Eau sacrée de Stratholme (5)"
          },
          xp = 6600,
          money = "1g 80s",
          reputation = {
            {
              faction = "Aube d'argent",
              amount = 100
            }
          },
          part = "Côté mort-vivant"
        },
        {
          id = 6163,
          name = "Ramstein",
          faction = "horde",
          level = 60,
          minLevel = 56,
          giver = {
            name = "Nathanos le Flétrisseur",
            where = "Maleterres de l'Est",
            coords = "26.6, 74.8"
          },
          turnIn = {
            name = "Nathanos le Flétrisseur",
            where = "Maleterres de l'Est",
            coords = "26.6, 74.8"
          },
          summary = "Aller à Stratholme et tuer Ramstein Grandgosier. Prendre sa tête, et l’apporter à Nathanos.",
          objectives = {
            "Tête de Ramstein Grandgosier (1)"
          },
          xp = 6600,
          money = "1g 80s",
          reputation = {
            {
              faction = "Fossoyeuse",
              amount = 100
            }
          },
          part = "Côté mort-vivant",
          tags = {
            "Prérequis"
          }
        },
        {
          id = 5282,
          name = "Âmes tourmentées",
          faction = "both",
          level = 60,
          minLevel = 55,
          giver = {
            name = "Egan",
            where = "Maleterres de l'Est",
            coords = "14.4, 33.6"
          },
          turnIn = {
            name = "Egan",
            where = "Maleterres de l'Est",
            coords = "14.4, 33.6"
          },
          summary = "Se servir du Libérateur d'Egan sur les citoyens fantomatiques et spectraux de Stratholme. Quand les esprits sans repos se libèrent de leur enveloppes fantomatiques, utiliser de nouveau le Libérateur – ils seront enfin libres ! Libérer 15 Esprits sans repos puis retourner auprès d’Egan.",
          objectives = {
            "Ames libérées (15)",
            "Libérateur d'Egan (1)"
          },
          xp = 8300,
          money = "1g 80s",
          part = "Côté vivant",
          tags = {
            "Prérequis",
            "Non partageable"
          }
        }
      }
    },
    {
      id = "shapers",
      slug = "terrasse-des-faconneurs",
      order = 28,
      name = "Terrasse des Façonneurs",
      type = "dungeon",
      origin = "new",
      nameEn = "The Shapers Terrace",
      levels = {
        min = 58,
        max = 60
      },
      players = "5",
      zone = "Cratère d'Un'Goro",
      entry = "Dans les collines d'Un'Goro.",
      summary = "Niveaux 58 à 60, une installation titan dans les collines d'Un'Goro. Intacte depuis toujours, pleine de dinosaures, de cristaux d'énergie et d'une source d'énergie encore inexpliquée.",
      bosses = {},
      quests = {}
    },
    {
      id = "barrow",
      slug = "fosses-de-barrow",
      order = 29,
      name = "Fosses de Barrow",
      type = "raid",
      origin = "new",
      players = "10",
      entry = "Trois entrées, dont une sur le Mont Hyjal.",
      summary = "10 joueurs. Un vaste réseau sacré de tumulus elfiques de la nuit avec trois entrées, dont une sur le Mont Hyjal, vers lequel Bastion de Gueule-Noire semble d'ailleurs creuser un tunnel. Les elfes de la nuit gardent leurs prisonniers les plus dangereux dans les Fosses ancestrales, où un chasseur de démons célèbre fut jadis enfermé. La corruption s'y répand désormais.",
      availability = "Ouverture 9 déc.",
      bosses = {},
      quests = {}
    },
    {
      id = "hyjal",
      slug = "sommet-du-hyjal",
      order = 30,
      name = "Mont Hyjal",
      type = "raid",
      origin = "new",
      players = "20",
      faction = "Horde / Alliance",
      summary = "20 joueurs, le grand raid de lancement : pics enneigés, ruines elfiques anciennes et fantômes qui hantent encore les lieux depuis la Troisième Guerre. L'histoire du Sommet du Hyjal revient sur ce que Malfurion a sacrifié pour arrêter Archimonde, et quelque chose draine actuellement le pouvoir de la région, sur ce qui ressemble au chemin vers la première légendaire de Forever.",
      availability = "Ouverture 9 déc.",
      bosses = {},
      quests = {}
    },
    {
      id = "ony",
      slug = "repaire-d-onyxia",
      order = 31,
      name = "Repaire d'Onyxia",
      type = "raid",
      origin = "classic",
      nameEn = "Onyxia's Lair",
      players = "40",
      availability = "Ouverture 9 déc.",
      bosses = {
        {
          name = "Onyxia"
        }
      },
      quests = {}
    },
    {
      id = "mc",
      slug = "coeur-du-magma",
      order = 32,
      name = "Cœur du Magma",
      type = "raid",
      origin = "classic",
      nameEn = "Molten Core",
      levelEntry = 50,
      players = "40",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      questsInCache = 2,
      bosses = {
        {
          name = "Lucifron"
        },
        {
          name = "Magmadar"
        },
        {
          name = "Gehennas"
        },
        {
          name = "Garr"
        },
        {
          name = "Baron Geddon"
        },
        {
          name = "Shazzrah"
        },
        {
          name = "Messager de Sulfuron",
          nameEn = "Sulfuron Harbinger"
        },
        {
          name = "Golemagg l'Incinérateur",
          nameEn = "Golemagg the Incinerator"
        },
        {
          name = "Chambellan Executus",
          nameEn = "Majordomo Executus"
        },
        {
          name = "Ragnaros"
        }
      },
      quests = {
        {
          id = nil,
          name = "L'Alliance a besoin de pierres du Magma calcinées !",
          faction = "alliance",
          nameEn = "The Alliance Needs Singed Corestones!",
          level = 60,
          state = "beta"
        },
        {
          id = nil,
          name = "La Horde a besoin de pierres du Magma calcinées !",
          faction = "horde",
          nameEn = "The Horde Needs Singed Corestones!",
          level = 60,
          state = "beta"
        }
      }
    },
    {
      id = "bwl",
      slug = "repaire-de-l-aile-noire",
      order = 33,
      name = "Repaire de l'Aile noire",
      type = "raid",
      origin = "classic",
      nameEn = "Blackwing Lair",
      players = "40",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      bosses = {
        {
          name = "Tranchetripe l'Indompté"
        },
        {
          name = "Vaelastrasz le Corrompu"
        },
        {
          name = "Seigneur des couvées Lashlayer"
        },
        {
          name = "Gueule-de-feu"
        },
        {
          name = "Rochébène"
        },
        {
          name = "Flamegor"
        },
        {
          name = "Chromaggus"
        },
        {
          name = "Nefarian"
        }
      },
      quests = {}
    },
    {
      id = "zg",
      slug = "zul-gurub",
      order = 34,
      name = "Zul'Gurub",
      type = "raid",
      origin = "classic",
      players = "20",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      bosses = {
        {
          name = "Grande prêtresse Jeklik"
        },
        {
          name = "Grand prêtre Venoxis"
        },
        {
          name = "Grande prêtresse Mar'li"
        },
        {
          name = "Seigneur sanglant Mandokir"
        },
        {
          name = "Gri'lek, Hazza'rah, Renataki ou Wushoolay"
        },
        {
          name = "Gahz'ranka"
        },
        {
          name = "Grand prêtre Thekal"
        },
        {
          name = "Grande prêtresse Arlokk"
        },
        {
          name = "Jin'do le Maléficieur"
        },
        {
          name = "Hakkar"
        }
      },
      quests = {}
    },
    {
      id = "aq20",
      slug = "ruines-d-ahn-qiraj",
      order = 35,
      name = "Ruines d'Ahn'Qiraj",
      type = "raid",
      origin = "classic",
      nameEn = "Ruins of Ahn'Qiraj",
      players = "20",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      bosses = {
        {
          name = "Kurinnaxx"
        },
        {
          name = "Général Rajaxx"
        },
        {
          name = "Moam"
        },
        {
          name = "Buru Grandgosier"
        },
        {
          name = "Ayamiss le Chasseur"
        },
        {
          name = "Ossirian l'Intouché"
        }
      },
      quests = {}
    },
    {
      id = "aq40",
      slug = "temple-d-ahn-qiraj",
      order = 36,
      name = "Ahn'Qiraj",
      type = "raid",
      origin = "classic",
      nameEn = "Temple of Ahn'Qiraj",
      players = "40",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      bosses = {
        {
          name = "Le Prophète Skeram"
        },
        {
          name = "Seigneur Kri, Princesse Yauj et Vem"
        },
        {
          name = "Garde de guerre Sartura"
        },
        {
          name = "Fankriss l'Inflexible"
        },
        {
          name = "Viscidus"
        },
        {
          name = "Princesse Huhuran"
        },
        {
          name = "Empereur Vek'lor et Empereur Vek'nilash"
        },
        {
          name = "Ouro"
        },
        {
          name = "C'Thun"
        }
      },
      quests = {}
    },
    {
      id = "naxx",
      slug = "naxxramas",
      order = 37,
      name = "Naxxramas",
      type = "raid",
      origin = "classic",
      players = "40",
      faction = "Horde / Alliance",
      availability = "Pas encore ouvert",
      bosses = {
        {
          name = "Anub'Rekhan"
        },
        {
          name = "Grande veuve Faerlina",
          nameEn = "Grand Widow Faerlina"
        },
        {
          name = "Maexxna"
        },
        {
          name = "Noth le Porte-peste",
          nameEn = "Noth the Plaguebringer"
        },
        {
          name = "Heigan l'Impur",
          nameEn = "Heigan the Unclean"
        },
        {
          name = "Horreb",
          nameEn = "Loatheb"
        },
        {
          name = "Instructeur Razuvious",
          nameEn = "Instructor Razuvious"
        },
        {
          name = "Gothik le Moissonneur",
          nameEn = "Gothik the Harvester"
        },
        {
          name = "Généralissime Mograine, Thane Korth'azz, Dame Blaumeux et Sire Zeliek",
          nameEn = "Highlord Mograine, Thane Korth'azz, Lady Blaumeux and Sir Zeliek"
        },
        {
          name = "Le Recousu",
          nameEn = "Patchwerk"
        },
        {
          name = "Grobbulus"
        },
        {
          name = "Gluth"
        },
        {
          name = "Thaddius"
        },
        {
          name = "Saphiron",
          nameEn = "Sapphiron"
        },
        {
          name = "Kel'Thuzad"
        }
      },
      quests = {}
    }
  }
}
