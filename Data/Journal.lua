-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Journal = {
  build = "1.60.1.70009",
  releve = true,
  instances = {
    -- wowhead forever (zone=2437, pages npc) : noms FR/EN, npcId et display conformes ; butin de Taragaman et Jergosh confirmé.
    -- à confirmer : butin de Lorgnesilex (272999, 272996, 272998) et Bazzalan (273003, 273007, 273005), objets Forever sans source de butin sur Wowhead (attribution fdj).
    rfc = {
      bosses = {
        {
          display = 11611,
          en = "Oggleflint",
          forever = true,
          level = "16",
          loot = { 272999, 272996, 272998 },
          name = "Lorgnesilex",
          npc = 11517,
          src = "fdj"
        },
        {
          display = 7970,
          en = "Taragaman the Hungerer",
          forever = true,
          level = "16",
          loot = { 14149, 14148, 14145 },
          name = "Taragaman l'Affameur",
          npc = 11520,
          src = "fdj"
        },
        {
          display = 11429,
          en = "Jergosh the Invoker",
          forever = true,
          level = "16",
          loot = { 14150, 14147, 14151 },
          name = "Jergosh l'Invocateur",
          npc = 11518,
          src = "fdj"
        },
        { display = 2007, forever = true, level = "16", loot = { 273003, 273007, 273005 }, name = "Bazzalan", npc = 11519, src = "fdj" }
      },
      entrance = { map = 1454, src = "questie", x = 0.526, y = 0.49 },
      quests = {
        [5722] = {
          confirmed = true,
          giver = { map = 1456, name = "Rahauro", npc = 11833, src = "site", x = 0.704, y = 0.296 },
          src = "client",
          title = "À la recherche de la sacoche perdue"
        },
        [5723] = {
          confirmed = true,
          giver = { map = 1456, name = "Rahauro", npc = 11833, src = "site", x = 0.704, y = 0.296 },
          src = "client",
          title = "Tester la force de l'ennemi",
          turnIn = { map = 1456, name = "Rahauro", npc = 11833, src = "site", x = 0.704, y = 0.296 }
        },
        [5724] = {
          chain = { 5722 },
          chainSrc = "questie",
          choice = 3,
          confirmed = true,
          rewards = { 15452, 15453, 270003 },
          src = "client",
          title = "Rapporter la sacoche perdue",
          turnIn = { map = 1456, name = "Rahauro", npc = 11833, src = "questie", x = 0.7014, y = 0.2952 }
        },
        [5725] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 },
          rewards = { 15449, 15450, 15451 },
          src = "client",
          title = "Le pouvoir de détruire...",
          turnIn = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 }
        },
        [5728] = {
          chain = { 5726, 5727 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1454, name = "Thrall", npc = 4949, src = "site", x = 0.32, y = 0.378 },
          src = "client",
          title = "Ennemis cachés",
          turnIn = { map = 1454, name = "Thrall", npc = 4949, src = "site", x = 0.32, y = 0.378 }
        },
        [5761] = {
          confirmed = true,
          giver = { map = 1454, name = "Neeru Lamefeu", npc = 3216, src = "site", x = 0.496, y = 0.504 },
          src = "client",
          title = "Tuer la bête",
          turnIn = { map = 1454, name = "Neeru Lamefeu", npc = 3216, src = "site", x = 0.496, y = 0.504 }
        }
      }
    },
    -- wowhead forever (zone=16919, pages npc) : noms FR officiels (Faldrim Courbenclume, Pilleur, Durgen Mornemartel), npcId et display de Magmatus.
    -- à confirmer : Wowhead Forever n'a pas encore de relevé de butin pour ces boss ; butin conservé (fdj), objets présents sur Wowhead Forever.
    hot = {
      bosses = {
        {
          display = 142826,
          en = "Faldrim Anvilmar",
          forever = true,
          level = "16",
          loot = { 270227, 271096, 271097 },
          name = "Faldrim Courbenclume",
          npc = 261306,
          src = "fdj"
        },
        {
          display = 1070,
          forever = true,
          loot = { 270230, 270231, 271095 },
          name = "Magmatus",
          npc = 261316,
          src = "fdj"
        },
        {
          display = 142840,
          en = "Plunder",
          forever = true,
          level = "16",
          loot = { 270228, 271098, 270229 },
          name = "Pilleur",
          npc = 261311,
          src = "fdj"
        },
        {
          display = 142837,
          en = "Durgen Dirgehammer",
          forever = true,
          level = "16",
          loot = { 270256, 270260, 270261, 274286 },
          name = "Durgen Mornemartel",
          npc = 261319,
          src = "fdj"
        }
      },
      entrance = { map = 1426, src = "jeu", x = 0.581, y = 0.294 },
      quests = {
        [96393] = {
          chain = { 96391 },
          chainSrc = "fdj",
          choice = 3,
          confirmed = true,
          rewards = { 279894, 279895, 279896 },
          src = "client",
          title = "Incursion dans le Vieux Forgefer"
        },
        [96394] = { choice = 2, confirmed = true, rewards = { 279897, 280095 }, src = "client", title = "Les morts sans repos" },
        [96395] = { choice = 2, confirmed = true, rewards = { 279899, 279900 }, src = "client", title = "Une rancune ancestrale" },
        [96403] = { choice = 2, confirmed = true, rewards = { 279898, 280096 }, src = "client", title = "Précieux héritages" },
        [98423] = { confirmed = true, src = "client", title = "Le traité d’entente" }
      }
    },
    -- wowhead forever (zone=718, pages npc) : noms FR/EN et npcId conformes, butin de base conforme.
    -- ajouté : Dragon féérique déviant (rare), butin propre relevé sur Wowhead Forever (avant : lootByNpc seulement, non affiché).
    -- à confirmer : 273088, 273084, 273089, 273137 existent sur Wowhead Forever mais sans source de butin (attribution fdj).
    -- butin : objets bleus de la page Wowhead Forever de chaque boss ajoutés, y compris butin de zone ou commun (taux parfois < 1 %).
    wc = {
      bosses = {
        {
          display = 4313,
          en = "Lady Anacondra",
          forever = true,
          level = "20",
          loot = { 10412, 5404, 6446, 273088, 12992 },
          name = "Dame Anacondra",
          npc = 3671,
          src = "fdj"
        },
        {
          display = 4213,
          en = "Lord Cobrahn",
          forever = true,
          level = "20",
          loot = { 6460, 10410, 6465, 13136, 12976, 12978 },
          name = "Seigneur Cobrahn",
          npc = 3669,
          src = "fdj"
        },
        { display = 5126, forever = true, level = "20", loot = { 13245, 6447, 273084, 2879, 12983, 12978, 12976 }, name = "Kresh", npc = 3653, src = "fdj" },
        {
          display = 4214,
          en = "Lord Pythas",
          forever = true,
          level = "21",
          loot = { 6472, 6473, 273089, 12979, 12978 },
          name = "Seigneur Pythas",
          npc = 3670,
          src = "fdj"
        },
        { display = 4203, forever = true, level = "21", loot = { 6449, 6448, 273137, 12983 }, name = "Skum", npc = 3674, src = "fdj" },
        {
          display = 4215,
          en = "Lord Serpentis",
          forever = true,
          level = "21",
          loot = { 6469, 5970, 10411, 6459, 1121, 12979 },
          name = "Seigneur Serpentis",
          npc = 3673,
          src = "fdj"
        },
        {
          display = 4256,
          en = "Verdan the Everliving",
          forever = true,
          level = "21",
          loot = { 6630, 6631, 6629, 935, 12979, 12988 },
          name = "Verdan l'Immortel",
          npc = 5775,
          src = "fdj"
        },
        {
          display = 4088,
          en = "Mutanus the Devourer",
          forever = true,
          level = "22",
          loot = { 6461, 6627, 6463, 10441, 12979, 12997, 12985 },
          name = "Mutanus le Dévoreur",
          npc = 3654,
          src = "fdj"
        },
        {
          display = 1267,
          en = "Deviate Faerie Dragon",
          forever = true,
          level = "20",
          loot = { 5243, 6632 },
          name = "Dragon féérique déviant",
          npc = 5912,
          rare = true,
          src = "wowhead"
        }
      },
      entrance = { map = 1413, src = "questie", x = 0.46, y = 0.365 },
      lootByNpc = { [3840] = { 10413 }, [5912] = { 5243, 6632 } },
      quests = {
        [914] = {
          chain = { 870, 877, 880, 1489, 1490 },
          chainSrc = "questie",
          choice = 3,
          confirmed = true,
          giver = { map = 1456, name = "Nara Crin-sauvage", npc = 5770, src = "site", x = 0.756, y = 0.312 },
          rewards = { 6505, 6504, 270018 },
          src = "client",
          title = "Les druides du Croc",
          turnIn = { map = 1456, name = "Nara Crin-sauvage", npc = 5770, src = "site", x = 0.756, y = 0.312 }
        },
        [959] = {
          confirmed = true,
          giver = { map = 1413, name = "Grutier Bigglefuzz", npc = 3665, src = "site", x = 0.63, y = 0.376 },
          src = "client",
          title = "Fuite de porto aux docks",
          turnIn = { map = 1413, name = "Grutier Bigglefuzz", npc = 3665, src = "site", x = 0.63, y = 0.376 }
        },
        [962] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1456, name = "Apothicaire Zamah", npc = 3419, src = "site", x = 0.23, y = 0.21 },
          rewards = { 10919, 270008, 270009 },
          src = "client",
          title = "Fleur de serpent",
          turnIn = { map = 1456, name = "Apothicaire Zamah", npc = 3419, src = "site", x = 0.23, y = 0.21 }
        },
        [1486] = {
          confirmed = true,
          giver = { map = 1413, name = "Nalpak", npc = 5767, src = "questie", x = 0.4599, y = 0.3566 },
          rewards = { 918, 6480 },
          src = "client",
          title = "Les peaux communes",
          turnIn = { map = 1413, name = "Nalpak", npc = 5767, src = "questie", x = 0.4599, y = 0.3566 }
        },
        [1487] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1413, name = "Ebru", npc = 5768, src = "questie", x = 0.4601, y = 0.3574 },
          rewards = { 6476, 8071, 6481 },
          src = "client",
          title = "L'éradication des Déviants",
          turnIn = { map = 1413, name = "Ebru", npc = 5768, src = "questie", x = 0.4601, y = 0.3574 }
        },
        [1489] = {
          chain = { 870, 877, 880 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1413, name = "Hamuul Totem-Runique", npc = 3448, src = "questie", x = 0.5226, y = 0.3193 },
          src = "client",
          title = "Hamuul Runetotem",
          turnIn = { map = 1456, name = "Arch Druid Hamuul Runetotem", npc = 5769, src = "questie", x = 0.7862, y = 0.2856 }
        },
        [1490] = {
          chain = { 870, 877, 880, 1489 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1456, name = "Nara Crin-Sauvage", npc = 5769, src = "questie", x = 0.7862, y = 0.2856 },
          src = "client",
          title = "Nara Wildmane",
          turnIn = { map = 1456, name = "Nara Wildmane", npc = 5770, src = "questie", x = 0.7565, y = 0.3161 }
        },
        [1491] = {
          chain = { 865 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1413, name = "Mebok Mizzyrix", npc = 3446, src = "site", x = 0.624, y = 0.376 },
          src = "client",
          title = "Les potions d'intelligence",
          turnIn = { map = 1413, name = "Mebok Mizzyrix", npc = 3446, src = "site", x = 0.624, y = 0.376 }
        },
        [6981] = {
          confirmed = true,
          giver = { map = 1456, name = "Falla Sagewind", src = "fdj", x = 0.706, y = 0.3 },
          src = "client",
          title = "L'Eclat luminescent",
          turnIn = { map = 1413, name = "Falla Vent-de-sagesse", npc = 8418, src = "site", x = 0.482, y = 0.328 }
        }
      }
    },
    -- wowhead forever (zone=16611, pages npc, guide=34931) : npcId (Le Baron 250660, Capitaine 255699), display, noms officiels Croc-Flétri et Viktor le Vil, butin par boss selon le tableau du guide (les pages npc n'ont pas de butin bleu relevé).
    -- à confirmer : butin du Capitaine de Lordaeron (6641, 6642, relevé fdj, rien sur Wowhead) ; Viktor le Vil et 271214 absents du tableau du guide, rattachement fdj conservé.
    rol = {
      bosses = {
        {
          display = 144189,
          en = "Witherfang",
          forever = true,
          level = "17",
          loot = { 271201, 271202, 271203 },
          name = "Croc-Flétri",
          npc = 250483,
          src = "wowhead"
        },
        {
          display = 138667,
          en = "The Abandoned",
          forever = true,
          level = "18",
          loot = { 271207, 271208, 271216 },
          name = "L'Abandonné",
          npc = 250631,
          src = "wowhead"
        },
        {
          display = 144188,
          en = "The Baron",
          forever = true,
          loot = { 271204, 271205, 271206 },
          name = "Le Baron",
          npc = 250660,
          src = "wowhead"
        },
        {
          display = 144175,
          forever = true,
          level = "20",
          loot = { 271213, 271214, 271215 },
          name = "Rath'mael",
          npc = 250657,
          src = "wowhead"
        },
        {
          display = 139050,
          en = "Lordaeron Captain",
          forever = true,
          loot = { 6641, 6642 },
          name = "Capitaine de Lordaeron",
          npc = 255699,
          rare = true,
          src = "fdj"
        },
        {
          display = 139455,
          en = "Viktor the Vile",
          forever = true,
          level = "19",
          loot = { 271211, 271212, 271218 },
          name = "Viktor le Vil",
          npc = 256035,
          src = "wowhead"
        },
        {
          display = 144170,
          forever = true,
          level = "19",
          loot = { 271209, 271210, 271217 },
          name = "Bjork",
          npc = 256097,
          src = "wowhead"
        }
      },
      entrance = { map = 1420, src = "jeu", x = 0.627, y = 0.674 },
      quests = {
        [92401] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1421, name = "Tabitha Tissecœur", src = "fdj", x = 0.445, y = 0.43 },
          rewards = { 251485, 251486 },
          src = "client",
          title = "Une requête apeurée"
        },
        [92415] = {
          confirmed = true,
          rewards = { 279870 },
          rewardsSrc = "fdj",
          src = "client",
          title = "N’oublie pas que je t’aime"
        },
        [92421] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1458, name = "Morbin Plaie-lumineuse", src = "fdj", x = 0.579, y = 0.895 },
          rewards = { 279874, 279875 },
          src = "client",
          title = "Justice de la Lumière"
        },
        [92422] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1420, name = "Nécrogarde Kristof", src = "fdj", x = 0.652, y = 0.602 },
          rewards = { 251533, 251534 },
          src = "client",
          title = "La colère de Rath’mael"
        },
        [95189] = { choice = 1, confirmed = true, rewards = { 280567 }, src = "client", title = "Écu de Lordaeron" },
        [95195] = { choice = 2, confirmed = true, rewards = { 279868, 279869 }, src = "client", title = "Insigne ensanglanté" },
        [95204] = { choice = 1, confirmed = true, rewards = { 280567 }, src = "client", title = "Écu de Lordaeron" },
        [95216] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1458, name = "Theodore Griffs", src = "fdj", x = 0.465, y = 0.716 },
          rewards = { 279876, 279877 },
          src = "client",
          title = "La peste nouvelle"
        },
        [95250] = {
          choice = 3,
          confirmed = true,
          rewards = { 279864, 279865, 279867 },
          src = "client",
          title = "Abominables créatures"
        },
        [97288] = {
          choice = 3,
          confirmed = true,
          rewards = { 279864, 279865, 279867 },
          rewardsSrc = "fdj",
          src = "client",
          title = "Tourment interminable"
        }
      }
    },
    -- wowhead forever (zone=1581, pages npc) : noms FR/EN et npcId conformes, butin de base conforme.
    -- à confirmer : 273289, 273293, 273092, 273297, 284715, 273298 existent sur Wowhead Forever sans source de butin (attribution fdj) ; 210178 (Sneed) vu sur Wowhead, non ajouté.
    -- ajoutés : Déchiqueteur de Sneed et Mineur Johnson (rare), butin propre relevé sur Wowhead Forever (avant : lootByNpc seulement, non affiché).
    -- butin : objets bleus de la page Wowhead Forever de chaque boss ajoutés, y compris butin de zone ou commun (taux parfois < 1 %).
    dm = {
      bosses = {
        { display = 14403, forever = true, level = "19", loot = { 872, 5187, 273289 }, name = "Rhahk'Zor", npc = 644, src = "fdj" },
        { display = 7125, forever = true, level = "20", loot = { 5194, 5195, 273293, 273092, 12975, 12978, 12977, 12979, 12982, 935, 12988 }, name = "Sneed", npc = 643, src = "fdj" },
        { display = 7124, forever = true, level = "20", loot = { 1156, 5199, 273297, 12985, 12975, 12982, 12978, 935, 12977, 12976 }, name = "Gilnid", npc = 1763, src = "fdj" },
        {
          display = 7113,
          en = "Captain Greenskin",
          forever = true,
          level = "20",
          loot = { 5201, 10403, 5200, 12994, 935, 12982, 12983, 12975, 12976, 12977, 12979, 2879, 12988 },
          name = "Capitaine Vertepeau",
          npc = 647,
          src = "fdj"
        },
        {
          display = 2026,
          en = "Mr. Smite",
          forever = true,
          level = "20",
          loot = { 7230, 5192, 5196, 284715, 12988, 2879, 12987, 12977, 12978, 935, 12976 },
          name = "M. Smite",
          npc = 646,
          src = "fdj"
        },
        {
          display = 1305,
          en = "Cookie",
          forever = true,
          level = "20",
          loot = { 5198, 5197, 273298, 12977, 12978, 12975, 12976, 12983, 12984, 935 },
          name = "Macaron",
          npc = 645,
          src = "fdj"
        },
        {
          display = 2029,
          forever = true,
          level = "21",
          loot = { 5193, 5202, 10399, 5191, 2874, 12996, 12983, 12984, 12982, 13136, 2879, 2911, 12977 },
          name = "Edwin VanCleef",
          npc = 639,
          src = "fdj"
        },
        {
          display = 1269,
          en = "Sneed's Shredder",
          forever = true,
          level = "20",
          loot = { 1937, 2169, 12976, 935, 12975, 12977, 12978, 12985, 12987 },
          name = "Déchiqueteur de Sneed",
          npc = 642,
          src = "wowhead"
        },
        {
          display = 556,
          en = "Miner Johnson",
          forever = true,
          level = "19",
          loot = { 5443, 5444 },
          name = "Mineur Johnson",
          npc = 3586,
          src = "wowhead"
        }
      },
      entrance = { map = 1436, src = "questie", x = 0.425, y = 0.717 },
      lootByNpc = {
        [598] = { 1930 },
        [622] = { 1936 },
        [634] = { 10400, 10401 },
        [636] = { 1934 },
        [641] = { 1945 },
        [642] = { 1937, 2169 },
        [657] = { 1951 },
        [1729] = { 1929 },
        [1731] = { 1944 },
        [1732] = { 1951 },
        [3586] = { 5443, 5444 },
        [3947] = { 1943 },
        [4416] = { 10402 },
        [4417] = { 10400, 10401 },
        [4418] = { 1929 }
      },
      quests = {
        [166] = {
          chain = { 65, 132, 135, 141, 142, 155 },
          chainSrc = "questie",
          choice = 3,
          confirmed = true,
          giver = { map = 1436, name = "Gryan Roidemantel", npc = 234, src = "site", x = 0.562, y = 0.476 },
          rewards = { 6087, 2041, 2042 },
          src = "client",
          title = "La Confrérie défias",
          turnIn = { map = 1436, name = "Gryan Roidemantel", npc = 234, src = "site", x = 0.562, y = 0.476 }
        },
        [167] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1453, name = "Wilder Crispechardon", npc = 656, src = "site", x = 0.652, y = 0.212 },
          rewards = { 1893, 270012, 270013 },
          src = "client",
          title = "Oh, mon frère…",
          turnIn = { map = 1453, name = "Wilder Crispechardon", npc = 656, src = "site", x = 0.652, y = 0.212 }
        },
        [168] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1453, name = "Wilder Crispechardon", npc = 656, src = "site", x = 0.652, y = 0.212 },
          rewards = { 2037, 2036, 270007 },
          src = "client",
          title = "À la recherche de Cartes du Syndicat des Mineurs",
          turnIn = { map = 1453, name = "Wilder Crispechardon", npc = 656, src = "site", x = 0.652, y = 0.212 }
        },
        [214] = {
          chain = { 65, 132, 135, 141, 142, 155 },
          chainSrc = "questie",
          choice = 4,
          confirmed = true,
          giver = { map = 1436, name = "Eclaireur Riell", npc = 820, src = "site", x = 0.566, y = 0.474 },
          rewards = { 2074, 2089, 6094, 270005 },
          src = "client",
          title = "Les masques rouges en soie",
          turnIn = { map = 1436, name = "Eclaireur Riell", npc = 820, src = "site", x = 0.566, y = 0.474 }
        },
        [373] = {
          confirmed = true,
          src = "client",
          title = "La lettre non envoyée",
          turnIn = { map = 1453, name = "Baros Alexston", npc = 1646, src = "site", x = 0.49, y = 0.302 }
        },
        [1654] = {
          chain = { 1649, 1650, 1651, 1652, 1653 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 },
          src = "client",
          title = "Le test de droiture",
          turnIn = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 }
        },
        [2040] = {
          choice = 4,
          confirmed = true,
          giver = { map = 1453, name = "Shoni la Silencieuse", npc = 6579, src = "site", x = 0.554, y = 0.126 },
          rewards = { 7606, 7607, 270015, 270016 },
          src = "client",
          title = "Assaut souterrain",
          turnIn = { map = 1453, name = "Shoni la Silencieuse", npc = 6579, src = "site", x = 0.554, y = 0.126 }
        },
        [92753] = {
          chain = { 92742, 92744, 92745, 92747, 92748, 92749, 92750, 92751, 92752, 92753, 92819 },
          chainSrc = "fdj",
          confirmed = true,
          src = "client",
          title = "Destruction dans les Mortemines"
        }
      }
    },
    -- wowhead forever (zone=209, pages npc) : noms FR/EN, npcId, display et butin de base conformes.
    -- à confirmer : 273457, 273456, 273637, 273643, 273645, 273646 sans source de butin sur Wowhead Forever (attribution fdj) ; rares Gefell et Gemela (211764, 211765) listés sur Wowhead, non ajoutés.
    -- ajoutés : Palefroi corrompu (6341, 932) et Capitaine Ligemort (6641, 6642), butin propre relevé sur Wowhead Forever (avant : lootByNpc seulement, non affiché).
    -- butin : objets bleus de la page Wowhead Forever de chaque boss ajoutés, y compris butin de zone ou commun (taux parfois < 1 %).
    sfk = {
      bosses = {
        { display = 524, forever = true, level = "20", loot = { 5254, 273457, 273456, 12988, 3194, 12982, 1974, 1484 }, name = "Rethilgore", npc = 3914, src = "fdj" },
        {
          display = 524,
          en = "Razorclaw the Butcher",
          forever = true,
          level = "22",
          loot = { 1292, 6226, 6633, 1974, 3194, 1318 },
          name = "Tranchegriffe le Boucher",
          npc = 3886,
          src = "fdj"
        },
        {
          display = 3222,
          en = "Baron Silverlaine",
          forever = true,
          level = "24",
          loot = { 6321, 6323, 273637, 2205, 1483, 1935, 3194 },
          name = "Baron d'Argelaine",
          npc = 3887,
          src = "fdj"
        },
        {
          display = 3223,
          en = "Commander Springvale",
          forever = true,
          level = "24",
          loot = { 6320, 3191, 273643, 6341, 1483, 1974, 1935, 1318, 1482 },
          name = "Commandant Springvale",
          npc = 4278,
          src = "fdj"
        },
        {
          display = 522,
          en = "Odo the Blindwatcher",
          forever = true,
          level = "24",
          loot = { 6318, 6319, 273645, 2807, 1483, 1935 },
          name = "Odo l'Aveugle",
          npc = 4279,
          src = "fdj"
        },
        {
          display = 2352,
          en = "Fenrus the Devourer",
          forever = true,
          level = "25",
          loot = { 6340, 3230, 273646, 1974, 1318, 3194 },
          name = "Fenrus le Dévoreur",
          npc = 4274,
          src = "fdj"
        },
        {
          display = 11179,
          en = "Wolf Master Nandos",
          forever = true,
          level = "25",
          loot = { 3748, 6314, 2292, 1318 },
          name = "Maître-loup Nandos",
          npc = 3927,
          src = "fdj"
        },
        {
          display = 2353,
          en = "Archmage Arugal",
          forever = true,
          level = "26",
          loot = { 6324, 6392, 6220, 1482, 3194, 1484, 2807 },
          name = "Archimage Arugal",
          npc = 4275,
          src = "fdj"
        },
        {
          display = 1951,
          en = "Fel Steed",
          forever = true,
          level = "20",
          loot = { 6341, 932, 13136, 1483, 12977 },
          name = "Palefroi corrompu",
          npc = 3864,
          src = "wowhead"
        },
        {
          display = 3224,
          en = "Deathsworn Captain",
          forever = true,
          level = "25",
          loot = { 6641, 6642, 2205 },
          name = "Capitaine Ligemort",
          npc = 3872,
          src = "wowhead"
        }
      },
      entrance = { map = 1421, src = "questie", x = 0.448, y = 0.678 },
      lootByNpc = { [3864] = { 6341 }, [3872] = { 6641, 6642 } },
      quests = {
        [1013] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1458, name = "Gardien Bel'dugur", npc = 2934, src = "site", x = 0.536, y = 0.54 },
          rewards = { 6335, 4534, 270030 },
          src = "client",
          title = "Le Livre d'Ur",
          turnIn = { map = 1458, name = "Gardien Bel'dugur", npc = 2934, src = "site", x = 0.536, y = 0.54 }
        },
        [1014] = {
          confirmed = true,
          giver = { map = 1421, name = "Dalar Tisselaube", npc = 1938, src = "site", x = 0.442, y = 0.398 },
          rewards = { 6414 },
          src = "client",
          title = "Arugal doit mourir",
          turnIn = { map = 1421, name = "Dalar Tisselaube", npc = 1938, src = "site", x = 0.442, y = 0.398 }
        },
        [1098] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1421, name = "Grand exécuteur Hadrec", npc = 1952, src = "site", x = 0.434, y = 0.408 },
          rewards = { 3324, 270023, 270024 },
          src = "client",
          title = "Des Traqueurs noirs à Ombrecroc"
        },
        [1654] = {
          chain = { 1649, 1650, 1651, 1652, 1653 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 },
          src = "client",
          title = "Le test de droiture",
          turnIn = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 }
        },
        [1740] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1413, name = "Doan Karhan", npc = 6247, src = "site", x = 0.492, y = 0.572 },
          rewards = { 6898, 15109 },
          src = "client",
          title = "L'Orbe de Soran'ruk",
          turnIn = { map = 1413, name = "Doan Karhan", npc = 6247, src = "site", x = 0.492, y = 0.572 }
        }
      }
    },
    -- wowhead forever (zone=717, pages npc) : npcId, display, niveaux, butin bleu de la page de chaque boss (surtout butin de zone ou commun, taux < 2 %).
    -- Bruegal Ironknuckle (rare) : butin propre 3228, 2941, 2942 (avant : lootByNpc seulement, non affiché).
    stocks = {
      bosses = {
        {
          display = 517,
          en = "Targorr the Dread",
          forever = true,
          level = "24",
          loot = { 12992, 1121, 12987, 890, 2059, 12990, 2256, 2800, 13041 },
          name = "Targorr le Terrifiant",
          npc = 1696,
          src = "wowhead"
        },
        {
          display = 825,
          forever = true,
          level = "27",
          loot = { 2280, 13062, 2098, 3203, 13032 },
          name = "Kam Deepfury",
          npc = 1666,
          src = "questie"
        },
        {
          display = 3250,
          forever = true,
          level = "28",
          loot = { 13057, 4298, 3203, 13031, 13016, 720, 13062 },
          name = "Hamhock",
          npc = 1717,
          src = "wowhead"
        },
        {
          display = 1621,
          forever = true,
          level = "29",
          loot = { 2098, 3203, 1717, 13012, 13094, 720, 13049, 2912, 13024, 13057, 13106, 13131 },
          name = "Bazil Thredd",
          npc = 1716,
          src = "wowhead"
        },
        {
          display = 2149,
          forever = true,
          level = "26",
          loot = { 13024, 13049 },
          name = "Dextren Ward",
          npc = 1663,
          src = "wowhead"
        },
        {
          display = 2142,
          forever = true,
          level = "26",
          loot = { 3228, 2941, 2942 },
          name = "Bruegal Ironknuckle",
          npc = 1720,
          src = "wowhead"
        }
      },
      entrance = { map = 1453, src = "questie", x = 0.423, y = 0.589 },
      hide = { 2, 4, 6, 8 },
      lootByNpc = { [1720] = { 2941, 2942, 3228 } },
      quests = {
        [377] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1431, name = "Conseiller Millstipe", npc = 270, src = "site", x = 0.72, y = 0.478 },
          rewards = { 2033, 2906, 270029 },
          src = "client",
          title = "Crime et Châtiments",
          turnIn = { map = 1431, name = "Conseiller Millstipe", npc = 270, src = "site", x = 0.72, y = 0.478 }
        },
        [378] = {
          chain = { 303 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1437, name = "Motley Garmaçon", npc = 1074, src = "site", x = 0.496, y = 0.182 },
          src = "questie",
          turnIn = { map = 1437, name = "Motley Garmaçon", npc = 1074, src = "site", x = 0.496, y = 0.182 }
        },
        [386] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1433, name = "Garde Berton", npc = 859, src = "site", x = 0.264, y = 0.466 },
          rewards = { 3400, 1317, 270027 },
          src = "client",
          title = "Ce qui se passait ailleurs…",
          turnIn = { map = 1433, name = "Garde Berton", npc = 859, src = "site", x = 0.264, y = 0.466 }
        },
        [387] = {
          confirmed = true,
          giver = { map = 1453, name = "Gardien Thelwater", npc = 1719, src = "site", x = 0.412, y = 0.58 },
          src = "client",
          title = "Écraser la rébellion",
          turnIn = { map = 1453, name = "Gardien Thelwater", npc = 1719, src = "site", x = 0.412, y = 0.58 }
        },
        [388] = {
          confirmed = true,
          giver = { map = 1453, name = "Nikova Raskol", npc = 1721, src = "questie", x = 0.6993, y = 0.3905 },
          src = "client",
          title = "La couleur du Sang",
          turnIn = { map = 1453, name = "Nikova Raskol", npc = 1721, src = "questie", x = 0.6993, y = 0.3905 }
        },
        [391] = {
          chain = { 373, 389 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1453, name = "Gardien Thelwater", npc = 1719, src = "site", x = 0.412, y = 0.58 },
          src = "client",
          title = "Les Emeutes de la Prison",
          turnIn = { map = 1453, name = "Gardien Thelwater", npc = 1719, src = "site", x = 0.412, y = 0.58 }
        }
      }
    },
    -- wowhead forever (zone=719, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin de zone ou commun).
    -- Dame Sarevess, Kelris, Vieux Serra'kis : butin propre (avant : lootByNpc seulement, non affiché). À confirmer : 273839 (Ghamoo-ra), 273843 (Lorgus Jett), attribution fdj.
    bfd = {
      bosses = {
        {
          display = 5027,
          forever = true,
          level = "25",
          loot = { 6908, 6907, 273839, 3416, 3415, 1486, 2567, 3413, 3417, 2271 },
          name = "Ghamoo-ra",
          npc = 4887,
          src = "fdj"
        },
        {
          display = 4979,
          en = "Lady Sarevess",
          forever = true,
          level = "25",
          loot = { 11121, 888, 3078 },
          name = "Dame Sarevess",
          npc = 4831,
          src = "wowhead"
        },
        {
          display = 1773,
          forever = true,
          level = "26",
          loot = { 6905, 6906, 1470, 1491, 1454 },
          name = "Gelihast",
          npc = 6243,
          src = "fdj"
        },
        {
          display = 12822,
          forever = true,
          level = "26",
          loot = { 273843 },
          name = "Lorgus Jett",
          npc = 12902,
          src = "fdj"
        },
        {
          display = 110,
          forever = true,
          level = "28",
          loot = { 16782, 2271 },
          name = "Baron Aquanis",
          npc = 12876,
          src = "fdj"
        },
        {
          display = 4939,
          en = "Twilight Lord Kelris",
          forever = true,
          level = "27",
          loot = { 1155, 6903, 3413, 3416 },
          name = "Seigneur du crépuscule Kelris",
          npc = 4832,
          src = "wowhead"
        },
        {
          display = 1816,
          en = "Old Serra'kis",
          forever = true,
          level = "26",
          loot = { 6901, 6902, 6904, 1454, 3417 },
          name = "Vieux Serra'kis",
          npc = 4830,
          src = "wowhead"
        },
        {
          display = 2837,
          forever = true,
          level = "28",
          loot = { 6911, 6910, 6909, 3416 },
          name = "Aku'mai",
          npc = 4829,
          src = "fdj"
        },
        {
          display = 4946,
          en = "Argent Guard Thaelrid",
          forever = true,
          level = "20",
          name = "Garde d'argent Thaelrid",
          npc = 4787,
          quest = true,
          src = "wowhead"
        }
      },
      entrance = { map = 1440, src = "questie", x = 0.145, y = 0.142 },
      fixIds = { [1] = 6564 },
      hide = { 11 },
      lootByNpc = { [4830] = { 6901, 6902, 6904 }, [4831] = { 888, 3078, 11121 }, [4832] = { 1155, 6903 } },
      quests = {
        [971] = {
          confirmed = true,
          giver = { map = 1455, name = "Gerrig Poigne-d'os", npc = 2786, src = "site", x = 0.504, y = 0.06 },
          rewards = { 6743 },
          src = "client",
          title = "La connaissance des profondeurs",
          turnIn = { map = 1455, name = "Gerrig Poigne-d'os", npc = 2786, src = "site", x = 0.504, y = 0.06 }
        },
        [1198] = {
          confirmed = true,
          giver = { map = 1457, name = "Veilleur de l'aube Shaedlass", npc = 4786, src = "site", x = 0.554, y = 0.246 },
          src = "client",
          title = "À la recherche de Thaelrid"
        },
        [1199] = {
          confirmed = true,
          giver = { map = 1457, name = "Garde d'argent Manados", npc = 4784, src = "site", x = 0.552, y = 0.236 },
          rewards = { 6998, 7000, 270025 },
          src = "client",
          title = "Le crépuscule descend",
          turnIn = { map = 1457, name = "Garde d'argent Manados", npc = 4784, src = "site", x = 0.552, y = 0.236 }
        },
        [1200] = {
          chain = { 1198 },
          chainSrc = "questie",
          choice = 4,
          confirmed = true,
          rewards = { 7001, 7002, 270031, 270032 },
          src = "client",
          title = "L'infamie de Brassenoire",
          turnIn = { map = 1457, name = "Veilleur de l'aube Selgorm", npc = 4783, src = "site", x = 0.558, y = 0.242 }
        },
        [1275] = {
          chain = { 3765 },
          chainSrc = "questie",
          choice = 3,
          confirmed = true,
          giver = { map = 1439, name = "Gershala Murmenuit", npc = 8997, src = "site", x = 0.384, y = 0.43 },
          rewards = { 7003, 7004, 270021 },
          src = "client",
          title = "Recherches sur la corruption",
          turnIn = { map = 1439, name = "Gershala Murmenuit", npc = 8997, src = "site", x = 0.384, y = 0.43 }
        },
        [1654] = {
          chain = { 1649, 1650, 1651, 1652, 1653 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 },
          src = "client",
          title = "Le test de droiture",
          turnIn = { map = 1426, name = "Jordan Morpuits", npc = 6181, src = "site", x = 0.524, y = 0.368 }
        },
        [1740] = {
          choice = 2,
          confirmed = true,
          giver = { map = 1413, name = "Doan Karhan", npc = 6247, src = "site", x = 0.492, y = 0.572 },
          rewards = { 6898, 15109 },
          src = "client",
          title = "L'Orbe de Soran'ruk",
          turnIn = { map = 1413, name = "Doan Karhan", npc = 6247, src = "site", x = 0.492, y = 0.572 }
        },
        [6561] = {
          choice = 4,
          confirmed = true,
          rewards = { 7001, 7002, 270031, 270032 },
          src = "client",
          title = "L'infamie de Brassenoire",
          turnIn = { map = 1456, name = "Bashana Totem-runique", npc = 9087, src = "site", x = 0.708, y = 0.338 }
        },
        [6562] = {
          confirmed = true,
          giver = { map = 1442, name = "Tsunaman", npc = 11862, src = "questie", x = 0.4736, y = 0.6425 },
          minLevel = 17,
          src = "client",
          title = "Problèmes dans les profondeurs",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "questie", x = 0.1156, y = 0.3429 }
        },
        [6563] = {
          chain = { 6562 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 },
          src = "client",
          title = "L'Essence d'Aku'Mai",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 }
        },
        [6564] = {
          confirmed = true,
          minLevel = 17,
          src = "client",
          title = "Allégeance aux Dieux très anciens",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "questie", x = 0.1156, y = 0.3429 }
        },
        [6565] = {
          chain = { 6564 },
          chainSrc = "questie",
          choice = 2,
          confirmed = true,
          giver = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 },
          rewards = { 17694, 17695 },
          src = "client",
          title = "Allégeance aux Dieux très anciens",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 }
        },
        [6921] = {
          confirmed = true,
          giver = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 },
          src = "client",
          title = "Parmi les ruines",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 }
        },
        [6922] = {
          choice = 3,
          confirmed = true,
          rewards = { 16886, 16887, 270043 },
          src = "client",
          title = "Baron Aquanis",
          turnIn = { map = 1440, name = "Je'neu Sancrea", npc = 12736, src = "site", x = 0.116, y = 0.342 }
        }
      }
    },
    excav = {
      bosses = {
        { en = "Saltspine", name = "Échine-de-sel" },
        { en = "Shadetooth", name = "Dent-d'ombre" },
        { en = "Highland Horror", name = "Horreur des hautes-terres" },
        { en = "Relic Guardian", name = "Gardien des reliques" }
      }
    },
    -- wowhead forever (Monastère écarlate, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss. Noms du jeu (Wowhead FR) : Herod, Interrogateur Vishas.
    -- rares du Cimetière ajoutés (npc 6488, 6489, 6490) : noms FR officiels, butin propre relevé.
    sm = {
      bosses = {
        {
          display = 2044,
          en = "Interrogator Vishas",
          forever = true,
          level = "32",
          loot = { 7683, 7682, 7727, 4301, 7752 },
          name = "Interrogateur Vishas",
          npc = 3983,
          src = "wowhead"
        },
        {
          display = 11396,
          en = "Bloodmage Thalnos",
          forever = true,
          level = "34",
          loot = { 7685, 7684, 3871, 7754, 10332 },
          name = "Mage de sang Thalnos",
          npc = 4543,
          src = "wowhead"
        },
        {
          display = 2040,
          en = "Houndmaster Loksey",
          forever = true,
          level = "34",
          loot = { 7710, 7727, 7786, 10332 },
          name = "Maître-chien Loksey",
          npc = 3974,
          src = "wowhead"
        },
        {
          display = 5266,
          en = "Arcanist Doan",
          forever = true,
          level = "37",
          loot = { 7714, 7713, 7754 },
          name = "Arcaniste Doan",
          npc = 6487,
          src = "wowhead"
        },
        {
          display = 2041,
          en = "Herod",
          forever = true,
          level = "40",
          loot = { 7719, 10330, 7717, 7730 },
          name = "Herod",
          npc = 3975,
          src = "wowhead"
        },
        {
          display = 2605,
          en = "High Inquisitor Fairbanks",
          forever = true,
          level = "40",
          loot = { 19507, 19508, 19509, 7730, 7786, 10332 },
          name = "Grand Inquisiteur Fairbanks",
          npc = 4542,
          src = "wowhead"
        },
        {
          display = 2042,
          en = "Scarlet Commander Mograine",
          forever = true,
          level = "42",
          loot = { 7726, 7724, 7723, 10330, 7752, 7757 },
          name = "Commandant écarlate Mograine",
          npc = 3976,
          src = "wowhead"
        },
        {
          display = 2043,
          en = "High Inquisitor Whitemane",
          forever = true,
          level = "42",
          loot = { 7721, 1204 },
          name = "Grand Inquisiteur Whitemane",
          npc = 3977,
          src = "wowhead"
        },
        {
          display = 5534,
          en = "Azshir the Sleepless",
          forever = true,
          level = "33",
          loot = { 7731, 7708, 7709, 7730 },
          name = "Azshir le Sans-sommeil",
          npc = 6490,
          src = "wowhead"
        },
        {
          display = 5231,
          en = "Ironspine",
          forever = true,
          level = "33",
          loot = { 7686, 7688, 7687, 7754 },
          name = "Échine-de-fer",
          npc = 6489,
          src = "wowhead"
        },
        {
          display = 5230,
          en = "Fallen Champion",
          forever = true,
          level = "33",
          loot = { 7690, 7691, 7689 },
          name = "Champion mort",
          npc = 6488,
          src = "wowhead"
        }
      },
      entrance = { map = 1420, src = "questie", x = 0.826, y = 0.338 },
      hide = { 9, 10, 11, 12, 13, 14, 15 },
      lootByNpc = { [3976] = { 7726 }, [3983] = { 7682, 7683 } },
      quests = {
        [1048] = {
          confirmed = false,
          giver = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 },
          src = "questie",
          turnIn = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 }
        },
        [1049] = {
          confirmed = false,
          giver = { map = 1456, name = "Sage Recherche-la-vérité", npc = 3978, src = "site", x = 0.346, y = 0.472 },
          src = "questie",
          turnIn = { map = 1456, name = "Sage Recherche-la-vérité", npc = 3978, src = "site", x = 0.346, y = 0.472 }
        },
        [1050] = {
          confirmed = false,
          giver = { map = 1455, name = "Bibliothécaire Mae Blêmepoussière", npc = 3979, src = "site", x = 0.746, y = 0.126 },
          src = "questie",
          turnIn = { map = 1455, name = "Bibliothécaire Mae Blêmepoussière", npc = 3979, src = "site", x = 0.746, y = 0.126 }
        },
        [1051] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1424, name = "Monika Sengutz", npc = 3982, src = "site", x = 0.626, y = 0.19 }
        },
        [1053] = {
          chain = { 261, 1052 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1424, name = "Raleigh le Dévot", npc = 3980, src = "site", x = 0.514, y = 0.584 },
          src = "questie",
          turnIn = { map = 1424, name = "Raleigh le Dévot", npc = 3980, src = "site", x = 0.514, y = 0.584 }
        },
        [1113] = {
          chain = { 1109 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1458, name = "Maître apothicaire Faranell", npc = 2055, src = "site", x = 0.484, y = 0.694 },
          src = "questie",
          turnIn = { map = 1458, name = "Maître apothicaire Faranell", npc = 2055, src = "site", x = 0.484, y = 0.694 }
        },
        [1160] = {
          chain = { 1149, 1150, 1151, 1152, 1154, 6627, 1159 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1458, name = "Parqual Fintallas", npc = 4488, src = "site", x = 0.578, y = 0.65 },
          src = "questie",
          turnIn = { map = 1458, name = "Parqual Fintallas", npc = 4488, src = "site", x = 0.578, y = 0.65 }
        },
        [1951] = {
          chain = { 1947, 1949, 1950 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1441, name = "Magus Tirth", npc = 6548, src = "site", x = 0.782, y = 0.758 },
          src = "questie",
          turnIn = { map = 1445, name = "Tabetha", npc = 6546, src = "site", x = 0.46, y = 0.57 }
        }
      }
    },
    cod = {
      bosses = {
        { en = "Arcane Anomaly", name = "Anomalie arcanique" },
        { en = "Fel Ancient", name = "Ancien gangrené" },
        { en = "Mana Devourer", name = "Dévoreur de mana" },
        { en = "Mana Elemental", name = "Élémentaire de mana" },
        { en = "Unstable Sentinel", name = "Sentinelle instable" },
        { en = "Shade of the Archmage", name = "Ombre de l'archimage" },
        { en = "Lyn the Ignored", name = "Lyn l'Ignorée" },
        { en = "Atrexis the Grave Knight", name = "Atrexis le Chevalier des tombes" },
        { en = "Mana Wraith", name = "Spectre de mana" }
      }
    },
    -- wowhead forever (zone=721, pages npc) : npcId, display, niveaux, noms FR/EN officiels (Faucheur de foule 9-60, Mekgénieur Thermaplugg, Ambassadeur Sombrefer), butin bleu de chaque page.
    -- ajoutés : Techbot, Ambassadeur Sombrefer (rare). Butin propre des boss qui était seulement dans lootByNpc (non affiché) désormais sur le boss.
    gnomer = {
      bosses = {
        {
          display = 7288,
          forever = true,
          level = "26",
          loot = { 2011, 9490, 12998 },
          name = "Techbot",
          npc = 6231,
          src = "wowhead"
        },
        {
          display = 144378,
          forever = true,
          level = "32",
          loot = { 9445 },
          name = "Grubbis",
          npc = 7361,
          src = "wowhead"
        },
        {
          display = 5497,
          en = "Viscous Fallout",
          forever = true,
          level = "30",
          loot = { 9454, 9452, 9453, 9509 },
          name = "Retombée visqueuse",
          npc = 7079,
          src = "wowhead"
        },
        {
          display = 6915,
          en = "Electrocutioner 6000",
          forever = true,
          level = "32",
          loot = { 9448, 9447, 9446, 9510 },
          name = "Électrocuteur 6000",
          npc = 6235,
          src = "wowhead"
        },
        {
          display = 6774,
          en = "Crowd Pummeler 9-60",
          forever = true,
          level = "32",
          loot = { 9450, 9449 },
          name = "Faucheur de foule 9-60",
          npc = 6229,
          src = "wowhead"
        },
        {
          display = 6980,
          en = "Mekgineer Thermaplugg",
          forever = true,
          level = "34",
          loot = { 9461, 9458, 4415 },
          name = "Mekgénieur Thermaplugg",
          npc = 7800,
          src = "wowhead"
        },
        {
          display = 6669,
          en = "Dark Iron Ambassador",
          forever = true,
          level = "33",
          loot = { 14549, 868, 867 },
          name = "Ambassadeur Sombrefer",
          npc = 6228,
          src = "wowhead"
        }
      },
      entrance = { map = 1426, src = "questie", x = 0.243, y = 0.398 },
      hide = { 10, 13 },
      lootByNpc = { [6229] = { 9449, 9450 }, [6235] = { 9446 }, [7079] = { 9452, 9453, 9454 }, [9676] = { 2901, 5956 } },
      quests = {
        [2841] = {
          confirmed = false,
          giver = { map = 1454, name = "Nogg", npc = 3412, src = "site", x = 0.758, y = 0.252 },
          src = "questie",
          turnIn = { map = 1454, name = "Nogg", npc = 3412, src = "site", x = 0.758, y = 0.252 }
        },
        [2842] = {
          confirmed = true,
          giver = { map = 1454, name = "Sovik", npc = 3413, src = "site", x = 0.756, y = 0.252 },
          src = "client",
          title = "L'ingénieur en chef Scooty",
          turnIn = { map = 1434, name = "Scooty", npc = 7853, src = "site", x = 0.276, y = 0.774 }
        },
        [2843] = {
          chain = { 2842 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1434, name = "Scooty", npc = 7853, src = "site", x = 0.276, y = 0.774 },
          rewards = { 9173 },
          src = "client",
          title = "Gnomer-paaarti !",
          turnIn = { map = 1434, name = "Scooty", npc = 7853, src = "site", x = 0.276, y = 0.774 }
        },
        [2904] = {
          choice = 3,
          confirmed = true,
          rewards = { 9535, 9536, 270042 },
          src = "client",
          title = "Une jolie pagaille",
          turnIn = { map = 1434, name = "Scooty", npc = 7853, src = "site", x = 0.276, y = 0.774 }
        },
        [2922] = {
          chain = { 2923 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1455, name = "Maître-bricoleur Suprétincelle", npc = 7944, src = "site", x = 0.698, y = 0.502 },
          src = "client",
          title = "Sauver le cerveau de Techbot !",
          turnIn = { map = 1455, name = "Maître-bricoleur Suprétincelle", npc = 7944, src = "site", x = 0.698, y = 0.502 }
        },
        [2923] = {
          confirmed = true,
          giver = { map = 1453, name = "Maître-artisan Overspark", npc = 7917, src = "questie", x = 0.4055, y = 0.3096 },
          minLevel = 20,
          src = "client",
          title = "Maître-artisan Overspark",
          turnIn = { map = 1455, name = "Maître-artisan Overspark", npc = 7944, src = "questie", x = 0.6955, y = 0.5033 }
        },
        [2924] = {
          confirmed = false,
          giver = { map = 1455, name = "Pléthorloge Cléventail", npc = 6169, src = "site", x = 0.682, y = 0.462 },
          src = "questie",
          turnIn = { map = 1455, name = "Pléthorloge Cléventail", npc = 6169, src = "site", x = 0.682, y = 0.462 }
        },
        [2926] = {
          chain = { 2927 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1426, name = "Ozzie Virevolt", npc = 1268, src = "site", x = 0.458, y = 0.492 },
          src = "client",
          title = "Gnogaine",
          turnIn = { map = 1426, name = "Ozzie Virevolt", npc = 1268, src = "site", x = 0.458, y = 0.492 }
        },
        [2927] = {
          confirmed = true,
          giver = { map = 1455, name = "Gnoarn", npc = 6569, src = "questie", x = 0.6918, y = 0.5055 },
          minLevel = 20,
          src = "client",
          title = "Le jour d'après",
          turnIn = { map = 1426, name = "Ozzie Togglevolt", npc = 1268, src = "questie", x = 0.4589, y = 0.4939 }
        },
        [2928] = {
          choice = 3,
          confirmed = true,
          giver = { map = 1453, name = "Shoni la Silencieuse", npc = 6579, src = "site", x = 0.554, y = 0.126 },
          rewards = { 9608, 9609, 270045 },
          src = "client",
          title = "Excavateurs gyrodrilmatiques",
          turnIn = { map = 1453, name = "Shoni la Silencieuse", npc = 6579, src = "site", x = 0.554, y = 0.126 }
        },
        [2929] = {
          confirmed = false,
          giver = { map = 1455, name = "Grand Bricoleur Mekkanivelle", npc = 7937, src = "site", x = 0.69, y = 0.49 },
          src = "questie",
          turnIn = { map = 1455, name = "Grand Bricoleur Mekkanivelle", npc = 7937, src = "site", x = 0.69, y = 0.49 }
        },
        [2930] = {
          confirmed = false,
          giver = { map = 1455, name = "Maître mécanicien Fontuyau", npc = 7950, src = "site", x = 0.698, y = 0.484 },
          src = "questie",
          turnIn = { map = 1455, name = "Maître mécanicien Fontuyau", npc = 7950, src = "site", x = 0.698, y = 0.484 }
        },
        [2945] = { confirmed = false, src = "questie" },
        [2951] = { confirmed = false, src = "questie" },
        [2962] = {
          chain = { 2927, 2926 },
          chainSrc = "questie",
          confirmed = true,
          giver = { map = 1426, name = "Ozzie Virevolt", npc = 1268, src = "site", x = 0.458, y = 0.492 },
          src = "client",
          title = "Encore plus de Lueur verte !",
          turnIn = { map = 1426, name = "Ozzie Virevolt", npc = 1268, src = "site", x = 0.458, y = 0.492 }
        }
      }
    },
    -- wowhead forever (zone=491, pages npc) : npcId, display, niveaux, noms FR/EN officiels (Aggem Mantépine, Agathelos l'Enragé), butin bleu propre à chaque boss.
    -- rares ajoutés (liste Atlas) : Lanceur de Tranchebauge, Chasseur aveugle, Implorateur de la terre Halmgar. Roogug : aucun butin bleu.
    -- à confirmer : 6679 (Lanceur, attribution fdj, absent de Wowhead Forever) ; 2264 (Halmgar, 13 % sur Wowhead) non ajouté.
    -- butin : objets bleus de la page Wowhead Forever de chaque boss ajoutés, y compris butin de zone ou commun (taux parfois < 1 %).
    rfk = {
      bosses = {
        {
          display = 6110,
          forever = true,
          level = "28",
          loot = { 1978 },
          name = "Roogug",
          npc = 6168,
          src = "wowhead"
        },
        {
          display = 6097,
          en = "Aggem Thorncurse",
          forever = true,
          level = "30",
          loot = { 6681, 1978, 2549, 1976 },
          name = "Aggem Mantépine",
          npc = 4424,
          src = "wowhead"
        },
        {
          display = 4644,
          en = "Death Speaker Jargba",
          forever = true,
          level = "30",
          loot = { 2816, 6682, 6685, 2039, 2264 },
          name = "Nécrorateur Jargba",
          npc = 4428,
          src = "wowhead"
        },
        {
          display = 4652,
          en = "Overlord Ramtusk",
          forever = true,
          level = "32",
          loot = { 6686, 6687, 1978 },
          name = "Seigneur Brusquebroche",
          npc = 4420,
          src = "wowhead"
        },
        {
          display = 2450,
          en = "Agathelos the Raging",
          forever = true,
          level = "33",
          loot = { 6690, 6691 },
          name = "Agathelos l'Enragé",
          npc = 4422,
          src = "wowhead"
        },
        {
          display = 4642,
          en = "Charlga Razorflank",
          forever = true,
          level = "33",
          loot = { 6692, 6693, 1976 },
          name = "Charlga Trancheflanc",
          npc = 4421,
          src = "wowhead"
        },
        {
          display = 6078,
          en = "Razorfen Spearhide",
          forever = true,
          level = "29",
          loot = { 6679, 1978, 2549 },
          name = "Lanceur de Tranchebauge",
          npc = 4438,
          src = "fdj"
        },
        {
          display = 4735,
          en = "Blind Hunter",
          forever = true,
          level = "32",
          loot = { 6695, 6696, 6697 },
          name = "Chasseur aveugle",
          npc = 4425,
          src = "wowhead"
        },
        {
          display = 6102,
          en = "Earthcaller Halmgar",
          forever = true,
          level = "32",
          loot = { 6688, 2264 },
          name = "Implorateur de la terre Halmgar",
          npc = 4842,
          src = "wowhead"
        }
      },
      entrance = { map = 1413, src = "questie", x = 0.429, y = 0.902 },
      hide = { 4 },
      lootByNpc = {
        [4420] = { 6686, 6687 },
        [4424] = { 6681 },
        [4428] = { 2816, 6682, 6685 },
        [4438] = { 6679 },
        [4842] = { 6688 }
      },
      quests = {
        [1101] = {
          chain = { 1100 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1444, name = "Falfindel Gardevoie", npc = 4048, src = "site", x = 0.896, y = 0.464 },
          src = "questie",
          turnIn = { map = 1444, name = "Falfindel Gardevoie", npc = 4048, src = "site", x = 0.896, y = 0.464 }
        },
        [1102] = {
          confirmed = false,
          giver = { map = 1456, name = "Cime-de-pierre le Vieil", npc = 4451, src = "site", x = 0.362, y = 0.598 },
          src = "questie",
          turnIn = { map = 1456, name = "Cime-de-pierre le Vieil", npc = 4451, src = "site", x = 0.362, y = 0.598 }
        },
        [1109] = {
          confirmed = false,
          giver = { map = 1458, name = "Maître apothicaire Faranell", npc = 2055, src = "site", x = 0.484, y = 0.694 },
          src = "questie",
          turnIn = { map = 1458, name = "Maître apothicaire Faranell", npc = 2055, src = "site", x = 0.484, y = 0.694 }
        },
        [1142] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1457, name = "Treshala Ruissefriche", npc = 4521, src = "site", x = 0.694, y = 0.674 }
        },
        [1144] = {
          choice = 4,
          confirmed = true,
          rewards = { 6748, 6750, 6749, 274078 },
          src = "client",
          title = "Willix l’Importateur"
        },
        [1221] = {
          confirmed = true,
          giver = { map = 1413, name = "Mebok Mizzyrix", npc = 3446, src = "site", x = 0.624, y = 0.376 },
          rewards = { 6755 },
          src = "client",
          title = "Racines de Feuillebleue",
          turnIn = { map = 1413, name = "Mebok Mizzyrix", npc = 3446, src = "site", x = 0.624, y = 0.376 }
        },
        [6522] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 }
        }
      }
    },
    -- wowhead forever (zone=722, pages npc) : npcId, display, niveaux, noms EN et butin propre à chaque boss ajoutés.
    -- à confirmer : butin classique absent de Wowhead Forever (10776, 10777 Tuten'kash ; 10769, 10770 Mordresh). loot = {} : aucun butin bleu (Pestegueule, Groinfendu, Dame Falther'ess).
    rfd = {
      bosses = {
        {
          display = 7845,
          forever = true,
          level = "40",
          loot = { 10775 },
          name = "Tuten'kash",
          npc = 7355,
          src = "wowhead"
        },
        {
          display = 8055,
          en = "Mordresh Fire Eye",
          forever = true,
          level = "39",
          loot = { 10771 },
          name = "Mordresh Oeil-de-feu",
          npc = 7357,
          src = "wowhead"
        },
        {
          display = 7864,
          en = "Glutton",
          forever = true,
          level = "40",
          loot = { 10772, 10774 },
          name = "Glouton",
          npc = 8567,
          src = "wowhead"
        },
        {
          display = 7971,
          en = "Amnennar the Coldbringer",
          forever = true,
          level = "41",
          loot = { 10761, 10762, 10763, 10764, 10765 },
          name = "Amnennar le Porte-froid",
          npc = 7358,
          src = "wowhead"
        },
        {
          display = 6124,
          en = "Plaguemaw the Rotting",
          forever = true,
          level = "40",
          loot = {},
          name = "Pestegueule le Pourrissant",
          npc = 7356,
          src = "wowhead"
        },
        {
          display = 11382,
          en = "Ragglesnout",
          forever = true,
          level = "40",
          loot = {},
          name = "Groinfendu",
          npc = 7354,
          src = "wowhead"
        },
        {
          display = 10698,
          en = "Lady Falther'ess",
          forever = true,
          level = "40",
          loot = {},
          name = "Dame Falther'ess",
          npc = 14686,
          src = "wowhead"
        }
      },
      entrance = { map = 1413, src = "questie", x = 0.49, y = 0.939 },
      quests = {
        [3341] = {
          confirmed = false,
          giver = { map = 1458, name = "Andrew Brownell", npc = 2308, src = "site", x = 0.74, y = 0.328 },
          src = "questie",
          turnIn = { map = 1458, name = "Andrew Brownell", npc = 2308, src = "site", x = 0.74, y = 0.328 }
        },
        [3523] = { confirmed = false, src = "questie" },
        [3525] = { chain = { 3523 }, chainSrc = "questie", confirmed = false, src = "questie" },
        [3636] = {
          confirmed = false,
          giver = { map = 1453, name = "Archevêque Benedictus", npc = 1284, src = "site", x = 0.396, y = 0.274 },
          src = "questie",
          turnIn = { map = 1453, name = "Archevêque Benedictus", npc = 1284, src = "site", x = 0.396, y = 0.274 }
        },
        [6521] = {
          chain = { 6522 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 },
          src = "questie",
          turnIn = { map = 1458, name = "Varimathras", npc = 2425, src = "site", x = 0.562, y = 0.926 }
        },
        [6626] = {
          confirmed = false,
          giver = { map = 1413, name = "Myriam Chantelune", npc = 12866, src = "site", x = 0.49, y = 0.948 },
          src = "questie",
          turnIn = { map = 1413, name = "Myriam Chantelune", npc = 12866, src = "site", x = 0.49, y = 0.948 }
        }
      }
    },
    -- wowhead forever (zone=1337, pages npc) : npcId, display, niveaux, noms EN et butin bleu relevé ajoutés.
    -- à confirmer : pas de butin bleu relevé sur Wowhead Forever pour Baelog, Eric, Olaf, Sentinelle, Galgann, Archaedas ; butin classique absent (ex. 9387, 9388 Revelosh ; 9408, 9409 Ironaya ; 9410 Ancien gardien) ; 9384 (Sentinelle, 3 %) non ajouté.
    -- butin : objets bleus de la page Wowhead Forever de chaque boss ajoutés, y compris butin de zone ou commun (taux parfois < 1 %).
    ulda = {
      bosses = {
        {
          display = 5945,
          forever = true,
          level = "40",
          loot = { 9389, 9390 },
          name = "Revelosh",
          npc = 6910,
          src = "wowhead"
        },
        {
          display = 5710,
          forever = true,
          level = "41",
          name = "Baelog",
          npc = 6906,
          src = "wowhead"
        },
        {
          display = 5708,
          en = "Eric \"The Swift\"",
          forever = true,
          level = "40",
          loot = { 870 },
          name = "Eric « l'Agile »",
          npc = 6907,
          src = "wowhead"
        },
        {
          display = 5709,
          forever = true,
          level = "40",
          name = "Olaf",
          npc = 6908,
          src = "wowhead"
        },
        {
          display = 6089,
          forever = true,
          level = "40",
          loot = { 9407, 10605 },
          name = "Ironaya",
          npc = 7228,
          src = "wowhead"
        },
        {
          display = 5285,
          en = "Obsidian Sentinel",
          forever = true,
          level = "42",
          loot = { 9384 },
          name = "Sentinelle d'obsidienne",
          npc = 7023,
          src = "wowhead"
        },
        {
          display = 10798,
          en = "Ancient Stone Keeper",
          forever = true,
          level = "44",
          loot = { 9411 },
          name = "Ancien gardien des pierres",
          npc = 7206,
          src = "wowhead"
        },
        {
          display = 6059,
          en = "Galgann Firehammer",
          forever = true,
          level = "45",
          name = "Galgann Martel-de-feu",
          npc = 7291,
          src = "wowhead"
        },
        {
          display = 11165,
          forever = true,
          level = "45",
          loot = { 9414, 9415, 9416 },
          name = "Grimlok",
          npc = 4854,
          src = "wowhead"
        },
        {
          display = 5988,
          forever = true,
          level = "47",
          loot = { 9420 },
          name = "Archaedas",
          npc = 2748,
          src = "wowhead"
        }
      },
      entrance = { map = 1418, src = "questie", x = 0.446, y = 0.121 },
      quests = {
        [17] = {
          chain = { 2500 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1432, name = "Ghak Touchesoins", npc = 1470, src = "site", x = 0.37, y = 0.492 },
          src = "questie",
          turnIn = { map = 1432, name = "Ghak Touchesoins", npc = 1470, src = "site", x = 0.37, y = 0.492 }
        },
        [704] = {
          chain = { 707, 738, 739 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1432, name = "Prospecteur Baguefer", npc = 1344, src = "site", x = 0.658, y = 0.656 },
          src = "questie",
          turnIn = { map = 1432, name = "Prospecteur Baguefer", npc = 1344, src = "site", x = 0.658, y = 0.656 }
        },
        [709] = {
          confirmed = false,
          giver = { map = 1418, name = "Theldurin l'Egaré", npc = 2785, src = "site", x = 0.514, y = 0.768 },
          src = "questie",
          turnIn = { map = 1418, name = "Theldurin l'Egaré", npc = 2785, src = "site", x = 0.514, y = 0.768 }
        },
        [1139] = {
          chain = { 720, 721, 722, 723, 724, 725, 726, 762 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1455, name = "Conseiller Belgrum", npc = 2918, src = "site", x = 0.772, y = 0.1 },
          src = "questie",
          turnIn = { map = 1455, name = "Conseiller Belgrum", npc = 2918, src = "site", x = 0.772, y = 0.1 }
        },
        [1360] = {
          confirmed = false,
          giver = { map = 1455, name = "Krom Rudebras", npc = 6294, src = "site", x = 0.742, y = 0.098 },
          src = "questie",
          turnIn = { map = 1455, name = "Krom Rudebras", npc = 6294, src = "site", x = 0.742, y = 0.098 }
        },
        [1956] = {
          chain = { 1953, 1954, 1955 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1445, name = "Tabetha", npc = 6546, src = "site", x = 0.46, y = 0.57 },
          src = "questie",
          turnIn = { map = 1445, name = "Tabetha", npc = 6546, src = "site", x = 0.46, y = 0.57 }
        },
        [2198] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1455, name = "Talvash del Kissel", npc = 6826, src = "site", x = 0.36, y = 0.04 }
        },
        [2202] = {
          chain = { 2258 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Jarkal Fondemousse", npc = 6868, src = "site", x = 0.026, y = 0.46 },
          src = "questie",
          turnIn = { map = 1418, name = "Jarkal Fondemousse", npc = 6868, src = "site", x = 0.026, y = 0.46 }
        },
        [2240] = {
          chain = { 2398 },
          chainSrc = "questie",
          confirmed = false,
          src = "questie",
          turnIn = { map = 1455, name = "Prospecteur Foudrepique", npc = 1356, src = "site", x = 0.744, y = 0.12 }
        },
        [2278] = { confirmed = false, src = "questie" },
        [2283] = {
          confirmed = false,
          giver = { map = 1454, name = "Dran Droffers", npc = 6986, src = "site", x = 0.594, y = 0.368 },
          src = "questie",
          turnIn = { map = 1454, name = "Dran Droffers", npc = 6986, src = "site", x = 0.594, y = 0.368 }
        },
        [2342] = {
          confirmed = false,
          giver = { map = 1458, name = "Patrick Garrett", npc = 5651, src = "site", x = 0.626, y = 0.484 },
          src = "questie",
          turnIn = { map = 1458, name = "Patrick Garrett", npc = 5651, src = "site", x = 0.626, y = 0.484 }
        },
        [2398] = {
          confirmed = false,
          giver = { map = 1455, name = "Prospecteur Foudrepique", npc = 1356, src = "site", x = 0.744, y = 0.12 },
          src = "questie"
        },
        [2418] = {
          confirmed = false,
          giver = { map = 1418, name = "Rigglefuzz", npc = 2817, src = "site", x = 0.424, y = 0.528 },
          src = "questie",
          turnIn = { map = 1418, name = "Rigglefuzz", npc = 2817, src = "site", x = 0.424, y = 0.528 }
        }
      }
    },
    -- wowhead forever (zone=1176, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin de zone ou commun).
    -- ajoutés : Bourreau Sandfury, Sergent Bly, rares Sandarr Ravadune, Ame en peine poudreuse, Zerillis. Sandarr et l'Ame en peine : pas de butin bleu relevé.
    zf = {
      bosses = {
        {
          display = 7353,
          forever = true,
          level = "48",
          loot = { 9640, 9639, 9379, 17413 },
          name = "Antu'sul",
          npc = 8127,
          src = "wowhead"
        },
        {
          display = 6696,
          en = "Theka the Martyr",
          forever = true,
          level = "45",
          loot = { 221286, 13100 },
          name = "Theka le Martyr",
          npc = 7272,
          src = "wowhead"
        },
        {
          display = 6434,
          en = "Witch Doctor Zum'rah",
          forever = true,
          level = "46",
          loot = { 18082, 13055, 17682 },
          name = "Sorcier-docteur Zum'rah",
          npc = 7271,
          src = "wowhead"
        },
        {
          display = 6685,
          en = "Hydromancer Velratha",
          forever = true,
          level = "46",
          loot = { 17682, 221285, 17413 },
          name = "Hydromancienne Velratha",
          npc = 7795,
          src = "wowhead"
        },
        {
          display = 7271,
          forever = true,
          level = "46",
          loot = { 9467, 9469, 17413 },
          name = "Gahz'rilla",
          npc = 7273,
          src = "wowhead"
        },
        {
          display = 6690,
          en = "Nekrum Gutchewer",
          forever = true,
          level = "45",
          loot = { 221285 },
          name = "Nekrum Mâchetripes",
          npc = 7796,
          src = "wowhead"
        },
        {
          display = 6441,
          en = "Shadowpriest Sezz'ziz",
          forever = true,
          level = "47",
          loot = { 9470, 9473, 9475, 9474, 221303, 17413, 221277, 17682 },
          name = "Prêtre des ombres Sezz'ziz",
          npc = 7275,
          src = "wowhead"
        },
        {
          display = 6439,
          en = "Chief Ukorz Sandscalp",
          forever = true,
          level = "48",
          loot = { 9476, 9477, 221290, 221305, 11086, 10605, 221296, 17413 },
          name = "Chef Ukorz Scalpessable",
          npc = 7267,
          src = "wowhead"
        },
        {
          display = 6687,
          forever = true,
          level = "46",
          loot = { 221276, 17682, 17413 },
          name = "Ruuzlu",
          npc = 7797,
          src = "wowhead"
        },
        {
          display = 6440,
          en = "Sandfury Executioner",
          forever = true,
          level = "46",
          loot = { 221290, 221304, 221295 },
          name = "Bourreau Sandfury",
          npc = 7274,
          src = "wowhead"
        },
        {
          display = 6433,
          en = "Sergeant Bly",
          forever = true,
          level = "45",
          loot = { 221278, 221288, 1715, 1718 },
          name = "Sergent Bly",
          npc = 7604,
          src = "wowhead"
        },
        {
          display = 9291,
          en = "Sandarr Dunereaver",
          forever = true,
          level = "45",
          name = "Sandarr Ravadune",
          npc = 10080,
          src = "wowhead"
        },
        {
          display = 9292,
          en = "Dustwraith",
          forever = true,
          level = "45",
          name = "Ame en peine poudreuse",
          npc = 10081,
          src = "wowhead"
        },
        {
          display = 9293,
          forever = true,
          level = "45",
          loot = { 12470, 221305 },
          name = "Zerillis",
          npc = 10082,
          src = "wowhead"
        }
      },
      entrance = { map = 1446, src = "questie", x = 0.387, y = 0.201 },
      quests = {
        [2768] = {
          confirmed = false,
          giver = { map = 1446, name = "Ingénieur en chef Vizisanie", npc = 7407, src = "site", x = 0.524, y = 0.284 },
          src = "questie",
          turnIn = { map = 1446, name = "Ingénieur en chef Vizisanie", npc = 7407, src = "site", x = 0.524, y = 0.284 }
        },
        [2770] = {
          confirmed = false,
          giver = { map = 1441, name = "Lachnouf Zéboulon", npc = 4453, src = "site", x = 0.78, y = 0.77 },
          src = "questie",
          turnIn = { map = 1441, name = "Lachnouf Zéboulon", npc = 4453, src = "site", x = 0.78, y = 0.77 }
        },
        [2846] = {
          confirmed = false,
          giver = { map = 1445, name = "Tabetha", npc = 6546, src = "site", x = 0.46, y = 0.57 },
          src = "questie",
          turnIn = { map = 1445, name = "Tabetha", npc = 6546, src = "site", x = 0.46, y = 0.57 }
        },
        [2865] = {
          chain = { 2864 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Tran'rek", npc = 7876, src = "site", x = 0.516, y = 0.268 },
          src = "questie",
          turnIn = { map = 1446, name = "Tran'rek", npc = 7876, src = "site", x = 0.516, y = 0.268 }
        },
        [2936] = {
          chain = { 2933, 2934, 2935 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1411, name = "Maître Gadrin", npc = 3188, src = "site", x = 0.56, y = 0.746 },
          src = "questie",
          turnIn = { map = 1411, name = "Maître Gadrin", npc = 3188, src = "site", x = 0.56, y = 0.746 }
        },
        [2991] = {
          chain = { 2988, 2989, 2990 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1419, name = "Thadius Sinissombre", npc = 8022, src = "site", x = 0.67, y = 0.194 },
          src = "questie",
          turnIn = { map = 1419, name = "Thadius Sinissombre", npc = 8022, src = "site", x = 0.67, y = 0.194 }
        },
        [3042] = {
          confirmed = false,
          giver = { map = 1446, name = "Trenton Martelume", npc = 7804, src = "site", x = 0.514, y = 0.286 },
          src = "questie",
          turnIn = { map = 1446, name = "Trenton Martelume", npc = 7804, src = "site", x = 0.514, y = 0.286 }
        },
        [3527] = {
          chain = { 3520 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "site", x = 0.67, y = 0.224 },
          src = "questie",
          turnIn = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "site", x = 0.67, y = 0.224 }
        }
      }
    },
    -- wowhead forever (zone=2100, pages npc) : npcId, display, niveaux, noms FR/EN du jeu (Esprit de Veng, Esprit de Maraudos, Meshlok le Moissonneur), butin bleu de chaque page.
    mara = {
      bosses = {
        {
          display = 12373,
          en = "Spirit of Veng",
          forever = true,
          level = "47",
          loot = { 13043, 1720, 13021, 13102 },
          name = "Esprit de Veng",
          npc = 12243,
          src = "wowhead"
        },
        {
          display = 11172,
          forever = true,
          level = "48",
          loot = { 17745, 221281, 13018 },
          name = "Noxxion",
          npc = 13282,
          src = "wowhead"
        },
        {
          display = 12389,
          en = "Razorlash",
          forever = true,
          level = "48",
          loot = { 17748 },
          name = "Tranchefouet",
          npc = 12258,
          src = "wowhead"
        },
        {
          display = 12370,
          en = "Spirit of Maraudos",
          forever = true,
          level = "46",
          name = "Esprit de Maraudos",
          npc = 12242,
          src = "wowhead"
        },
        {
          display = 12334,
          en = "Lord Vyletongue",
          forever = true,
          level = "47",
          loot = { 17755, 13102 },
          name = "Seigneur Vylelangue",
          npc = 12236,
          src = "wowhead"
        },
        {
          display = 12350,
          en = "Celebras the Cursed",
          forever = true,
          level = "49",
          loot = { 17739, 17738, 17740, 4091 },
          name = "Celebras le Maudit",
          npc = 12225,
          src = "wowhead"
        },
        {
          display = 12293,
          en = "Landslide",
          forever = true,
          level = "50",
          loot = { 17943, 13009 },
          name = "Glissement de terrain",
          npc = 12203,
          src = "wowhead"
        },
        {
          display = 7125,
          en = "Tinkerer Gizlock",
          forever = true,
          level = "50",
          loot = { 17719, 17717, 13076 },
          name = "Artisan Gizlock",
          npc = 13601,
          src = "wowhead"
        },
        {
          display = 13589,
          en = "Rotgrip",
          forever = true,
          level = "50",
          loot = { 17732, 17728, 17730, 13089, 13126 },
          name = "Grippe-charogne",
          npc = 13596,
          src = "wowhead"
        },
        {
          display = 12292,
          en = "Princess Theradras",
          forever = true,
          level = "51",
          loot = { 17713, 17714, 17766, 17715, 17710, 221271, 13126, 13125, 13009 },
          name = "Princesse Theradras",
          npc = 12201,
          src = "wowhead"
        },
        {
          display = 9014,
          en = "Meshlok the Harvester",
          forever = true,
          level = "48",
          loot = { 17741, 13125 },
          name = "Meshlok le Moissonneur",
          npc = 12237,
          rare = true,
          src = "wowhead"
        }
      },
      entrance = { map = 1443, src = "questie", x = 0.291, y = 0.625 },
      quests = {
        [7028] = {
          confirmed = false,
          giver = { map = 1443, name = "Saule", npc = 13656, src = "site", x = 0.622, y = 0.396 },
          src = "questie",
          turnIn = { map = 1443, name = "Saule", npc = 13656, src = "site", x = 0.622, y = 0.396 }
        },
        [7029] = {
          confirmed = false,
          giver = { map = 1443, name = "Vark Balafre-glorieuse", npc = 11823, src = "site", x = 0.232, y = 0.702 },
          src = "questie",
          turnIn = { map = 1443, name = "Vark Balafre-glorieuse", npc = 11823, src = "site", x = 0.232, y = 0.702 }
        },
        [7041] = {
          confirmed = false,
          giver = { map = 1443, name = "Talendria", npc = 11715, src = "site", x = 0.684, y = 0.088 },
          src = "questie",
          turnIn = { map = 1443, name = "Talendria", npc = 11715, src = "site", x = 0.684, y = 0.088 }
        },
        [7044] = {
          confirmed = false,
          giver = { map = 1443, name = "Cavindra", npc = 13697, src = "questie", x = 0.321, y = 0.6396 },
          src = "questie"
        },
        [7046] = { chain = { 7044 }, chainSrc = "questie", confirmed = false, src = "questie" },
        [7064] = {
          confirmed = false,
          giver = { map = 1443, name = "Selendra", npc = 13699, src = "site", x = 0.268, y = 0.776 },
          src = "questie",
          turnIn = { map = 1443, name = "Selendra", npc = 13699, src = "site", x = 0.268, y = 0.776 }
        },
        [7065] = {
          confirmed = false,
          giver = { map = 1443, name = "Gardien Marandis", npc = 13698, src = "site", x = 0.638, y = 0.106 },
          src = "questie",
          turnIn = { map = 1443, name = "Gardien Marandis", npc = 13698, src = "site", x = 0.638, y = 0.106 }
        },
        [7066] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1450, name = "Gardien Remulos", npc = 11832, src = "site", x = 0.362, y = 0.418 }
        },
        [7067] = {
          confirmed = false,
          giver = { map = 1443, name = "Paria centaure", npc = 13717, src = "site", x = 0.504, y = 0.866 },
          src = "questie",
          turnIn = { map = 1443, name = "Paria centaure", npc = 13717, src = "site", x = 0.504, y = 0.866 }
        },
        [7068] = {
          confirmed = false,
          giver = { map = 1454, name = "Uthel'nay", npc = 7311, src = "site", x = 0.39, y = 0.86 },
          src = "questie",
          turnIn = { map = 1454, name = "Uthel'nay", npc = 7311, src = "site", x = 0.39, y = 0.86 }
        },
        [7070] = {
          confirmed = false,
          giver = { map = 1445, name = "Archimage Tervosh", npc = 4967, src = "site", x = 0.664, y = 0.492 },
          src = "questie",
          turnIn = { map = 1445, name = "Archimage Tervosh", npc = 4967, src = "site", x = 0.664, y = 0.492 }
        }
      }
    },
    -- wowhead forever (zone=1477, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin commun). Taux non publiés pour l'Avatar d'Hakkar.
    st = {
      bosses = {
        {
          display = 7873,
          forever = true,
          level = "50",
          loot = { 10799, 17682, 17413 },
          name = "Atal'alarion",
          npc = 8580,
          src = "wowhead"
        },
        {
          display = 6375,
          en = "Weaver",
          forever = true,
          level = "51",
          loot = { 12243, 12466, 12465, 17682 },
          name = "Tisserand",
          npc = 5720,
          src = "wowhead"
        },
        {
          display = 7553,
          en = "Dreamscythe",
          forever = true,
          level = "53",
          loot = { 12465, 12466, 12243, 17682 },
          name = "Fauche-rêve",
          npc = 5721,
          src = "wowhead"
        },
        {
          display = 6708,
          en = "Jammal'an the Prophet",
          forever = true,
          level = "54",
          loot = { 10807, 810 },
          name = "Jammal'an le prophète",
          npc = 5710,
          src = "wowhead"
        },
        {
          display = 6709,
          en = "Ogom the Wretched",
          forever = true,
          level = "53",
          loot = { 10804, 17413 },
          name = "Ogom le Misérable",
          npc = 5711,
          src = "wowhead"
        },
        {
          display = 7975,
          forever = true,
          level = "52",
          loot = { 12466, 12243, 12465, 17682, 17413 },
          name = "Morphaz",
          npc = 5719,
          src = "wowhead"
        },
        {
          display = 9584,
          forever = true,
          level = "53",
          loot = { 12466, 12243, 12465, 17413, 17682 },
          name = "Hazzas",
          npc = 5722,
          src = "wowhead"
        },
        {
          display = 8053,
          en = "Avatar of Hakkar",
          forever = true,
          level = "55",
          loot = { 10838, 10844 },
          name = "Avatar d'Hakkar",
          npc = 8443,
          src = "wowhead"
        },
        {
          display = 7806,
          en = "Shade of Eranikus",
          forever = true,
          level = "55",
          loot = { 10833, 17414 },
          name = "Ombre d'Eranikus",
          npc = 5709,
          src = "wowhead"
        }
      },
      entrance = { map = 1435, src = "questie", x = 0.699, y = 0.535 },
      quests = {
        [1445] = {
          chain = { 1424, 1429, 1444 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1435, name = "Fel'zerul", npc = 1443, src = "site", x = 0.48, y = 0.55 },
          src = "questie",
          turnIn = { map = 1435, name = "Fel'zerul", npc = 1443, src = "site", x = 0.48, y = 0.55 }
        },
        [1446] = {
          confirmed = false,
          giver = { map = 1425, name = "Exilé atal'ai", npc = 5598, src = "site", x = 0.336, y = 0.752 },
          src = "questie",
          turnIn = { map = 1425, name = "Exilé atal'ai", npc = 5598, src = "site", x = 0.336, y = 0.752 }
        },
        [1475] = {
          chain = { 1448, 1449, 1450, 1451, 1452, 1469 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1453, name = "Brohann Ventrabière", npc = 5384, src = "site", x = 0.642, y = 0.208 },
          src = "questie",
          turnIn = { map = 1453, name = "Brohann Ventrabière", npc = 5384, src = "site", x = 0.642, y = 0.208 }
        },
        [3373] = { confirmed = false, src = "questie" },
        [3446] = {
          chain = { 3380, 3444 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Marvon Chercherivet", npc = 7771, src = "site", x = 0.526, y = 0.458 },
          src = "questie"
        },
        [3447] = {
          chain = { 3380, 3444 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Marvon Chercherivet", npc = 7771, src = "site", x = 0.526, y = 0.458 },
          src = "questie"
        },
        [3528] = {
          chain = { 3520, 3527, 4787 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "site", x = 0.67, y = 0.224 },
          src = "questie",
          turnIn = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "site", x = 0.67, y = 0.224 }
        },
        [4143] = {
          chain = { 4141, 4142 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1444, name = "Gregan Gerbebière", npc = 7775, src = "site", x = 0.45, y = 0.254 },
          src = "questie",
          turnIn = { map = 1449, name = "Muigin", npc = 9119, src = "site", x = 0.43, y = 0.096 }
        },
        [4146] = {
          chain = { 4145, 4147 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1413, name = "Liv Rafistolier", npc = 8496, src = "site", x = 0.624, y = 0.386 },
          src = "questie",
          turnIn = { map = 1449, name = "Larion", npc = 9118, src = "site", x = 0.456, y = 0.086 }
        }
      }
    },
    -- wowhead forever (zone=1584, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin de zone ou commun). Ajouté : Panzor l'Invincible (rare).
    -- Arène (Anneau de la Loi) et Les Sept : entrée groupée gardée, butin = union des pages de chaque PNJ ; Les Sept n'ont pas de butin bleu (coffre). Noms FR gardés quand Wowhead FR n'affiche que l'anglais (Loregrain, Darkvire, Blackbreath, Screwspigot, Spazzring, Bronzebeard).
    brd = {
      bosses = {
        {
          display = 5781,
          en = "Lord Roccor",
          forever = true,
          level = "51",
          loot = { 11632, 11631, 11630, 17413, 17682 },
          name = "Seigneur Roccor",
          npc = 9025,
          src = "wowhead"
        },
        {
          display = 12162,
          forever = true,
          level = "54",
          loot = { 22393, 18600 },
          name = "Bael'Gar",
          npc = 9016,
          src = "wowhead"
        },
        {
          display = 9212,
          en = "Houndmaster Grebmar",
          forever = true,
          level = "52",
          loot = { 11627, 11623, 11628, 17682, 17413 },
          name = "Maître-chien Grebmar",
          npc = 9319,
          src = "wowhead"
        },
        {
          display = 8761,
          en = "High Interrogator Gerstahn",
          forever = true,
          level = "52",
          loot = { 22240, 17413, 17682 },
          name = "Grand Interrogateur Gerstahn",
          npc = 9018,
          src = "wowhead"
        },
        {
          display = 8708,
          en = "Kharan Mighthammer",
          forever = true,
          level = "55",
          name = "Kharan Mighthammer",
          npc = 9021,
          quest = true,
          src = "wowhead"
        },
        {
          display = 8703,
          en = "Commander Gor'shak",
          forever = true,
          level = "53",
          name = "Commandant Gor'shak",
          npc = 9020,
          quest = true,
          src = "wowhead"
        },
        {
          display = 8707,
          en = "Marshal Windsor",
          forever = true,
          level = "54",
          name = "Maréchal Windsor",
          npc = 9023,
          quest = true,
          src = "wowhead"
        },
        {
          en = "Anub'shiah, Eviscerator, Gorosh the Dervish, Grizzle, Hedrum the Creeper or Ok'thor the Breaker",
          forever = true,
          loot = { 11731, 11730, 11726, 11610, 221300, 11633, 11729, 11728, 17683, 17682, 17413, 18600 },
          name = "Anub'shiah, Éviscérateur, Gorosh le Derviche, Grison, Hedrum le Rampant ou Ok'thor le Briseur",
          src = "wowhead"
        },
        {
          display = 8762,
          en = "Pyromancer Loregrain",
          forever = true,
          level = "52",
          loot = { 11748, 11747, 11749, 11750, 221294, 17413 },
          name = "Pyromancien Blé-du-savoir",
          npc = 9024,
          src = "wowhead"
        },
        {
          display = 1204,
          en = "Lord Incendius",
          forever = true,
          level = "55",
          loot = { 11764, 11765, 19268, 22393, 17683, 17413, 17414, 18600 },
          name = "Seigneur Incendius",
          npc = 9017,
          src = "wowhead"
        },
        {
          display = 9089,
          en = "Warder Stilgiss",
          forever = true,
          level = "56",
          loot = { 22241, 17414, 18600, 22393, 19275 },
          name = "Gardien Stilgiss",
          npc = 9041,
          src = "wowhead"
        },
        {
          display = 9019,
          forever = true,
          level = "55",
          loot = { 22242, 17413, 17682 },
          name = "Verek",
          npc = 9042,
          src = "wowhead"
        },
        {
          display = 8704,
          en = "Fineous Darkvire",
          forever = true,
          level = "54",
          loot = { 11841, 11840, 17682, 19263, 221287, 19233, 22393, 221286 },
          name = "Fineous Sombrevire",
          npc = 9056,
          src = "wowhead"
        },
        {
          display = 8756,
          en = "General Angerforge",
          forever = true,
          level = "57",
          loot = { 11821, 11817, 19234, 221304, 19265, 19274, 221285, 221297, 221287, 19281, 17683, 18600, 221306, 17414 },
          name = "Général Forgehargne",
          npc = 9033,
          src = "wowhead"
        },
        {
          display = 8759,
          en = "Golem Lord Argelmach",
          forever = true,
          level = "57",
          loot = { 11823, 11822, 221303, 22890, 19233, 17683, 17414 },
          name = "Seigneur golem Argelmach",
          npc = 8983,
          src = "wowhead"
        },
        {
          display = 8658,
          en = "Hurley Blackbreath",
          forever = true,
          level = "55",
          loot = { 11735, 19283, 17414, 221278, 221294, 17682 },
          name = "Hurley Soufflenoir",
          npc = 9537,
          src = "wowhead"
        },
        {
          display = 8177,
          en = "Phalanx",
          forever = true,
          level = "55",
          loot = { 11745, 11746, 811, 22890, 22891 },
          name = "Phalange",
          npc = 9502,
          src = "wowhead"
        },
        {
          display = 8652,
          en = "Plugger Spazzring",
          forever = true,
          level = "55",
          loot = { 19233, 17414 },
          name = "Lanfiche Brouillecircuit",
          npc = 9499,
          src = "wowhead"
        },
        {
          display = 8667,
          en = "Ribbly Screwspigot",
          forever = true,
          level = "53",
          loot = { 227901, 11612, 221300, 221293, 13067, 221274, 221283, 17413, 17682 },
          name = "Ribbly Fermevanne",
          npc = 9543,
          src = "wowhead"
        },
        {
          display = 8329,
          en = "Ambassador Flamelash",
          forever = true,
          level = "57",
          loot = { 811, 22393, 22891 },
          name = "Ambassadeur Cinglefouet",
          npc = 9156,
          src = "wowhead"
        },
        {
          en = "The Seven: Hate'rel, Anger'rel, Vile'rel, Gloom'rel, Seeth'rel, Doom'rel, Dope'rel",
          forever = true,
          name = "Les Sept : Haine'rel, Colé'rel, Ignobl'rel, Funéb'rel, Fulmi'rel, Tragi'rel, Demeu'rel",
          src = "wowhead"
        },
        {
          display = 12162,
          forever = true,
          level = "57",
          loot = { 11746, 17683, 18600 },
          name = "Magmus",
          npc = 9938,
          src = "wowhead"
        },
        {
          display = 8807,
          en = "Emperor Dagran Thaurissan",
          forever = true,
          level = "59",
          loot = { 16724, 19281, 19235, 18600, 221288, 221286, 21524 },
          name = "Empereur Dagran Thaurissan",
          npc = 9019,
          src = "wowhead"
        },
        {
          display = 8705,
          en = "Princess Moira Bronzebeard",
          forever = true,
          level = "58",
          loot = { 22890, 22891, 19234, 17414, 22206 },
          name = "Princesse Moira Barbe-de-bronze",
          npc = 8929,
          src = "wowhead"
        },
        {
          display = 8270,
          en = "Panzor the Invincible",
          forever = true,
          level = "57",
          loot = { 18600 },
          name = "Panzor l'Invincible",
          npc = 8923,
          rare = true,
          src = "wowhead"
        }
      },
      entrance = { map = 1427, src = "questie", x = 0.348, y = 0.853 },
      lootByNpc = { [8929] = { 22206 }, [9019] = { 21524 }, [9056] = { 11840 } },
      quests = {
        [3802] = { chain = { 3801 }, chainSrc = "questie", confirmed = false, src = "questie" },
        [3906] = {
          confirmed = false,
          giver = { map = 1418, name = "Cœur-de-tonnerre", npc = 9084, src = "site", x = 0.034, y = 0.482 },
          src = "questie",
          turnIn = { map = 1418, name = "Cœur-de-tonnerre", npc = 9084, src = "site", x = 0.034, y = 0.482 }
        },
        [3907] = {
          chain = { 3906 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Cœur-de-tonnerre", npc = 9084, src = "site", x = 0.034, y = 0.482 },
          src = "questie",
          turnIn = { map = 1418, name = "Cœur-de-tonnerre", npc = 9084, src = "site", x = 0.034, y = 0.482 }
        },
        [3981] = {
          chain = { 3906 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Galamav le Tireur d'élite", npc = 9081, src = "site", x = 0.058, y = 0.476 },
          src = "questie"
        },
        [4003] = {
          chain = { 3906, 3981, 3982, 4001, 4002 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1454, name = "Thrall", npc = 4949, src = "site", x = 0.32, y = 0.378 },
          src = "questie"
        },
        [4024] = {
          chain = { 3441, 3442, 3443, 3452, 3453, 3454, 3462, 3463, 3481, 4022 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Cyrus Lerepenti", npc = 9459, src = "site", x = 0.948, y = 0.316 },
          src = "questie",
          turnIn = { map = 1428, name = "Cyrus Lerepenti", npc = 9459, src = "site", x = 0.948, y = 0.316 }
        },
        [4063] = {
          chain = { 4061, 4062 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Lotwil Veriatus", npc = 2921, src = "site", x = 0.258, y = 0.45 },
          src = "questie",
          turnIn = { map = 1418, name = "Lotwil Veriatus", npc = 2921, src = "site", x = 0.258, y = 0.45 }
        },
        [4081] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1418, name = "Seigneur de guerre Sangredent", npc = 9077, src = "site", x = 0.058, y = 0.474 }
        },
        [4082] = {
          chain = { 4081 },
          chainSrc = "questie",
          confirmed = false,
          src = "questie",
          turnIn = { map = 1418, name = "Seigneur de guerre Sangredent", npc = 9077, src = "site", x = 0.058, y = 0.474 }
        },
        [4123] = {
          confirmed = false,
          giver = { map = 1428, name = "Maxwort Uberbrille", npc = 9536, src = "site", x = 0.652, y = 0.238 },
          src = "questie",
          turnIn = { map = 1428, name = "Maxwort Uberbrille", npc = 9536, src = "site", x = 0.652, y = 0.238 }
        },
        [4126] = {
          chain = { 4128 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1426, name = "Ragnar Tonnebière", npc = 1267, src = "site", x = 0.468, y = 0.524 },
          src = "questie",
          turnIn = { map = 1426, name = "Ragnar Tonnebière", npc = 1267, src = "site", x = 0.468, y = 0.524 }
        },
        [4132] = {
          chain = { 4122, 4121 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Seigneur de guerre Sangredent", npc = 9077, src = "site", x = 0.058, y = 0.474 },
          src = "questie",
          turnIn = { map = 1418, name = "Seigneur de guerre Sangredent", npc = 9077, src = "site", x = 0.058, y = 0.474 }
        },
        [4134] = {
          chain = { 4133 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 },
          src = "questie",
          turnIn = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 }
        },
        [4136] = {
          chain = { 4324 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Yuka Fermevanne", npc = 9544, src = "site", x = 0.66, y = 0.22 },
          src = "questie",
          turnIn = { map = 1428, name = "Yuka Fermevanne", npc = 9544, src = "site", x = 0.66, y = 0.22 }
        },
        [4201] = { confirmed = false, src = "questie" },
        [4241] = {
          chain = { 4182, 4183, 4184, 4185, 4186, 4223, 4224 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Maréchal Maxwell", npc = 9560, src = "site", x = 0.846, y = 0.688 },
          src = "questie"
        },
        [4262] = {
          confirmed = false,
          giver = { map = 1428, name = "Jalinda Brindille", npc = 9561, src = "site", x = 0.854, y = 0.7 },
          src = "questie",
          turnIn = { map = 1428, name = "Jalinda Brindille", npc = 9561, src = "site", x = 0.854, y = 0.7 }
        },
        [4263] = {
          chain = { 4262 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Jalinda Brindille", npc = 9561, src = "site", x = 0.854, y = 0.7 },
          src = "questie",
          turnIn = { map = 1428, name = "Jalinda Brindille", npc = 9561, src = "site", x = 0.854, y = 0.7 }
        },
        [4286] = {
          confirmed = false,
          giver = { map = 1428, name = "Oralius", npc = 9177, src = "site", x = 0.846, y = 0.686 },
          src = "questie",
          turnIn = { map = 1428, name = "Oralius", npc = 9177, src = "site", x = 0.846, y = 0.686 }
        },
        [4322] = {
          chain = { 4182, 4183, 4184, 4185, 4186, 4223, 4224, 4241, 4242, 4264, 4282 },
          chainSrc = "questie",
          confirmed = false,
          src = "questie",
          turnIn = { map = 1428, name = "Maréchal Maxwell", npc = 9560, src = "site", x = 0.846, y = 0.688 }
        },
        [4341] = {
          chain = { 3702, 3701 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1455, name = "Roi Magni Barbe-de-bronze", npc = 2784, src = "site", x = 0.394, y = 0.558 },
          src = "questie"
        },
        [4362] = {
          chain = { 3702, 3701, 4341, 4361 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1455, name = "Roi Magni Barbe-de-bronze", npc = 2784, src = "site", x = 0.394, y = 0.558 },
          src = "questie"
        },
        [7201] = {
          confirmed = false,
          giver = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 },
          src = "questie",
          turnIn = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 }
        },
        [7848] = { confirmed = false, src = "questie" }
      }
    },
    brs = {
      bosses = {
        { name = "Généralissime Omokk" },
        { name = "Chasseresse des ombres Vosh'gajin" },
        { name = "Maître de guerre Voone" },
        { name = "Matriarche Couveuse" },
        { name = "Urok Hurleruine" },
        { name = "Intendant Zigris" },
        { level = "59", name = "Halycon", npc = 10220 },
        { name = "Gizrul l'esclavagiste" },
        { name = "Seigneur Wyrmthalak" },
        { name = "Pyrogarde Prophète ardent" },
        { name = "Solakar Voluteflamme" },
        { name = "Goraluk Brisenclume" },
        { name = "Gyth" },
        { name = "Chef de guerre Rend Main-noire" },
        { name = "La Bête" },
        { name = "Général Drakkisath" }
      },
      entrance = { map = 1427, src = "questie", x = 0.348, y = 0.853 },
      lootByNpc = {
        [9096] = { 16681 },
        [9196] = { 16670 },
        [9236] = { 16712 },
        [9237] = { 16676, 21524 },
        [9268] = { 16736 },
        [9568] = { 16679 },
        [9816] = { 16672 },
        [10363] = { 16666, 16674, 16688, 16690, 16700, 16706, 16721, 16726, 16730 },
        [10374] = { 140 },
        [10430] = { 16729 },
        [10596] = { 16715 },
        [10899] = { 21525 }
      },
      quests = {
        [4735] = {
          chain = { 4726, 4808, 4809, 4810, 4734 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Brikolette Toutevapeur", npc = 10267, src = "site", x = 0.652, y = 0.238 },
          src = "questie",
          turnIn = { map = 1428, name = "Brikolette Toutevapeur", npc = 10267, src = "site", x = 0.652, y = 0.238 }
        },
        [4764] = {
          chain = { 4766 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Mayara Luisaile", npc = 9565, src = "site", x = 0.848, y = 0.69 },
          src = "questie",
          turnIn = { map = 1428, name = "Mayara Luisaile", npc = 9565, src = "site", x = 0.848, y = 0.69 }
        },
        [4768] = {
          chain = { 4769 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 },
          src = "questie",
          turnIn = { map = 1418, name = "Ombremage Vivian Lagrave", npc = 9078, src = "site", x = 0.03, y = 0.476 }
        },
        [4974] = {
          chain = { 4903, 4941 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1454, name = "Thrall", npc = 4949, src = "site", x = 0.32, y = 0.378 },
          src = "questie",
          turnIn = { map = 1454, name = "Thrall", npc = 4949, src = "site", x = 0.32, y = 0.378 }
        },
        [5047] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1452, name = "Malyfous Sombremartel", npc = 10637, src = "site", x = 0.61, y = 0.386 }
        },
        [5102] = {
          chain = { 5089 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1428, name = "Maréchal Maxwell", npc = 9560, src = "site", x = 0.846, y = 0.688 },
          src = "questie",
          turnIn = { map = 1428, name = "Maréchal Maxwell", npc = 9560, src = "site", x = 0.846, y = 0.688 }
        },
        [5127] = {
          chain = { 5126 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1452, name = "Lorax", npc = 10918, src = "site", x = 0.638, y = 0.738 },
          src = "questie",
          turnIn = { map = 1452, name = "Lorax", npc = 10918, src = "site", x = 0.638, y = 0.738 }
        },
        [5160] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1452, name = "Haleh", npc = 10929, src = "site", x = 0.544, y = 0.512 }
        },
        [6502] = {
          chain = { 4182, 4183, 4184, 4185, 4186, 4223, 4224, 4241, 4242, 4264, 4282, 4322, 6402, 6403, 6501 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1452, name = "Haleh", npc = 10929, src = "site", x = 0.544, y = 0.512 },
          src = "questie",
          turnIn = { map = 1452, name = "Haleh", npc = 10929, src = "site", x = 0.544, y = 0.512 }
        },
        [6602] = {
          chain = { 4903, 4941, 4974, 6566, 6567, 6568, 6569, 6570, 6582, 6583, 6584, 6585, 6601 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1444, name = "Rokaro", npc = 10182, src = "questie", x = 0.4639, y = 0.1824 },
          src = "questie",
          turnIn = { map = 1444, name = "Rokaro", npc = 10182, src = "questie", x = 0.4639, y = 0.1824 }
        },
        [6821] = {
          chain = { 6804, 6805 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1447, name = "Duc Hydraxis", npc = 13278, src = "site", x = 0.792, y = 0.736 },
          src = "questie",
          turnIn = { map = 1447, name = "Duc Hydraxis", npc = 13278, src = "site", x = 0.792, y = 0.736 }
        },
        [7761] = { confirmed = false, src = "questie" }
      }
    },
    -- wowhead forever (zone=2557, pages npc) : npcId, display, niveaux, noms EN, butin bleu de chaque page (surtout livres de classe et butin commun ; butin propre classique absent de Wowhead Forever).
    -- ajoutés : Tsu'zee (rare), Ferra, Kreeg le Marteleur, Pimgib. Seigneur Hel'nurath (invocation) non ajouté. Noms traduits gardés : Zevrim Sabot-de-ronce, Illyanna Corvichêne (Wowhead FR : Thornhoof, Ravenoak).
    dire = {
      bosses = {
        {
          display = 7552,
          forever = true,
          level = "57",
          loot = { 14507, 19283, 18357, 18361, 18364, 18360, 18358, 18362, 18356, 18363, 18401 },
          name = "Pusillin",
          npc = 14354,
          src = "wowhead"
        },
        {
          display = 11335,
          en = "Zevrim Thornhoof",
          forever = true,
          level = "57",
          loot = { 13040, 18357, 18361, 18358, 18364, 18360, 18356, 18362, 18359, 18363, 18401, 19235, 22890, 18335, 22393, 19273 },
          name = "Zevrim Sabot-de-ronce",
          npc = 11490,
          src = "wowhead"
        },
        {
          display = 5489,
          en = "Hydrospawn",
          forever = true,
          level = "57",
          loot = { 19268, 18358, 18357, 18361, 18364, 18356, 18360, 18362, 18359, 18363, 18401, 18600, 17683, 13040 },
          name = "Hydrogénos",
          npc = 13280,
          src = "wowhead"
        },
        {
          display = 14378,
          forever = true,
          level = "57",
          loot = { 13118, 17683 },
          name = "Lethtendris",
          npc = 14327,
          src = "wowhead"
        },
        {
          display = 14416,
          en = "Alzzin the Wildshaper",
          forever = true,
          level = "58",
          loot = { 18362, 18358, 18364, 18357, 18356, 18360, 18361, 18359, 13036, 18363, 18401, 18335, 18600, 22393 },
          name = "Alzzin le Modeleur",
          npc = 11492,
          src = "wowhead"
        },
        {
          display = 14383,
          en = "Tendris Warpwood",
          forever = true,
          level = "60",
          loot = { 17414, 18357, 18360, 18362, 18356, 18364, 18358, 18363, 22891 },
          name = "Tendris Crochebois",
          npc = 11489,
          src = "wowhead"
        },
        {
          display = 11270,
          en = "Illyanna Ravenoak",
          forever = true,
          level = "60",
          loot = { 18356, 18361, 18362, 18357, 18360, 18358, 18364, 18363, 22206 },
          name = "Illyanna Corvichêne",
          npc = 11488,
          src = "wowhead"
        },
        {
          display = 14384,
          en = "Magister Kalendris",
          forever = true,
          level = "60",
          loot = { 19236, 18360, 18358, 18364, 18361, 18362, 18363, 18356, 18357, 18359, 18401, 18335 },
          name = "Magistère Kalendris",
          npc = 11487,
          src = "wowhead"
        },
        {
          display = 14173,
          forever = true,
          level = "61",
          loot = { 18360, 17414, 18361, 18358, 18356, 18362, 18364, 18357, 18363, 18359, 18401 },
          name = "Immol'thar",
          npc = 11496,
          src = "wowhead"
        },
        {
          display = 11256,
          forever = true,
          level = "61",
          loot = { 21525, 19272, 19234, 18335, 18600, 17683 },
          name = "Prince Tortheldrin",
          npc = 11486,
          src = "wowhead"
        },
        {
          display = 11561,
          en = "Guard Mol'dar",
          forever = true,
          level = "59",
          name = "Garde Mol'dar",
          npc = 14326,
          src = "wowhead"
        },
        {
          display = 11561,
          en = "Guard Fengus",
          forever = true,
          level = "58",
          loot = { 22393, 18360, 18356, 18364, 18357, 18362, 18358, 18363, 18359, 18401 },
          name = "Garde Fengus",
          npc = 14321,
          src = "wowhead"
        },
        {
          display = 11561,
          en = "Guard Slip'kik",
          forever = true,
          level = "59",
          loot = { 18356, 18357, 18358, 18361, 18362, 18364, 18363, 18401 },
          name = "Garde Slip'kik",
          npc = 14323,
          src = "wowhead"
        },
        {
          display = 11564,
          en = "Captain Kromcrush",
          forever = true,
          level = "61",
          loot = { 18360, 18358, 18362, 18357, 18356, 18364, 18361, 18363 },
          name = "Capitaine Kromcrush",
          npc = 14325,
          src = "wowhead"
        },
        {
          display = 11537,
          en = "Cho'Rush the Observer",
          forever = true,
          level = "60",
          name = "Cho'Rush l'Observateur",
          npc = 14324,
          src = "wowhead"
        },
        {
          display = 11583,
          en = "King Gordok",
          forever = true,
          level = "62",
          loot = { 18780, 19258, 19284, 18356, 18358, 18361, 18362, 18360, 18357, 18364, 18363, 18359, 19262, 18401, 18335, 17414, 17683 },
          name = "Roi Gordok",
          npc = 11501,
          src = "wowhead"
        },
        {
          display = 11250,
          forever = true,
          level = "59",
          loot = { 18335 },
          name = "Tsu'zee",
          npc = 11467,
          rare = true,
          src = "wowhead"
        },
        {
          display = 1083,
          forever = true,
          level = "60",
          name = "Ferra",
          npc = 14308,
          src = "wowhead"
        },
        {
          display = 11545,
          en = "Stomper Kreeg",
          forever = true,
          level = "59",
          loot = { 17414 },
          name = "Kreeg le Marteleur",
          npc = 14322,
          src = "wowhead"
        },
        {
          display = 14380,
          forever = true,
          level = "56",
          name = "Pimgib",
          npc = 14349,
          src = "wowhead"
        }
      },
      entrance = { map = 1444, src = "questie", x = 0.592, y = 0.451 },
      lootByNpc = { [11488] = { 22206 } },
      quests = {
        [4701] = {
          confirmed = false,
          giver = { map = 1428, name = "Helendis Ruissecorne", npc = 9562, src = "site", x = 0.856, y = 0.69 },
          src = "questie",
          turnIn = { map = 1428, name = "Helendis Ruissecorne", npc = 9562, src = "site", x = 0.856, y = 0.69 }
        },
        [4724] = {
          confirmed = false,
          giver = { map = 1418, name = "Galamav le Tireur d'élite", npc = 9081, src = "site", x = 0.058, y = 0.476 },
          src = "questie",
          turnIn = { map = 1418, name = "Galamav le Tireur d'élite", npc = 9081, src = "site", x = 0.058, y = 0.476 }
        },
        [4729] = {
          confirmed = false,
          giver = { map = 1428, name = "Kibler", npc = 10260, src = "site", x = 0.658, y = 0.22 },
          src = "questie",
          turnIn = { map = 1428, name = "Kibler", npc = 10260, src = "site", x = 0.658, y = 0.22 }
        },
        [4742] = { confirmed = false, src = "questie" },
        [4788] = {
          chain = { 3520, 3527, 4787, 3528, 5065 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1446, name = "Prospecteur Botte-de-fer", npc = 10460, src = "site", x = 0.668, y = 0.24 },
          src = "questie",
          turnIn = { map = 1446, name = "Prospecteur Botte-de-fer", npc = 10460, src = "site", x = 0.668, y = 0.24 }
        },
        [4862] = {
          confirmed = false,
          giver = { map = 1428, name = "Kibler", npc = 10260, src = "site", x = 0.658, y = 0.22 },
          src = "questie",
          turnIn = { map = 1428, name = "Kibler", npc = 10260, src = "site", x = 0.658, y = 0.22 }
        },
        [4866] = {
          confirmed = false,
          giver = { map = 1428, name = "John le Loqueteux", npc = 9563, src = "site", x = 0.65, y = 0.236 },
          src = "questie",
          turnIn = { map = 1428, name = "John le Loqueteux", npc = 9563, src = "site", x = 0.65, y = 0.236 }
        },
        [4867] = { confirmed = false, src = "questie" },
        [4903] = {
          confirmed = false,
          giver = { map = 1418, name = "Warlord Goretooth", npc = 9077, src = "questie", x = 0.0581, y = 0.4752 },
          src = "questie",
          turnIn = { map = 1418, name = "Seigneur de guerre Sangredent", npc = 9077, src = "site", x = 0.058, y = 0.474 }
        },
        [4981] = {
          confirmed = false,
          giver = { map = 1418, name = "Lexlort", npc = 9080, src = "site", x = 0.058, y = 0.476 },
          src = "questie"
        },
        [5001] = { confirmed = false, src = "questie" },
        [5089] = {
          confirmed = false,
          src = "questie",
          turnIn = { map = 1428, name = "Maréchal Maxwell", npc = 9560, src = "site", x = 0.846, y = 0.688 }
        },
        [5518] = { confirmed = false, src = "questie" },
        [5525] = { confirmed = false, src = "questie" },
        [5526] = {
          chain = { 5527 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1450, name = "Rabine Saturna", npc = 11801, src = "site", x = 0.516, y = 0.448 },
          src = "questie",
          turnIn = { map = 1450, name = "Rabine Saturna", npc = 11801, src = "site", x = 0.516, y = 0.448 }
        },
        [5528] = { confirmed = false, src = "questie" },
        [7441] = {
          confirmed = false,
          giver = { map = 1444, name = "Azj'Tordin", npc = 14355, src = "site", x = 0.768, y = 0.374 },
          src = "questie",
          turnIn = { map = 1444, name = "Azj'Tordin", npc = 14355, src = "site", x = 0.768, y = 0.374 }
        },
        [7461] = { confirmed = false, src = "questie" },
        [7463] = { confirmed = false, src = "questie" },
        [7481] = {
          confirmed = false,
          giver = { map = 1444, name = "Sage Korolusk", npc = 14373, src = "site", x = 0.75, y = 0.438 },
          src = "questie",
          turnIn = { map = 1444, name = "Sage Korolusk", npc = 14373, src = "site", x = 0.75, y = 0.438 }
        },
        [7482] = {
          confirmed = false,
          giver = { map = 1444, name = "Erudite Roncerune", npc = 14374, src = "site", x = 0.312, y = 0.434 },
          src = "questie",
          turnIn = { map = 1444, name = "Erudite Roncerune", npc = 14374, src = "site", x = 0.312, y = 0.434 }
        },
        [7488] = {
          chain = { 7494 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1444, name = "Latronicus Lancelune", npc = 7877, src = "site", x = 0.304, y = 0.46 },
          src = "questie",
          turnIn = { map = 1444, name = "Latronicus Lancelune", npc = 7877, src = "site", x = 0.304, y = 0.46 }
        },
        [7489] = {
          chain = { 7492 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1444, name = "Talo Sabot-de-ronce", npc = 7776, src = "site", x = 0.76, y = 0.438 },
          src = "questie",
          turnIn = { map = 1444, name = "Talo Sabot-de-ronce", npc = 7776, src = "site", x = 0.76, y = 0.438 }
        },
        [7507] = { confirmed = false, src = "questie" },
        [7703] = { confirmed = false, src = "questie" }
      }
    },
    -- wowhead forever (zone=2057, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin de zone ou commun). Kormok, Ravassombre, Seigneur Noirbois (invocations) non ajoutés.
    scholo = {
      bosses = {
        {
          display = 143673,
          en = "Kirtonos the Herald",
          forever = true,
          level = "60",
          loot = { 16734, 13002, 23197, 13004, 13047, 13096, 18600, 17414, 17683, 13006 },
          name = "Kirtonos le Héraut",
          npc = 10506,
          src = "wowhead"
        },
        {
          display = 10925,
          en = "Blood Steward of Kirtonos",
          forever = true,
          level = "61",
          loot = { 18335, 18600, 22890, 22891 },
          name = "Régisseuse sanglante de Kirtonos",
          npc = 14861,
          src = "wowhead"
        },
        {
          display = 11073,
          forever = true,
          level = "61",
          loot = { 16701, 17683, 19263, 19265, 19281, 18335, 18600, 19233, 13053 },
          name = "Jandice Barov",
          npc = 10503,
          src = "wowhead"
        },
        {
          display = 12073,
          en = "Rattlegore",
          forever = true,
          level = "61",
          loot = { 16711, 18782, 19272, 18335, 19281, 18600, 17414, 17683, 13015, 13135, 19234, 5267, 9402, 19233, 22393, 19262 },
          name = "Cliquettripes",
          npc = 11622,
          src = "wowhead"
        },
        {
          display = 10248,
          en = "Marduk Blackpool",
          forever = true,
          level = "58",
          loot = { 19263, 19282, 18335 },
          name = "Marduk Noirétang",
          npc = 10433,
          src = "wowhead"
        },
        {
          display = 2606,
          forever = true,
          level = "60",
          loot = { 19235, 22393, 23199, 22890, 18600, 18335, 17414, 17683, 19282 },
          name = "Vectus",
          npc = 10432,
          src = "wowhead"
        },
        {
          display = 7919,
          en = "Ras Frostwhisper",
          forever = true,
          level = "62",
          loot = { 16689, 14525, 13107, 19263, 19284, 22890, 18335, 19283, 19282, 17683, 17414, 18600, 9402, 13006, 19234, 19236, 19262, 19272, 19275, 22393 },
          name = "Ras Murmegivre",
          npc = 10508,
          src = "wowhead"
        },
        {
          display = 11069,
          en = "Instructor Malicia",
          forever = true,
          level = "60",
          loot = { 16710, 14623, 14621, 14620, 14622, 14624, 18335, 13135, 14507, 19264, 17414, 18600, 22890, 17683, 13053, 4696, 22393, 19236 },
          name = "Instructeur Malicia",
          npc = 10505,
          src = "wowhead"
        },
        {
          display = 10901,
          en = "Doctor Theolen Krastinov",
          forever = true,
          level = "60",
          loot = { 16684, 14617, 14622, 14620, 14621, 14623, 14624, 19281, 19282, 1973, 19275, 4696, 19264, 19272, 19234, 19235, 19283, 18335, 17414, 22890, 17683, 18600, 13072, 13101, 22891, 13002, 13060, 19262, 19263, 22393 },
          name = "Docteur Theolen Krastinov",
          npc = 11261,
          src = "wowhead"
        },
        {
          display = 11492,
          en = "Lorekeeper Polkelt",
          forever = true,
          level = "60",
          loot = { 16705, 22206, 14620, 14622, 14623, 14621, 14624, 13135, 19283, 18335, 17683, 22891, 17414, 18600, 13053, 4696, 19275, 19284, 22890 },
          name = "Gardien du savoir Polkelt",
          npc = 10901,
          src = "wowhead"
        },
        {
          display = 10433,
          en = "The Ravenian",
          forever = true,
          level = "60",
          loot = { 16716, 14622, 14620, 14623, 14621, 14624, 12703, 19233, 19235, 19282, 4696, 23197, 18335, 19234, 22890, 17414, 13004, 13053, 18600, 17683, 13015, 13070, 19273, 22393 },
          name = "Le Voracien",
          npc = 10507,
          src = "wowhead"
        },
        {
          display = 11072,
          en = "Lord Alexei Barov",
          forever = true,
          level = "60",
          loot = { 14624, 16722, 14620, 14623, 14622, 14621, 18335, 13004, 19264, 19272, 22890, 17683, 22393, 17414, 13006, 13135, 18600, 19262, 13123 },
          name = "Seigneur Alexei Barov",
          npc = 10504,
          src = "wowhead"
        },
        {
          display = 11835,
          en = "Lady Illucia Barov",
          forever = true,
          level = "60",
          loot = { 14620, 14621, 14622, 14623, 14624, 13002, 13146, 19272, 1973, 19236, 19263, 23199, 17683, 22891, 17414, 18335, 18600, 22393, 13070, 19234 },
          name = "Dame Illucia Barov",
          npc = 10502,
          src = "wowhead"
        },
        {
          display = 11070,
          en = "Darkmaster Gandling",
          forever = true,
          level = "61",
          loot = { 16677, 16686, 16731, 16698, 16693, 16720, 16707, 14514, 16727, 16667, 19276, 228310, 228114, 22891, 228117, 22393, 17683, 18600, 227905, 13096 },
          name = "Sombre Maître Gandling",
          npc = 1853,
          src = "wowhead"
        }
      },
      entrance = { map = 1422, src = "questie", x = 0.697, y = 0.732 },
      lootByNpc = {
        [10469] = { 16684 },
        [10477] = { 16705 },
        [10478] = { 1382, 16671 },
        [10495] = { 16714 },
        [10901] = { 16705, 22206 },
        [11261] = { 14617, 16684 },
        [11622] = { 16711 }
      },
      quests = {
        [4771] = {
          chain = { 4726, 4808, 4809, 4810, 4734, 4735, 5522, 5531 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 },
          src = "questie",
          turnIn = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 }
        },
        [5341] = {
          confirmed = false,
          giver = { map = 1420, name = "Alexi Barov", npc = 11022, src = "site", x = 0.83, y = 0.714 },
          src = "questie",
          turnIn = { map = 1420, name = "Alexi Barov", npc = 11022, src = "site", x = 0.83, y = 0.714 }
        },
        [5343] = {
          confirmed = false,
          giver = { map = 1422, name = "Weldon Barov", npc = 11023, src = "site", x = 0.434, y = 0.836 },
          src = "questie",
          turnIn = { map = 1422, name = "Weldon Barov", npc = 11023, src = "site", x = 0.434, y = 0.836 }
        },
        [5382] = {
          confirmed = false,
          giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 },
          src = "questie",
          turnIn = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 }
        },
        [5384] = {
          chain = { 5382, 5515 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 },
          src = "questie",
          turnIn = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 }
        },
        [5466] = {
          chain = { 5382, 5515, 5384, 5461, 5462, 5463, 5464, 5465 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1422, name = "Magistrat Marduke", npc = 11286, src = "site", x = 0.704, y = 0.74 },
          src = "questie",
          turnIn = { map = 1422, name = "Magistrat Marduke", npc = 11286, src = "site", x = 0.704, y = 0.74 }
        },
        [5515] = {
          chain = { 5382 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 },
          src = "questie",
          turnIn = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "site", x = 0.702, y = 0.738 }
        },
        [5529] = {
          confirmed = false,
          giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 },
          src = "questie",
          turnIn = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 }
        },
        [5582] = {
          chain = { 5529 },
          chainSrc = "questie",
          confirmed = false,
          src = "questie",
          turnIn = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 }
        },
        [7668] = { confirmed = false, src = "site" }
      }
    },
    -- wowhead forever (zone=2017, pages npc) : npcId, display, niveaux, noms EN, butin bleu de la page de chaque boss (y compris butin de zone ou commun).
    -- ajoutés : rares Krân, Hearthsinger Forresten, Echine-de-pierre ; Fras Siabi, Postier Malown, Forgeur de marteaux cramoisi, Fabricant d'épées de la Garde noire. Baron Vaillefendre : nom FR gardé (Wowhead FR affiche « Baron Rivendare »).
    -- à confirmer : Balnazzar (taux non publiés sur Wowhead) ; Fras Siabi s'appelle « Ezra Grimm » en anglais sur Forever.
    strat = {
      bosses = {
        {
          display = 571,
          en = "Timmy the Cruel",
          forever = true,
          level = "58",
          loot = { 13400, 13402, 16724, 19263, 22393, 13101, 17414, 18335 },
          name = "Timmy le Cruel",
          npc = 10808,
          src = "wowhead"
        },
        {
          display = 10458,
          en = "Malor the Zealous",
          forever = true,
          level = "60",
          loot = { 18335, 18600, 17683, 13028, 22393, 17414, 13123, 4696, 19236, 13015, 22891, 23203 },
          name = "Malor le Zélé",
          npc = 11032,
          src = "wowhead"
        },
        {
          display = 10674,
          en = "Cannon Master Willey",
          forever = true,
          level = "60",
          loot = { 16708, 12839, 13070, 17414, 17683, 19262, 22393, 13053, 13135, 18335, 18600, 21524 },
          name = "Maître canonnier Willey",
          npc = 10997,
          src = "wowhead"
        },
        {
          display = 10544,
          en = "Archivist Galford",
          forever = true,
          level = "60",
          loot = { 13387, 16692, 22897, 22393, 19233, 19273, 19234, 13053, 9402, 18335, 17414, 17683, 19264, 22206 },
          name = "Archiviste Galford",
          npc = 10811,
          src = "wowhead"
        },
        {
          display = 10691,
          forever = true,
          level = "62",
          loot = { 14512, 16725, 18720 },
          name = "Balnazzar",
          npc = 10813,
          src = "wowhead"
        },
        {
          display = 10433,
          en = "Magistrate Barthilas",
          forever = true,
          level = "58",
          loot = { 18722, 13036, 22891, 2245, 13002, 19234, 19263, 13013, 18335, 17414, 18600, 17683, 13070 },
          name = "Magistrat Barthilas",
          npc = 10435,
          src = "wowhead"
        },
        {
          display = 9793,
          forever = true,
          level = "60",
          loot = { 16675, 13002, 22891, 13096, 17683, 17414, 18600 },
          name = "Nerub'enkan",
          npc = 10437,
          src = "wowhead"
        },
        {
          display = 10698,
          en = "Baroness Anastari",
          forever = true,
          level = "59",
          loot = { 16704, 13135, 19263, 23197, 13044, 19274, 17414, 17683, 18335, 22393 },
          name = "Baronne Anastari",
          npc = 10436,
          src = "wowhead"
        },
        {
          display = 10546,
          en = "Maleki the Pallid",
          forever = true,
          level = "61",
          loot = { 16691, 12833, 18335, 19233, 19275, 22393, 17683 },
          name = "Maleki le Blafard",
          npc = 10438,
          src = "wowhead"
        },
        {
          display = 12818,
          en = "Ramstein the Gorger",
          forever = true,
          level = "61",
          loot = { 16737, 9402, 13107, 18600, 22891, 17683, 17414 },
          name = "Ramstein Grandgosier",
          npc = 10439,
          src = "wowhead"
        },
        {
          display = 10729,
          en = "Baron Rivendare",
          forever = true,
          level = "62",
          loot = { 13340, 16687, 16709, 16732, 16694, 16678, 16699, 16719, 16728, 16668, 17414, 13000, 13006, 19236, 228114, 227905, 228117, 228310, 18335, 19272, 19263, 22890, 17683, 18600, 22393 },
          name = "Baron Vaillefendre",
          npc = 10440,
          src = "wowhead"
        },
        {
          display = 10771,
          en = "The Unforgiven",
          forever = true,
          level = "57",
          loot = { 13405, 13404, 16717, 19262, 13044, 17683, 18600, 18335, 19283 },
          name = "Le Condamné",
          npc = 10516,
          src = "wowhead"
        },
        {
          display = 2606,
          en = "Skul",
          forever = true,
          level = "58",
          loot = { 17683, 18335 },
          name = "Krân",
          npc = 10393,
          rare = true,
          src = "wowhead"
        },
        {
          display = 10482,
          forever = true,
          level = "57",
          loot = { 16682, 13101, 17414, 17683, 24222, 18600, 19233, 18335, 13036, 13122, 22891 },
          name = "Hearthsinger Forresten",
          npc = 10558,
          rare = true,
          src = "wowhead"
        },
        {
          display = 7856,
          en = "Stonespine",
          forever = true,
          level = "60",
          loot = { 13397, 18600 },
          name = "Echine-de-pierre",
          npc = 10809,
          rare = true,
          src = "wowhead"
        },
        {
          display = 10475,
          en = "Ezra Grimm",
          forever = true,
          level = "61",
          loot = { 18600, 2801, 17414 },
          name = "Fras Siabi",
          npc = 11058,
          src = "wowhead"
        },
        {
          display = 10669,
          en = "Postmaster Malown",
          forever = true,
          level = "60",
          loot = { 18335 },
          name = "Postier Malown",
          npc = 11143,
          src = "wowhead"
        },
        {
          display = 10637,
          en = "Crimson Hammersmith",
          forever = true,
          level = "60",
          loot = { 18781, 17683, 18335, 17414 },
          name = "Forgeur de marteaux cramoisi",
          npc = 11120,
          src = "wowhead"
        },
        {
          display = 775,
          en = "Black Guard Swordsmith",
          forever = true,
          level = "61",
          loot = { 18783, 19233, 18335, 13028, 17414 },
          name = "Fabricant d'épées de la Garde noire",
          npc = 11121,
          src = "wowhead"
        }
      },
      entrance = { map = 1423, src = "questie", x = 0.435, y = 0.194 },
      lootByNpc = {
        [10406] = { 16681 },
        [10407] = { 16681 },
        [10412] = { 16671 },
        [10413] = { 16671 },
        [10414] = { 16736 },
        [10416] = { 16736 },
        [10417] = { 16736 },
        [10421] = { 16681 },
        [10426] = { 16714 },
        [10436] = { 16704 },
        [10438] = { 16691 },
        [10440] = { 16668, 16678, 16687, 16694, 16699, 16709, 16719, 16728, 16732 },
        [10463] = { 16714 },
        [10464] = { 16714 },
        [10558] = { 16682 },
        [10811] = { 16692, 22206 },
        [10997] = { 16708, 21524 },
        [11043] = { 16671 },
        [14684] = { 23125 }
      },
      quests = {
        [5122] = { confirmed = false, src = "questie" },
        [5125] = { chain = { 5122 }, chainSrc = "questie", confirmed = false, src = "questie" },
        [5212] = {
          confirmed = false,
          giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 },
          src = "questie",
          turnIn = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 }
        },
        [5213] = {
          chain = { 5212 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 },
          src = "questie",
          turnIn = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "site", x = 0.814, y = 0.596 }
        },
        [5214] = {
          confirmed = false,
          giver = { map = 1423, name = "Smokey LaRue", npc = 11033, src = "site", x = 0.806, y = 0.58 },
          src = "questie",
          turnIn = { map = 1423, name = "Smokey LaRue", npc = 11033, src = "site", x = 0.806, y = 0.58 }
        },
        [5243] = {
          confirmed = false,
          giver = { map = 1423, name = "Leonid Barthalomew le Révéré", npc = 11036, src = "site", x = 0.816, y = 0.578 },
          src = "questie",
          turnIn = { map = 1423, name = "Leonid Barthalomew le Révéré", npc = 11036, src = "site", x = 0.816, y = 0.578 }
        },
        [5251] = {
          confirmed = false,
          giver = { map = 1423, name = "Duc Nicholas Zverenhoff", npc = 11039, src = "site", x = 0.814, y = 0.598 },
          src = "questie",
          turnIn = { map = 1423, name = "Duc Nicholas Zverenhoff", npc = 11039, src = "site", x = 0.814, y = 0.598 }
        },
        [5262] = {
          chain = { 5251 },
          chainSrc = "questie",
          confirmed = false,
          src = "questie",
          turnIn = { map = 1423, name = "Duc Nicholas Zverenhoff", npc = 11039, src = "site", x = 0.814, y = 0.598 }
        },
        [5263] = {
          chain = { 5251, 5262 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Duc Nicholas Zverenhoff", npc = 11039, src = "site", x = 0.814, y = 0.598 },
          src = "questie",
          turnIn = { map = 1423, name = "Duc Nicholas Zverenhoff", npc = 11039, src = "site", x = 0.814, y = 0.598 }
        },
        [5282] = {
          chain = { 5281 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Egan", npc = 11140, src = "site", x = 0.144, y = 0.336 },
          src = "questie",
          turnIn = { map = 1423, name = "Egan", npc = 11140, src = "site", x = 0.144, y = 0.336 }
        },
        [5463] = {
          chain = { 5382, 5515, 5384, 5461, 5462 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Leonid Barthalomew le Révéré", npc = 11036, src = "site", x = 0.816, y = 0.578 },
          src = "questie"
        },
        [5848] = {
          chain = { 5542, 5543, 5544, 5742, 5781, 5845, 5846 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1422, name = "Artiste Renfray", npc = 11936, src = "site", x = 0.656, y = 0.754 },
          src = "questie",
          turnIn = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "site", x = 0.074, y = 0.436 }
        },
        [6163] = {
          chain = { 6133, 6135 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Nathanos le Flétrisseur", npc = 11878, src = "site", x = 0.266, y = 0.748 },
          src = "questie",
          turnIn = { map = 1423, name = "Nathanos le Flétrisseur", npc = 11878, src = "site", x = 0.266, y = 0.748 }
        },
        [8945] = {
          chain = { 8905, 8922, 8921, 8924, 8925, 8928, 8977, 8926, 8929 },
          chainSrc = "questie",
          confirmed = false,
          giver = { map = 1423, name = "Anthion Harmon", npc = 16016, src = "questie", x = 0.3085, y = 0.1675 },
          src = "questie"
        }
      }
    },
    ony = {
      bosses = {
        { level = "63", name = "Onyxia", npc = 10184 }
      },
      entrance = { map = 1445, src = "questie", x = 0.526, y = 0.768 }
    },
    -- wowhead forever (zone=2717, pages npc) : npcId, display, noms EN/DE/ES, tout le butin bleu et épique relevé (propre au boss, puis butin de zone).
    -- à confirmer : les pages Wowhead Forever ne montrent pas encore le butin épique propre à chaque boss (pièces de set, armes) ; Chambellan Executus : butin du Cache du seigneur du feu (coffre) non relevé ; Ragnaros : objets de zone vus sur peu de morts (119).
    mc = {
      bosses = {
        {
          display = 13031,
          forever = true,
          level = "63",
          loot = {
            18879, 19147, 21371, 18265, 18260, 18290, 18252, 18259,
            18291, 18292, 18257, 18264
          },
          name = "Lucifron",
          npc = 12118,
          src = "wowhead"
        },
        {
          display = 10193,
          forever = true,
          level = "63",
          loot = {
            17073, 18821, 18820, 18257, 18264, 18252, 18292, 18259,
            18260, 18291, 18290, 18265, 21371
          },
          name = "Magmadar",
          npc = 11982,
          src = "wowhead"
        },
        {
          display = 13030,
          forever = true,
          level = "63",
          loot = {
            19147, 18879, 18265, 18259, 21371, 18260, 18292, 18290,
            18257, 18264, 18252, 18291
          },
          name = "Gehennas",
          npc = 12259,
          src = "wowhead"
        },
        {
          display = 12110,
          forever = true,
          level = "63",
          loot = {
            17011, 18820, 18821, 18564, 18264, 18259, 18265, 18257,
            18291, 18290, 21371, 18292, 18260, 18252
          },
          name = "Garr",
          npc = 12057,
          src = "wowhead"
        },
        {
          display = 12129,
          forever = true,
          level = "63",
          loot = {
            17010, 18563, 18820, 18821, 18260, 18290, 18291, 18252,
            18259, 18265, 21371, 18257, 18292, 18264
          },
          name = "Baron Geddon",
          npc = 12056,
          src = "wowhead"
        },
        {
          display = 13032,
          forever = true,
          level = "63",
          loot = {
            18879, 19147, 18259, 18265, 18264, 18292, 18257, 18260,
            18290, 18252, 18291, 21371
          },
          name = "Shazzrah",
          npc = 12264,
          src = "wowhead"
        },
        {
          display = 13030,
          en = "Sulfuron Harbinger",
          forever = true,
          loot = { 18879, 19147 },
          name = "Messager de Sulfuron",
          npc = 12098,
          src = "wowhead"
        },
        {
          display = 11986,
          en = "Golemagg the Incinerator",
          forever = true,
          loot = {
            17011, 17203, 18820, 18821, 18291, 18260, 18265, 18257,
            18290, 18252, 18264, 18259, 21371, 18292
          },
          name = "Golemagg l'Incinérateur",
          npc = 11988,
          src = "wowhead"
        },
        {
          display = 12029,
          en = "Majordomo Executus",
          forever = true,
          loot = { 14343, 18646, 18703 },
          name = "Chambellan Executus",
          npc = 12018,
          src = "wowhead"
        },
        {
          display = 11121,
          forever = true,
          loot = {
            7734, 18815, 18814, 19138, 21110, 13008, 17204, 19017,
            13073, 13009, 21106, 2564, 13007, 13111, 13013, 13004,
            13072, 13107, 13130, 13125, 13126, 13135, 13116, 13144,
            13000, 13040, 13047, 13123, 1203, 5267, 6622, 9402,
            13006, 13036, 13053, 13066, 13077, 13113, 13118, 13120,
            13002, 13003, 13060, 13067, 13070
          },
          name = "Ragnaros",
          npc = 11502,
          src = "wowhead"
        }
      },
      entrance = { map = 1427, src = "questie", x = 0.348, y = 0.853 }
    },
    bwl = {
      bosses = {
        { name = "Tranchetripe l'Indompté" },
        { name = "Vaelastrasz le Corrompu" },
        { name = "Seigneur des couvées Lashlayer" },
        { name = "Gueule-de-feu" },
        { name = "Rochébène" },
        { level = "63", name = "Flamegor", npc = 11981 },
        { level = "63", name = "Chromaggus", npc = 14020 },
        { name = "Nefarian" }
      },
      entrance = { map = 1427, src = "questie", x = 0.348, y = 0.853 },
      lootByNpc = {
        [12017] = { 19341, 19342 },
        [12435] = { 19336, 19337 },
        [12457] = { 19434 },
        [12459] = { 19434 },
        [12461] = { 19434 },
        [13020] = { 19339, 19340, 19371 }
      }
    },
    zg = {
      bosses = {
        { name = "Grande prêtresse Jeklik" },
        { name = "Grand prêtre Venoxis" },
        { name = "Grande prêtresse Mar'li" },
        { name = "Seigneur sanglant Mandokir" },
        { name = "Gri'lek, Hazza'rah, Renataki ou Wushoolay" },
        { name = "Gahz'ranka" },
        { name = "Grand prêtre Thekal" },
        { name = "Grande prêtresse Arlokk" },
        { name = "Jin'do le Maléficieur" },
        { level = "63", name = "Hakkar", npc = 14834 }
      },
      entrance = { map = 1434, src = "questie", x = 0.5389, y = 0.176 },
      lootByNpc = { [11357] = { 21039, 21040 } }
    },
    aq20 = {
      bosses = {
        { level = "63", name = "Kurinnaxx", npc = 15348 },
        { name = "Général Rajaxx" },
        { level = "63", loot = { 21473, 21477 }, name = "Moam", npc = 15340, src = "questie" },
        { name = "Buru Grandgosier" },
        { name = "Ayamiss le Chasseur" },
        { name = "Ossirian l'Intouché" }
      },
      entrance = { map = 1451, src = "questie", x = 0.286, y = 0.923 },
      lootByNpc = { [15369] = { 21483 }, [15370] = { 21488 } }
    },
    aq40 = {
      bosses = {
        { name = "Le Prophète Skeram" },
        { name = "Seigneur Kri, Princesse Yauj et Vem" },
        { name = "Garde de guerre Sartura" },
        { name = "Fankriss l'Inflexible" },
        {
          level = "63",
          loot = { 21622, 21623, 21624, 21625, 21677, 22399 },
          name = "Viscidus",
          npc = 15299,
          src = "questie"
        },
        { name = "Princesse Huhuran" },
        { name = "Empereur Vek'lor et Empereur Vek'nilash" },
        { name = "Ouro" },
        { level = "63", loot = { 21579 }, name = "C'Thun", npc = 15727, src = "questie" }
      },
      entrance = { map = 1451, src = "questie", x = 0.286, y = 0.923 },
      lootByNpc = {
        [15275] = { 21604, 21605, 21606, 21607, 21608, 21609 },
        [15276] = { 21597, 21598, 21600, 21601, 21602 },
        [15509] = { 21616, 21618, 21619, 21620 },
        [15511] = { 21681, 21685, 21693, 21694, 21695 },
        [15543] = { 21687, 21693, 21694, 21695 },
        [15544] = { 21690, 21693, 21694, 21695 }
      }
    },
    -- wowhead forever (zone=3456, pages npc) : npcId, display, noms EN/DE/ES, tout le butin épique et bleu relevé (propre au boss puis Fragment d'Atiesh et Rune de givre).
    -- Quatre cavaliers : une seule entrée, npc et butin de Thane Korth'azz (seul des quatre avec un butin relevé ; le coffre des cavaliers n'est pas relevé). Maexxna : objets listés sans taux.
    -- à confirmer : 23577 (The Hungering Cold), sans nom FR/DE/ES sur Wowhead, traduction faite main.
    naxx = {
      bosses = {
        {
          display = 15931,
          forever = true,
          level = "63",
          loot = {
            22355, 22362, 22369, 22726, 22935, 22939, 22682
          },
          name = "Anub'Rekhan",
          npc = 15956,
          src = "wowhead"
        },
        {
          display = 15940,
          en = "Grand Widow Faerlina",
          forever = true,
          loot = {
            22355, 22362, 22369, 22726, 22943, 22940, 22941, 22682
          },
          name = "Grande veuve Faerlina",
          npc = 15953,
          src = "wowhead"
        },
        {
          display = 15928,
          forever = true,
          level = "63",
          loot = {
            22357, 22364, 22371, 22726, 22947, 22954, 22682
          },
          name = "Maexxna",
          npc = 15952,
          src = "wowhead"
        },
        {
          display = 16590,
          en = "Noth the Plaguebringer",
          forever = true,
          loot = {
            22363, 22356, 22370, 22726, 23031, 23028, 23006, 23005
          },
          name = "Noth le Porte-peste",
          npc = 15954,
          src = "wowhead"
        },
        {
          display = 16309,
          en = "Heigan the Unclean",
          forever = true,
          loot = {
            22356, 22363, 22370, 22726, 23019, 23033, 23036, 22682
          },
          name = "Heigan l'Impur",
          npc = 15936,
          src = "wowhead"
        },
        {
          display = 16110,
          en = "Loatheb",
          forever = true,
          loot = {
            22366, 22359, 22352, 22726, 23037, 23038, 23042
          },
          name = "Horreb",
          npc = 16011,
          src = "wowhead"
        },
        {
          display = 16582,
          en = "Instructor Razuvious",
          forever = true,
          loot = { 22372, 22365, 22358, 22726, 23004, 23018 },
          name = "Instructeur Razuvious",
          npc = 16061,
          src = "wowhead"
        },
        {
          display = 16279,
          en = "Gothik the Harvester",
          forever = true,
          loot = {
            22682, 22365, 22372, 22358, 22726, 23020, 23023, 23032
          },
          name = "Gothik le Moissonneur",
          npc = 16060,
          src = "wowhead"
        },
        {
          display = 16155,
          en = "Highlord Mograine, Thane Korth'azz, Lady Blaumeux and Sir Zeliek",
          forever = true,
          loot = { 22350, 22349, 22351, 22726, 23025, 23027 },
          name = "Généralissime Mograine, Thane Korth'azz, Dame Blaumeux et Sire Zeliek",
          npc = 16064,
          src = "wowhead"
        },
        {
          display = 16174,
          en = "Patchwerk",
          forever = true,
          loot = { 22361, 22354, 22726, 22368, 22961 },
          name = "Le Recousu",
          npc = 16028,
          src = "wowhead"
        },
        {
          display = 16035,
          forever = true,
          level = "63",
          loot = { 22368, 22726, 22361, 22354, 22968, 22967 },
          name = "Grobbulus",
          npc = 15931,
          src = "wowhead"
        },
        {
          display = 16064,
          forever = true,
          level = "63",
          loot = {
            22726, 22981, 22370, 22355, 22362, 22372, 22354, 22365,
            22363, 22356, 22358, 22369, 22368, 22361
          },
          name = "Gluth",
          npc = 15932,
          src = "wowhead"
        },
        {
          display = 16137,
          forever = true,
          level = "63",
          loot = { 22367, 22353, 22360, 22726, 23001 },
          name = "Thaddius",
          npc = 15928,
          src = "wowhead"
        },
        {
          display = 16033,
          en = "Sapphiron",
          forever = true,
          loot = {
            23549, 23547, 23545, 23548, 23047, 23040, 23041, 23046
          },
          name = "Saphiron",
          npc = 15989,
          src = "wowhead"
        },
        {
          display = 15945,
          forever = true,
          level = "63",
          loot = {
            22520, 23060, 23064, 23063, 23059, 23062, 23061, 23067,
            23066, 23053, 23577, 23057, 23065, 22733
          },
          name = "Kel'Thuzad",
          npc = 15990,
          src = "wowhead"
        }
      },
      entrance = { map = 1423, src = "questie", x = 0.399, y = 0.258 },
      lootByNpc = {
        [15936] = { 23019, 23033, 23036 },
        [15953] = { 22940, 22941, 22943 },
        [15954] = { 23005, 23006, 23028, 23031 },
        [16011] = { 23037, 23038, 23042 },
        [16028] = { 22961 },
        [16060] = { 23020, 23023, 23032 },
        [16061] = { 23004, 23018 }
      }
    },
  },
  steps = {
    [65] = {
      giver = { map = 1436, name = "Gryan Stoutmantle", npc = 234, src = "questie", x = 0.5633, y = 0.4752 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [132] = {
      giver = { map = 1433, name = "Wiley the Black", npc = 266, src = "questie", x = 0.2648, y = 0.4535 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [135] = {
      giver = { map = 1436, name = "Gryan Stoutmantle", npc = 234, src = "questie", x = 0.5633, y = 0.4752 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [141] = {
      giver = { map = 1453, name = "Maître Mathias Shaw", npc = 332, src = "questie", x = 0.7578, y = 0.5984 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [142] = {
      giver = { map = 1436, name = "Gryan Stoutmantle", npc = 234, src = "questie", x = 0.5633, y = 0.4752 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [155] = {
      giver = { map = 1436, name = "Le traître défias", npc = 467, src = "questie", x = 0.5568, y = 0.475 },
      level = 18,
      minLevel = 14,
      name = "La Confrérie défias",
      src = "client"
    },
    [261] = {
      giver = { map = 1443, name = "Brother Anton", npc = 1182, src = "questie", x = 0.6652, y = 0.0791 },
      level = 39,
      minLevel = 34,
      name = "Down the Scarlet Path",
      src = "questie"
    },
    [303] = {
      giver = { map = 1437, name = "Motley Garmason", npc = 1074, src = "questie", x = 0.4967, y = 0.1823 },
      level = 30,
      minLevel = 25,
      name = "The Dark Iron War",
      src = "questie"
    },
    [373] = { fromItem = 2874, level = 22, minLevel = 16, name = "La lettre non envoyée", src = "client" },
    [389] = {
      giver = { map = 1453, name = "Baros Alexston", npc = 1646, src = "questie", x = 0.4919, y = 0.3028 },
      level = 22,
      minLevel = 16,
      name = "Bazil Thredd",
      src = "client"
    },
    [707] = {
      giver = { map = 1455, name = "Prospecteur Stormpike", npc = 1356, src = "questie", x = 0.7464, y = 0.1174 },
      level = 37,
      minLevel = 30,
      name = "Ironband Wants You!",
      src = "questie"
    },
    [720] = { level = 35, minLevel = 35, name = "A Sign of Hope", src = "questie" },
    [721] = {
      giver = { map = 1418, name = "Prospector Ryedol", npc = 2910, src = "questie", x = 0.5342, y = 0.4339 },
      level = 35,
      minLevel = 35,
      name = "A Sign of Hope",
      src = "questie"
    },
    [722] = {
      giver = { map = 1432, name = "Hammertoe Grez", npc = 2909, src = "questie", x = 0.3728, y = 0.8578 },
      level = 40,
      minLevel = 35,
      name = "Amulet of Secrets",
      src = "questie"
    },
    [723] = {
      giver = { map = 1432, name = "Hammertoe Grez", npc = 2909, src = "questie", x = 0.3728, y = 0.8578 },
      level = 40,
      minLevel = 35,
      name = "Prospect of Faith",
      src = "questie"
    },
    [724] = {
      giver = { map = 1418, name = "Prospector Ryedol", npc = 2910, src = "questie", x = 0.5342, y = 0.4339 },
      level = 40,
      minLevel = 35,
      name = "Prospect of Faith",
      src = "questie"
    },
    [725] = {
      giver = { map = 1455, name = "Historien Karnik", npc = 2916, src = "questie", x = 0.7754, y = 0.1182 },
      level = 40,
      minLevel = 35,
      name = "Passing Word of a Threat",
      src = "questie"
    },
    [726] = {
      giver = { map = 1455, name = "Conseiller Belgrum", npc = 2918, src = "questie", x = 0.7734, y = 0.0971 },
      level = 40,
      minLevel = 35,
      name = "Passing Word of a Threat",
      src = "questie"
    },
    [738] = {
      giver = { map = 1432, name = "Prospecteur Ironband", npc = 1344, src = "questie", x = 0.6593, y = 0.6562 },
      level = 38,
      minLevel = 30,
      name = "Find Agmond",
      src = "questie"
    },
    [739] = { level = 42, minLevel = 30, name = "Murdaloc", src = "questie" },
    [762] = {
      giver = { map = 1455, name = "Historien Karnik", npc = 2916, src = "questie", x = 0.7754, y = 0.1182 },
      level = 44,
      minLevel = 35,
      name = "An Ambassador of Evil",
      src = "questie"
    },
    [865] = {
      giver = { map = 1413, name = "Mebok Mizzyrix", npc = 3446, src = "questie", x = 0.6237, y = 0.3762 },
      level = 18,
      minLevel = 13,
      name = "Les cornes de raptors",
      src = "client"
    },
    [870] = {
      giver = { map = 1413, name = "Tonga Runetotem", npc = 3448, src = "questie", x = 0.5226, y = 0.3193 },
      level = 13,
      minLevel = 10,
      name = "Les Bassins oubliés",
      src = "client"
    },
    [877] = {
      giver = { map = 1413, name = "Tonga Runetotem", npc = 3448, src = "questie", x = 0.5226, y = 0.3193 },
      level = 16,
      minLevel = 10,
      name = "L'oasis stagnante",
      src = "client"
    },
    [880] = {
      giver = { map = 1413, name = "Tonga Runetotem", npc = 3448, src = "questie", x = 0.5226, y = 0.3193 },
      level = 16,
      minLevel = 10,
      name = "Source de vie",
      src = "client"
    },
    [1052] = {
      giver = { map = 1443, name = "Brother Anton", npc = 1182, src = "questie", x = 0.6652, y = 0.0791 },
      level = 40,
      minLevel = 34,
      name = "Down the Scarlet Path",
      src = "questie"
    },
    [1100] = { fromItem = 5791, level = 34, minLevel = 29, name = "Lonebrow's Journal", src = "questie" },
    [1109] = {
      giver = { map = 1458, name = "Master Apothecary Faranell", npc = 2055, src = "questie", x = 0.4882, y = 0.6928 },
      level = 33,
      minLevel = 30,
      name = "Going, Going, Guano!",
      src = "questie"
    },
    [1149] = {
      giver = { map = 1441, name = "Dorn Plainstalker", npc = 2986, src = "questie", x = 0.5395, y = 0.4149 },
      level = 26,
      minLevel = 25,
      name = "Test of Faith",
      src = "questie"
    },
    [1150] = {
      giver = { map = 1441, name = "Dorn Plainstalker", npc = 2986, src = "questie", x = 0.5395, y = 0.4149 },
      level = 30,
      minLevel = 25,
      name = "Test of Endurance",
      src = "questie"
    },
    [1151] = {
      giver = { map = 1441, name = "Dorn Plainstalker", npc = 2986, src = "questie", x = 0.5395, y = 0.4149 },
      level = 30,
      minLevel = 25,
      name = "Test of Strength",
      src = "questie"
    },
    [1152] = {
      giver = { map = 1441, name = "Dorn Plainstalker", npc = 2986, src = "questie", x = 0.5395, y = 0.4149 },
      level = 30,
      minLevel = 25,
      name = "Test of Lore",
      src = "questie"
    },
    [1154] = {
      giver = { map = 1442, name = "Braug Dimspirit", npc = 4489, src = "questie", x = 0.788, y = 0.4569 },
      level = 30,
      minLevel = 25,
      name = "Test of Lore",
      src = "questie"
    },
    [1159] = {
      giver = { map = 1442, name = "Braug Dimspirit", npc = 4489, src = "questie", x = 0.788, y = 0.4569 },
      level = 30,
      minLevel = 25,
      name = "Test of Lore",
      src = "questie"
    },
    [1198] = {
      giver = { map = 1457, name = "Dawnwatcher Shaedlass", npc = 4786, src = "questie", x = 0.5536, y = 0.2503 },
      level = 24,
      minLevel = 18,
      name = "À la recherche de Thaelrid",
      src = "client"
    },
    [1424] = {
      giver = { map = 1435, name = "Fel'zerul", npc = 1443, src = "questie", x = 0.4793, y = 0.5478 },
      level = 43,
      minLevel = 38,
      name = "Pool of Tears",
      src = "questie"
    },
    [1429] = {
      giver = { map = 1435, name = "Fel'zerul", npc = 1443, src = "questie", x = 0.4793, y = 0.5478 },
      level = 44,
      minLevel = 38,
      name = "The Atal'ai Exile",
      src = "questie"
    },
    [1444] = {
      giver = { map = 1425, name = "Atal'ai Exile", npc = 5598, src = "questie", x = 0.3375, y = 0.7521 },
      level = 44,
      minLevel = 38,
      name = "Return to Fel'Zerul",
      src = "questie"
    },
    [1448] = {
      giver = { map = 1453, name = "Brohann Caskbelly", npc = 5384, src = "questie", x = 0.6433, y = 0.2063 },
      level = 43,
      minLevel = 38,
      name = "In Search of The Temple",
      src = "questie"
    },
    [1449] = {
      giver = { map = 1453, name = "Brohann Caskbelly", npc = 5384, src = "questie", x = 0.6433, y = 0.2063 },
      level = 43,
      minLevel = 38,
      name = "To The Hinterlands",
      src = "questie"
    },
    [1450] = {
      giver = { map = 1425, name = "Falstad Wildhammer", npc = 5635, src = "questie", x = 0.1181, y = 0.4676 },
      level = 43,
      minLevel = 38,
      name = "Gryphon Master Talonaxe",
      src = "questie"
    },
    [1451] = {
      giver = { map = 1425, name = "Gryphon Master Talonaxe", npc = 5636, src = "questie", x = 0.0975, y = 0.4447 },
      level = 43,
      minLevel = 38,
      name = "Rhapsody Shindigger",
      src = "questie"
    },
    [1452] = {
      giver = { map = 1425, name = "Rhapsody Shindigger", npc = 5634, src = "questie", x = 0.2694, y = 0.4859 },
      level = 43,
      minLevel = 38,
      name = "Rhapsody's Kalimdor Kocktail",
      src = "questie"
    },
    [1469] = {
      giver = { map = 1425, name = "Rhapsody Shindigger", npc = 5634, src = "questie", x = 0.2694, y = 0.4859 },
      level = 43,
      minLevel = 38,
      name = "Rhapsody's Tale",
      src = "questie"
    },
    [1489] = {
      giver = { map = 1413, name = "Tonga Runetotem", npc = 3448, src = "questie", x = 0.5226, y = 0.3193 },
      level = 16,
      minLevel = 10,
      name = "Hamuul Runetotem",
      src = "client"
    },
    [1490] = {
      giver = { map = 1456, name = "Arch Druid Hamuul Runetotem", npc = 5769, src = "questie", x = 0.7862, y = 0.2856 },
      level = 16,
      minLevel = 10,
      name = "Nara Wildmane",
      src = "client"
    },
    [1649] = { fromItem = 6776, level = 20, minLevel = 20, name = "Le Tome de la bravoure", src = "client" },
    [1650] = {
      giver = { map = 1453, name = "Duthorian Rall", npc = 6171, src = "questie", x = 0.3981, y = 0.2979 },
      level = 23,
      minLevel = 20,
      name = "Le Tome de la bravoure",
      src = "client"
    },
    [1651] = {
      giver = { map = 1436, name = "Daphne Stilwell", npc = 6182, src = "questie", x = 0.4169, y = 0.8924 },
      level = 25,
      minLevel = 20,
      name = "Le Tome de la bravoure",
      src = "client"
    },
    [1652] = {
      giver = { map = 1436, name = "Daphne Stilwell", npc = 6182, src = "questie", x = 0.4169, y = 0.8924 },
      level = 25,
      minLevel = 20,
      name = "Le Tome de la bravoure",
      src = "client"
    },
    [1653] = {
      giver = { map = 1453, name = "Duthorian Rall", npc = 6171, src = "questie", x = 0.3981, y = 0.2979 },
      level = 21,
      minLevel = 20,
      name = "Le test de droiture",
      src = "client"
    },
    [1947] = {
      giver = { map = 1453, name = "Jennea Cannon", npc = 5497, src = "questie", x = 0.3862, y = 0.793 },
      level = 38,
      minLevel = 30,
      name = "Journey to the Marsh",
      src = "questie"
    },
    [1949] = {
      giver = { map = 1445, name = "Tabetha", npc = 6546, src = "questie", x = 0.4606, y = 0.5709 },
      level = 38,
      minLevel = 30,
      name = "Hidden Secrets",
      src = "questie"
    },
    [1950] = {
      giver = { map = 1441, name = "Magus Tirth", npc = 6548, src = "questie", x = 0.7829, y = 0.757 },
      level = 30,
      minLevel = 30,
      name = "Get the Scoop",
      src = "questie"
    },
    [1953] = {
      giver = { map = 1458, name = "Anastasia Hartwell", npc = 4568, src = "questie", x = 0.8514, y = 0.1003 },
      level = 40,
      minLevel = 35,
      name = "Return to the Marsh",
      src = "questie"
    },
    [1954] = {
      giver = { map = 1445, name = "Tabetha", npc = 6546, src = "questie", x = 0.4606, y = 0.5709 },
      level = 40,
      minLevel = 35,
      name = "The Infernal Orb",
      src = "questie"
    },
    [1955] = {
      giver = { map = 1445, name = "Tabetha", npc = 6546, src = "questie", x = 0.4606, y = 0.5709 },
      level = 40,
      minLevel = 35,
      name = "The Exorcism",
      src = "questie"
    },
    [2258] = {
      giver = { map = 1418, name = "Jarkal Mossmeld", npc = 6868, src = "questie", x = 0.0242, y = 0.4606 },
      level = 39,
      minLevel = 36,
      name = "Badlands Reagent Run",
      src = "questie"
    },
    [2398] = {
      giver = { map = 1455, name = "Prospecteur Stormpike", npc = 1356, src = "questie", x = 0.7464, y = 0.1174 },
      level = 40,
      minLevel = 35,
      name = "The Lost Dwarves",
      src = "questie"
    },
    [2500] = {
      giver = { map = 1432, name = "Ghak Healtouch", npc = 1470, src = "questie", x = 0.3707, y = 0.4938 },
      level = 39,
      minLevel = 36,
      name = "Badlands Reagent Run",
      src = "questie"
    },
    [2842] = {
      giver = { map = 1454, name = "Sovik", npc = 3413, src = "questie", x = 0.7549, y = 0.2536 },
      level = 35,
      minLevel = 20,
      name = "L'ingénieur en chef Scooty",
      src = "client"
    },
    [2864] = {
      giver = { map = 1434, name = "Krazek", npc = 773, src = "questie", x = 0.2694, y = 0.7721 },
      level = 45,
      minLevel = 40,
      name = "Tran'rek",
      src = "questie"
    },
    [2923] = {
      giver = { map = 1453, name = "Frère Sarno", npc = 7917, src = "questie", x = 0.4055, y = 0.3096 },
      level = 26,
      minLevel = 20,
      name = "Maître-artisan Overspark",
      src = "client"
    },
    [2926] = {
      giver = { map = 1426, name = "Ozzie Togglevolt", npc = 1268, src = "questie", x = 0.4589, y = 0.4939 },
      level = 27,
      minLevel = 20,
      name = "Gnogaine",
      src = "client"
    },
    [2927] = {
      giver = { map = 1455, name = "Gnoarn", npc = 6569, src = "questie", x = 0.6918, y = 0.5055 },
      level = 27,
      minLevel = 20,
      name = "Le jour d'après",
      src = "client"
    },
    [2933] = { level = 43, minLevel = 40, name = "Venom Bottles", src = "questie" },
    [2934] = {
      giver = { map = 1424, name = "Apothecary Lydon", npc = 2216, src = "questie", x = 0.6144, y = 0.1906 },
      level = 45,
      minLevel = 40,
      name = "Undamaged Venom Sac",
      src = "questie"
    },
    [2935] = {
      giver = { map = 1424, name = "Apothecary Lydon", npc = 2216, src = "questie", x = 0.6144, y = 0.1906 },
      level = 45,
      minLevel = 40,
      name = "Consult Master Gadrin",
      src = "questie"
    },
    [2988] = {
      giver = { map = 1425, name = "Gryphon Master Talonaxe", npc = 5636, src = "questie", x = 0.0975, y = 0.4447 },
      level = 45,
      minLevel = 40,
      name = "Witherbark Cages",
      src = "questie"
    },
    [2989] = {
      giver = { map = 1425, name = "Gryphon Master Talonaxe", npc = 5636, src = "questie", x = 0.0975, y = 0.4447 },
      level = 48,
      minLevel = 40,
      name = "The Altar of Zul",
      src = "questie"
    },
    [2990] = {
      giver = { map = 1425, name = "Gryphon Master Talonaxe", npc = 5636, src = "questie", x = 0.0975, y = 0.4447 },
      level = 47,
      minLevel = 40,
      name = "Thadius Grimshade",
      src = "questie"
    },
    [3380] = {
      giver = { map = 1444, name = "Witch Doctor Uzer'i", npc = 8115, src = "questie", x = 0.7442, y = 0.4336 },
      level = 51,
      minLevel = 46,
      name = "The Sunken Temple",
      src = "questie"
    },
    [3441] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 48,
      minLevel = 40,
      name = "Divine Retribution",
      src = "questie"
    },
    [3442] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 48,
      minLevel = 40,
      name = "The Flawless Flame",
      src = "questie"
    },
    [3443] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 48,
      minLevel = 40,
      name = "Forging the Shaft",
      src = "questie"
    },
    [3444] = {
      giver = { map = 1446, name = "Marvon Rivetseeker", npc = 7771, src = "questie", x = 0.5271, y = 0.4592 },
      level = 51,
      minLevel = 46,
      name = "The Stone Circle",
      src = "questie"
    },
    [3452] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 50,
      minLevel = 40,
      name = "The Flame's Casing",
      src = "questie"
    },
    [3453] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 50,
      minLevel = 40,
      name = "The Torch of Retribution",
      src = "questie"
    },
    [3454] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 50,
      minLevel = 40,
      name = "The Torch of Retribution",
      src = "questie"
    },
    [3462] = {
      giver = { map = 1427, name = "Kalaran Windblade", npc = 8479, src = "questie", x = 0.3906, y = 0.3899 },
      level = 50,
      minLevel = 40,
      name = "Squire Maltrake",
      src = "questie"
    },
    [3463] = {
      giver = { map = 1427, name = "Squire Maltrake", npc = 8509, src = "questie", x = 0.3917, y = 0.39 },
      level = 52,
      minLevel = 40,
      name = "Set Them Ablaze!",
      src = "questie"
    },
    [3481] = { level = 50, minLevel = 40, name = "Trinkets...", src = "questie" },
    [3520] = {
      giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "questie", x = 0.6699, y = 0.2236 },
      level = 44,
      minLevel = 40,
      name = "Screecher Spirits",
      src = "questie"
    },
    [3523] = {
      giver = { name = "Belnistrasz", npc = 8516 },
      level = 37,
      minLevel = 32,
      name = "Scourge of the Downs",
      src = "questie"
    },
    [3527] = {
      giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "questie", x = 0.6699, y = 0.2236 },
      level = 47,
      minLevel = 40,
      name = "The Prophecy of Mosh'aru",
      src = "questie"
    },
    [3528] = {
      giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "questie", x = 0.6699, y = 0.2236 },
      level = 53,
      minLevel = 40,
      name = "The God Hakkar",
      src = "questie"
    },
    [3701] = {
      giver = { map = 1455, name = "Historienne royale Archesonus", npc = 8879, src = "questie", x = 0.3837, y = 0.5531 },
      level = 54,
      minLevel = 50,
      name = "The Smoldering Ruins of Thaurissan",
      src = "questie"
    },
    [3702] = {
      giver = { map = 1455, name = "Historienne royale Archesonus", npc = 8879, src = "questie", x = 0.3837, y = 0.5531 },
      level = 54,
      minLevel = 50,
      name = "The Smoldering Ruins of Thaurissan",
      src = "questie"
    },
    [3765] = {
      giver = { map = 1453, name = "Argos Nightwhisper", npc = 4984, src = "questie", x = 0.214, y = 0.558 },
      level = 24,
      minLevel = 18,
      name = "La dépravation au loin",
      src = "client"
    },
    [3801] = {
      giver = { name = "Franclorn Forgewright", npc = 8888 },
      level = 52,
      minLevel = 48,
      name = "Dark Iron Legacy",
      src = "questie"
    },
    [3906] = {
      giver = { map = 1418, name = "Thunderheart", npc = 9084, src = "questie", x = 0.0333, y = 0.4826 },
      level = 52,
      minLevel = 48,
      name = "Disharmony of Flame",
      src = "questie"
    },
    [3981] = {
      giver = { map = 1418, name = "Galamav the Marksman", npc = 9081, src = "questie", x = 0.0596, y = 0.4773 },
      level = 52,
      minLevel = 48,
      name = "Commander Gor'shak",
      src = "questie"
    },
    [3982] = {
      giver = { name = "Commander Gor'shak", npc = 9020 },
      level = 54,
      minLevel = 48,
      name = "What Is Going On?",
      src = "questie"
    },
    [4001] = {
      giver = { name = "Commander Gor'shak", npc = 9020 },
      level = 54,
      minLevel = 48,
      name = "What Is Going On?",
      src = "questie"
    },
    [4002] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 54,
      minLevel = 48,
      name = "The Eastern Kingdom",
      src = "questie"
    },
    [4022] = {
      giver = { map = 1428, name = "Cyrus Therepentous", npc = 9459, src = "questie", x = 0.9509, y = 0.3156 },
      level = 54,
      minLevel = 52,
      name = "A Taste of Flame",
      src = "questie"
    },
    [4061] = {
      giver = { map = 1418, name = "Hierophant Theodora Mulvadania", npc = 9079, src = "questie", x = 0.0302, y = 0.4781 },
      level = 54,
      minLevel = 52,
      name = "The Rise of the Machines",
      src = "questie"
    },
    [4062] = {
      giver = { map = 1418, name = "Hierophant Theodora Mulvadania", npc = 9079, src = "questie", x = 0.0302, y = 0.4781 },
      level = 54,
      minLevel = 52,
      name = "The Rise of the Machines",
      src = "questie"
    },
    [4081] = { level = 52, minLevel = 48, name = "KILL ON SIGHT: Dark Iron Dwarves", src = "questie" },
    [4121] = {
      giver = { map = 1428, name = "Grark Lorkrub", npc = 9520, src = "questie", x = 0.402, y = 0.3424 },
      level = 58,
      minLevel = 52,
      name = "Precarious Predicament",
      src = "questie"
    },
    [4122] = {
      giver = { map = 1418, name = "Lexlort", npc = 9080, src = "questie", x = 0.0588, y = 0.4763 },
      level = 58,
      minLevel = 52,
      name = "Grark Lorkrub",
      src = "questie"
    },
    [4128] = {
      giver = { map = 1419, name = "Enohar Thunderbrew", npc = 9540, src = "questie", x = 0.6363, y = 0.2063 },
      level = 55,
      minLevel = 50,
      name = "Ragnar Thunderbrew",
      src = "questie"
    },
    [4133] = {
      giver = { map = 1458, name = "Apothecary Zinge", npc = 5204, src = "questie", x = 0.5014, y = 0.6797 },
      level = 55,
      minLevel = 50,
      name = "Vivian Lagrave",
      src = "questie"
    },
    [4141] = {
      giver = { map = 1449, name = "Muigin", npc = 9119, src = "questie", x = 0.4294, y = 0.0964 },
      level = 52,
      minLevel = 47,
      name = "Muigin and Larion",
      src = "questie"
    },
    [4142] = {
      giver = { map = 1449, name = "Muigin", npc = 9119, src = "questie", x = 0.4294, y = 0.0964 },
      level = 52,
      minLevel = 47,
      name = "A Visit to Gregan",
      src = "questie"
    },
    [4145] = {
      giver = { map = 1449, name = "Larion", npc = 9118, src = "questie", x = 0.4554, y = 0.0872 },
      level = 52,
      minLevel = 47,
      name = "Larion and Muigin",
      src = "questie"
    },
    [4147] = {
      giver = { map = 1449, name = "Larion", npc = 9118, src = "questie", x = 0.4554, y = 0.0872 },
      level = 52,
      minLevel = 47,
      name = "Marvon's Workshop",
      src = "questie"
    },
    [4182] = {
      giver = { map = 1428, name = "Helendis Riverhorn", npc = 9562, src = "questie", x = 0.8582, y = 0.6895 },
      level = 54,
      minLevel = 48,
      name = "Dragonkin Menace",
      src = "questie"
    },
    [4183] = {
      giver = { map = 1428, name = "Helendis Riverhorn", npc = 9562, src = "questie", x = 0.8582, y = 0.6895 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4184] = {
      giver = { map = 1433, name = "Magistrate Solomon", npc = 344, src = "questie", x = 0.2999, y = 0.4445 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4185] = {
      giver = { map = 1453, name = "Généralissime Bolvar Fordragon", npc = 1748, src = "questie", x = 0.7823, y = 0.1798 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4186] = {
      giver = { map = 1453, name = "Généralissime Bolvar Fordragon", npc = 1748, src = "questie", x = 0.7823, y = 0.1798 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4223] = {
      giver = { map = 1433, name = "Magistrate Solomon", npc = 344, src = "questie", x = 0.2999, y = 0.4445 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4224] = {
      giver = { map = 1428, name = "Marshal Maxwell", npc = 9560, src = "questie", x = 0.8474, y = 0.6902 },
      level = 54,
      minLevel = 48,
      name = "The True Masters",
      src = "questie"
    },
    [4241] = {
      giver = { map = 1428, name = "Marshal Maxwell", npc = 9560, src = "questie", x = 0.8474, y = 0.6902 },
      level = 54,
      minLevel = 48,
      name = "Marshal Windsor",
      src = "questie"
    },
    [4242] = {
      giver = { name = "Marshal Windsor", npc = 9023 },
      level = 54,
      minLevel = 48,
      name = "Abandoned Hope",
      src = "questie"
    },
    [4262] = {
      giver = { map = 1428, name = "Jalinda Sprig", npc = 9561, src = "questie", x = 0.8541, y = 0.7006 },
      level = 52,
      minLevel = 48,
      name = "Overmaster Pyron",
      src = "questie"
    },
    [4264] = { fromItem = 11446, level = 58, minLevel = 50, name = "A Crumpled Up Note", src = "questie" },
    [4282] = {
      giver = { name = "Marshal Windsor", npc = 9023 },
      level = 58,
      minLevel = 50,
      name = "A Shred of Hope",
      src = "questie"
    },
    [4322] = {
      giver = { name = "Marshal Windsor", npc = 9023 },
      level = 58,
      minLevel = 50,
      name = "Jail Break!",
      src = "questie"
    },
    [4324] = {
      giver = { map = 1446, name = "Yorba Screwspigot", npc = 9706, src = "questie", x = 0.6704, y = 0.2401 },
      level = 53,
      minLevel = 48,
      name = "Yuka Screwspigot",
      src = "questie"
    },
    [4341] = {
      giver = { map = 1455, name = "Roi Magni Bronzebeard", npc = 2784, src = "questie", x = 0.3909, y = 0.562 },
      level = 59,
      minLevel = 50,
      name = "Kharan Mighthammer",
      src = "questie"
    },
    [4361] = {
      giver = { name = "Kharan Mighthammer", npc = 9021 },
      level = 59,
      minLevel = 50,
      name = "The Bearer of Bad News",
      src = "questie"
    },
    [4726] = {
      giver = { map = 1428, name = "Tinkee Steamboil", npc = 10267, src = "questie", x = 0.6524, y = 0.24 },
      level = 52,
      minLevel = 50,
      name = "Broodling Essence",
      src = "questie"
    },
    [4734] = {
      giver = { map = 1428, name = "Tinkee Steamboil", npc = 10267, src = "questie", x = 0.6524, y = 0.24 },
      level = 60,
      minLevel = 57,
      name = "Egg Freezing",
      src = "questie"
    },
    [4735] = {
      giver = { map = 1428, name = "Tinkee Steamboil", npc = 10267, src = "questie", x = 0.6524, y = 0.24 },
      level = 60,
      minLevel = 57,
      name = "Egg Collection",
      src = "questie"
    },
    [4766] = {
      giver = { map = 1453, name = "Comte Remington Ridgewell", npc = 2285, src = "questie", x = 0.7401, y = 0.3024 },
      level = 60,
      minLevel = 57,
      name = "Mayara Brightwing",
      src = "questie"
    },
    [4769] = {
      giver = { map = 1458, name = "Apothecary Zinge", npc = 5204, src = "questie", x = 0.5014, y = 0.6797 },
      level = 60,
      minLevel = 57,
      name = "Vivian Lagrave and the Darkstone Tablet",
      src = "questie"
    },
    [4787] = {
      giver = { map = 1446, name = "Yeh'kinya", npc = 8579, src = "questie", x = 0.6699, y = 0.2236 },
      level = 50,
      minLevel = 40,
      name = "The Ancient Egg",
      src = "questie"
    },
    [4808] = {
      giver = { map = 1428, name = "Tinkee Steamboil", npc = 10267, src = "questie", x = 0.6524, y = 0.24 },
      level = 54,
      minLevel = 50,
      name = "Felnok Steelspring",
      src = "questie"
    },
    [4809] = {
      giver = { map = 1452, name = "Felnok Steelspring", npc = 10468, src = "questie", x = 0.6163, y = 0.3861 },
      level = 54,
      minLevel = 50,
      name = "Chillwind Horns",
      src = "questie"
    },
    [4810] = {
      giver = { map = 1452, name = "Felnok Steelspring", npc = 10468, src = "questie", x = 0.6163, y = 0.3861 },
      level = 54,
      minLevel = 50,
      name = "Return to Tinkee",
      src = "questie"
    },
    [4903] = {
      giver = { map = 1418, name = "Warlord Goretooth", npc = 9077, src = "questie", x = 0.0581, y = 0.4752 },
      level = 60,
      minLevel = 55,
      name = "Warlord's Command",
      src = "questie"
    },
    [4941] = {
      giver = { map = 1418, name = "Warlord Goretooth", npc = 9077, src = "questie", x = 0.0581, y = 0.4752 },
      level = 60,
      minLevel = 55,
      name = "Eitrigg's Wisdom",
      src = "questie"
    },
    [4974] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 60,
      minLevel = 55,
      name = "For The Horde!",
      src = "questie"
    },
    [5065] = {
      giver = { map = 1446, name = "Prospector Ironboot", npc = 10460, src = "questie", x = 0.6689, y = 0.2403 },
      level = 58,
      minLevel = 40,
      name = "The Lost Tablets of Mosh'aru",
      src = "questie"
    },
    [5089] = { fromItem = 12780, level = 60, minLevel = 55, name = "General Drakkisath's Command", src = "questie" },
    [5122] = {
      giver = { name = "Aurius", npc = 10917 },
      level = 60,
      minLevel = 55,
      name = "The Medallion of Faith",
      src = "questie"
    },
    [5126] = {
      giver = { map = 1452, name = "Lorax", npc = 10918, src = "questie", x = 0.6379, y = 0.7376 },
      level = 60,
      minLevel = 55,
      name = "Lorax's Tale",
      src = "questie"
    },
    [5212] = {
      giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "questie", x = 0.8147, y = 0.5966 },
      level = 60,
      minLevel = 55,
      name = "The Flesh Does Not Lie",
      src = "questie"
    },
    [5251] = {
      giver = { map = 1423, name = "Duke Nicholas Zverenhoff", npc = 11039, src = "questie", x = 0.8144, y = 0.5982 },
      level = 60,
      minLevel = 55,
      name = "The Archivist",
      src = "questie"
    },
    [5262] = { fromItem = 13250, level = 60, minLevel = 55, name = "The Truth Comes Crashing Down", src = "questie" },
    [5281] = {
      giver = { map = 1423, name = "Caretaker Alen", npc = 11038, src = "questie", x = 0.7955, y = 0.6386 },
      level = 60,
      minLevel = 55,
      name = "The Restless Souls",
      src = "questie"
    },
    [5382] = {
      giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "questie", x = 0.7022, y = 0.7371 },
      level = 60,
      minLevel = 55,
      name = "Doctor Theolen Krastinov, the Butcher",
      src = "questie"
    },
    [5384] = {
      giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "questie", x = 0.7022, y = 0.7371 },
      level = 60,
      minLevel = 55,
      name = "Kirtonos the Herald",
      src = "questie"
    },
    [5461] = {
      giver = { map = 1422, name = "Magistrate Marduke", npc = 11286, src = "questie", x = 0.7057, y = 0.7411 },
      level = 60,
      minLevel = 57,
      name = "The Human, Ras Frostwhisper",
      src = "questie"
    },
    [5462] = {
      giver = { map = 1422, name = "Magistrate Marduke", npc = 11286, src = "questie", x = 0.7057, y = 0.7411 },
      level = 60,
      minLevel = 57,
      name = "The Dying, Ras Frostwhisper",
      src = "questie"
    },
    [5463] = {
      giver = { map = 1423, name = "Leonid Barthalomew the Revered", npc = 11036, src = "questie", x = 0.8173, y = 0.5783 },
      level = 60,
      minLevel = 57,
      name = "Menethil's Gift",
      src = "questie"
    },
    [5464] = { level = 60, minLevel = 57, name = "Menethil's Gift", src = "questie" },
    [5465] = {
      giver = { map = 1423, name = "Leonid Barthalomew the Revered", npc = 11036, src = "questie", x = 0.8173, y = 0.5783 },
      level = 60,
      minLevel = 57,
      name = "Soulbound Keepsake",
      src = "questie"
    },
    [5515] = {
      giver = { map = 1422, name = "Eva Sarkhoff", npc = 11216, src = "questie", x = 0.7022, y = 0.7371 },
      level = 60,
      minLevel = 55,
      name = "Krastinov's Bag of Horrors",
      src = "questie"
    },
    [5522] = {
      giver = { map = 1428, name = "Tinkee Steamboil", npc = 10267, src = "questie", x = 0.6524, y = 0.24 },
      level = 60,
      minLevel = 57,
      name = "Leonid Barthalomew",
      src = "questie"
    },
    [5527] = {
      giver = { map = 1450, name = "Rabine Saturna", npc = 11801, src = "questie", x = 0.5169, y = 0.451 },
      level = 60,
      minLevel = 56,
      name = "A Reliquary of Purity",
      src = "questie"
    },
    [5529] = {
      giver = { map = 1423, name = "Betina Bigglezink", npc = 11035, src = "questie", x = 0.8147, y = 0.5966 },
      level = 58,
      minLevel = 55,
      name = "Plagued Hatchlings",
      src = "questie"
    },
    [5531] = {
      giver = { map = 1423, name = "Leonid Barthalomew the Revered", npc = 11036, src = "questie", x = 0.8173, y = 0.5783 },
      level = 60,
      minLevel = 57,
      name = "Betina Bigglezink",
      src = "questie"
    },
    [5542] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 56,
      minLevel = 52,
      name = "Demon Dogs",
      src = "questie"
    },
    [5543] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 56,
      minLevel = 52,
      name = "Blood Tinged Skies",
      src = "questie"
    },
    [5544] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 56,
      minLevel = 52,
      name = "Carrion Grubbage",
      src = "questie"
    },
    [5722] = {
      giver = { map = 1456, name = "Rahauro", npc = 11833, src = "questie", x = 0.7014, y = 0.2952 },
      level = 16,
      minLevel = 9,
      name = "À la recherche de la sacoche perdue",
      src = "client"
    },
    [5726] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 12,
      minLevel = 9,
      name = "Ennemis cachés",
      src = "client"
    },
    [5727] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 12,
      minLevel = 9,
      name = "Ennemis cachés",
      src = "client"
    },
    [5742] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 56,
      minLevel = 52,
      name = "Redemption",
      src = "questie"
    },
    [5781] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 57,
      minLevel = 52,
      name = "Of Forgotten Memories",
      src = "questie"
    },
    [5845] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 58,
      minLevel = 52,
      name = "Of Lost Honor",
      src = "questie"
    },
    [5846] = {
      giver = { map = 1423, name = "Tirion Fordring", npc = 1855, src = "questie", x = 0.0757, y = 0.437 },
      level = 58,
      minLevel = 52,
      name = "Of Love and Family",
      src = "questie"
    },
    [6133] = {
      giver = { map = 1423, name = "Nathanos Blightcaller", npc = 11878, src = "questie", x = 0.2654, y = 0.7473 },
      level = 60,
      minLevel = 54,
      name = "The Ranger Lord's Behest",
      src = "questie"
    },
    [6135] = {
      giver = { map = 1423, name = "Nathanos Blightcaller", npc = 11878, src = "questie", x = 0.2654, y = 0.7473 },
      level = 60,
      minLevel = 56,
      name = "Duskwing, Oh How I Hate Thee...",
      src = "questie"
    },
    [6402] = {
      giver = { map = 1428, name = "Marshal Maxwell", npc = 9560, src = "questie", x = 0.8474, y = 0.6902 },
      level = 60,
      minLevel = 50,
      name = "Stormwind Rendezvous",
      src = "questie"
    },
    [6403] = {
      giver = { name = "Reginald Windsor", npc = 12580 },
      level = 60,
      minLevel = 50,
      name = "The Great Masquerade",
      src = "questie"
    },
    [6501] = {
      giver = { map = 1453, name = "Généralissime Bolvar Fordragon", npc = 1748, src = "questie", x = 0.7823, y = 0.1798 },
      level = 60,
      minLevel = 50,
      name = "The Dragon's Eye",
      src = "questie"
    },
    [6522] = { fromItem = 17008, level = 36, minLevel = 28, name = "An Unholy Alliance", src = "questie" },
    [6562] = {
      giver = { map = 1442, name = "Tsunaman", npc = 11862, src = "questie", x = 0.4736, y = 0.6425 },
      level = 22,
      minLevel = 17,
      name = "Problèmes dans les profondeurs",
      src = "client"
    },
    [6564] = { fromItem = 16790, level = 22, minLevel = 17, name = "Allégeance aux Dieux très anciens", src = "client" },
    [6566] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 60,
      minLevel = 55,
      name = "What the Wind Carries",
      src = "questie"
    },
    [6567] = {
      giver = { map = 1454, name = "Thrall", npc = 4949, src = "questie", x = 0.3173, y = 0.3782 },
      level = 60,
      minLevel = 55,
      name = "The Champion of the Horde",
      src = "questie"
    },
    [6568] = {
      giver = { map = 1444, name = "Rexxar", npc = 10182, src = "questie", x = 0.4639, y = 0.1824 },
      level = 60,
      minLevel = 55,
      name = "The Testament of Rexxar",
      src = "questie"
    },
    [6569] = {
      giver = { map = 1422, name = "Myranda the Hag", npc = 11872, src = "questie", x = 0.5079, y = 0.7785 },
      level = 60,
      minLevel = 55,
      name = "Oculus Illusions",
      src = "questie"
    },
    [6570] = {
      giver = { map = 1422, name = "Myranda the Hag", npc = 11872, src = "questie", x = 0.5079, y = 0.7785 },
      level = 60,
      minLevel = 55,
      name = "Emberstrife",
      src = "questie"
    },
    [6582] = {
      giver = { map = 1445, name = "Emberstrife", npc = 10321, src = "questie", x = 0.5666, y = 0.8772 },
      level = 60,
      minLevel = 55,
      name = "The Test of Skulls, Scryer",
      src = "questie"
    },
    [6583] = {
      giver = { map = 1445, name = "Emberstrife", npc = 10321, src = "questie", x = 0.5666, y = 0.8772 },
      level = 60,
      minLevel = 55,
      name = "The Test of Skulls, Somnus",
      src = "questie"
    },
    [6584] = {
      giver = { map = 1445, name = "Emberstrife", npc = 10321, src = "questie", x = 0.5666, y = 0.8772 },
      level = 60,
      minLevel = 55,
      name = "The Test of Skulls, Chronalis",
      src = "questie"
    },
    [6585] = {
      giver = { map = 1445, name = "Emberstrife", npc = 10321, src = "questie", x = 0.5666, y = 0.8772 },
      level = 60,
      minLevel = 55,
      name = "The Test of Skulls, Axtroz",
      src = "questie"
    },
    [6601] = {
      giver = { map = 1445, name = "Emberstrife", npc = 10321, src = "questie", x = 0.5666, y = 0.8772 },
      level = 60,
      minLevel = 55,
      name = "Ascension...",
      src = "questie"
    },
    [6627] = {
      giver = { map = 1442, name = "Braug Dimspirit", npc = 4489, src = "questie", x = 0.788, y = 0.4569 },
      level = 30,
      minLevel = 25,
      name = "Test of Lore",
      src = "questie"
    },
    [6804] = {
      giver = { map = 1447, name = "Duke Hydraxis", npc = 13278, src = "questie", x = 0.7928, y = 0.737 },
      level = 56,
      minLevel = 55,
      name = "Poisoned Water",
      src = "questie"
    },
    [6805] = {
      giver = { map = 1447, name = "Duke Hydraxis", npc = 13278, src = "questie", x = 0.7928, y = 0.737 },
      level = 57,
      minLevel = 55,
      name = "Stormers and Rumblers",
      src = "questie"
    },
    [7044] = {
      giver = { map = 1443, name = "Cavindra", npc = 13697, src = "questie", x = 0.321, y = 0.6396 },
      level = 49,
      minLevel = 41,
      name = "Legends of Maraudon",
      src = "questie"
    },
    [7492] = {
      giver = { map = 1454, name = "Warcaller Gorlach", npc = 10880, src = "questie", x = 0.3756, y = 0.7536 },
      level = 57,
      minLevel = 54,
      name = "Camp Mojache",
      src = "questie"
    },
    [7494] = {
      giver = { map = 1453, name = "Crieur Goodman", npc = 2198, src = "questie", x = 0.4745, y = 0.6417 },
      level = 57,
      minLevel = 54,
      name = "Feathermoon Stronghold",
      src = "questie"
    },
    [8905] = {
      giver = { map = 1455, name = "Deliana", npc = 16013, src = "questie", x = 0.4353, y = 0.5264 },
      level = 60,
      minLevel = 58,
      name = "An Earnest Proposition",
      src = "questie"
    },
    [8921] = {
      giver = { map = 1446, name = "Mux Manascrambler", npc = 16014, src = "questie", x = 0.5247, y = 0.2723 },
      level = 60,
      minLevel = 58,
      name = "The Ectoplasmic Distiller",
      src = "questie"
    },
    [8922] = {
      giver = { map = 1455, name = "Deliana", npc = 16013, src = "questie", x = 0.4353, y = 0.5264 },
      level = 60,
      minLevel = 58,
      name = "A Supernatural Device",
      src = "questie"
    },
    [8924] = {
      giver = { map = 1446, name = "Mux Manascrambler", npc = 16014, src = "questie", x = 0.5247, y = 0.2723 },
      level = 60,
      minLevel = 58,
      name = "Hunting for Ectoplasm",
      src = "questie"
    },
    [8925] = {
      giver = { map = 1446, name = "Mux Manascrambler", npc = 16014, src = "questie", x = 0.5247, y = 0.2723 },
      level = 60,
      minLevel = 58,
      name = "A Portable Power Source",
      src = "questie"
    },
    [8926] = {
      giver = { map = 1455, name = "Deliana", npc = 16013, src = "questie", x = 0.4353, y = 0.5264 },
      level = 60,
      minLevel = 58,
      name = "Just Compensation",
      src = "questie"
    },
    [8928] = {
      giver = { map = 1446, name = "Mux Manascrambler", npc = 16014, src = "questie", x = 0.5247, y = 0.2723 },
      level = 60,
      minLevel = 58,
      name = "A Shifty Merchant",
      src = "questie"
    },
    [8929] = {
      giver = { map = 1455, name = "Deliana", npc = 16013, src = "questie", x = 0.4353, y = 0.5264 },
      level = 60,
      minLevel = 58,
      name = "In Search of Anthion",
      src = "questie"
    },
    [8977] = {
      giver = { map = 1446, name = "Mux Manascrambler", npc = 16014, src = "questie", x = 0.5247, y = 0.2723 },
      level = 60,
      minLevel = 58,
      name = "Return to Deliana",
      src = "questie"
    },
    [92742] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 12,
      minLevel = 9,
      name = "Tester les puits",
      src = "client"
    },
    [92744] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 12,
      minLevel = 9,
      name = "Des branchies de Murloc",
      src = "client"
    },
    [92745] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 14,
      minLevel = 9,
      name = "Quelles sales mines !",
      src = "client"
    },
    [92747] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 15,
      minLevel = 9,
      name = "Espionnage de Ruisselune",
      src = "client"
    },
    [92748] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 16,
      minLevel = 9,
      name = "Consultation explosive",
      src = "client"
    },
    [92749] = { level = 16, minLevel = 9, name = "Un plan explosif", src = "client" },
    [92750] = { level = 16, minLevel = 9, name = "Détonation à distance", src = "client" },
    [92751] = { level = 16, minLevel = 9, name = "Détonation à distance", src = "client" },
    [92752] = { level = 16, minLevel = 9, name = "Consultation explosive", src = "client" },
    [92753] = { level = 18, minLevel = 9, name = "Destruction dans les Mortemines", src = "client" },
    [92819] = {
      giver = { map = 1436, name = "Alba Fairmoon", src = "fdj", x = 0.53, y = 0.533 },
      level = 18,
      minLevel = 9,
      name = "Destruction dans les Mortemines",
      src = "client"
    },
    [96391] = {
      giver = { map = 1426, name = "Dark Iron Spies", src = "fdj", x = 0.77, y = 0.6 },
      level = 15,
      minLevel = 9,
      name = "La carte souterraine",
      src = "client"
    }
  }
}
