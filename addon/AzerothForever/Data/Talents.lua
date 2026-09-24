-- Azeroth Forever : catalogue des talents de classe.
-- Généré par tools/export-lua.mjs depuis data/talents-data.js. Ne pas éditer à la main.
-- Champs conservés tels quels (aucune invention) : id, name, icon, row, col, maxRank,
-- requires, ranks (spellId + desc). Les champs documentaires (status, sources, classic,
-- background) du site ne sont pas repris ici.
local ADDON_NAME, AF = ...

AF.Data = AF.Data or {}
AF.Data.Talents = {
  {
    id = 1,
    slug = "guerrier",
    name = "Guerrier",
    color = "#C79C6E",
    icon = "class_warrior",
    trees = {
      {
        id = 161,
        name = "Armes",
        slug = "armes",
        order = 0,
        icon = "ability_rogue_eviscerate",
        talents = {
          {
            id = 105958,
            name = "Frappe héroïque améliorée",
            icon = "ability_rogue_ambush",
            row = 0,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12282,
                desc = "Réduit le coût de votre technique Frappe héroïque de 1 point de rage."
              },
              {
                spellId = 0,
                desc = "Réduit le coût de votre technique Frappe héroïque de 2 point de rage."
              },
              {
                spellId = 0,
                desc = "Réduit le coût de votre technique Frappe héroïque de 3 point de rage."
              }
            }
          },
          {
            id = 105957,
            name = "Déviation",
            icon = "ability_parry",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16462,
                desc = "Augmente de 1% vos chances de Parer."
              },
              {
                spellId = 0,
                desc = "Augmente de 2% vos chances de Parer."
              },
              {
                spellId = 0,
                desc = "Augmente de 3% vos chances de Parer."
              },
              {
                spellId = 0,
                desc = "Augmente de 4% vos chances de Parer."
              },
              {
                spellId = 0,
                desc = "Augmente de 5% vos chances de Parer."
              }
            }
          },
          {
            id = 105956,
            name = "Pourfendre amélioré",
            icon = "ability_gouge",
            row = 0,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12286,
                desc = "Augmente de 12 % les dégâts de saignement infligés par votre technique Pourfendre."
              },
              {
                spellId = 0,
                desc = "Augmente de 23 % les dégâts de saignement infligés par votre technique Pourfendre."
              },
              {
                spellId = 0,
                desc = "Augmente de 35 % les dégâts de saignement infligés par votre technique Pourfendre."
              }
            }
          },
          {
            id = 105955,
            name = "Charge améliorée",
            icon = "ability_warrior_charge",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12285,
                desc = "Augmente de 3 points la rage générée par votre technique Charge."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 points la rage générée par votre technique Charge."
              }
            }
          },
          {
            id = 105954,
            name = "Maîtrise tactique améliorée",
            icon = "spell_nature_enchantarmor",
            row = 1,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12295,
                desc = "Votre Maîtrise tactique vous permet de conserver jusqu’à 3 points de rage supplémentaires lorsque vous changez de posture."
              },
              {
                spellId = 0,
                desc = "Votre Maîtrise tactique vous permet de conserver jusqu’à 6 points de rage supplémentaires lorsque vous changez de posture."
              },
              {
                spellId = 0,
                desc = "Votre Maîtrise tactique vous permet de conserver jusqu’à 9 points de rage supplémentaires lorsque vous changez de posture."
              },
              {
                spellId = 0,
                desc = "Votre Maîtrise tactique vous permet de conserver jusqu’à 12 points de rage supplémentaires lorsque vous changez de posture."
              },
              {
                spellId = 0,
                desc = "Votre Maîtrise tactique vous permet de conserver jusqu’à 15 points de rage supplémentaires lorsque vous changez de posture."
              }
            }
          },
          {
            id = 105952,
            name = "Fulgurance améliorée",
            icon = "inv_sword_05",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12290,
                desc = "Augmente de 25% vos chances d'infliger un coup critique avec la technique Fulgurance."
              },
              {
                spellId = 0,
                desc = "Augmente de 50% vos chances d'infliger un coup critique avec la technique Fulgurance."
              }
            }
          },
          {
            id = 105951,
            name = "Maîtrise de la Rage",
            icon = "spell_holy_blessingofstamina",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105954,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 12296,
                desc = "Génère 1 point de rage toutes les 3 s au combat et réduit la perte de rage en dehors des combats de 30 %."
              }
            }
          },
          {
            id = 105950,
            name = "Blessures profondes",
            icon = "ability_backstab",
            row = 2,
            col = 2,
            maxRank = 3,
            requires = {
              {
                id = 105956,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 12834,
                desc = "Vos coups critiques font saigner votre adversaire, lui infligeant 20 % des dégâts moyens de votre arme de mêlée pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques font saigner votre adversaire, lui infligeant 40 % des dégâts moyens de votre arme de mêlée pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques font saigner votre adversaire, lui infligeant 60 % des dégâts moyens de votre arme de mêlée pendant 12 sec."
              }
            }
          },
          {
            id = 105949,
            name = "Frappe transperçante",
            icon = "inv_spear_01",
            row = 3,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310222,
                desc = "Une attaque brutale qui inflige 40 % des dégâts de l’arme. Inflige 80 % des dégâts de l’arme supplémentaires contre les géants, les draconiens et les cibles sur une monture. Les cibles sur une monture sont désarçonnées."
              }
            }
          },
          {
            id = 105948,
            name = "Spécialisation Arme 2M",
            icon = "inv_axe_09",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12163,
                desc = "Augmente de 1% les points de dégâts que vous infligez avec les armes à deux mains."
              },
              {
                spellId = 0,
                desc = "Augmente de 2% les points de dégâts que vous infligez avec les armes à deux mains."
              },
              {
                spellId = 0,
                desc = "Augmente de 3% les points de dégâts que vous infligez avec les armes à deux mains."
              }
            }
          },
          {
            id = 105947,
            name = "Empaler",
            icon = "ability_searingarrow",
            row = 3,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16493,
                desc = "Augmente de 10% le bonus aux dégâts des coups critiques réussis avec vos techniques."
              },
              {
                spellId = 0,
                desc = "Augmente de 20% le bonus aux dégâts des coups critiques réussis avec vos techniques."
              }
            }
          },
          {
            id = 110524,
            name = "Exaltation sanguinaire",
            icon = "inv_sword_01",
            row = 4,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1289682,
                desc = "Vos attaques en mêlée contre les cibles affectées par Pourfendre ont 2 % de chances d’activer votre technique Fulgurance pour 1 attaque sur votre cible actuelle. Dure 6 sec."
              },
              {
                spellId = 0,
                desc = "Vos attaques en mêlée contre les cibles affectées par Pourfendre ont 4 % de chances d’activer votre technique Fulgurance pour 1 attaque sur votre cible actuelle. Dure 6 sec."
              },
              {
                spellId = 0,
                desc = "Vos attaques en mêlée contre les cibles affectées par Pourfendre ont 6 % de chances d’activer votre technique Fulgurance pour 1 attaque sur votre cible actuelle. Dure 6 sec."
              },
              {
                spellId = 0,
                desc = "Vos attaques en mêlée contre les cibles affectées par Pourfendre ont 8 % de chances d’activer votre technique Fulgurance pour 1 attaque sur votre cible actuelle. Dure 6 sec."
              },
              {
                spellId = 0,
                desc = "Vos attaques en mêlée contre les cibles affectées par Pourfendre ont 10 % de chances d’activer votre technique Fulgurance pour 1 attaque sur votre cible actuelle. Dure 6 sec."
              }
            }
          },
          {
            id = 105945,
            name = "Attaques circulaires",
            icon = "ability_rogue_slicedice",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12292,
                desc = "Vos 5 prochaines attaques de mêlée touchent un adversaire proche supplémentaire."
              }
            }
          },
          {
            id = 105944,
            name = "Maître d’armes",
            icon = "garrison_weaponupgrade",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1290261,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/arme d’hast : augmente vos chances de coup critique de 1 %.<br>Masse/bâton : vos attaques ignorent 3 % de l’Armure de votre cible.<br>Épée : les attaques en mêlée réussies ont 1 % de chances de déclencher une attaque supplémentaire contre la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/arme d’hast : augmente vos chances de coup critique de 2 %.<br>Masse/bâton : vos attaques ignorent 6 % de l’Armure de votre cible.<br>Épée : les attaques en mêlée réussies ont 2 % de chances de déclencher une attaque supplémentaire contre la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/arme d’hast : augmente vos chances de coup critique de 3 %.<br>Masse/bâton : vos attaques ignorent 9 % de l’Armure de votre cible.<br>Épée : les attaques en mêlée réussies ont 3 % de chances de déclencher une attaque supplémentaire contre la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/arme d’hast : augmente vos chances de coup critique de 4 %.<br>Masse/bâton : vos attaques ignorent 12 % de l’Armure de votre cible.<br>Épée : les attaques en mêlée réussies ont 4 % de chances de déclencher une attaque supplémentaire contre la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/arme d’hast : augmente vos chances de coup critique de 5 %.<br>Masse/bâton : vos attaques ignorent 15 % de l’Armure de votre cible.<br>Épée : les attaques en mêlée réussies ont 5 % de chances de déclencher une attaque supplémentaire contre la cible."
              }
            }
          },
          {
            id = 110858,
            name = "Heurtoir amélioré",
            icon = "ability_warrior_decisivestrike",
            row = 5,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12862,
                desc = "Réduit de 0.25 s le temps de recharge global et le temps d’incantation de votre technique Heurtoir. De plus, Heurtoir n’interrompt plus votre temps de frappe en mêlée."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.5 s le temps de recharge global et le temps d’incantation de votre technique Heurtoir. De plus, Heurtoir n’interrompt plus votre temps de frappe en mêlée."
              }
            }
          },
          {
            id = 105942,
            name = "Brise-genou amélioré",
            icon = "ability_shockwave",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12289,
                desc = "Confère à votre technique Brise-genou 5 % de chances d’immobiliser la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Brise-genou 10 % de chances d’immobiliser la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Brise-genou 15 % de chances d’immobiliser la cible pendant 5 sec."
              }
            }
          },
          {
            id = 105941,
            name = "Frappe mortelle",
            icon = "ability_warrior_savageblow",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105945,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 12294,
                desc = "Une attaque vicieuse qui inflige les dégâts de l’arme plus 85 et blesse la cible. L’efficacité des sorts de soins dont elle est la cible est réduite de 50 % pendant 10 sec."
              }
            }
          }
        }
      },
      {
        id = 164,
        name = "Fureur",
        slug = "fureur",
        order = 1,
        icon = "ability_warrior_innerrage",
        talents = {
          {
            id = 105938,
            name = "Voix tonitruante",
            icon = "spell_nature_purge",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12321,
                desc = "Augmente de 10 % la zone d’effet de vos techniques Cri de guerre et Cri démoralisant."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la zone d’effet de vos techniques Cri de guerre et Cri démoralisant."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % la zone d’effet de vos techniques Cri de guerre et Cri démoralisant."
              },
              {
                spellId = 0,
                desc = "Augmente de 40 % la zone d’effet de vos techniques Cri de guerre et Cri démoralisant."
              },
              {
                spellId = 0,
                desc = "Augmente de 50 % la zone d’effet de vos techniques Cri de guerre et Cri démoralisant."
              }
            }
          },
          {
            id = 105939,
            name = "Cruauté",
            icon = "ability_rogue_eviscerate",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12320,
                desc = "Augmente de 1 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              }
            }
          },
          {
            id = 110857,
            name = "Volonté de fer",
            icon = "spell_magic_magearmor",
            row = 1,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12962,
                desc = "Réduit de 3 % la durée des effets d’étourdissement et de peur qui vous sont infligés."
              },
              {
                spellId = 0,
                desc = "Réduit de 6 % la durée des effets d’étourdissement et de peur qui vous sont infligés."
              },
              {
                spellId = 0,
                desc = "Réduit de 9 % la durée des effets d’étourdissement et de peur qui vous sont infligés."
              },
              {
                spellId = 0,
                desc = "Réduit de 12 % la durée des effets d’étourdissement et de peur qui vous sont infligés."
              },
              {
                spellId = 0,
                desc = "Réduit de 15 % la durée des effets d’étourdissement et de peur qui vous sont infligés."
              }
            }
          },
          {
            id = 105937,
            name = "Colère déchaînée",
            icon = "spell_nature_stoneclawtotem",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12322,
                desc = "Donne 12 % de chances de générer 1 point de rage supplémentaire quand vous infligez des dégâts en mêlée avec une arme. Cet effet passe à 2 points de rage si vous utilisez une arme à deux mains."
              },
              {
                spellId = 0,
                desc = "Donne 24 % de chances de générer 1 point de rage supplémentaire quand vous infligez des dégâts en mêlée avec une arme. Cet effet passe à 2 points de rage si vous utilisez une arme à deux mains."
              },
              {
                spellId = 0,
                desc = "Donne 36 % de chances de générer 1 point de rage supplémentaire quand vous infligez des dégâts en mêlée avec une arme. Cet effet passe à 2 points de rage si vous utilisez une arme à deux mains."
              },
              {
                spellId = 0,
                desc = "Donne 48 % de chances de générer 1 point de rage supplémentaire quand vous infligez des dégâts en mêlée avec une arme. Cet effet passe à 2 points de rage si vous utilisez une arme à deux mains."
              },
              {
                spellId = 0,
                desc = "Donne 60 % de chances de générer 1 point de rage supplémentaire quand vous infligez des dégâts en mêlée avec une arme. Cet effet passe à 2 points de rage si vous utilisez une arme à deux mains."
              }
            }
          },
          {
            id = 105936,
            name = "Enchaînement amélioré",
            icon = "ability_warrior_cleave",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12329,
                desc = "Réduit le coût en rage de votre prochaine technique Enchaînement de 1."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en rage de votre prochaine technique Enchaînement de 2."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en rage de votre prochaine technique Enchaînement de 3."
              }
            }
          },
          {
            id = 105935,
            name = "Hurlement perçant",
            icon = "spell_shadow_deathscream",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12323,
                desc = "Hébète les adversaires proches et réduit leur vitesse de déplacement de 50 % pendant 6 sec."
              }
            }
          },
          {
            id = 105934,
            name = "Folie sanguinaire",
            icon = "spell_shadow_summonimp",
            row = 2,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16487,
                desc = "Régénère 1 % de votre total de points de vie en 6 sec après avoir reçu un coup critique, infligé des dégâts avec Sanguinaire ou subi une attaque vous faisant perdre plus de 20 % de votre maximum de points de vie."
              },
              {
                spellId = 0,
                desc = "Régénère 2 % de votre total de points de vie en 6 sec après avoir reçu un coup critique, infligé des dégâts avec Sanguinaire ou subi une attaque vous faisant perdre plus de 20 % de votre maximum de points de vie."
              },
              {
                spellId = 0,
                desc = "Régénère 3 % de votre total de points de vie en 6 sec après avoir reçu un coup critique, infligé des dégâts avec Sanguinaire ou subi une attaque vous faisant perdre plus de 20 % de votre maximum de points de vie."
              }
            }
          },
          {
            id = 105953,
            name = "Rage infinie",
            icon = "ability_warrior_intensifyrage",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1310236,
                desc = "Augmente votre maximum de points de rage de 10."
              },
              {
                spellId = 0,
                desc = "Augmente votre maximum de points de rage de 20."
              },
              {
                spellId = 0,
                desc = "Augmente votre maximum de points de rage de 30."
              }
            }
          },
          {
            id = 105933,
            name = "Spécialisation Ambidextrie",
            icon = "ability_dualwield",
            row = 3,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 23584,
                desc = "Augmente de 5 % les dégâts de votre arme tenue en main gauche, de 20 % les points de rage générés avec la main gauche et de 2 % vos chances de toucher avec les attaques effectuées avec la main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts de votre arme tenue en main gauche, de 40 % les points de rage générés avec la main gauche et de 4 % vos chances de toucher avec les attaques effectuées avec la main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts de votre arme tenue en main gauche, de 60 % les points de rage générés avec la main gauche et de 6 % vos chances de toucher avec les attaques effectuées avec la main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les dégâts de votre arme tenue en main gauche, de 80 % les points de rage générés avec la main gauche et de 8 % vos chances de toucher avec les attaques effectuées avec la main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 25 % les dégâts de votre arme tenue en main gauche, de 100 % les points de rage générés avec la main gauche et de 10 % vos chances de toucher avec les attaques effectuées avec la main gauche."
              }
            }
          },
          {
            id = 105977,
            name = "Coups déchaînés",
            icon = "ability_whirlwind",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310315,
                desc = "Permet également à votre technique Tourbillon de frapper avec votre arme tenue en main gauche et réduit le coût en rage de votre technique Enchaînement de 2."
              }
            }
          },
          {
            id = 105931,
            name = "Enrager",
            icon = "spell_shadow_unholyfrenzy",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12317,
                desc = "Vous confère 30 % de chances d’infliger 2 % de dégâts physiques supplémentaires pendant 12 sec après avoir été victime d’une attaque infligeant des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 30 % de chances d’infliger 4 % de dégâts physiques supplémentaires pendant 12 sec après avoir été victime d’une attaque infligeant des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 30 % de chances d’infliger 6 % de dégâts physiques supplémentaires pendant 12 sec après avoir été victime d’une attaque infligeant des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 30 % de chances d’infliger 8 % de dégâts physiques supplémentaires pendant 12 sec après avoir été victime d’une attaque infligeant des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 30 % de chances d’infliger 10 % de dégâts physiques supplémentaires pendant 12 sec après avoir été victime d’une attaque infligeant des dégâts."
              }
            }
          },
          {
            id = 105932,
            name = "Exécution améliorée",
            icon = "inv_sword_48",
            row = 3,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 20502,
                desc = "Réduit le coût en rage de votre technique Exécution de 3."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en rage de votre technique Exécution de 5."
              }
            }
          },
          {
            id = 105929,
            name = "Précision",
            icon = "ability_marksmanship",
            row = 4,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1225295,
                desc = "Améliore vos chances de toucher de 1 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 2 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 3 %."
              }
            }
          },
          {
            id = 105927,
            name = "Souhait mortel",
            icon = "spell_shadow_deathpact",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12328,
                desc = "À l’activation, augmente de 20 % les dégâts physiques que vous infligez et vous rend insensible aux effets de peur, mais augmente de 5 % les dégâts que vous subissez. Dure 30 sec."
              }
            }
          },
          {
            id = 105926,
            name = "Interception améliorée",
            icon = "ability_rogue_sprint",
            row = 4,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 20504,
                desc = "Réduit le temps de recharge de votre technique Interception de 5 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre technique Interception de 10 sec."
              }
            }
          },
          {
            id = 105978,
            name = "Rage berserker améliorée",
            icon = "spell_nature_ancestralguardian",
            row = 5,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 20500,
                desc = "Votre technique Rage de berserker génère désormais instantanément 5 points de rage et a 50 % de chances d’annuler tous les effets affectant le déplacement quand elle est active."
              },
              {
                spellId = 0,
                desc = "Votre technique Rage de berserker génère désormais instantanément 10 points de rage et a 100 % de chances d’annuler tous les effets affectant le déplacement quand elle est active."
              }
            }
          },
          {
            id = 105928,
            name = "Rafale",
            icon = "ability_ghoulfrenzy",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 105931,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 12319,
                desc = "Augmente votre vitesse d’attaque en mêlée de 5 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque en mêlée de 10 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque en mêlée de 15 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque en mêlée de 20 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque en mêlée de 25 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              }
            }
          },
          {
            id = 105930,
            name = "Sanguinaire",
            icon = "spell_nature_bloodlust",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105927,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 23881,
                desc = "Attaque instantanément la cible, lui infligeant des dégâts d’un montant égal à 35 % de votre puissance d’attaque plus (30 % de la puissance des sorts), et augmente votre vitesse de déplacement de 10 % pendant 10 sec."
              }
            }
          }
        }
      },
      {
        id = 163,
        name = "Protection",
        slug = "protection",
        order = 2,
        icon = "inv_shield_06",
        talents = {
          {
            id = 105976,
            name = "Spécialisation Bouclier",
            icon = "inv_shield_06",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12298,
                desc = "Augmente de 1 % vos chances de bloquer les attaques avec votre bouclier et vous confère 20 % de chances de générer 5 points de rage lorsque vous bloquez une attaque."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % vos chances de bloquer les attaques avec votre bouclier et vous confère 40 % de chances de générer 5 points de rage lorsque vous bloquez une attaque."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % vos chances de bloquer les attaques avec votre bouclier et vous confère 60 % de chances de générer 5 points de rage lorsque vous bloquez une attaque."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances de bloquer les attaques avec votre bouclier et vous confère 80 % de chances de générer 5 points de rage lorsque vous bloquez une attaque."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % vos chances de bloquer les attaques avec votre bouclier et vous confère 100 % de chances de générer 5 points de rage lorsque vous bloquez une attaque."
              }
            }
          },
          {
            id = 105975,
            name = "Anticipation",
            icon = "spell_nature_mirrorimage",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12297,
                desc = "Augmente votre défense de 4."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 8."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 12."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 16."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 20."
              }
            }
          },
          {
            id = 105974,
            name = "Rage sanguinaire améliorée",
            icon = "ability_racial_bloodrage",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12301,
                desc = "Augmente de 25 % la rage générée par votre technique Rage de sang."
              },
              {
                spellId = 0,
                desc = "Augmente de 50 % la rage générée par votre technique Rage de sang."
              }
            }
          },
          {
            id = 105973,
            name = "Résistance",
            icon = "spell_holy_devotion",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 12299,
                desc = "Augmente la valeur d’armure des objets de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente la valeur d’armure des objets de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente la valeur d’armure des objets de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente la valeur d’armure des objets de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente la valeur d’armure des objets de 10 %."
              }
            }
          },
          {
            id = 105972,
            name = "Coup de tonnerre amélioré",
            icon = "ability_thunderclap",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12287,
                desc = "Réduit de 2 points le coût en rage de votre technique Coup de tonnerre."
              },
              {
                spellId = 0,
                desc = "Réduit de 4 points le coût en rage de votre technique Coup de tonnerre."
              },
              {
                spellId = 0,
                desc = "Réduit de 6 points le coût en rage de votre technique Coup de tonnerre."
              }
            }
          },
          {
            id = 105970,
            name = "Dernier rempart",
            icon = "spell_holy_ashestoashes",
            row = 2,
            col = 0,
            maxRank = 1,
            requires = {
              {
                id = 105974,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 12975,
                desc = "À l’activation, cette technique vous confère temporairement 30 % de vos points de vie maximum pendant 20 sec. Lorsque l’effet expire, les points de vie sont perdus."
              }
            }
          },
          {
            id = 105971,
            name = "Maîtrise de la défense",
            icon = "ability_warrior_shieldguard",
            row = 2,
            col = 1,
            maxRank = 2,
            requires = {
              {
                id = 105976,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 1310316,
                desc = "Vous confère 50 % de chances de générer 5 points de rage lorsque vous esquivez ou parez avec un bouclier équipé."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances de générer 5 points de rage lorsque vous esquivez ou parez avec un bouclier équipé."
              }
            }
          },
          {
            id = 105969,
            name = "Vengeance améliorée",
            icon = "ability_warrior_revenge",
            row = 2,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12797,
                desc = "Augmente les dégâts infligés par votre technique Revanche de 20 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par votre technique Revanche de 40 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par votre technique Revanche de 60 %."
              }
            }
          },
          {
            id = 110856,
            name = "Défi",
            icon = "ability_warrior_innerrage",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12792,
                desc = "Augmente la génération de menace globale en posture défensive de 5 % supplémentaires si le personnage est équipé d’un bouclier."
              },
              {
                spellId = 0,
                desc = "Augmente la génération de menace globale en posture défensive de 10 % supplémentaires si le personnage est équipé d’un bouclier."
              },
              {
                spellId = 0,
                desc = "Augmente la génération de menace globale en posture défensive de 15 % supplémentaires si le personnage est équipé d’un bouclier."
              }
            }
          },
          {
            id = 105968,
            name = "Fracasser armure amélioré",
            icon = "ability_warrior_sunder",
            row = 3,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12308,
                desc = "Réduit de 1 points le coût en rage de votre technique Fracasser armure."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 points le coût en rage de votre technique Fracasser armure."
              },
              {
                spellId = 0,
                desc = "Réduit de 3 points le coût en rage de votre technique Fracasser armure."
              }
            }
          },
          {
            id = 105967,
            name = "Désarmement amélioré",
            icon = "ability_warrior_disarm",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 12313,
                desc = "Réduit le temps de recharge de votre technique Désarmement de 7 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre technique Désarmement de 13 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre technique Désarmement de 20 s."
              }
            }
          },
          {
            id = 105966,
            name = "Avant-garde",
            icon = "ability_warrior_shieldcharge",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310317,
                desc = "Votre technique Charge est désormais utilisable en posture défensive."
              }
            }
          },
          {
            id = 105964,
            name = "Mur protecteur amélioré",
            icon = "ability_warrior_shieldwall",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12312,
                desc = "Réduit le temps de recharge de votre technique Mur protecteur de 5.5 min."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre technique Mur protecteur de 11 min."
              }
            }
          },
          {
            id = 105965,
            name = "Bourrasque",
            icon = "ability_thunderbolt",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12809,
                desc = "Étourdit la cible pendant 5 sec."
              }
            }
          },
          {
            id = 105963,
            name = "Coup de bouclier amélioré",
            icon = "ability_warrior_shieldbash",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 12311,
                desc = "Confère à votre technique Coup de bouclier 50 % de chances de réduire la cible au silence pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Coup de bouclier 100 % de chances de réduire la cible au silence pendant 3 sec."
              }
            }
          },
          {
            id = 105962,
            name = "Bastion",
            icon = "inv_shield_04",
            row = 4,
            col = 3,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16538,
                desc = "Augmente tous les dégâts que vous infligez de 2 % quand un bouclier est équipé."
              },
              {
                spellId = 0,
                desc = "Augmente tous les dégâts que vous infligez de 4 % quand un bouclier est équipé."
              },
              {
                spellId = 0,
                desc = "Augmente tous les dégâts que vous infligez de 6 % quand un bouclier est équipé."
              },
              {
                spellId = 0,
                desc = "Augmente tous les dégâts que vous infligez de 8 % quand un bouclier est équipé."
              },
              {
                spellId = 0,
                desc = "Augmente tous les dégâts que vous infligez de 10 % quand un bouclier est équipé."
              }
            }
          },
          {
            id = 105961,
            name = "Rage focalisée",
            icon = "ability_warrior_focusedrage",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 29787,
                desc = "Réduit le coût en rage de vos techniques offensives de 1."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en rage de vos techniques offensives de 2."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en rage de vos techniques offensives de 3."
              }
            }
          },
          {
            id = 105959,
            name = "Heurt de bouclier",
            icon = "inv_shield_05",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105965,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 23922,
                desc = "Frappe la cible avec votre bouclier, infligeant (100 % de la puissance des sorts) points de dégâts. Les dégâts sont augmentés par votre valeur de blocage, avec 50 % de chances de dissiper 1 effet de magie affectant la cible. Génère un niveau de menace très élevé."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 2,
    slug = "paladin",
    name = "Paladin",
    color = "#F58CBA",
    icon = "class_paladin",
    trees = {
      {
        id = 382,
        name = "Sacré",
        slug = "sacre",
        order = 0,
        icon = "spell_holy_holybolt",
        talents = {
          {
            id = 105328,
            name = "Frappe sacrée améliorée",
            icon = "classicon_paladin",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1310902,
                desc = "Réduit de 1 s le temps de recharge de votre technique Frappe sacrée."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 s le temps de recharge de votre technique Frappe sacrée."
              }
            }
          },
          {
            id = 105639,
            name = "Force divine",
            icon = "ability_golemthunderclap",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20262,
                desc = "Augmente votre Force de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Force de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Force de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Force de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Force de 10%."
              }
            }
          },
          {
            id = 105332,
            name = "Intelligence divine",
            icon = "spell_nature_sleep",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20257,
                desc = "Augmente votre total d'Intelligence de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Intelligence de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Intelligence de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Intelligence de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Intelligence de 10%."
              }
            }
          },
          {
            id = 105333,
            name = "Lumière guérisseuse",
            icon = "spell_holy_holybolt",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20237,
                desc = "Augmente de 4 % le nombre de points de vie rendus par vos sorts Lumière sacrée, Éclair lumineux et Horion sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % le nombre de points de vie rendus par vos sorts Lumière sacrée, Éclair lumineux et Horion sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % le nombre de points de vie rendus par vos sorts Lumière sacrée, Éclair lumineux et Horion sacré."
              }
            }
          },
          {
            id = 105335,
            name = "Focalisation spirituelle",
            icon = "spell_arcane_blink",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 20205,
                desc = "Confère à vos sorts Éclair lumineux, Lumière sacrée et Vigile de lumière 35 % de chances de ne pas voir leur incantation interrompue lorsque vous subissez des dégâts."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts Éclair lumineux, Lumière sacrée et Vigile de lumière 70 % de chances de ne pas voir leur incantation interrompue lorsque vous subissez des dégâts."
              }
            }
          },
          {
            id = 105334,
            name = "Sceaux améliorés",
            icon = "ability_thunderbolt",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20224,
                desc = "Augmente de 5 % les dégâts infligés par vos sceaux et jugements."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par vos sceaux et jugements."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts infligés par vos sceaux et jugements."
              }
            }
          },
          {
            id = 105331,
            name = "Foi inflexible",
            icon = "spell_holy_unyieldingfaith",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 9453,
                desc = "Réduit de 15 % la durée de tous les effets de peur et de désorientation."
              },
              {
                spellId = 0,
                desc = "Réduit de 30 % la durée de tous les effets de peur et de désorientation."
              }
            }
          },
          {
            id = 105330,
            name = "Voix de la vérité",
            icon = "inv_misc_horn_03",
            row = 2,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310897,
                desc = "Vous rend insensible aux effets de silence et d’interruption pendant 6 sec."
              }
            }
          },
          {
            id = 110871,
            name = "Révérence",
            icon = "spell_holy_divineillumination",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1310899,
                desc = "Vous confère 10 % de votre vitesse normale de récupération du mana pendant l’incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 20 % de votre vitesse normale de récupération du mana pendant l’incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 30 % de votre vitesse normale de récupération du mana pendant l’incantation."
              }
            }
          },
          {
            id = 105327,
            name = "Puissance purifiante",
            icon = "spell_holy_purifyingpower",
            row = 2,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 429144,
                desc = "Réduit de 10 % le coût en mana de vos sorts Épuration et Purification, et de 17 % le temps de recharge de vos sorts Exorcisme et Colère divine."
              },
              {
                spellId = 0,
                desc = "Réduit de 20 % le coût en mana de vos sorts Épuration et Purification, et de 33 % le temps de recharge de vos sorts Exorcisme et Colère divine."
              }
            }
          },
          {
            id = 110873,
            name = "Imprégnation de lumière",
            icon = "ability_paladin_infusionoflight",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 426065,
                desc = "Les coups critiques de Horion sacré et Éclair lumineux réduisent de 0.5 s le temps d’incantation de votre prochain sort Lumière sacrée lancé dans les 15 sec."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de Horion sacré et Éclair lumineux réduisent de 1 s le temps d’incantation de votre prochain sort Lumière sacrée lancé dans les 15 sec."
              }
            }
          },
          {
            id = 105329,
            name = "Illumination",
            icon = "spell_holy_greaterheal",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {
              {
                id = 110871,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 20210,
                desc = "Lorsque vous obtenez un effet critique avec Éclair lumineux, Lumière sacrée, Vigile de Lumière ou le sort de soins Horion sacré, vous avez 20 % de chances de recevoir un montant de mana égal à 50 % du coût de base du sort."
              },
              {
                spellId = 0,
                desc = "Lorsque vous obtenez un effet critique avec Éclair lumineux, Lumière sacrée, Vigile de Lumière ou le sort de soins Horion sacré, vous avez 40 % de chances de recevoir un montant de mana égal à 50 % du coût de base du sort."
              },
              {
                spellId = 0,
                desc = "Lorsque vous obtenez un effet critique avec Éclair lumineux, Lumière sacrée, Vigile de Lumière ou le sort de soins Horion sacré, vous avez 60 % de chances de recevoir un montant de mana égal à 50 % du coût de base du sort."
              },
              {
                spellId = 0,
                desc = "Lorsque vous obtenez un effet critique avec Éclair lumineux, Lumière sacrée, Vigile de Lumière ou le sort de soins Horion sacré, vous avez 80 % de chances de recevoir un montant de mana égal à 50 % du coût de base du sort."
              },
              {
                spellId = 0,
                desc = "Lorsque vous obtenez un effet critique avec Éclair lumineux, Lumière sacrée, Vigile de Lumière ou le sort de soins Horion sacré, vous avez 100 % de chances de recevoir un montant de mana égal à 50 % du coût de base du sort."
              }
            }
          },
          {
            id = 105325,
            name = "Faveur divine",
            icon = "spell_holy_heal",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 20216,
                desc = "Une fois activé, confère 100% de chances à votre prochain sort Eclair lumineux, Lumière sacrée ou Horion sacré d'avoir un effet critique."
              }
            }
          },
          {
            id = 105324,
            name = "Précision divine",
            icon = "spell_holy_healingfocus",
            row = 4,
            col = 0,
            maxRank = 3,
            requires = {
              {
                id = 105323,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310904,
                desc = "Améliore de 6 % vos chances de toucher avec les sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Améliore de 12 % vos chances de toucher avec les sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Améliore de 18 % vos chances de toucher avec les sorts du sacré."
              }
            }
          },
          {
            id = 105323,
            name = "Horion sacré",
            icon = "spell_holy_searinglight",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1311606,
                desc = "L’énergie sacrée frappe la cible et inflige (42.9 % de la puissance des sorts) points de dégâts du sacré à un adversaire, ou rend (42.9 % de la puissance des sorts) points de vie à un personnage allié."
              }
            }
          },
          {
            id = 110872,
            name = "Terre consacrée",
            icon = "spell_holy_innerfire",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1310905,
                desc = "Augmente les dégâts de vos sorts du sacré de 5 % contre les 4 premiers adversaires qui entrent dans la zone d’effet de votre Consécration."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts de vos sorts du sacré de 10 % contre les 4 premiers adversaires qui entrent dans la zone d’effet de votre Consécration."
              }
            }
          },
          {
            id = 105321,
            name = "Puissance sacrée",
            icon = "spell_holy_power",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 5923,
                desc = "Augmente de 3 % les chances de coup critique de votre sort Horion sacré, et celles de vos autres sorts de 1 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les chances de coup critique de votre sort Horion sacré, et celles de vos autres sorts de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 9 % les chances de coup critique de votre sort Horion sacré, et celles de vos autres sorts de 3 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les chances de coup critique de votre sort Horion sacré, et celles de vos autres sorts de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les chances de coup critique de votre sort Horion sacré, et celles de vos autres sorts de 5 %."
              }
            }
          },
          {
            id = 105320,
            name = "Vigile de Lumière",
            icon = "ability_paladin_judgementofthepure",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105323,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310911,
                desc = "Applique Vigile de Lumière à la cible pendant 30 sec. Le prochain Horion sacré que vous leur lancez ne déclenche pas de temps de recharge et permet aux cibles amicales de soigner leur groupe à hauteur de (14.3 % de la puissance des sorts), ou oblige les cibles ennemies à subir (42.9 % de la puissance des sorts) points de dégâts du sacré et à rendre 75 % du coût en mana de Vigile de Lumière. 1 occurence de Vigile de Lumière active par paladin ou paladine et par groupe."
              }
            }
          }
        }
      },
      {
        id = 383,
        name = "Protection",
        slug = "protection",
        order = 1,
        icon = "spell_holy_devotionaura",
        talents = {
          {
            id = 105630,
            name = "Résistance",
            icon = "spell_holy_devotion",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20143,
                desc = "Augmente le score d'armure des objets de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente le score d'armure des objets de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente le score d'armure des objets de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente le score d'armure des objets de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente le score d'armure des objets de 10%."
              }
            }
          },
          {
            id = 105626,
            name = "Redoute",
            icon = "ability_defend",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20127,
                desc = "Les attaques en mêlée qui vous infligent des dégâts ont 10 % de chances d’augmenter vos chances de blocage de 6 %. Dure 10 sec ou bloque 5 attaques."
              },
              {
                spellId = 0,
                desc = "Les attaques en mêlée qui vous infligent des dégâts ont 10 % de chances d’augmenter vos chances de blocage de 12 %. Dure 10 sec ou bloque 5 attaques."
              },
              {
                spellId = 0,
                desc = "Les attaques en mêlée qui vous infligent des dégâts ont 10 % de chances d’augmenter vos chances de blocage de 18 %. Dure 10 sec ou bloque 5 attaques."
              },
              {
                spellId = 0,
                desc = "Les attaques en mêlée qui vous infligent des dégâts ont 10 % de chances d’augmenter vos chances de blocage de 24 %. Dure 10 sec ou bloque 5 attaques."
              },
              {
                spellId = 0,
                desc = "Les attaques en mêlée qui vous infligent des dégâts ont 10 % de chances d’augmenter vos chances de blocage de 30 %. Dure 10 sec ou bloque 5 attaques."
              }
            }
          },
          {
            id = 105638,
            name = "Précision",
            icon = "ability_rogue_ambush",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20189,
                desc = "Améliore vos chances de toucher de 1 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 2 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 3 %."
              }
            }
          },
          {
            id = 105637,
            name = "Faveur du Gardien",
            icon = "spell_holy_sealofprotection",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 20174,
                desc = "Réduit de 1 min le temps de recharge de votre sort Bénédiction de protection et augmente la durée de votre sort Bénédiction de liberté de 3 s."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 min le temps de recharge de votre sort Bénédiction de protection et augmente la durée de votre sort Bénédiction de liberté de 6 s."
              }
            }
          },
          {
            id = 105636,
            name = "Anticipation",
            icon = "spell_magic_lesserinvisibilty",
            row = 1,
            col = 3,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20096,
                desc = "Augmente votre défense de 4."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 8."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 12."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 16."
              },
              {
                spellId = 0,
                desc = "Augmente votre défense de 20."
              }
            }
          },
          {
            id = 110875,
            name = "Sceau de fureur amélioré",
            icon = "spell_holy_righteousnessaura",
            row = 2,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1314103,
                desc = "Une fois que le bouclier de Sceau de fureur est entièrement absorbé, rend 60 points de mana, augmentés de 15 % par niveau vous séparant du personnage attaquant, jusqu’à 45 %."
              }
            }
          },
          {
            id = 105634,
            name = "Fureur vertueuse améliorée",
            icon = "spell_holy_sealoffury",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20468,
                desc = "Tant que Fureur vertueuse est active, tous les dégâts subis sont réduits de 2 %."
              },
              {
                spellId = 0,
                desc = "Tant que Fureur vertueuse est active, tous les dégâts subis sont réduits de 4 %."
              },
              {
                spellId = 0,
                desc = "Tant que Fureur vertueuse est active, tous les dégâts subis sont réduits de 6 %."
              }
            }
          },
          {
            id = 110874,
            name = "Spécialisation Bouclier",
            icon = "inv_shield_06",
            row = 2,
            col = 2,
            maxRank = 3,
            requires = {
              {
                id = 105626,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 20150,
                desc = "Augmente le nombre de points de dégâts absorbés par votre bouclier de 10 %. De plus, vos blocages ont 33 % de chances de restaurer 6 % de votre maximum de mana. Ne peut se produire plus d’une fois toutes les 3 s."
              },
              {
                spellId = 0,
                desc = "Augmente le nombre de points de dégâts absorbés par votre bouclier de 20 %. De plus, vos blocages ont 66 % de chances de restaurer 6 % de votre maximum de mana. Ne peut se produire plus d’une fois toutes les 3 s."
              },
              {
                spellId = 0,
                desc = "Augmente le nombre de points de dégâts absorbés par votre bouclier de 30 %. De plus, vos blocages ont 100 % de chances de restaurer 6 % de votre maximum de mana. Ne peut se produire plus d’une fois toutes les 3 s."
              }
            }
          },
          {
            id = 105632,
            name = "Devoir sacré",
            icon = "spell_holy_divineintervention",
            row = 2,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1224697,
                desc = "Augmente votre total d’Endurance de 2 % et réduit le temps de recharge de vos techniques Bouclier divin, Protection divine et Rempart de templier de 30 s."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d’Endurance de 4 % et réduit le temps de recharge de vos techniques Bouclier divin, Protection divine et Rempart de templier de 60 s."
              }
            }
          },
          {
            id = 110878,
            name = "Jugement rapide",
            icon = "ability_paladin_judgementred",
            row = 3,
            col = 0,
            maxRank = 1,
            requires = {
              {
                id = 110875,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310994,
                desc = "Réinitialise le temps de recharge de Jugement et réduit le coût en mana de votre prochaine utilisation de cette technique de 100 %."
              }
            }
          },
          {
            id = 105629,
            name = "Spécialisation Arme 1M",
            icon = "inv_sword_20",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20196,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à une main de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à une main de 7%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à une main de 10%."
              }
            }
          },
          {
            id = 105633,
            name = "Marteau de la justice amélioré",
            icon = "spell_holy_sealofmight",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20487,
                desc = "Diminue le temps de recharge de votre sort Marteau de la justice de 5 sec."
              },
              {
                spellId = 0,
                desc = "Diminue le temps de recharge de votre sort Marteau de la justice de 10 sec."
              },
              {
                spellId = 0,
                desc = "Diminue le temps de recharge de votre sort Marteau de la justice de 15 sec."
              }
            }
          },
          {
            id = 105625,
            name = "Rempart de templier",
            icon = "ability_paladin_shieldofthetemplar",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1311015,
                desc = "Lorsqu’elle est active, cette technique vous confère un bouclier qui absorbe des dégâts équivalant à 100 % de votre maximum de points de vie pendant 8 sec. Applique Longanimité pendant 1 min. Elle ne peut pas être lancée tant que Longanimité est active."
              }
            }
          },
          {
            id = 105627,
            name = "Rétribution",
            icon = "spell_holy_blessingofstrength",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20177,
                desc = "Confère 8 % de chances de bénéficier d’une attaque supplémentaire lorsque vous bloquez une attaque en mêlée et 20 % de chances de bénéficier d’une attaque supplémentaire lorsque vous êtes victime d’un coup critique non périodique."
              },
              {
                spellId = 0,
                desc = "Confère 16 % de chances de bénéficier d’une attaque supplémentaire lorsque vous bloquez une attaque en mêlée et 40 % de chances de bénéficier d’une attaque supplémentaire lorsque vous êtes victime d’un coup critique non périodique."
              },
              {
                spellId = 0,
                desc = "Confère 24 % de chances de bénéficier d’une attaque supplémentaire lorsque vous bloquez une attaque en mêlée et 60 % de chances de bénéficier d’une attaque supplémentaire lorsque vous êtes victime d’un coup critique non périodique."
              },
              {
                spellId = 0,
                desc = "Confère 32 % de chances de bénéficier d’une attaque supplémentaire lorsque vous bloquez une attaque en mêlée et 80 % de chances de bénéficier d’une attaque supplémentaire lorsque vous êtes victime d’un coup critique non périodique."
              },
              {
                spellId = 0,
                desc = "Confère 40 % de chances de bénéficier d’une attaque supplémentaire lorsque vous bloquez une attaque en mêlée et 100 % de chances de bénéficier d’une attaque supplémentaire lorsque vous êtes victime d’un coup critique non périodique."
              }
            }
          },
          {
            id = 110879,
            name = "Credo de fer",
            icon = "spell_holy_improvedresistanceauras",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1311034,
                desc = "Augmente le niveau de menace généré par votre technique Frappe sacrée de 5 %. Tant que Fureur vertueuse est active, Frappe sacrée réduit également les dégâts que vous subissez de 2 % pendant 6 sec."
              },
              {
                spellId = 0,
                desc = "Augmente le niveau de menace généré par votre technique Frappe sacrée de 10 %. Tant que Fureur vertueuse est active, Frappe sacrée réduit également les dégâts que vous subissez de 4 % pendant 6 sec."
              },
              {
                spellId = 0,
                desc = "Augmente le niveau de menace généré par votre technique Frappe sacrée de 15 %. Tant que Fureur vertueuse est active, Frappe sacrée réduit également les dégâts que vous subissez de 6 % pendant 6 sec."
              },
              {
                spellId = 0,
                desc = "Augmente le niveau de menace généré par votre technique Frappe sacrée de 20 %. Tant que Fureur vertueuse est active, Frappe sacrée réduit également les dégâts que vous subissez de 8 % pendant 6 sec."
              },
              {
                spellId = 0,
                desc = "Augmente le niveau de menace généré par votre technique Frappe sacrée de 25 %. Tant que Fureur vertueuse est active, Frappe sacrée réduit également les dégâts que vous subissez de 10 % pendant 6 sec."
              }
            }
          },
          {
            id = 105628,
            name = "Bouclier sacré",
            icon = "spell_holy_blessingofprotection",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105625,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 20925,
                desc = "Augmente les chances de bloquer de 20 % pendant 10 sec et inflige 110 points de dégâts du sacré pour chaque attaque bloquée pendant que l’effet est actif. Les dégâts infligés par Bouclier sacré augmentent le niveau de menace de 20 %. Chaque blocage consomme une charge. 4 charges."
              }
            }
          }
        }
      },
      {
        id = 381,
        name = "Vindicte",
        slug = "vindicte",
        order = 2,
        icon = "spell_holy_auraoflight",
        talents = {
          {
            id = 105707,
            name = "Déviation",
            icon = "ability_parry",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20060,
                desc = "Augmente vos chances de Parer de 1%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 5%."
              }
            }
          },
          {
            id = 105706,
            name = "Bénédiction",
            icon = "spell_frost_windwalkon",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20101,
                desc = "Réduit le coût en mana de tous les sorts et techniques instantanés de 2 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les sorts et techniques instantanés de 4 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les sorts et techniques instantanés de 6 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les sorts et techniques instantanés de 8 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les sorts et techniques instantanés de 10 %."
              }
            }
          },
          {
            id = 105705,
            name = "Jugement amélioré",
            icon = "spell_holy_righteousfury",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 25956,
                desc = "Réduit le temps de recharge de votre technique Jugement de 1 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre technique Jugement de 2 s."
              }
            }
          },
          {
            id = 105704,
            name = "Conduit sacré",
            icon = "spell_holy_devineaegis",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1237268,
                desc = "Réduit de 20 % le coût en mana de vos sorts Consécration, Colère divine, Exorcisme et Marteau de courroux."
              },
              {
                spellId = 0,
                desc = "Réduit de 40 % le coût en mana de vos sorts Consécration, Colère divine, Exorcisme et Marteau de courroux."
              }
            }
          },
          {
            id = 105703,
            name = "Conviction",
            icon = "spell_holy_retributionaura",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 20117,
                desc = "Augmente de 1 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % vos chances d’infliger un coup critique avec vos attaques en mêlée."
              }
            }
          },
          {
            id = 105702,
            name = "Justification",
            icon = "spell_holy_vindication",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 9452,
                desc = "Confère à vos attaques en mêlée qui infligent des dégâts une chance de réduire la puissance d’attaque de la cible de 68 et d’augmenter la vôtre de 1 % pendant 30 sec."
              },
              {
                spellId = 0,
                desc = "Confère à vos attaques en mêlée qui infligent des dégâts une chance de réduire la puissance d’attaque de la cible de 136 et d’augmenter la vôtre de 2 % pendant 30 sec."
              },
              {
                spellId = 0,
                desc = "Confère à vos attaques en mêlée qui infligent des dégâts une chance de réduire la puissance d’attaque de la cible de 204 et d’augmenter la vôtre de 3 % pendant 30 sec."
              }
            }
          },
          {
            id = 105701,
            name = "Jugement sanctifié",
            icon = "ability_paladin_judgementblue",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1311074,
                desc = "Confère à votre technique Jugement 33 % de chances de récupérer 20 % du coût en mana du sceau jugé."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Jugement 66 % de chances de récupérer 40 % du coût en mana du sceau jugé."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Jugement 100 % de chances de récupérer 60 % du coût en mana du sceau jugé."
              }
            }
          },
          {
            id = 105696,
            name = "Sceau d'autorité",
            icon = "ability_warrior_innerrage",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 20375,
                desc = "Confère au personnage paladin une chance d’infliger des dégâts du sacré supplémentaires d’un montant égal à 70 % des dégâts normaux de l’arme. Le personnage paladin ne peut avoir qu’un seul sceau actif à la fois. Dure 30 sec.<br>Libérez l’énergie de ce sceau pour juger un personnage adverse, lui infligeant instantanément (42.9 % de la puissance des sorts) points de dégâts du sacré ou(42.9 % de la puissance des sorts) points de dégâts du sacré si la cible est étourdie ou stupéfiée."
              }
            }
          },
          {
            id = 105699,
            name = "Poursuite de la justice",
            icon = "spell_holy_persuitofjustice",
            row = 2,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 26022,
                desc = "Augmente votre vitesse de déplacement et la vitesse de déplacement de votre monture de 8 %. Ne se cumule pas avec les autres effets qui augmentent la vitesse de déplacement."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse de déplacement et la vitesse de déplacement de votre monture de 15 %. Ne se cumule pas avec les autres effets qui augmentent la vitesse de déplacement."
              }
            }
          },
          {
            id = 105698,
            name = "Oeil pour oeil",
            icon = "spell_holy_eyeforaneye",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 9799,
                desc = "Tous les coups critiques contre vous infligent également 5% des dégâts que vous subissez au personnage attaquant. Les points de dégâts causés par Œil pour oeil ne peuvent excéder 50 % du total des points de vie du personnage paladin."
              },
              {
                spellId = 0,
                desc = "Tous les coups critiques contre vous infligent également 10% des dégâts que vous subissez au personnage attaquant. Les points de dégâts causés par Œil pour oeil ne peuvent excéder 50 % du total des points de vie du personnage paladin."
              }
            }
          },
          {
            id = 105700,
            name = "Sentence sacrée",
            icon = "inv_sword_08",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1311087,
                desc = "Augmente les dégâts infligés par votre technique Frappe sacrée de 10 % et réinitialise tous les effets de Jugement qui affectent la cible."
              }
            }
          },
          {
            id = 110883,
            name = "Croisade",
            icon = "spell_holy_crusade",
            row = 3,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1311083,
                desc = "Augmente tous les dégâts infligés de 1 %, et de 1 % supplémentaires contre les cibles démoniaques et mortes-vivantes."
              },
              {
                spellId = 0,
                desc = "Augmente tous les dégâts infligés de 2 %, et de 2 % supplémentaires contre les cibles démoniaques et mortes-vivantes."
              }
            }
          },
          {
            id = 105697,
            name = "Spécialisation Arme 2M",
            icon = "inv_hammer_04",
            row = 4,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 20111,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à deux mains de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à deux mains de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes de mêlée à deux mains de 9%."
              }
            }
          },
          {
            id = 105693,
            name = "Vengeance",
            icon = "ability_racial_avatar",
            row = 4,
            col = 1,
            maxRank = 3,
            requires = {
              {
                id = 105701,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 20049,
                desc = "Vos coups critiques augmentent les dégâts physiques et les dégâts du sacré que vous infligez de 1 % pendant 30 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques augmentent les dégâts physiques et les dégâts du sacré que vous infligez de 2 % pendant 30 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques augmentent les dégâts physiques et les dégâts du sacré que vous infligez de 3 % pendant 30 sec. Cumulable jusqu’à 5 fois."
              }
            }
          },
          {
            id = 105694,
            name = "Repentir",
            icon = "spell_holy_prayerofhealing",
            row = 4,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 20066,
                desc = "Plonge la cible adverse dans une transe méditative qui la stupéfie pendant 6 sec au maximum. Si la cible subit des dégâts, elle se réveille. Ne fonctionne que sur les humanoïdes."
              }
            }
          },
          {
            id = 110882,
            name = "Champion de la lumière",
            icon = "ability_paladin_enlightenedjudgements",
            row = 5,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1311084,
                desc = "Augmente les dégâts et les soins de vos sorts d’un montant pouvant atteindre 33 % de votre intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts et les soins de vos sorts d’un montant pouvant atteindre 66 % de votre intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts et les soins de vos sorts d’un montant pouvant atteindre 100 % de votre intelligence."
              }
            }
          },
          {
            id = 110880,
            name = "Instrument de la loi",
            icon = "spell_holy_divinepurpose",
            row = 5,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1311085,
                desc = "Réduit le temps d’incantation de Marteau de courroux de 0.5 s et réduit le niveau de menace que vous générez de 10 % tant que Fureur vertueuse est inactive."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de Marteau de courroux de 1 s et réduit le niveau de menace que vous générez de 20 % tant que Fureur vertueuse est inactive."
              }
            }
          },
          {
            id = 105692,
            name = "Effet de lumière",
            icon = "spell_holy_blessedresillience",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310735,
                desc = "Quand vous remplacez votre Sceau d’autorité, de piété, de fureur ou de justice par un autre, vous obtenez un Écho. Votre prochaine attaque en mêlée applique les effets du sceau remplacé et consomme l’Écho."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 3,
    slug = "chasseur",
    name = "Chasseur",
    color = "#ABD473",
    icon = "class_hunter",
    trees = {
      {
        id = 361,
        name = "Dressage",
        slug = "dressage",
        order = 0,
        icon = "ability_hunter_beasttaming",
        talents = {
          {
            id = 104960,
            name = "Aspects mortels",
            icon = "spell_nature_ravenform",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19552,
                desc = "Lorsqu’Aspect du faucon est actif, les tirs automatiques ont 2 % de chances d’augmenter la vitesse d’attaque à distance de 30 % pendant 12 sec. Lorsqu’Aspect de la bête est actif, toutes les attaques automatiques en mêlée ont 2 % de chances d’augmenter la vitesse d’attaque en mêlée de 30 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Lorsqu’Aspect du faucon est actif, les tirs automatiques ont 4 % de chances d’augmenter la vitesse d’attaque à distance de 30 % pendant 12 sec. Lorsqu’Aspect de la bête est actif, toutes les attaques automatiques en mêlée ont 4 % de chances d’augmenter la vitesse d’attaque en mêlée de 30 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Lorsqu’Aspect du faucon est actif, les tirs automatiques ont 6 % de chances d’augmenter la vitesse d’attaque à distance de 30 % pendant 12 sec. Lorsqu’Aspect de la bête est actif, toutes les attaques automatiques en mêlée ont 6 % de chances d’augmenter la vitesse d’attaque en mêlée de 30 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Lorsqu’Aspect du faucon est actif, les tirs automatiques ont 8 % de chances d’augmenter la vitesse d’attaque à distance de 30 % pendant 12 sec. Lorsqu’Aspect de la bête est actif, toutes les attaques automatiques en mêlée ont 8 % de chances d’augmenter la vitesse d’attaque en mêlée de 30 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Lorsqu’Aspect du faucon est actif, les tirs automatiques ont 10 % de chances d’augmenter la vitesse d’attaque à distance de 30 % pendant 12 sec. Lorsqu’Aspect de la bête est actif, toutes les attaques automatiques en mêlée ont 10 % de chances d’augmenter la vitesse d’attaque en mêlée de 30 % pendant 12 sec."
              }
            }
          },
          {
            id = 104976,
            name = "Entraînement à l'Endurance",
            icon = "spell_nature_reincarnation",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19583,
                desc = "Augmente de 3 % les points de vie et l’armure de vos familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les points de vie et l’armure de vos familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 9 % les points de vie et l’armure de vos familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les points de vie et l’armure de vos familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les points de vie et l’armure de vos familiers."
              }
            }
          },
          {
            id = 104975,
            name = "Feu focalisé",
            icon = "inv_weapon_crossbow_10",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1223755,
                desc = "Augmente de 1 % tous les dégâts que vous et votre familier infligez tant que ce dernier est actif."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % tous les dégâts que vous et votre familier infligez tant que ce dernier est actif."
              }
            }
          },
          {
            id = 104974,
            name = "Aspect du singe amélioré",
            icon = "ability_hunter_aspectofthemonkey",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 19549,
                desc = "Augmente de 2 % le bonus d’Esquive conféré par votre Aspect du singe. De plus, votre familier obtient 50 % de l’effet de votre technique Aspect du singe."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % le bonus d’Esquive conféré par votre Aspect du singe. De plus, votre familier obtient 50 % de l’effet de votre technique Aspect du singe."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % le bonus d’Esquive conféré par votre Aspect du singe. De plus, votre familier obtient 50 % de l’effet de votre technique Aspect du singe."
              }
            }
          },
          {
            id = 104973,
            name = "Science des chemins",
            icon = "ability_mount_jungletiger",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19559,
                desc = "Augmente le bonus d'accélération de vos Aspects de la meute et du guépard de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente le bonus d'accélération de vos Aspects de la meute et du guépard de 6%."
              }
            }
          },
          {
            id = 104972,
            name = "Ressusciter le familier amélioré",
            icon = "ability_hunter_beastsoothe",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 24443,
                desc = "Le temps d'incantation du sort Ressusciter le familier est réduit de 3 sec., son coût en mana est diminué de 20% et le familier revient avec 15% points de vie supplémentaires."
              },
              {
                spellId = 0,
                desc = "Le temps d'incantation du sort Ressusciter le familier est réduit de 6 sec., son coût en mana est diminué de 40% et le familier revient avec 30% points de vie supplémentaires."
              }
            }
          },
          {
            id = 104970,
            name = "Rapidité bestiale",
            icon = "ability_druid_dash",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 19596,
                desc = "Augmente de 30 % la vitesse de déplacement de vos familiers."
              }
            }
          },
          {
            id = 104969,
            name = "Fureur libérée",
            icon = "ability_bullrush",
            row = 2,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19616,
                desc = "Augmente de 3 % les dégâts infligés par vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les dégâts infligés par vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 9 % les dégâts infligés par vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les dégâts infligés par vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts infligés par vos faucons et familiers."
              }
            }
          },
          {
            id = 104968,
            name = "Guérison du familier améliorée",
            icon = "ability_hunter_mendpet",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19572,
                desc = "Confère à votre sort Guérison du familier 15 % de chances de dissiper 1 effet de malédiction, de maladie, de magie ou de poison affectant votre familier à chaque fois qu’il le soigne, et réduit le coût en mana de 10 %."
              },
              {
                spellId = 0,
                desc = "Confère à votre sort Guérison du familier 50 % de chances de dissiper 1 effet de malédiction, de maladie, de magie ou de poison affectant votre familier à chaque fois qu’il le soigne, et réduit le coût en mana de 20 %."
              }
            }
          },
          {
            id = 104967,
            name = "Ferocité",
            icon = "inv_misc_monsterclaw_04",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19598,
                desc = "Augmente de 2 % les chances de coup critique de vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances de coup critique de vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les chances de coup critique de vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % les chances de coup critique de vos faucons et familiers."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les chances de coup critique de vos faucons et familiers."
              }
            }
          },
          {
            id = 104966,
            name = "Invocation de faucon",
            icon = "ability_hunter_animalhandler",
            row = 3,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1293241,
                desc = "Ordonne à un faucon de réaliser un bombardement en piqué sur l’adversaire que vous ciblez. Il lui inflige 32 (+ 5 % de la puissance d'attaque à distance) points de dégâts physiques et continue son assaut pendant 18 sec. Seuls 2 faucons peuvent être actifs à la fois. Invoquer un faucon partage son temps de recharge avec Tir des arcanes."
              }
            }
          },
          {
            id = 104965,
            name = "Engagement spirituel",
            icon = "ability_druid_demoralizingroar",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19578,
                desc = "Tant que votre familier est actif, vous et votre familier récupérez 1 % du total de vos points de vie toutes les 10 s."
              },
              {
                spellId = 0,
                desc = "Tant que votre familier est actif, vous et votre familier récupérez 1 % du total de vos points de vie toutes les 5 s."
              }
            }
          },
          {
            id = 104964,
            name = "Intimidation",
            icon = "ability_devour",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104970,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 19577,
                desc = "Vous ordonnez à votre familier d’étourdir la cible pendant 3 sec lors de sa prochaine attaque réussie, qui bénéficie également de chances de coup critique augmentées de 100 %. Génère un niveau élevé de menace."
              }
            }
          },
          {
            id = 104963,
            name = "Discipline bestiale",
            icon = "spell_nature_abolishmagic",
            row = 4,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19590,
                desc = "Augmente de 10 % la régénération de focalisation de vos familiers et permet à 25 % de votre régénération de mana de se poursuivre pendant les incantations."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la régénération de focalisation de vos familiers et permet à 50 % de votre régénération de mana de se poursuivre pendant les incantations."
              }
            }
          },
          {
            id = 104962,
            name = "Frénésie",
            icon = "inv_misc_monsterclaw_03",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 104967,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 19621,
                desc = "Confère à votre familier 20% de chances de bénéficier d'un bonus de 30% à la vitesse d'attaque pendant 8 sec après qu'il a infligé un coup critique."
              },
              {
                spellId = 0,
                desc = "Confère à votre familier 40% de chances de bénéficier d'un bonus de 30% à la vitesse d'attaque pendant 8 sec après qu'il a infligé un coup critique."
              },
              {
                spellId = 0,
                desc = "Confère à votre familier 60% de chances de bénéficier d'un bonus de 30% à la vitesse d'attaque pendant 8 sec après qu'il a infligé un coup critique."
              },
              {
                spellId = 0,
                desc = "Confère à votre familier 80% de chances de bénéficier d'un bonus de 30% à la vitesse d'attaque pendant 8 sec après qu'il a infligé un coup critique."
              },
              {
                spellId = 0,
                desc = "Confère à votre familier 100% de chances de bénéficier d'un bonus de 30% à la vitesse d'attaque pendant 8 sec après qu'il a infligé un coup critique."
              }
            }
          },
          {
            id = 104961,
            name = "Courroux bestial",
            icon = "ability_druid_ferociousbite",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104964,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 19574,
                desc = "Votre familier, fou de rage, inflige 50% de points de dégâts supplémentaires pendant 18 sec. Lorsqu’il est dans cet état, il n’éprouve ni pitié, ni remords, ni peur et ne peut plus être arrêté à moins d’être tué."
              }
            }
          }
        }
      },
      {
        id = 363,
        name = "Précision",
        slug = "precision",
        order = 1,
        icon = "ability_marksmanship",
        talents = {
          {
            id = 105013,
            name = "Oeil de faucon",
            icon = "ability_townwatch",
            row = 0,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 19498,
                desc = "Augmente la portée de vos armes à distance de 2 mètres."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos armes à distance de 4 mètres."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos armes à distance de 6 mètres."
              }
            }
          },
          {
            id = 105012,
            name = "Trait de choc amélioré",
            icon = "spell_frost_stun",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19407,
                desc = "Confère à votre technique Trait de choc 4% de chances d'étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Trait de choc 8% de chances d'étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Trait de choc 12% de chances d'étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Trait de choc 16% de chances d'étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Trait de choc 20% de chances d'étourdir la cible pendant 3 sec."
              }
            }
          },
          {
            id = 105011,
            name = "Attaques mortelles",
            icon = "ability_searingarrow",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19426,
                desc = "Augmente de 1 % vos chances d’infliger un coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % vos chances d’infliger un coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % vos chances d’infliger un coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances d’infliger un coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % vos chances d’infliger un coup critique avec toutes vos attaques."
              }
            }
          },
          {
            id = 110870,
            name = "Morsures et piqûres améliorées",
            icon = "hunter_pvp_spidersting",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1310661,
                desc = "Augmente les dégâts de votre Morsure de serpent de 6 %, réduit le temps de recharge de votre Morsure de vipère de 2 s et prolonge la durée de votre Piqûre de scorpide de 15 s."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts de votre Morsure de serpent de 13 %, réduit le temps de recharge de votre Morsure de vipère de 4 s et prolonge la durée de votre Piqûre de scorpide de 30 s."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts de votre Morsure de serpent de 20 %, réduit le temps de recharge de votre Morsure de vipère de 6 s et prolonge la durée de votre Piqûre de scorpide de 45 s."
              }
            }
          },
          {
            id = 105009,
            name = "Efficacité",
            icon = "spell_frost_wizardmark",
            row = 1,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19416,
                desc = "Réduit le coût en mana de vos Tirs, Piqûres et techniques de mêlée de 3 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos Tirs, Piqûres et techniques de mêlée de 6 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos Tirs, Piqûres et techniques de mêlée de 9 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos Tirs, Piqûres et techniques de mêlée de 12 %."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos Tirs, Piqûres et techniques de mêlée de 15 %."
              }
            }
          },
          {
            id = 105008,
            name = "Visée minutieuse",
            icon = "ability_hunter_zenarchery",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1223984,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 20 % de votre Intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 40 % de votre Intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 60 % de votre Intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 80 % de votre Intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 100 % de votre Intelligence."
              }
            }
          },
          {
            id = 105005,
            name = "Tueur rapide",
            icon = "ability_hunter_rapidkilling",
            row = 2,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 415405,
                desc = "Réduit de 1 min. le temps de recharge de votre technique Tir rapide. De plus, lorsque vous éliminez un adversaire non négligeable ou qu’il meurt alors qu’il subit Morsure de serpent, vous obtenez l’effet Tueur rapide, qui augmente de 20 % les dégâts de votre prochaine technique de tir lancée dans les 10 sec."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 min. le temps de recharge de votre technique Tir rapide. De plus, lorsque vous éliminez un adversaire non négligeable ou qu’il meurt alors qu’il subit Morsure de serpent, vous obtenez l’effet Tueur rapide, qui augmente de 20 % les dégâts de votre prochaine technique de tir lancée dans les 20 sec."
              }
            }
          },
          {
            id = 105006,
            name = "Tir des arcanes amélioré",
            icon = "ability_impalingbolt",
            row = 2,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19454,
                desc = "Réduit le temps de recharge de votre Tir des arcanes de 0.3 s. N’affecte pas le temps de recharge des techniques qui partagent un temps de recharge avec Tir des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre Tir des arcanes de 0.6 s. N’affecte pas le temps de recharge des techniques qui partagent un temps de recharge avec Tir des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre Tir des arcanes de 0.9 s. N’affecte pas le temps de recharge des techniques qui partagent un temps de recharge avec Tir des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre Tir des arcanes de 1.2 s. N’affecte pas le temps de recharge des techniques qui partagent un temps de recharge avec Tir des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre Tir des arcanes de 1.5 s. N’affecte pas le temps de recharge des techniques qui partagent un temps de recharge avec Tir des arcanes."
              }
            }
          },
          {
            id = 105007,
            name = "Loup solitaire",
            icon = "ability_mount_whitedirewolf",
            row = 2,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 415370,
                desc = "Vous infligez 20 % de dégâts supplémentaires avec toutes vos attaques tant que vous n’avez pas de familier actif."
              }
            }
          },
          {
            id = 105004,
            name = "Aura de précision",
            icon = "ability_trueshot",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1299346,
                desc = "Augmente la puissance d’attaque à distance des membres du groupe à moins de 45 m de 30. Dure 30 min."
              }
            }
          },
          {
            id = 105002,
            name = "Coups mortels",
            icon = "ability_piercedamage",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 105008,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 19485,
                desc = "Augmente de 6 % le bonus de dégâts des coups critiques de toutes vos techniques à distance."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % le bonus de dégâts des coups critiques de toutes vos techniques à distance."
              },
              {
                spellId = 0,
                desc = "Augmente de 18 % le bonus de dégâts des coups critiques de toutes vos techniques à distance."
              },
              {
                spellId = 0,
                desc = "Augmente de 24 % le bonus de dégâts des coups critiques de toutes vos techniques à distance."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % le bonus de dégâts des coups critiques de toutes vos techniques à distance."
              }
            }
          },
          {
            id = 105003,
            name = "Morsure de serpent améliorée",
            icon = "ability_hunter_quickshot",
            row = 3,
            col = 3,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19464,
                desc = "Augmente les points de dégâts infligés par votre technique Morsure de serpent de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par votre technique Morsure de serpent de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par votre technique Morsure de serpent de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par votre technique Morsure de serpent de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par votre technique Morsure de serpent de 10%."
              }
            }
          },
          {
            id = 104999,
            name = "Recouvrement rapide",
            icon = "ability_hunter_rapidregeneration",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {
              {
                id = 105005,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 1223987,
                desc = "Toucher une cible avec votre technique Morsure de serpent vous confère 25 % et consommer Tueur rapide vous confère 50 % de régénération de points de mana lors de la prochaine incantation de 15 sec."
              },
              {
                spellId = 0,
                desc = "Toucher une cible avec votre technique Morsure de serpent vous confère 50 % et consommer Tueur rapide vous confère 100 % de régénération de points de mana lors de la prochaine incantation de 15 sec."
              }
            }
          },
          {
            id = 105001,
            name = "Barrage",
            icon = "ability_upgrademoonglaive",
            row = 4,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 19461,
                desc = "Augmente de 3 % les dégâts infligés par vos techniques Flèches multiples, Visée et Salve."
              },
              {
                spellId = 0,
                desc = "Augmente de 7 % les dégâts infligés par vos techniques Flèches multiples, Visée et Salve."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par vos techniques Flèches multiples, Visée et Salve."
              }
            }
          },
          {
            id = 105000,
            name = "Flèche de dispersion",
            icon = "ability_golemstormbolt",
            row = 4,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 19503,
                desc = "Un tir à courte distance qui inflige 50% des points de dégâts de l'arme et désoriente la cible pendant 4 sec. Si la cible subit des dégâts, l'effet est annulé. Interrompt l'attaque lors de son utilisation."
              }
            }
          },
          {
            id = 104998,
            name = "Spécialisation Armes à distance",
            icon = "inv_weapon_rifle_06",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19507,
                desc = "Augmente les points de dégâts que vous infligez avec les armes à distance de 1%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes à distance de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes à distance de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes à distance de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts que vous infligez avec les armes à distance de 5%."
              }
            }
          },
          {
            id = 104997,
            name = "Tir de précision",
            icon = "hunter_pvp_snipershot",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105004,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310687,
                desc = "Un tir précis qui augmente de 160 les points de dégâts infligés par votre attaque à distance."
              }
            }
          }
        }
      },
      {
        id = 362,
        name = "Survie",
        slug = "survie",
        order = 2,
        icon = "ability_hunter_swiftstrike",
        talents = {
          {
            id = 104996,
            name = "Pistage amélioré",
            icon = "inv_misc_head_dragon_black",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 24293,
                desc = "Lorsque vous remontez la piste de bêtes, de démons, de draconiens, d’élémentaires, de géants, d’humanoïdes ou de morts-vivants, tous les dégâts que vous infligez au type de créature pisté augmentent de 1 %."
              },
              {
                spellId = 0,
                desc = "Lorsque vous remontez la piste de bêtes, de démons, de draconiens, d’élémentaires, de géants, d’humanoïdes ou de morts-vivants, tous les dégâts que vous infligez au type de créature pisté augmentent de 2 %."
              },
              {
                spellId = 0,
                desc = "Lorsque vous remontez la piste de bêtes, de démons, de draconiens, d’élémentaires, de géants, d’humanoïdes ou de morts-vivants, tous les dégâts que vous infligez au type de créature pisté augmentent de 3 %."
              },
              {
                spellId = 0,
                desc = "Lorsque vous remontez la piste de bêtes, de démons, de draconiens, d’élémentaires, de géants, d’humanoïdes ou de morts-vivants, tous les dégâts que vous infligez au type de créature pisté augmentent de 4 %."
              },
              {
                spellId = 0,
                desc = "Lorsque vous remontez la piste de bêtes, de démons, de draconiens, d’élémentaires, de géants, d’humanoïdes ou de morts-vivants, tous les dégâts que vous infligez au type de créature pisté augmentent de 5 %."
              }
            }
          },
          {
            id = 104995,
            name = "Déviation",
            icon = "ability_parry",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19295,
                desc = "Augmente vos chances de Parer de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de Parer de 10%."
              }
            }
          },
          {
            id = 104994,
            name = "Piège",
            icon = "spell_nature_stranglevines",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19184,
                desc = "Lorsque vos pièges se déclenchent, toutes les cibles affectées subissent Pris au piège et ne peuvent plus se déplacer pendant 1 s."
              },
              {
                spellId = 0,
                desc = "Lorsque vos pièges se déclenchent, toutes les cibles affectées subissent Pris au piège et ne peuvent plus se déplacer pendant 2 s."
              },
              {
                spellId = 0,
                desc = "Lorsque vos pièges se déclenchent, toutes les cibles affectées subissent Pris au piège et ne peuvent plus se déplacer pendant 3 s."
              },
              {
                spellId = 0,
                desc = "Lorsque vos pièges se déclenchent, toutes les cibles affectées subissent Pris au piège et ne peuvent plus se déplacer pendant 4 s."
              },
              {
                spellId = 0,
                desc = "Lorsque vos pièges se déclenchent, toutes les cibles affectées subissent Pris au piège et ne peuvent plus se déplacer pendant 5 s."
              }
            }
          },
          {
            id = 104993,
            name = "Frappes sauvages",
            icon = "ability_racial_bloodrage",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19159,
                desc = "Augmente de 2 % les chances de coup critique de toutes vos techniques de mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances de coup critique de toutes vos techniques de mêlée."
              }
            }
          },
          {
            id = 104992,
            name = "Survivant",
            icon = "spell_shadow_twilight",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19255,
                desc = "Augmente votre total de points de vie de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total de points de vie de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total de points de vie de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total de points de vie de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total de points de vie de 10 %."
              }
            }
          },
          {
            id = 104990,
            name = "Coupure d'ailes améliorée",
            icon = "ability_rogue_trip",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 19228,
                desc = "Confère à votre technique Coupure d’ailes 7 % de chances d’immobiliser la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Coupure d’ailes 13 % de chances d’immobiliser la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Coupure d’ailes 20 % de chances d’immobiliser la cible pendant 5 sec."
              }
            }
          },
          {
            id = 104991,
            name = "Pièges astucieux",
            icon = "spell_nature_timestop",
            row = 2,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19239,
                desc = "Augmente la durée des effets de Piège givrant et Piège de givre de 15% et les dégâts infligés par les effets de Piège d'Immolation et Piège explosif de 15%."
              },
              {
                spellId = 0,
                desc = "Augmente la durée des effets de Piège givrant et Piège de givre de 30% et les dégâts infligés par les effets de Piège d'Immolation et Piège explosif de 30%."
              }
            }
          },
          {
            id = 104987,
            name = "Pied sûr",
            icon = "ability_kick",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 19290,
                desc = "Augmente vos chances de toucher de 1 % et réduit la durée des effets ralentissant vos déplacements de 10 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de toucher de 2 % et réduit la durée des effets ralentissant vos déplacements de 20 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de toucher de 3 % et réduit la durée des effets ralentissant vos déplacements de 30 %."
              }
            }
          },
          {
            id = 104986,
            name = "Dissuasion",
            icon = "ability_whirlwind",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 19263,
                desc = "Une fois activé, augmente vos chances d'Esquiver et de Parer de 25% pendant 10 sec."
              }
            }
          },
          {
            id = 104988,
            name = "Tactique de survie",
            icon = "ability_ensnare",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 19376,
                desc = "Augmente de 5 % vos chances de toucher avec vos techniques Piège et Feindre la mort."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % vos chances de toucher avec vos techniques Piège et Feindre la mort."
              }
            }
          },
          {
            id = 110861,
            name = "Tranchant de prédateur",
            icon = "ability_hunter_hatchettoss",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1310627,
                desc = "Augmente de 6 % les dégâts des coups critiques de vos techniques de mêlée et de 10 % les dégâts de votre arme en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les dégâts des coups critiques de vos techniques de mêlée et de 20 % les dégâts de votre arme en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 18 % les dégâts des coups critiques de vos techniques de mêlée et de 30 % les dégâts de votre arme en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 24 % les dégâts des coups critiques de vos techniques de mêlée et de 40 % les dégâts de votre arme en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % les dégâts des coups critiques de vos techniques de mêlée et de 50 % les dégâts de votre arme en main gauche."
              }
            }
          },
          {
            id = 104989,
            name = "Contre-attaque",
            icon = "ability_warrior_challange",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 104986,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 19306,
                desc = "Disponible après avoir paré une attaque de l’adversaire, cette technique inflige 50 % des dégâts de l’arme plus 26, et immobilise la cible pendant 5 sec. La contre-attaque ne peut être bloquée, esquivée ou parée."
              }
            }
          },
          {
            id = 104983,
            name = "Ingéniosité",
            icon = "ability_hunter_resourcefulness",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 440529,
                desc = "Réduit de 30 % le coût en mana de vos techniques de Piège et techniques en mêlée. De plus, vos coups critiques ont 3 % de chances de permettre à 50 % de votre régénération de mana de se poursuivre lors des incantations pendant 30 sec."
              },
              {
                spellId = 0,
                desc = "Réduit de 60 % le coût en mana de vos techniques de Piège et techniques en mêlée. De plus, vos coups critiques ont 3 % de chances de permettre à 50 % de votre régénération de mana de se poursuivre lors des incantations pendant 30 sec."
              }
            }
          },
          {
            id = 104985,
            name = "Exposition de proie",
            icon = "ability_hunter_swiftstrike",
            row = 4,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1310532,
                desc = "Vos attaques contre les cibles portant la Marque du chasseur ont 5 % de chances d’activer votre Morsure de mangouste pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Vos attaques contre les cibles portant la Marque du chasseur ont 10 % de chances d’activer votre Morsure de mangouste pendant 5 sec."
              }
            }
          },
          {
            id = 110860,
            name = "Discipline de survivaliste",
            icon = "ability_hunter_mastertactitian",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1310496,
                desc = "Réduit de 20 % le temps de recharge de vos techniques Piège et Dissuasion."
              },
              {
                spellId = 0,
                desc = "Réduit de 40 % le temps de recharge de vos techniques Piège et Dissuasion."
              }
            }
          },
          {
            id = 104981,
            name = "Coup de trotteur",
            icon = "ability_hunter_pet_tallstrider",
            row = 4,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1317257,
                desc = "Un coup puissant qui inflige 100 % des dégâts de l’arme de mêlée."
              }
            }
          },
          {
            id = 110859,
            name = "Réflexes éclairs",
            icon = "spell_nature_invisibilty",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 19168,
                desc = "Augmente votre Agilité de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Agilité de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Agilité de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Agilité de 8%."
              },
              {
                spellId = 0,
                desc = "Augmente votre Agilité de 10%."
              }
            }
          },
          {
            id = 104984,
            name = "Frappes lacérantes",
            icon = "ability_gouge",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104985,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 1310533,
                desc = "Votre Morsure de mangouste fait également saigner la cible, ce qui lui inflige 40 % des dégâts de la morsure en 21 sec."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 4,
    slug = "voleur",
    name = "Voleur",
    color = "#FFF569",
    icon = "class_rogue",
    trees = {
      {
        id = 182,
        name = "Assassinat",
        slug = "assassinat",
        order = 0,
        icon = "ability_rogue_eviscerate",
        talents = {
          {
            id = 105742,
            name = "Suriner amélioré",
            icon = "ability_gouge",
            row = 0,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13741,
                desc = "Augmente la durée de votre technique Suriner de 0.5 s."
              },
              {
                spellId = 0,
                desc = "Augmente la durée de votre technique Suriner de 1 s."
              },
              {
                spellId = 0,
                desc = "Augmente la durée de votre technique Suriner de 1.5 s."
              }
            }
          },
          {
            id = 105723,
            name = "Attaques impitoyables",
            icon = "ability_fiegndead",
            row = 0,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14144,
                desc = "Après avoir éliminé un personnage adverse non négligeable, augmente de 20 % les chances de coup critique de votre prochaine attaque utilisant Attaque pernicieuse, Attaque sournoise, Embuscade, Estropier ou Frappe fantomatique. Dure 20 sec."
              },
              {
                spellId = 0,
                desc = "Après avoir éliminé un personnage adverse non négligeable, augmente de 40 % les chances de coup critique de votre prochaine attaque utilisant Attaque pernicieuse, Attaque sournoise, Embuscade, Estropier ou Frappe fantomatique. Dure 20 sec."
              }
            }
          },
          {
            id = 105722,
            name = "Malice",
            icon = "ability_racial_bloodrage",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 14138,
                desc = "Augmente de 1 % vos chances d’infliger un coup critique avec vos attaques et poisons."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % vos chances d’infliger un coup critique avec vos attaques et poisons."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % vos chances d’infliger un coup critique avec vos attaques et poisons."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances d’infliger un coup critique avec vos attaques et poisons."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % vos chances d’infliger un coup critique avec vos attaques et poisons."
              }
            }
          },
          {
            id = 105721,
            name = "Némésis",
            icon = "ability_druid_disembowel",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14156,
                desc = "Confère à vos coups de grâce 20 % de chances de générer un point de combo sur votre cible."
              },
              {
                spellId = 0,
                desc = "Confère à vos coups de grâce 40 % de chances de générer un point de combo sur votre cible."
              },
              {
                spellId = 0,
                desc = "Confère à vos coups de grâce 60 % de chances de générer un point de combo sur votre cible."
              }
            }
          },
          {
            id = 105720,
            name = "Meurtre",
            icon = "spell_shadow_deathscream",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14158,
                desc = "Augmente de 2 % tous les dégâts infligés contre les cibles humanoïdes et géantes."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % tous les dégâts infligés contre les cibles humanoïdes et géantes."
              }
            }
          },
          {
            id = 105739,
            name = "Débiter amélioré",
            icon = "ability_rogue_slicedice",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14165,
                desc = "Augmente la durée de votre technique Débiter de 15%."
              },
              {
                spellId = 0,
                desc = "Augmente la durée de votre technique Débiter de 30%."
              },
              {
                spellId = 0,
                desc = "Augmente la durée de votre technique Débiter de 45%."
              }
            }
          },
          {
            id = 105759,
            name = "Frappes implacables",
            icon = "ability_warrior_decisivestrike",
            row = 2,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14179,
                desc = "Vos coups de grâce ont 20 % de chances par point de combo de restaurer 25 points d’énergie."
              }
            }
          },
          {
            id = 105717,
            name = "Exposer l'armure amélioré",
            icon = "ability_warrior_riposte",
            row = 2,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14168,
                desc = "Réduit le coût en énergie de votre technique Exposer l’armure de 5. Si ce sort est lancé avec 5 points de combo, vous récupérez 1 points de combo."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en énergie de votre technique Exposer l’armure de 10. Si ce sort est lancé avec 5 points de combo, vous récupérez 2 points de combo."
              }
            }
          },
          {
            id = 105716,
            name = "Mortalité",
            icon = "ability_criticalstrike",
            row = 2,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 105722,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 14128,
                desc = "Augmente de 4 % le bonus de dégâts des coups critiques de vos techniques Attaque pernicieuse, Suriner, Attaque sournoise, Estropier, Frappe fantomatique et Hémorragie."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % le bonus de dégâts des coups critiques de vos techniques Attaque pernicieuse, Suriner, Attaque sournoise, Estropier, Frappe fantomatique et Hémorragie."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % le bonus de dégâts des coups critiques de vos techniques Attaque pernicieuse, Suriner, Attaque sournoise, Estropier, Frappe fantomatique et Hémorragie."
              },
              {
                spellId = 0,
                desc = "Augmente de 16 % le bonus de dégâts des coups critiques de vos techniques Attaque pernicieuse, Suriner, Attaque sournoise, Estropier, Frappe fantomatique et Hémorragie."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % le bonus de dégâts des coups critiques de vos techniques Attaque pernicieuse, Suriner, Attaque sournoise, Estropier, Frappe fantomatique et Hémorragie."
              }
            }
          },
          {
            id = 105714,
            name = "Poisons abominables",
            icon = "ability_rogue_feigndeath",
            row = 3,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16513,
                desc = "Augmente de 4 % les dégâts infligés par vos poisons et confère à ces derniers 8 % de chances supplémentaires de résister aux effets de dissipation."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % les dégâts infligés par vos poisons et confère à ces derniers 16 % de chances supplémentaires de résister aux effets de dissipation."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les dégâts infligés par vos poisons et confère à ces derniers 24 % de chances supplémentaires de résister aux effets de dissipation."
              },
              {
                spellId = 0,
                desc = "Augmente de 16 % les dégâts infligés par vos poisons et confère à ces derniers 32 % de chances supplémentaires de résister aux effets de dissipation."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les dégâts infligés par vos poisons et confère à ces derniers 40 % de chances supplémentaires de résister aux effets de dissipation."
              }
            }
          },
          {
            id = 105715,
            name = "Sang froid",
            icon = "spell_ice_lament",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14177,
                desc = "À l’activation, augmente de 100 % les chances de coup critique de votre prochaine attaque utilisant Attaque pernicieuse, Attaque sournoise, Embuscade, Éviscération ou Estropier."
              }
            }
          },
          {
            id = 105713,
            name = "Poisons améliorés",
            icon = "ability_poisons",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 14113,
                desc = "Augmente de 2 % vos chances d’appliquer des poisons à votre cible et confère aux applications de poison 10 % de chances de ne pas consommer de charge."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % vos chances d’appliquer des poisons à votre cible et confère aux applications de poison 20 % de chances de ne pas consommer de charge."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % vos chances d’appliquer des poisons à votre cible et confère aux applications de poison 30 % de chances de ne pas consommer de charge."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % vos chances d’appliquer des poisons à votre cible et confère aux applications de poison 40 % de chances de ne pas consommer de charge."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % vos chances d’appliquer des poisons à votre cible et confère aux applications de poison 50 % de chances de ne pas consommer de charge."
              }
            }
          },
          {
            id = 105718,
            name = "Vigueur",
            icon = "spell_nature_earthbindtotem",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14983,
                desc = "Augmente votre maximum de points d’énergie de 5."
              },
              {
                spellId = 0,
                desc = "Augmente votre maximum de points d’énergie de 10."
              }
            }
          },
          {
            id = 105709,
            name = "Estropier",
            icon = "ability_rogue_deadlybrew",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310707,
                desc = "Attaque instantanément avec les deux armes et inflige 75 % des dégâts des armes plus 17.25 points de dégâts avec chacune d’elles. Dégâts augmentés de 20 % contre les cibles empoisonnées. Confère 2 points de combo."
              }
            }
          },
          {
            id = 105711,
            name = "Aiguillon perfide amélioré",
            icon = "ability_rogue_kidneyshot",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14174,
                desc = "Les dégâts infligés par vos poisons et attaques augmentent de 5 % contre les personnages adverses étourdis par votre technique Aiguillon perfide."
              },
              {
                spellId = 0,
                desc = "Les dégâts infligés par vos poisons et attaques augmentent de 10 % contre les personnages adverses étourdis par votre technique Aiguillon perfide."
              }
            }
          },
          {
            id = 105710,
            name = "Scelle le destin",
            icon = "spell_shadow_chilltouch",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 14186,
                desc = "Vos coups critiques obtenus avec des techniques générant des points de combo ont 20 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques obtenus avec des techniques générant des points de combo ont 40 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques obtenus avec des techniques générant des points de combo ont 60 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques obtenus avec des techniques générant des points de combo ont 80 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques obtenus avec des techniques générant des points de combo ont 100 % de chances de générer un point de combo supplémentaire."
              }
            }
          },
          {
            id = 105712,
            name = "Toxine",
            icon = "inv_sword_31",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105709,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310703,
                desc = "Coup de grâce qui augmente les dégâts infligés par vos poisons de 30 % et vos chances d’appliquer des poisons de 10 %. La durée dépend du nombre de points de combo : 1 point : 9 s 2 points : 12 s 3 points : 15 s 4 points : 18 s 5 points : 21 s"
              }
            }
          }
        }
      },
      {
        id = 181,
        name = "Combat",
        slug = "combat",
        order = 1,
        icon = "ability_backstab",
        talents = {
          {
            id = 105708,
            name = "Éviscération améliorée",
            icon = "ability_rogue_eviscerate",
            row = 0,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14162,
                desc = "Augmente de 7 % les dégâts infligés par votre technique Eviscération."
              },
              {
                spellId = 0,
                desc = "Augmente de 13 % les dégâts infligés par votre technique Eviscération."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les dégâts infligés par votre technique Eviscération."
              }
            }
          },
          {
            id = 105741,
            name = "Attaque pernicieuse améliorée",
            icon = "spell_shadow_ritualofsacrifice",
            row = 0,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 13732,
                desc = "Réduit de 3 le coût en énergie de votre technique Attaque pernicieuse."
              },
              {
                spellId = 0,
                desc = "Réduit de 5 le coût en énergie de votre technique Attaque pernicieuse."
              }
            }
          },
          {
            id = 113398,
            name = "Réflexes-éclairs",
            icon = "spell_nature_invisibilty",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 13712,
                desc = "Augmente vos chances d’esquiver de 1 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 3 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 5 %."
              }
            }
          },
          {
            id = 105719,
            name = "Blessures transperçantes",
            icon = "ability_backstab",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1224716,
                desc = "Augmente les chances de coup critique de vos techniques Attaque sournoise et Estropier respectivement de 10 % et 5 %, et confère à Attaque sournoise 15 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Augmente les chances de coup critique de vos techniques Attaque sournoise et Estropier respectivement de 20 % et 10 %, et confère à Attaque sournoise 30 % de chances de générer un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Augmente les chances de coup critique de vos techniques Attaque sournoise et Estropier respectivement de 30 % et 15 %, et confère à Attaque sournoise 45 % de chances de générer un point de combo supplémentaire."
              }
            }
          },
          {
            id = 105738,
            name = "Déviation",
            icon = "ability_parry",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13713,
                desc = "Augmente vos chances de parer de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de parer de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances de parer de 6%."
              }
            }
          },
          {
            id = 105737,
            name = "Précision",
            icon = "ability_marksmanship",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13705,
                desc = "Améliore vos chances de toucher de 1 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 2 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de toucher de 3 %."
              }
            }
          },
          {
            id = 105736,
            name = "Endurcissement",
            icon = "spell_shadow_shadowward",
            row = 2,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 13742,
                desc = "Réduit de 30 % le temps de recharge de vos techniques Sprint et Évasion."
              },
              {
                spellId = 0,
                desc = "Réduit de 60 % le temps de recharge de vos techniques Sprint et Évasion."
              }
            }
          },
          {
            id = 105735,
            name = "Riposte",
            icon = "ability_warrior_challange",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105738,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 14251,
                desc = "Disponible après avoir paré une attaque de l’adversaire, cette technique inflige 150 % des dégâts de l’arme et désarme la cible pendant 19718 sec."
              }
            }
          },
          {
            id = 105732,
            name = "Sprint amélioré",
            icon = "ability_rogue_sprint",
            row = 2,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 13743,
                desc = "Confère 50 % de chances de dissiper tous les effets qui affectent le déplacement lorsque vous activez votre technique Sprint."
              },
              {
                spellId = 0,
                desc = "Confère 100 % de chances de dissiper tous les effets qui affectent le déplacement lorsque vous activez votre technique Sprint."
              }
            }
          },
          {
            id = 105733,
            name = "Coup de pied amélioré",
            icon = "ability_kick",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 13754,
                desc = "Confère à votre technique Coup de pied 50 % de chances de réduire la cible au silence pendant 2 sec."
              },
              {
                spellId = 0,
                desc = "Confère à votre technique Coup de pied 100 % de chances de réduire la cible au silence pendant 2 sec."
              }
            }
          },
          {
            id = 108100,
            name = "Exécution parfaite",
            icon = "inv_sword_35",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1310711,
                desc = "Réduit de 10 le coût en énergie de votre technique Éviscération."
              }
            }
          },
          {
            id = 105740,
            name = "Spécialisation Ambidextrie",
            icon = "ability_dualwield",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 105737,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 13715,
                desc = "Augmente de 5 % les dégâts infligés par votre arme tenue en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par votre arme tenue en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts infligés par votre arme tenue en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les dégâts infligés par votre arme tenue en main gauche."
              },
              {
                spellId = 0,
                desc = "Augmente de 25 % les dégâts infligés par votre arme tenue en main gauche."
              }
            }
          },
          {
            id = 105728,
            name = "Déluge de lames",
            icon = "ability_warrior_punishingblow",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 13877,
                desc = "Augmente votre vitesse d’attaque en mêlée de 20 % et permet à vos attaques en mêlée de toucher un personnage adverse proche supplémentaire. Dure 15 sec."
              }
            }
          },
          {
            id = 105727,
            name = "Taillader et trancher",
            icon = "inv_sword_27",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 13960,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/épée : vos attaques en mêlée réussies ont 1 % de chances de déclencher une attaque supplémentaire contre la cible.<br>Dague/poing : vos chances de coup critique augmentent de 1 %.<br>Masse : vos attaques ignorent 3 % de l’armure de la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/épée : vos attaques en mêlée réussies ont 2 % de chances de déclencher une attaque supplémentaire contre la cible.<br>Dague/poing : vos chances de coup critique augmentent de 2 %.<br>Masse : vos attaques ignorent 6 % de l’armure de la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/épée : vos attaques en mêlée réussies ont 3 % de chances de déclencher une attaque supplémentaire contre la cible.<br>Dague/poing : vos chances de coup critique augmentent de 3 %.<br>Masse : vos attaques ignorent 9 % de l’armure de la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/épée : vos attaques en mêlée réussies ont 4 % de chances de déclencher une attaque supplémentaire contre la cible.<br>Dague/poing : vos chances de coup critique augmentent de 4 %.<br>Masse : vos attaques ignorent 12 % de l’armure de la cible."
              },
              {
                spellId = 0,
                desc = "Confère un avantage à vos attaques avec les armes de mêlée selon l’arme utilisée.<br>Hache/épée : vos attaques en mêlée réussies ont 5 % de chances de déclencher une attaque supplémentaire contre la cible.<br>Dague/poing : vos chances de coup critique augmentent de 5 %.<br>Masse : vos attaques ignorent 15 % de l’armure de la cible."
              }
            }
          },
          {
            id = 105726,
            name = "Expertise en armes",
            icon = "spell_holy_blessingofstrength",
            row = 5,
            col = 1,
            maxRank = 2,
            requires = {
              {
                id = 105728,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 30919,
                desc = "Réduit de 1 % les chances que vos attaques soient esquivées ou parées."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 % les chances que vos attaques soient esquivées ou parées."
              }
            }
          },
          {
            id = 105730,
            name = "Agressivité",
            icon = "ability_racial_avatar",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18427,
                desc = "Augmente de 2% les points de dégâts infligés par vos techniques Attaque pernicieuse, Attaque sournoise et Eviscération."
              },
              {
                spellId = 0,
                desc = "Augmente de 4% les points de dégâts infligés par vos techniques Attaque pernicieuse, Attaque sournoise et Eviscération."
              },
              {
                spellId = 0,
                desc = "Augmente de 6% les points de dégâts infligés par vos techniques Attaque pernicieuse, Attaque sournoise et Eviscération."
              }
            }
          },
          {
            id = 105724,
            name = "Poussée d'adrénaline",
            icon = "spell_shadow_shadowworddominate",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 13750,
                desc = "Augmente la vitesse de régénération de votre Energie de 100% pendant 15 sec."
              }
            }
          }
        }
      },
      {
        id = 183,
        name = "Finesse",
        slug = "finesse",
        order = 2,
        icon = "ability_stealth",
        talents = {
          {
            id = 105756,
            name = "Dissimulation",
            icon = "ability_stealth",
            row = 0,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 13975,
                desc = "Réduit de 3 % la pénalité affectant la vitesse de votre technique Camouflage et réduit son temps de recharge de 2 s."
              },
              {
                spellId = 0,
                desc = "Réduit de 6 % la pénalité affectant la vitesse de votre technique Camouflage et réduit son temps de recharge de 3 s."
              },
              {
                spellId = 0,
                desc = "Réduit de 9 % la pénalité affectant la vitesse de votre technique Camouflage et réduit son temps de recharge de 4 s."
              },
              {
                spellId = 0,
                desc = "Réduit de 12 % la pénalité affectant la vitesse de votre technique Camouflage et réduit son temps de recharge de 5 s."
              },
              {
                spellId = 0,
                desc = "Réduit de 15 % la pénalité affectant la vitesse de votre technique Camouflage et réduit son temps de recharge de 6 s."
              }
            }
          },
          {
            id = 105761,
            name = "Maître des illusions",
            icon = "spell_shadow_charm",
            row = 0,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13958,
                desc = "Réduit les chances de vos adversaires de vous détecter lorsque vous êtes en camouflage comme si vous aviez gagné 1 niveaux."
              },
              {
                spellId = 0,
                desc = "Réduit les chances de vos adversaires de vous détecter lorsque vous êtes en camouflage comme si vous aviez gagné 2 niveaux."
              },
              {
                spellId = 0,
                desc = "Réduit les chances de vos adversaires de vous détecter lorsque vous êtes en camouflage comme si vous aviez gagné 3 niveaux."
              }
            }
          },
          {
            id = 105760,
            name = "Opportunité",
            icon = "ability_warrior_warcry",
            row = 0,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14057,
                desc = "Augmente de 5 % les dégâts infligés avec vos techniques Attaque sournoise, Garrot, Embuscade et Estropier."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés avec vos techniques Attaque sournoise, Garrot, Embuscade et Estropier."
              }
            }
          },
          {
            id = 105751,
            name = "Préparatifs",
            icon = "spell_nature_mirrorimage",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13983,
                desc = "Vous confère 33 % de chances de générer un point de combo sur votre cible après avoir esquivé une attaque ou complètement résisté à un sort."
              },
              {
                spellId = 0,
                desc = "Vous confère 67 % de chances de générer un point de combo sur votre cible après avoir esquivé une attaque ou complètement résisté à un sort."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances de générer un point de combo sur votre cible après avoir esquivé une attaque ou complètement résisté à un sort."
              }
            }
          },
          {
            id = 105753,
            name = "Insaisissable",
            icon = "spell_magic_lesserinvisibilty",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 13981,
                desc = "Réduit le temps de recharge de vos techniques Disparition et Cécité de 45 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de vos techniques Disparition et Cécité de 90 sec."
              }
            }
          },
          {
            id = 105757,
            name = "Coup tordu",
            icon = "ability_sap",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1224782,
                desc = "Réduit de 25 % le coût en énergie de vos techniques Assommer et Cécité."
              },
              {
                spellId = 0,
                desc = "Réduit de 50 % le coût en énergie de vos techniques Assommer et Cécité."
              }
            }
          },
          {
            id = 105749,
            name = "Embuscade améliorée",
            icon = "ability_rogue_ambush",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14079,
                desc = "Augmente de 15 % les chances de coup critique de votre technique Embuscade."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % les chances de coup critique de votre technique Embuscade."
              },
              {
                spellId = 0,
                desc = "Augmente de 45 % les chances de coup critique de votre technique Embuscade."
              }
            }
          },
          {
            id = 105755,
            name = "Initiative",
            icon = "spell_shadow_fumble",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 13976,
                desc = "Vous confère 33% de chances de gagner un point de combo supplémentaire lorsque vous utilisez les techniques Embuscade, Garrot et Coup bas."
              },
              {
                spellId = 0,
                desc = "Vous confère 67% de chances de gagner un point de combo supplémentaire lorsque vous utilisez les techniques Embuscade, Garrot et Coup bas."
              },
              {
                spellId = 0,
                desc = "Vous confère 100% de chances de gagner un point de combo supplémentaire lorsque vous utilisez les techniques Embuscade, Garrot et Coup bas."
              }
            }
          },
          {
            id = 105754,
            name = "Frappe fantomatique",
            icon = "spell_shadow_curse",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14278,
                desc = "Une attaque qui inflige 125 % des dégâts de l’arme (180 % si une dague est équipée en main droite) et qui augmente vos chances d’esquiver de 15 % pendant 7 sec. Vous gagnez 1 point de combo."
              }
            }
          },
          {
            id = 110868,
            name = "Distraction améliorée",
            icon = "ability_rogue_distract",
            row = 2,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14084,
                desc = "Augmente le rayon d’effet de votre technique Distraction de 3 m et réduit la détection du camouflage des personnages adverses distraits de 1 niveaux supplémentaires."
              },
              {
                spellId = 0,
                desc = "Augmente le rayon d’effet de votre technique Distraction de 5 m et réduit la détection du camouflage des personnages adverses distraits de 2 niveaux supplémentaires."
              }
            }
          },
          {
            id = 105747,
            name = "Sens amplifiés",
            icon = "ability_ambush",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 30894,
                desc = "Augmente votre détection du camouflage comme si vous aviez 1 niveaux de plus et réduit de 2 % la probabilité que les sorts et les attaques à distance vous touchent."
              },
              {
                spellId = 0,
                desc = "Augmente votre détection du camouflage comme si vous aviez 3 niveaux de plus et réduit de 4 % la probabilité que les sorts et les attaques à distance vous touchent."
              }
            }
          },
          {
            id = 105743,
            name = "Préméditation",
            icon = "spell_shadow_possession",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14183,
                desc = "Confère 2 points de combo à la cible. Vous devez accumuler d’autres points de combo ou les utiliser en moins de 20 sec sinon les points de combo sont perdus."
              }
            }
          },
          {
            id = 105752,
            name = "Lames dentelées",
            icon = "inv_sword_17",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14171,
                desc = "Vos attaques ignorent 3 % de l’armure de votre cible. Augmente de 10 % les dégâts infligés par votre technique Rupture."
              },
              {
                spellId = 0,
                desc = "Vos attaques ignorent 6 % de l’armure de votre cible. Augmente de 20 % les dégâts infligés par votre technique Rupture."
              },
              {
                spellId = 0,
                desc = "Vos attaques ignorent 9 % de l’armure de votre cible. Augmente de 30 % les dégâts infligés par votre technique Rupture."
              }
            }
          },
          {
            id = 105745,
            name = "Coups fourrés",
            icon = "spell_shadow_summonsuccubus",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14082,
                desc = "Réduit de 10 le coût en énergie de vos techniques Coup bas et Garrot. De plus, votre technique Garrot ne requiert plus que vous vous placiez derrière la cible."
              },
              {
                spellId = 0,
                desc = "Réduit de 20 le coût en énergie de vos techniques Coup bas et Garrot. De plus, votre technique Garrot ne requiert plus que vous vous placiez derrière la cible."
              }
            }
          },
          {
            id = 105746,
            name = "Préparation",
            icon = "spell_shadow_antishadow",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14185,
                desc = "Lorsque vous la déclenchez, cette technique annule le temps de recharge de toutes vos autres techniques de voleur."
              }
            }
          },
          {
            id = 105748,
            name = "Hémorragie",
            icon = "spell_shadow_lifedrain",
            row = 4,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 105752,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 16511,
                desc = "Une frappe instantanée qui inflige 100 % des dégâts de l’arme (145 % si une dague est équipée). Augmente de 15 % les dégâts de Rupture infligés à la cible par le personnage voleur. Dure 15 sec. Confère 1 point de combo."
              }
            }
          },
          {
            id = 110867,
            name = "Quiétus",
            icon = "ability_rogue_garrote",
            row = 5,
            col = 0,
            maxRank = 5,
            requires = {
              {
                id = 105745,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 1310728,
                desc = "Vos techniques Attaque pernicieuse, Frappe fantomatique et Hémorragie entraînent 2 % de dégâts supplémentaires contre les cibles à moins de 35 % de points de vie."
              },
              {
                spellId = 0,
                desc = "Vos techniques Attaque pernicieuse, Frappe fantomatique et Hémorragie entraînent 4 % de dégâts supplémentaires contre les cibles à moins de 35 % de points de vie."
              },
              {
                spellId = 0,
                desc = "Vos techniques Attaque pernicieuse, Frappe fantomatique et Hémorragie entraînent 6 % de dégâts supplémentaires contre les cibles à moins de 35 % de points de vie."
              },
              {
                spellId = 0,
                desc = "Vos techniques Attaque pernicieuse, Frappe fantomatique et Hémorragie entraînent 8 % de dégâts supplémentaires contre les cibles à moins de 35 % de points de vie."
              },
              {
                spellId = 0,
                desc = "Vos techniques Attaque pernicieuse, Frappe fantomatique et Hémorragie entraînent 10 % de dégâts supplémentaires contre les cibles à moins de 35 % de points de vie."
              }
            }
          },
          {
            id = 105750,
            name = "Coupe-gorge",
            icon = "classicon_rogue",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 462708,
                desc = "Votre technique Attaque sournoise a 3 % de chances de vous permettre d’effectuer votre prochaine Embuscade en moins de 10 sec sans être en Camouflage."
              },
              {
                spellId = 0,
                desc = "Votre technique Attaque sournoise a 6 % de chances de vous permettre d’effectuer votre prochaine Embuscade en moins de 10 sec sans être en Camouflage."
              },
              {
                spellId = 0,
                desc = "Votre technique Attaque sournoise a 9 % de chances de vous permettre d’effectuer votre prochaine Embuscade en moins de 10 sec sans être en Camouflage."
              },
              {
                spellId = 0,
                desc = "Votre technique Attaque sournoise a 12 % de chances de vous permettre d’effectuer votre prochaine Embuscade en moins de 10 sec sans être en Camouflage."
              },
              {
                spellId = 0,
                desc = "Votre technique Attaque sournoise a 15 % de chances de vous permettre d’effectuer votre prochaine Embuscade en moins de 10 sec sans être en Camouflage."
              }
            }
          },
          {
            id = 110866,
            name = "Mille coupures",
            icon = "ability_rogue_rupture",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105746,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1310721,
                desc = "Lorsque votre technique Rupture inflige des dégâts périodiques, le coût en énergie de votre prochaine utilisation d’Hémorragie ou Attaque sournoise en moins de 10 sec est réduit de 3. Cumulable jusqu’à 5 fois."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 5,
    slug = "pretre",
    name = "Prêtre",
    color = "#FFFFFF",
    icon = "class_priest",
    trees = {
      {
        id = 201,
        name = "Discipline",
        slug = "discipline",
        order = 0,
        icon = "spell_holy_wordfortitude",
        talents = {
          {
            id = 110853,
            name = "Puissance de la Lumière",
            icon = "spell_holy_searinglight",
            row = 0,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1309969,
                desc = "Vos sorts Châtiment et Pénitence infligent 2 % de dégâts supplémentaires aux cibles affectées par votre sort Flammes sacrées."
              },
              {
                spellId = 0,
                desc = "Vos sorts Châtiment et Pénitence infligent 4 % de dégâts supplémentaires aux cibles affectées par votre sort Flammes sacrées."
              },
              {
                spellId = 0,
                desc = "Vos sorts Châtiment et Pénitence infligent 6 % de dégâts supplémentaires aux cibles affectées par votre sort Flammes sacrées."
              },
              {
                spellId = 0,
                desc = "Vos sorts Châtiment et Pénitence infligent 8 % de dégâts supplémentaires aux cibles affectées par votre sort Flammes sacrées."
              },
              {
                spellId = 0,
                desc = "Vos sorts Châtiment et Pénitence infligent 10 % de dégâts supplémentaires aux cibles affectées par votre sort Flammes sacrées."
              }
            }
          },
          {
            id = 105850,
            name = "Spécialisation Baguette",
            icon = "inv_wand_01",
            row = 0,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14524,
                desc = "Augmente les dégâts que vous infligez avec les baguettes de 13%."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts que vous infligez avec les baguettes de 25%."
              }
            }
          },
          {
            id = 105849,
            name = "Disciplines jumelles",
            icon = "spell_holy_sealofvengeance",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1225132,
                desc = "Augmente de 1 % les dégâts et les soins de vos sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les dégâts et les soins de vos sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les dégâts et les soins de vos sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les dégâts et les soins de vos sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les dégâts et les soins de vos sorts instantanés."
              }
            }
          },
          {
            id = 105848,
            name = "Résolution silencieuse",
            icon = "spell_nature_manaregentotem",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14523,
                desc = "Diminue la menace générée par vos sorts du sacré de 10 % et réduit la durée des effets d’étourdissement, de peur et de silence qui vous sont infligés de 5 %."
              },
              {
                spellId = 0,
                desc = "Diminue la menace générée par vos sorts du sacré de 20 % et réduit la durée des effets d’étourdissement, de peur et de silence qui vous sont infligés de 10 %."
              },
              {
                spellId = 0,
                desc = "Diminue la menace générée par vos sorts du sacré de 30 % et réduit la durée des effets d’étourdissement, de peur et de silence qui vous sont infligés de 15 %."
              }
            }
          },
          {
            id = 110852,
            name = "Précision sacrée",
            icon = "spell_holy_divineillumination",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1309957,
                desc = "Améliore de 6 % vos chances de toucher avec les sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Améliore de 12 % vos chances de toucher avec les sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Améliore de 18 % vos chances de toucher avec les sorts du sacré."
              }
            }
          },
          {
            id = 105846,
            name = "Mot de pouvoir : Bouclier amélioré",
            icon = "spell_holy_powerwordshield",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14748,
                desc = "Augmente les dégâts absorbés par votre Mot de pouvoir : Bouclier de 7%."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts absorbés par votre Mot de pouvoir : Bouclier de 14%."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts absorbés par votre Mot de pouvoir : Bouclier de 20%."
              }
            }
          },
          {
            id = 105845,
            name = "Martyre",
            icon = "spell_nature_tranquility",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14531,
                desc = "Vous confère 50 % de chances de bénéficier d’Incantation focalisée pendant 6 sec après avoir été victime d’un coup critique en mêlée ou à distance. Cet effet vous évite, lors de l’incantation d’un sort, de vous faire interrompre lorsque vous subissez des dégâts. Il augmente aussi votre résistance aux effets d’interruption de 20 %."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances de bénéficier d’Incantation focalisée pendant 6 sec après avoir été victime d’un coup critique en mêlée ou à distance. Cet effet vous évite, lors de l’incantation d’un sort, de vous faire interrompre lorsque vous subissez des dégâts. Il augmente aussi votre résistance aux effets d’interruption de 20 %."
              }
            }
          },
          {
            id = 105842,
            name = "Sagacité",
            icon = "ability_hibernation",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14520,
                desc = "Réduit de 3 % le coût en mana de Châtiment, Flammes sacrées et des sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Réduit de 7 % le coût en mana de Châtiment, Flammes sacrées et des sorts instantanés."
              },
              {
                spellId = 0,
                desc = "Réduit de 10 % le coût en mana de Châtiment, Flammes sacrées et des sorts instantanés."
              }
            }
          },
          {
            id = 105844,
            name = "Focalisation améliorée",
            icon = "spell_frost_windwalkon",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 14751,
                desc = "Lorsqu'elle est activée, cette technique réduit de 100% le coût en mana de votre prochain sort et augmente ses chances d'infliger un effet critique de 25%, si cela est possible."
              }
            }
          },
          {
            id = 105843,
            name = "Méditation",
            icon = "spell_nature_sleep",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14521,
                desc = "Vous confère 17% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 33% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 50% de votre vitesse de récupération du mana normale pendant l'incantation."
              }
            }
          },
          {
            id = 105841,
            name = "Feu intérieur amélioré",
            icon = "spell_holy_innerfire",
            row = 3,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14747,
                desc = "Augmente le bonus d’armure que confère votre sort Feu intérieur de 15 %, et son nombre de charges de 4."
              },
              {
                spellId = 0,
                desc = "Augmente le bonus d’armure que confère votre sort Feu intérieur de 30 %, et son nombre de charges de 8."
              },
              {
                spellId = 0,
                desc = "Augmente le bonus d’armure que confère votre sort Feu intérieur de 45 %, et son nombre de charges de 12."
              }
            }
          },
          {
            id = 105837,
            name = "Force mentale",
            icon = "spell_nature_enchantarmor",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18551,
                desc = "Augmente votre total d’intelligence de 3 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d’intelligence de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d’intelligence de 9 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d’intelligence de 12 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d’intelligence de 15 %."
              }
            }
          },
          {
            id = 105839,
            name = "Protection de l’âme",
            icon = "spell_holy_pureofheart",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 105846,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 402000,
                desc = "Réduit le temps de recharge de votre sort Mot de pouvoir : Bouclier de 4 s et réduit son coût en mana de 15 %."
              }
            }
          },
          {
            id = 105838,
            name = "Brûlure de mana améliorée",
            icon = "spell_shadow_manaburn",
            row = 3,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 14750,
                desc = "Réduit le temps d’incantation de votre sort Brûlure de mana de 0.5 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Brûlure de mana de 1 s."
              }
            }
          },
          {
            id = 105834,
            name = "Pénitence",
            icon = "spell_holy_penance",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 402174,
                desc = "Lance une salve de lumière sacrée sur la cible et inflige (81 % de la puissance des sorts) points de dégâts du sacré à un personnage adverse ou rend (184 % de la puissance des sorts) points de vie à un personnage allié instantanément et toutes les 1 s pendant 2 sec."
              }
            }
          },
          {
            id = 105835,
            name = "Regain d’espoir",
            icon = "spell_holy_holyprotection",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 105839,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 425280,
                desc = "Vos soins avec Soins rapides, Soins de lien, Soins inférieurs, Soins, Soins supérieurs et Pénitence voient leurs chances de coup critique augmenter de 2 % sur une cible avec Âme affaiblie. De plus, la durée restante d’Âme affaiblie est réduite de 1 s."
              },
              {
                spellId = 0,
                desc = "Vos soins avec Soins rapides, Soins de lien, Soins inférieurs, Soins, Soins supérieurs et Pénitence voient leurs chances de coup critique augmenter de 4 % sur une cible avec Âme affaiblie. De plus, la durée restante d’Âme affaiblie est réduite de 2 s."
              },
              {
                spellId = 0,
                desc = "Vos soins avec Soins rapides, Soins de lien, Soins inférieurs, Soins, Soins supérieurs et Pénitence voient leurs chances de coup critique augmenter de 6 % sur une cible avec Âme affaiblie. De plus, la durée restante d’Âme affaiblie est réduite de 3 s."
              },
              {
                spellId = 0,
                desc = "Vos soins avec Soins rapides, Soins de lien, Soins inférieurs, Soins, Soins supérieurs et Pénitence voient leurs chances de coup critique augmenter de 8 % sur une cible avec Âme affaiblie. De plus, la durée restante d’Âme affaiblie est réduite de 4 s."
              },
              {
                spellId = 0,
                desc = "Vos soins avec Soins rapides, Soins de lien, Soins inférieurs, Soins, Soins supérieurs et Pénitence voient leurs chances de coup critique augmenter de 10 % sur une cible avec Âme affaiblie. De plus, la durée restante d’Âme affaiblie est réduite de 5 s."
              }
            }
          },
          {
            id = 105840,
            name = "Égide divine",
            icon = "spell_holy_devineaegis",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 431622,
                desc = "Vos soins critiques créent un bouclier protecteur sur la cible qui absorbe un montant de dégâts égal à 5 % des points de vie rendus. Dure 12 sec."
              },
              {
                spellId = 0,
                desc = "Vos soins critiques créent un bouclier protecteur sur la cible qui absorbe un montant de dégâts égal à 10 % des points de vie rendus. Dure 12 sec."
              },
              {
                spellId = 0,
                desc = "Vos soins critiques créent un bouclier protecteur sur la cible qui absorbe un montant de dégâts égal à 15 % des points de vie rendus. Dure 12 sec."
              }
            }
          },
          {
            id = 105836,
            name = "Infusion de puissance",
            icon = "spell_holy_powerinfusion",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105834,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 10060,
                desc = "Imprègne la cible de puissance, ce qui augmente de 20 % les dégâts et les soins qu’elle produit avec des sorts pendant 15 sec."
              }
            }
          }
        }
      },
      {
        id = 202,
        name = "Sacré",
        slug = "sacre",
        order = 1,
        icon = "spell_holy_guardianspirit",
        talents = {
          {
            id = 105867,
            name = "Concentration crépusculaire",
            icon = "spell_holy_healingfocus",
            row = 0,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14913,
                desc = "Vous confère 23 % de chances d’éviter l’interruption de vos incantations par des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 47 % de chances d’éviter l’interruption de vos incantations par des dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 70 % de chances d’éviter l’interruption de vos incantations par des dégâts."
              }
            }
          },
          {
            id = 105866,
            name = "Rénovation améliorée",
            icon = "spell_holy_renew",
            row = 0,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14908,
                desc = "Augmente de 5% le nombre de points de vie soignés par votre sort Rénovation."
              },
              {
                spellId = 0,
                desc = "Augmente de 10% le nombre de points de vie soignés par votre sort Rénovation."
              },
              {
                spellId = 0,
                desc = "Augmente de 15% le nombre de points de vie soignés par votre sort Rénovation."
              }
            }
          },
          {
            id = 110855,
            name = "Spécialisation (Sacré)",
            icon = "spell_holy_sealofsalvation",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 14889,
                desc = "Augmente de 1 % les chances d’effet critique de vos sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les chances d’effet critique de vos sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les chances d’effet critique de vos sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances d’effet critique de vos sorts du sacré."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les chances d’effet critique de vos sorts du sacré."
              }
            }
          },
          {
            id = 105864,
            name = "Protection contre les sorts",
            icon = "spell_holy_spellwarding",
            row = 1,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 27900,
                desc = "Réduit tous les dégâts des sorts subis de 2%."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts des sorts subis de 4%."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts des sorts subis de 6%."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts des sorts subis de 8%."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts des sorts subis de 10%."
              }
            }
          },
          {
            id = 105863,
            name = "Fureur divine",
            icon = "spell_holy_sealofwrath",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18530,
                desc = "Réduit le temps d’incantation de vos sorts Châtiment, Flammes sacrées, Soins et Soins supérieurs de 0.1 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Châtiment, Flammes sacrées, Soins et Soins supérieurs de 0.2 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Châtiment, Flammes sacrées, Soins et Soins supérieurs de 0.3 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Châtiment, Flammes sacrées, Soins et Soins supérieurs de 0.4 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Châtiment, Flammes sacrées, Soins et Soins supérieurs de 0.5 s."
              }
            }
          },
          {
            id = 105862,
            name = "Nova sacrée",
            icon = "spell_holy_holynova",
            row = 2,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 15237,
                desc = "Provoque une explosion de lumière sacrée autour du lanceur ou de la lanceuse. Elle inflige (10.7 % de la puissance des sorts) points de dégâts du sacré à toutes les cibles ennemies dans une zone de 10 m et rend (10.7 % de la puissance des sorts) points de vie aux membres du groupe dans une zone de 10 m. Ces effets ne modifient pas le niveau de menace."
              }
            }
          },
          {
            id = 105861,
            name = "Rétablissement béni",
            icon = "spell_holy_blessedrecovery",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 27811,
                desc = "Lorsque vous subissez un coup critique en mêlée ou à distance, ou qu’une seule attaque vous fait perdre 30 % de votre maximum de points de vie, vous récupérez 8 % des points de dégâts subis en 6 sec. Lorsque cet effet est renouvelé, les soins restants sont conservés."
              },
              {
                spellId = 0,
                desc = "Lorsque vous subissez un coup critique en mêlée ou à distance, ou qu’une seule attaque vous fait perdre 30 % de votre maximum de points de vie, vous récupérez 17 % des points de dégâts subis en 6 sec. Lorsque cet effet est renouvelé, les soins restants sont conservés."
              },
              {
                spellId = 0,
                desc = "Lorsque vous subissez un coup critique en mêlée ou à distance, ou qu’une seule attaque vous fait perdre 30 % de votre maximum de points de vie, vous récupérez 25 % des points de dégâts subis en 6 sec. Lorsque cet effet est renouvelé, les soins restants sont conservés."
              }
            }
          },
          {
            id = 105860,
            name = "Inspiration",
            icon = "spell_holy_layonhands",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14892,
                desc = "Vos soins critiques non périodiques augmentent l’armure de votre cible de 8 % pendant 15 sec."
              },
              {
                spellId = 0,
                desc = "Vos soins critiques non périodiques augmentent l’armure de votre cible de 17 % pendant 15 sec."
              },
              {
                spellId = 0,
                desc = "Vos soins critiques non périodiques augmentent l’armure de votre cible de 25 % pendant 15 sec."
              }
            }
          },
          {
            id = 105859,
            name = "Allonge du Sacré",
            icon = "spell_holy_purify",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 27789,
                desc = "Augmente de 10% la portée de vos sorts Châtiment et Flammes sacrées et le rayon d'effet de vos sorts Prière de soins et Nova sacrée."
              },
              {
                spellId = 0,
                desc = "Augmente de 20% la portée de vos sorts Châtiment et Flammes sacrées et le rayon d'effet de vos sorts Prière de soins et Nova sacrée."
              }
            }
          },
          {
            id = 105858,
            name = "Soin amélioré",
            icon = "spell_holy_heal02",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14912,
                desc = "Réduit de 5 % le coût en mana de vos sorts Soins inférieurs, Soins, Soins supérieurs, Pénitence et Prière de guérison."
              },
              {
                spellId = 0,
                desc = "Réduit de 10 % le coût en mana de vos sorts Soins inférieurs, Soins, Soins supérieurs, Pénitence et Prière de guérison."
              },
              {
                spellId = 0,
                desc = "Réduit de 15 % le coût en mana de vos sorts Soins inférieurs, Soins, Soins supérieurs, Pénitence et Prière de guérison."
              }
            }
          },
          {
            id = 105857,
            name = "Lumière incendiaire",
            icon = "spell_holy_searinglightpriest",
            row = 3,
            col = 2,
            maxRank = 2,
            requires = {
              {
                id = 105863,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 14909,
                desc = "Augmente les dégâts du sacré que vous infligez de 2 %, et chaque fois que votre sort Flammes sacrées inflige des dégâts périodiques, vous avez 5 % de chances que votre prochaine utilisation de Nova sacrée ne coûte pas de mana."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts du sacré que vous infligez de 5 %, et chaque fois que votre sort Flammes sacrées inflige des dégâts périodiques, vous avez 10 % de chances que votre prochaine utilisation de Nova sacrée ne coûte pas de mana."
              }
            }
          },
          {
            id = 105856,
            name = "Soins de lien",
            icon = "spell_holy_blindingheal",
            row = 3,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 401937,
                desc = "Rend (42.9 % de la puissance des sorts) points de vie au lanceur ou à la lanceuse et à une cible alliée. Menace faible."
              }
            }
          },
          {
            id = 105855,
            name = "Litanie de Lumière",
            icon = "inv_scroll_07",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1317006,
                desc = "Lorsque vous lancez un sort de soins, vous récupérez un montant de mana égal à 5 % du coût de base du sort si vos soins précédents proviennent d’un sort différent."
              },
              {
                spellId = 0,
                desc = "Lorsque vous lancez un sort de soins, vous récupérez un montant de mana égal à 10 % du coût de base du sort si vos soins précédents proviennent d’un sort différent."
              }
            }
          },
          {
            id = 105854,
            name = "Esprit de rédemption",
            icon = "inv_enchant_essenceeternallarge",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 20711,
                desc = "Au moment de sa mort, le prêtre devient l'Esprit de rédemption pendant 15 sec. L'Esprit de rédemption ne peut pas se déplacer ou attaquer, ni être attaqué ou ciblé par aucun sort ou effet. Tant qu'il est sous cette forme, le prêtre peut lancer tout sort de soins sans le moindre coût. A la fin de l'effet, le prêtre meurt."
              }
            }
          },
          {
            id = 105853,
            name = "Direction spirituelle",
            icon = "spell_holy_spiritualguidence",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 14901,
                desc = "Augmente les soins de vos sorts d’un montant au maximum égal à 5 % de votre total d’Esprit et les dégâts de vos sorts d’un montant au maximum égal à 1 % de votre total d’Esprit."
              },
              {
                spellId = 0,
                desc = "Augmente les soins de vos sorts d’un montant au maximum égal à 10 % de votre total d’Esprit et les dégâts de vos sorts d’un montant au maximum égal à 3 % de votre total d’Esprit."
              },
              {
                spellId = 0,
                desc = "Augmente les soins de vos sorts d’un montant au maximum égal à 15 % de votre total d’Esprit et les dégâts de vos sorts d’un montant au maximum égal à 5 % de votre total d’Esprit."
              },
              {
                spellId = 0,
                desc = "Augmente les soins de vos sorts d’un montant au maximum égal à 20 % de votre total d’Esprit et les dégâts de vos sorts d’un montant au maximum égal à 6 % de votre total d’Esprit."
              },
              {
                spellId = 0,
                desc = "Augmente les soins de vos sorts d’un montant au maximum égal à 25 % de votre total d’Esprit et les dégâts de vos sorts d’un montant au maximum égal à 8 % de votre total d’Esprit."
              }
            }
          },
          {
            id = 105852,
            name = "Soins spirituels",
            icon = "spell_nature_moonglow",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 14898,
                desc = "Augmente de 3 % le montant de points de vie rendus par vos sorts."
              },
              {
                spellId = 0,
                desc = "Augmente de 7 % le montant de points de vie rendus par vos sorts."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % le montant de points de vie rendus par vos sorts."
              }
            }
          },
          {
            id = 105851,
            name = "Prière de guérison",
            icon = "spell_holy_prayerofmendingtga",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105854,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 401859,
                desc = "Place sur la cible un sort qui lui rend 172 (+ 42.9 % de la puissance des soins) points de vie la prochaine fois qu’elle subit des dégâts ou reçoit des soins non périodiques. Chaque fois que les soins sont déclenchés, Prière de guérison passe à un autre membre du groupe ou raid à moins de 20 m. Change de cible 5 fois au maximum et dure 30 sec après chaque changement. Ce sort ne peut être placé que sur une cible à la fois."
              }
            }
          }
        }
      },
      {
        id = 203,
        name = "Ombre",
        slug = "ombre",
        order = 2,
        icon = "spell_shadow_shadowwordpain",
        talents = {
          {
            id = 110851,
            name = "Focalisation de l'ombre",
            icon = "spell_shadow_burningspirit",
            row = 0,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 15260,
                desc = "Améliore de 1 % vos chances de toucher avec les sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Améliore de 2 % vos chances de toucher avec les sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Améliore de 3 % vos chances de toucher avec les sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Améliore de 4 % vos chances de toucher avec les sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Améliore de 5 % vos chances de toucher avec les sorts d’ombre."
              }
            }
          },
          {
            id = 105832,
            name = "Aveuglement",
            icon = "spell_shadow_gathershadows",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 15326,
                desc = "Vos sorts de dégâts d’ombre ont 2 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Vos sorts de dégâts d’ombre ont 4 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Vos sorts de dégâts d’ombre ont 6 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Vos sorts de dégâts d’ombre ont 8 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Vos sorts de dégâts d’ombre ont 10 % de chances d’étourdir la cible pendant 3 sec."
              }
            }
          },
          {
            id = 105833,
            name = "Connexion spirituelle",
            icon = "spell_shadow_requiem",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 15270,
                desc = "Vous donne 20 % de chances de gagner un bonus de 100 % à l’Esprit pendant 15 sec après avoir tué une cible non négligeable. Tant que l’effet est actif, votre mana se régénère à 50 % de la vitesse de récupération normale pendant l’incantation de sorts."
              },
              {
                spellId = 0,
                desc = "Vous donne 40 % de chances de gagner un bonus de 100 % à l’Esprit pendant 15 sec après avoir tué une cible non négligeable. Tant que l’effet est actif, votre mana se régénère à 50 % de la vitesse de récupération normale pendant l’incantation de sorts."
              },
              {
                spellId = 0,
                desc = "Vous donne 60 % de chances de gagner un bonus de 100 % à l’Esprit pendant 15 sec après avoir tué une cible non négligeable. Tant que l’effet est actif, votre mana se régénère à 50 % de la vitesse de récupération normale pendant l’incantation de sorts."
              },
              {
                spellId = 0,
                desc = "Vous donne 80 % de chances de gagner un bonus de 100 % à l’Esprit pendant 15 sec après avoir tué une cible non négligeable. Tant que l’effet est actif, votre mana se régénère à 50 % de la vitesse de récupération normale pendant l’incantation de sorts."
              },
              {
                spellId = 0,
                desc = "Vous donne 100 % de chances de gagner un bonus de 100 % à l’Esprit pendant 15 sec après avoir tué une cible non négligeable. Tant que l’effet est actif, votre mana se régénère à 50 % de la vitesse de récupération normale pendant l’incantation de sorts."
              }
            }
          },
          {
            id = 105831,
            name = "Affinité avec l'Ombre",
            icon = "spell_shadow_shadowward",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 15318,
                desc = "Diminue le niveau de menace généré par vos sorts d'Ombre de 10%."
              },
              {
                spellId = 0,
                desc = "Diminue le niveau de menace généré par vos sorts d'Ombre de 20%."
              },
              {
                spellId = 0,
                desc = "Diminue le niveau de menace généré par vos sorts d'Ombre de 30%."
              }
            }
          },
          {
            id = 105830,
            name = "Mot de l'ombre : Douleur amélioré",
            icon = "spell_shadow_shadowwordpain",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 15275,
                desc = "Augmente la durée de votre sort Mot de l’ombre : Douleur de 3 s."
              },
              {
                spellId = 0,
                desc = "Augmente la durée de votre sort Mot de l’ombre : Douleur de 6 s."
              }
            }
          },
          {
            id = 105829,
            name = "Allonge de l'Ombre",
            icon = "spell_shadow_chilltouch",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 17322,
                desc = "Augmente de 10% la portée de vos sorts offensifs d'Ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 20% la portée de vos sorts offensifs d'Ombre."
              }
            }
          },
          {
            id = 105827,
            name = "Attaque mentale améliorée",
            icon = "spell_shadow_unholyfrenzy",
            row = 2,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 15273,
                desc = "Réduit le temps de recharge du sort Attaque mentale de 0.5 secondes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge du sort Attaque mentale de 1 secondes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge du sort Attaque mentale de 1.5 secondes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge du sort Attaque mentale de 2 secondes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge du sort Attaque mentale de 2.5 secondes."
              }
            }
          },
          {
            id = 105828,
            name = "Cri psychique amélioré",
            icon = "spell_shadow_psychicscream",
            row = 2,
            col = 1,
            maxRank = 2,
            requires = {
              {
                id = 105832,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 15392,
                desc = "Réduit le temps de recharge de votre sort Cri psychique de 2 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre sort Cri psychique de 4 sec."
              }
            }
          },
          {
            id = 105826,
            name = "Fouet mental",
            icon = "spell_shadow_siphonmana",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 15407,
                desc = "Attaque l’esprit de la cible avec l’énergie de l’ombre, ce qui lui inflige (63 % de la puissance des sorts) point de dégâts d’ombre en 3 sec et réduit sa vitesse de déplacement de 50 %."
              }
            }
          },
          {
            id = 105825,
            name = "Fouet mental amélioré",
            icon = "spell_shadow_soulleech_2",
            row = 2,
            col = 3,
            maxRank = 2,
            requires = {
              {
                id = 105826,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1225139,
                desc = "Votre sort Fouet mental inflige désormais 10 % de dégâts supplémentaires, sa portée augmente de 5 m, et il diminue la vitesse de déplacement de la cible de 35 %."
              },
              {
                spellId = 0,
                desc = "Votre sort Fouet mental inflige désormais 20 % de dégâts supplémentaires, sa portée augmente de 10 m, et il diminue la vitesse de déplacement de la cible de 20 %."
              }
            }
          },
          {
            id = 105823,
            name = "Oubli amélioré",
            icon = "spell_magic_lesserinvisibilty",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 15274,
                desc = "Diminue le temps de recharge de votre technique Oubli de 3 sec."
              },
              {
                spellId = 0,
                desc = "Diminue le temps de recharge de votre technique Oubli de 6 sec."
              }
            }
          },
          {
            id = 105820,
            name = "Etreinte vampirique",
            icon = "spell_shadow_unsummonbuilding",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 15286,
                desc = "Libère sur votre cible de l’énergie de l’ombre qui soigne tous les personnages de votre groupe de 20 % de tous les dégâts de sorts d’ombre que vous infligez pendant 30 sec. Lorsqu’un personnage adverse affecté par Étreinte vampirique meurt, vous bénéficiez également d’une chance de déclencher votre talent Connexion spirituelle."
              }
            }
          },
          {
            id = 105821,
            name = "Tissage de l'ombre",
            icon = "spell_shadow_blackplague",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 15257,
                desc = "Vos sorts d’ombre infligeant des dégâts ont 33 % de chances d’augmenter les dégâts d’ombre que vous infligez de 2 % pendant 15 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Vos sorts d’ombre infligeant des dégâts ont 67 % de chances d’augmenter les dégâts d’ombre que vous infligez de 2 % pendant 15 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Vos sorts d’ombre infligeant des dégâts ont 100 % de chances d’augmenter les dégâts d’ombre que vous infligez de 2 % pendant 15 sec. Cumulable jusqu’à 5 fois."
              }
            }
          },
          {
            id = 105824,
            name = "Silence",
            icon = "spell_shadow_impphaseshift",
            row = 4,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 15487,
                desc = "Rend la cible silencieuse, ce qui l’empêche de lancer des sorts pendant 5 sec et interrompt ses incantations pendant 3 sec."
              }
            }
          },
          {
            id = 105819,
            name = "Contagion dévorante",
            icon = "spell_shadow_devouringplague",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1309950,
                desc = "Réduit le coût en mana de Peste dévorante de 25 %.<br>Les cibles qui meurent alors que Peste dévorante est active propagent l’effet à un personnage adverse proche à moins de 5 m pendant la durée restante."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de Peste dévorante de 50 %.<br>Les cibles qui meurent alors que Peste dévorante est active propagent l’effet à un personnage adverse proche à moins de 10 m pendant la durée restante."
              }
            }
          },
          {
            id = 110854,
            name = "Trépas prématuré",
            icon = "spell_shadow_demonicfortitude",
            row = 5,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1310076,
                desc = "Augmente de 15 % vos chances de coup critique avec Mot de l’ombre : Mort contre les cibles disposant de 20 % ou moins de leurs points de vie."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % vos chances de coup critique avec Mot de l’ombre : Mort contre les cibles disposant de 20 % ou moins de leurs points de vie."
              }
            }
          },
          {
            id = 105818,
            name = "Ténèbres",
            icon = "spell_shadow_twilight",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 15259,
                desc = "Augmente vos dégâts d’ombre de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos dégâts d’ombre de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos dégâts d’ombre de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos dégâts d’ombre de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente vos dégâts d’ombre de 10 %."
              }
            }
          },
          {
            id = 105817,
            name = "Forme d'Ombre",
            icon = "spell_shadow_shadowform",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105820,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 15473,
                desc = "Permet d’adopter une forme d’ombre qui augmente de 10 % les dégâts d’ombre infligés, réduit le coût en mana des sorts d’ombre de 50 %, augmente le bonus aux dégâts des coups critiques de vos sorts d’ombre de 100 % et réduit les dégâts physiques que vous subissez de 15 %. Vous ne pouvez pas lancer de sorts de soins sous cette forme."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 7,
    slug = "chaman",
    name = "Chaman",
    color = "#0070DE",
    icon = "class_shaman",
    trees = {
      {
        id = 261,
        name = "Éléments",
        slug = "elements",
        order = 0,
        icon = "spell_nature_lightning",
        talents = {
          {
            id = 104773,
            name = "Convection",
            icon = "spell_nature_wispsplode",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16039,
                desc = "Réduit de 2 % le coût en mana de vos sorts Horion, Éclair, Explosion de lave et Chaîne d’éclairs."
              },
              {
                spellId = 0,
                desc = "Réduit de 4 % le coût en mana de vos sorts Horion, Éclair, Explosion de lave et Chaîne d’éclairs."
              },
              {
                spellId = 0,
                desc = "Réduit de 6 % le coût en mana de vos sorts Horion, Éclair, Explosion de lave et Chaîne d’éclairs."
              },
              {
                spellId = 0,
                desc = "Réduit de 8 % le coût en mana de vos sorts Horion, Éclair, Explosion de lave et Chaîne d’éclairs."
              },
              {
                spellId = 0,
                desc = "Réduit de 10 % le coût en mana de vos sorts Horion, Éclair, Explosion de lave et Chaîne d’éclairs."
              }
            }
          },
          {
            id = 104772,
            name = "Commotion",
            icon = "spell_nature_earthshock",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16035,
                desc = "Augmente de 1 % les dégâts infligés par vos sorts Éclair, Chaîne d’éclairs et Horion de terre."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les dégâts infligés par vos sorts Éclair, Chaîne d’éclairs et Horion de terre."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les dégâts infligés par vos sorts Éclair, Chaîne d’éclairs et Horion de terre."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les dégâts infligés par vos sorts Éclair, Chaîne d’éclairs et Horion de terre."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les dégâts infligés par vos sorts Éclair, Chaîne d’éclairs et Horion de terre."
              }
            }
          },
          {
            id = 104771,
            name = "Protection contre les éléments",
            icon = "spell_nature_spiritarmor",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 28996,
                desc = "Réduit de 3 % les dégâts subis des effets de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Réduit de 7 % les dégâts subis des effets de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Réduit de 10 % les dégâts subis des effets de feu, de givre et de nature."
              }
            }
          },
          {
            id = 104767,
            name = "Réverbération",
            icon = "spell_frost_frostward",
            row = 1,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16040,
                desc = "Réduit le temps de recharge de vos sorts Horion de 0.2 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de vos sorts Horion de 0.4 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de vos sorts Horion de 0.6 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de vos sorts Horion de 0.8 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de vos sorts Horion de 1 s."
              }
            }
          },
          {
            id = 104770,
            name = "Appel des flammes",
            icon = "spell_fire_immolation",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16038,
                desc = "Augmente de 5 % les dégâts infligés par vos totems de feu et vos sorts Horion de flamme, Nova de feu et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par vos totems de feu et vos sorts Horion de flamme, Nova de feu et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts infligés par vos totems de feu et vos sorts Horion de flamme, Nova de feu et Explosion de lave."
              }
            }
          },
          {
            id = 104769,
            name = "Dévastation élémentaire",
            icon = "spell_fire_elementaldevastation",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 30160,
                desc = "Vos coups critiques avec des sorts offensifs augmentent de 3 % vos chances d’infliger un coup critique avec vos attaques en mêlée pendant 10 sec."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques avec des sorts offensifs augmentent de 6 % vos chances d’infliger un coup critique avec vos attaques en mêlée pendant 10 sec."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques avec des sorts offensifs augmentent de 9 % vos chances d’infliger un coup critique avec vos attaques en mêlée pendant 10 sec."
              }
            }
          },
          {
            id = 104768,
            name = "Focalisation élémentaire",
            icon = "spell_shadow_manaburn",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 16164,
                desc = "Vous confère 10 % de chances d’entrer dans un état d’Idées claires après avoir lancé un sort infligeant des dégâts de feu, de givre ou de nature. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              }
            }
          },
          {
            id = 104766,
            name = "Fureur élémentaire",
            icon = "spell_fire_volcano",
            row = 2,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16089,
                desc = "Augmente de 20 % le bonus de dégâts des coups critiques de votre totem incendiaire et de votre totem de magma, ainsi que les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 40 % le bonus de dégâts des coups critiques de votre totem incendiaire et de votre totem de magma, ainsi que les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 60 % le bonus de dégâts des coups critiques de votre totem incendiaire et de votre totem de magma, ainsi que les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 80 % le bonus de dégâts des coups critiques de votre totem incendiaire et de votre totem de magma, ainsi que les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de feu, de givre et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 100 % le bonus de dégâts des coups critiques de votre totem incendiaire et de votre totem de magma, ainsi que les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de feu, de givre et de nature."
              }
            }
          },
          {
            id = 104764,
            name = "Nova de feu améliorée",
            icon = "spell_fire_sealoffire",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16086,
                desc = "Augmente les dégâts infligés par votre sort Nova de feu de 10 % et réduit le temps de recharge de 2 s."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par votre sort Nova de feu de 20 % et réduit le temps de recharge de 4 s."
              }
            }
          },
          {
            id = 104763,
            name = "Oeil du cyclone",
            icon = "spell_nature_eyeofthestorm",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 29062,
                desc = "Réduit de 23 % la perte de temps d’incantation causée par les attaques infligeant des dégâts pendant que vous incantez les sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Réduit de 47 % la perte de temps d’incantation causée par les attaques infligeant des dégâts pendant que vous incantez les sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Réduit de 70 % la perte de temps d’incantation causée par les attaques infligeant des dégâts pendant que vous incantez les sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              }
            }
          },
          {
            id = 104762,
            name = "Appel de la foudre",
            icon = "spell_nature_callstorm",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 104766,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 16120,
                desc = "Augmente de 3 % les chances de coup critique de vos sorts Éclair et Chaîne d’éclairs."
              }
            }
          },
          {
            id = 104761,
            name = "Allonge élémentaire",
            icon = "spell_nature_stormreach",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 28999,
                desc = "Augmente la portée de vos sorts Éclair, Chaîne d’éclairs, Nova de feu et Explosion de lave de 3 m et augmente la portée de votre sort Horion de flamme de 8 m."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos sorts Éclair, Chaîne d’éclairs, Nova de feu et Explosion de lave de 6 m et augmente la portée de votre sort Horion de flamme de 15 m."
              }
            }
          },
          {
            id = 104759,
            name = "Surcharge de foudre",
            icon = "spell_nature_lightningoverload",
            row = 4,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 408438,
                desc = "Confère à vos sorts Éclair et Chaîne d’éclairs 3 % de chances de lancer un second sort similaire sur la même cible sans coût supplémentaire, infligeant la moitié des dégâts et ne générant aucun niveau de menace."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts Éclair et Chaîne d’éclairs 7 % de chances de lancer un second sort similaire sur la même cible sans coût supplémentaire, infligeant la moitié des dégâts et ne générant aucun niveau de menace."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts Éclair et Chaîne d’éclairs 10 % de chances de lancer un second sort similaire sur la même cible sans coût supplémentaire, infligeant la moitié des dégâts et ne générant aucun niveau de menace."
              }
            }
          },
          {
            id = 104760,
            name = "Lien terrestre",
            icon = "spell_nature_stranglevines",
            row = 4,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1222988,
                desc = "Votre totem de lien terrestre immobilise les cibles proches pendant 5 sec lorsqu’il est lancé."
              }
            }
          },
          {
            id = 104765,
            name = "Empressement élémentaire",
            icon = "spell_lightning_lightningbolt01",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {
              {
                id = 104762,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 16578,
                desc = "Réduit de 0.17 s le temps d’incantation de vos sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.33 s le temps d’incantation de vos sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.5 s le temps d’incantation de vos sorts Éclair, Chaîne d’éclairs et Explosion de lave."
              }
            }
          },
          {
            id = 104758,
            name = "Explosion de lave",
            icon = "spell_shaman_lavaburst",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104759,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 408490,
                desc = "Vous lancez de la lave en fusion sur la cible, lui infligeant (71.4 % de la puissance des sorts) points de dégâts de feu. Si Horion de flammes est actif sur la cible, Explosion de lave inflige 20 % de dégâts supplémentaires."
              }
            }
          }
        }
      },
      {
        id = 263,
        name = "Amélioration",
        slug = "amelioration",
        order = 1,
        icon = "spell_nature_lightningshield",
        talents = {
          {
            id = 104757,
            name = "Emprise de la terre",
            icon = "spell_nature_stoneclawtotem",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16043,
                desc = "Augmente de 25 % les points de vie de votre totem de griffes de pierre et de 10 % le rayon d’action de votre totem de lien terrestre."
              },
              {
                spellId = 0,
                desc = "Augmente de 50 % les points de vie de votre totem de griffes de pierre et de 20 % le rayon d’action de votre totem de lien terrestre."
              }
            }
          },
          {
            id = 104753,
            name = "Frappe foudroyante",
            icon = "ability_thunderbolt",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16255,
                desc = "Améliore vos chances de coup critique des sorts et attaques de 1 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de coup critique des sorts et attaques de 2 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de coup critique des sorts et attaques de 3 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de coup critique des sorts et attaques de 4 %."
              },
              {
                spellId = 0,
                desc = "Améliore vos chances de coup critique des sorts et attaques de 5 %."
              }
            }
          },
          {
            id = 104756,
            name = "Connaissance ancestrale",
            icon = "spell_shadow_grimward",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17485,
                desc = "Augmente votre intelligence de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre intelligence de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre intelligence de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre intelligence de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre intelligence de 10 %."
              }
            }
          },
          {
            id = 104754,
            name = "Totems gardiens",
            icon = "spell_nature_stoneskintotem",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16258,
                desc = "Augmente de 10 % la quantité de dégâts réduits par votre totem de peau de pierre et votre totem Mur de vent. Réduit le temps de recharge de votre totem de glèbe de 1 s."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la quantité de dégâts réduits par votre totem de peau de pierre et votre totem Mur de vent. Réduit le temps de recharge de votre totem de glèbe de 2 s."
              }
            }
          },
          {
            id = 104755,
            name = "Dextérité mentale",
            icon = "spell_nature_mentalquickness",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 415140,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 33 % de votre intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 67 % de votre intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre puissance d’attaque d’un montant égal à 100 % de votre intelligence."
              }
            }
          },
          {
            id = 104752,
            name = "Loup fantôme amélioré",
            icon = "spell_nature_spiritwolf",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16262,
                desc = "Réduit le temps d’incantation de votre sort Loup fantôme de 1 s. De plus, Loup fantôme peut être utilisé en intérieur."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Loup fantôme de 3 s. De plus, Loup fantôme peut être utilisé en intérieur."
              }
            }
          },
          {
            id = 104751,
            name = "Bouclier de foudre amélioré",
            icon = "spell_nature_lightningshield",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16261,
                desc = "Augmente de 5 % les dégâts infligés par les orbes de votre bouclier de foudre."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par les orbes de votre bouclier de foudre."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les dégâts infligés par les orbes de votre bouclier de foudre."
              }
            }
          },
          {
            id = 104750,
            name = "Armes élémentaires",
            icon = "spell_fire_flametounge",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16266,
                desc = "Augmente de 7 % le bonus à la puissance d’attaque en mêlée de votre arme Croque-roc, de 13 % l’effet de votre arme Furie-des-vents et de 5 % les dégâts infligés par votre arme Langue de feu et votre arme de givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 13 % le bonus à la puissance d’attaque en mêlée de votre arme Croque-roc, de 27 % l’effet de votre arme Furie-des-vents et de 10 % les dégâts infligés par votre arme Langue de feu et votre arme de givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % le bonus à la puissance d’attaque en mêlée de votre arme Croque-roc, de 40 % l’effet de votre arme Furie-des-vents et de 15 % les dégâts infligés par votre arme Langue de feu et votre arme de givre."
              }
            }
          },
          {
            id = 104749,
            name = "Focalisation chamanique",
            icon = "spell_nature_elementalabsorption",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1223030,
                desc = "Réduit le coût en mana de vos sorts Horion et Bouclier de foudre de 45 %."
              }
            }
          },
          {
            id = 104748,
            name = "Anticipation",
            icon = "spell_nature_mirrorimage",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16254,
                desc = "Augmente vos chances d’esquiver de 2 % supplémentaires."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 4 % supplémentaires."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 6 % supplémentaires."
              }
            }
          },
          {
            id = 104746,
            name = "Résistance",
            icon = "spell_holy_devotion",
            row = 3,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16252,
                desc = "Augmente votre endurance de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre endurance de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre endurance de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre endurance de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre endurance de 10 %."
              }
            }
          },
          {
            id = 104747,
            name = "Rafale",
            icon = "ability_ghoulfrenzy",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {
              {
                id = 104755,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 16256,
                desc = "Augmente votre vitesse d’attaque de 5 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque de 10 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque de 15 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque de 20 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente votre vitesse d’attaque de 25 % pour vos 3 prochaines attaques après avoir infligé un coup critique en mêlée."
              }
            }
          },
          {
            id = 104743,
            name = "Courroux naturel",
            icon = "ability_shaman_stormstrike",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 17364,
                desc = "Inflige instantanément les dégâts normaux de l’arme et augmente de 20 % les dégâts que vous infligez à la cible avec votre prochain sort Éclair, Chaîne d’éclairs ou Horion de terre pendant 12 sec."
              }
            }
          },
          {
            id = 104745,
            name = "Armes spirituelles",
            icon = "ability_parry",
            row = 4,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 16268,
                desc = "Donne une chance de parer les attaques en mêlée des adversaires, réduit la menace générée par vos attaques de 30 % tant que l’arme Croque-roc est inactive, et augmente le niveau de menace généré de 30 % quand Arme Croque-roc est active."
              }
            }
          },
          {
            id = 104744,
            name = "Rapidité mentale",
            icon = "spell_nature_sleep",
            row = 4,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 30812,
                desc = "Augmente les dégâts et les soins de vos sorts d’un montant pouvant atteindre 15 % de votre intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts et les soins de vos sorts d’un montant pouvant atteindre 30 % de votre intelligence."
              }
            }
          },
          {
            id = 104742,
            name = "Frappe-tempête amélioré",
            icon = "spell_shaman_improvedstormstrike",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {
              {
                id = 104743,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1223031,
                desc = "Lorsque vous utilisez Frappe-tempête, vous avez 50 % de chances d’augmenter votre régénération de mana de 50 % pendant 15 sec lorsque vous lancez des sorts, et le temps de recharge de Frappe-tempête a 50 % de chances d’être réinitialisé chaque fois que vous esquivez ou parez."
              },
              {
                spellId = 0,
                desc = "Lorsque vous utilisez Frappe-tempête, vous avez 100 % de chances d’augmenter votre régénération de mana de 50 % pendant 15 sec lorsque vous lancez des sorts, et le temps de recharge de Frappe-tempête a 100 % de chances d’être réinitialisé chaque fois que vous esquivez ou parez."
              }
            }
          },
          {
            id = 104741,
            name = "Arme du Maelström",
            icon = "spell_shaman_maelstromweapon",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 408498,
                desc = "Quand vous infligez des dégâts avec une attaque en mêlée, vous avez une chance de réduire de 4 % le temps d’incantation et le coût en mana de votre prochain sort Éclair. Cumulable jusqu’à 5 fois. Dure 30 sec."
              },
              {
                spellId = 0,
                desc = "Quand vous infligez des dégâts avec une attaque en mêlée, vous avez une chance de réduire de 8 % le temps d’incantation et le coût en mana de votre prochain sort Éclair. Cumulable jusqu’à 5 fois. Dure 30 sec."
              },
              {
                spellId = 0,
                desc = "Quand vous infligez des dégâts avec une attaque en mêlée, vous avez une chance de réduire de 12 % le temps d’incantation et le coût en mana de votre prochain sort Éclair. Cumulable jusqu’à 5 fois. Dure 30 sec."
              },
              {
                spellId = 0,
                desc = "Quand vous infligez des dégâts avec une attaque en mêlée, vous avez une chance de réduire de 16 % le temps d’incantation et le coût en mana de votre prochain sort Éclair. Cumulable jusqu’à 5 fois. Dure 30 sec."
              },
              {
                spellId = 0,
                desc = "Quand vous infligez des dégâts avec une attaque en mêlée, vous avez une chance de réduire de 20 % le temps d’incantation et le coût en mana de votre prochain sort Éclair. Cumulable jusqu’à 5 fois. Dure 30 sec."
              }
            }
          },
          {
            id = 104740,
            name = "Rage long-voyante",
            icon = "spell_nature_bloodlust",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104744,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 425336,
                desc = "Augmente votre vitesse d’attaque en mêlée et d’incantation de 30 % pendant 25 sec."
              }
            }
          }
        }
      },
      {
        id = 262,
        name = "Restauration",
        slug = "restauration",
        order = 2,
        icon = "spell_nature_magicimmunity",
        talents = {
          {
            id = 104739,
            name = "Vague de soins améliorée",
            icon = "spell_nature_magicimmunity",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16182,
                desc = "Réduit le temps d’incantation de votre sort Vague de soins de 0.1 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Vague de soins de 0.2 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Vague de soins de 0.3 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Vague de soins de 0.4 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Vague de soins de 0.5 s."
              }
            }
          },
          {
            id = 104729,
            name = "Focalisation totémique",
            icon = "spell_nature_moonglow",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16173,
                desc = "Réduit de 5 % le coût en mana de vos totems et des sorts qui permettent de les invoquer ou de les déplacer."
              },
              {
                spellId = 0,
                desc = "Réduit de 10 % le coût en mana de vos totems et des sorts qui permettent de les invoquer ou de les déplacer."
              },
              {
                spellId = 0,
                desc = "Réduit de 15 % le coût en mana de vos totems et des sorts qui permettent de les invoquer ou de les déplacer."
              },
              {
                spellId = 0,
                desc = "Réduit de 20 % le coût en mana de vos totems et des sorts qui permettent de les invoquer ou de les déplacer."
              },
              {
                spellId = 0,
                desc = "Réduit de 25 % le coût en mana de vos totems et des sorts qui permettent de les invoquer ou de les déplacer."
              }
            }
          },
          {
            id = 104734,
            name = "Pleine conscience",
            icon = "spell_nature_sleep",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1223033,
                desc = "Vous confère 17 % de votre vitesse normale de récupération du mana pendant l’incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 33 % de votre vitesse normale de récupération du mana pendant l’incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 50 % de votre vitesse normale de récupération du mana pendant l’incantation."
              }
            }
          },
          {
            id = 104736,
            name = "Grâce naturelle",
            icon = "spell_nature_healingtouch",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 29187,
                desc = "Diminue le niveau de menace généré par vos sorts de 5 %."
              },
              {
                spellId = 0,
                desc = "Diminue le niveau de menace généré par vos sorts de 10 %."
              },
              {
                spellId = 0,
                desc = "Diminue le niveau de menace généré par vos sorts de 15 %."
              }
            }
          },
          {
            id = 104735,
            name = "Focalisation des flots",
            icon = "spell_frost_manarecharge",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16179,
                desc = "Réduit de 1 % le coût en mana de vos sorts de soins et améliore de 1 % vos chances de toucher."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 % le coût en mana de vos sorts de soins et améliore de 2 % vos chances de toucher."
              },
              {
                spellId = 0,
                desc = "Réduit de 3 % le coût en mana de vos sorts de soins et améliore de 3 % vos chances de toucher."
              },
              {
                spellId = 0,
                desc = "Réduit de 4 % le coût en mana de vos sorts de soins et améliore de 4 % vos chances de toucher."
              },
              {
                spellId = 0,
                desc = "Réduit de 5 % le coût en mana de vos sorts de soins et améliore de 5 % vos chances de toucher."
              }
            }
          },
          {
            id = 104737,
            name = "Réincarnation améliorée",
            icon = "spell_nature_reincarnation",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16184,
                desc = "Réduit le temps de recharge de votre sort Réincarnation de 10 min, augmente de 2 % votre maximum de points de vie et augmente les points de vie et de mana dont vous disposez quand vous vous réincarnez de 10 % supplémentaires."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre sort Réincarnation de 20 min, augmente de 4 % votre maximum de points de vie et augmente les points de vie et de mana dont vous disposez quand vous vous réincarnez de 20 % supplémentaires."
              }
            }
          },
          {
            id = 104731,
            name = "Guérison des anciens",
            icon = "spell_nature_undyingstrength",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16176,
                desc = "Augmente de 8 % la valeur d’armure de votre cible pendant 15 sec après qu’elle a subi un effet critique de l’un de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 17 % la valeur d’armure de votre cible pendant 15 sec après qu’elle a subi un effet critique de l’un de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 25 % la valeur d’armure de votre cible pendant 15 sec après qu’elle a subi un effet critique de l’un de vos sorts de soins."
              }
            }
          },
          {
            id = 104733,
            name = "Focalisation des soins",
            icon = "spell_nature_healingwavelesser",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16181,
                desc = "Vous confère 23 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous lancez un sort de soins."
              },
              {
                spellId = 0,
                desc = "Vous confère 47 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous lancez un sort de soins."
              },
              {
                spellId = 0,
                desc = "Vous confère 70 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous lancez un sort de soins."
              }
            }
          },
          {
            id = 104732,
            name = "Bouclier d’eau",
            icon = "ability_shaman_watershield",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 408510,
                desc = "Le lanceur ou la lanceuse s’entoure de 3 globes d’eau. Si une attaque en mêlée, à distance ou un sort touche le lanceur ou la lanceuse, ou si l’un de ses sorts de soins obtient un effet critique, un globe d’eau est dépensé pour restaurer 2 % de son maximum de mana. Un seul globe peut s’activer toutes les quelques secondes. Dure 10 min.<br>Un seul bouclier élémentaire peut être actif sur le chaman ou la chamane à la fois."
              }
            }
          },
          {
            id = 104738,
            name = "Maîtrise des flots",
            icon = "spell_nature_tranquility",
            row = 3,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16194,
                desc = "Augmente de 1 % les chances d’effet critique de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les chances d’effet critique de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les chances d’effet critique de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances d’effet critique de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les chances d’effet critique de vos sorts de soins."
              }
            }
          },
          {
            id = 104730,
            name = "Totems de restauration",
            icon = "spell_nature_manaregentotem",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16187,
                desc = "Augmente de 5 % les effets de votre totem Fontaine de mana et de 10 % celui de votre totem guérisseur."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les effets de votre totem Fontaine de mana et de 20 % celui de votre totem guérisseur."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % les effets de votre totem Fontaine de mana et de 30 % celui de votre totem guérisseur."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les effets de votre totem Fontaine de mana et de 40 % celui de votre totem guérisseur."
              },
              {
                spellId = 0,
                desc = "Augmente de 25 % les effets de votre totem Fontaine de mana et de 50 % celui de votre totem guérisseur."
              }
            }
          },
          {
            id = 104728,
            name = "Totem de Vague de mana",
            icon = "spell_frost_summonwaterelemental",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 16190,
                desc = "Invoque un Totem de Vague de mana aux pieds du lanceur de sorts ; le Totem dispose de 5 points de vie. Agit pendant 12 s. Il rend 88 points de mana toutes les 3 secondes, à tous les membres du groupe qui se trouvent dans une zone de 30 mètres."
              }
            }
          },
          {
            id = 104727,
            name = "Flots de soins",
            icon = "spell_nature_healingway",
            row = 4,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 29206,
                desc = "Augmente le montant de points de vie rendus par votre Vague de soins de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente le montant de points de vie rendus par votre Vague de soins de 17 %."
              },
              {
                spellId = 0,
                desc = "Augmente le montant de points de vie rendus par votre Vague de soins de 25 %."
              }
            }
          },
          {
            id = 104726,
            name = "Rapidité de la nature",
            icon = "spell_nature_ravenform",
            row = 4,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 16188,
                desc = "Activé, votre prochain sort de Nature dont le temps d'incantation est inférieur à 10 secondes devient un sort instantané."
              }
            }
          },
          {
            id = 104725,
            name = "Purification",
            icon = "spell_frost_wizardmark",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16178,
                desc = "Augmente de 2 % l’efficacité de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % l’efficacité de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % l’efficacité de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % l’efficacité de vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % l’efficacité de vos sorts de soins."
              }
            }
          },
          {
            id = 104724,
            name = "Remous",
            icon = "spell_nature_riptide",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104727,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 408521,
                desc = "Rend (21.4 % de la puissance des sorts) points de vie à une cible alliée, puis (50 % de la puissance des sorts) points de vie supplémentaires en 15 sec. Augmente l’efficacité de votre sort Salve de guérison de 25 % lorsqu’il est lancé directement sur cette cible."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 8,
    slug = "mage",
    name = "Mage",
    color = "#69CCF0",
    icon = "class_mage",
    trees = {
      {
        id = 81,
        name = "Arcanes",
        slug = "arcanes",
        order = 0,
        icon = "spell_holy_magicalsentry",
        talents = {
          {
            id = 105815,
            name = "Spécialisation Baguette",
            icon = "inv_wand_01",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 6057,
                desc = "Augmente de 13% les points de dégâts que vous infligez avec une Baguette."
              },
              {
                spellId = 0,
                desc = "Augmente de 25% les points de dégâts que vous infligez avec une Baguette."
              }
            }
          },
          {
            id = 105814,
            name = "Focalisation des arcanes",
            icon = "spell_holy_devotion",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11222,
                desc = "Améliore de 1 % vos chances de toucher avec les sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Améliore de 2 % vos chances de toucher avec les sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Améliore de 3 % vos chances de toucher avec les sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Améliore de 4 % vos chances de toucher avec les sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Améliore de 5 % vos chances de toucher avec les sorts des arcanes."
              }
            }
          },
          {
            id = 105813,
            name = "Canalisation améliorée",
            icon = "spell_nature_starfall",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11237,
                desc = "Vous confère 20 % de chances d’éviter une interruption provoquée par des dégâts pendant que vous canalisez Projectiles des arcanes et 14 % de chances pendant que vous lancez Déflagration des arcanes."
              },
              {
                spellId = 0,
                desc = "Vous confère 40 % de chances d’éviter une interruption provoquée par des dégâts pendant que vous canalisez Projectiles des arcanes et 28 % de chances pendant que vous lancez Déflagration des arcanes."
              },
              {
                spellId = 0,
                desc = "Vous confère 60 % de chances d’éviter une interruption provoquée par des dégâts pendant que vous canalisez Projectiles des arcanes et 42 % de chances pendant que vous lancez Déflagration des arcanes."
              },
              {
                spellId = 0,
                desc = "Vous confère 80 % de chances d’éviter une interruption provoquée par des dégâts pendant que vous canalisez Projectiles des arcanes et 56 % de chances pendant que vous lancez Déflagration des arcanes."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances d’éviter une interruption provoquée par des dégâts pendant que vous canalisez Projectiles des arcanes et 70 % de chances pendant que vous lancez Déflagration des arcanes."
              }
            }
          },
          {
            id = 105812,
            name = "Subtilité des arcanes",
            icon = "spell_holy_dispelmagic",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11210,
                desc = "Réduit de 8 la résistance de votre cible à tous les types de magie, et diminue de 15% la menace générée par vos sorts d'Arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit de 15 la résistance de votre cible à tous les types de magie, et diminue de 30% la menace générée par vos sorts d'Arcanes."
              }
            }
          },
          {
            id = 105811,
            name = "Absorption de magie",
            icon = "spell_nature_astralrecalgroup",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 29441,
                desc = "Augmente toutes les résistances de 5. Tous les sorts auxquels vous résistez entièrement restaurent 1 % de votre total de mana. Cet effet ne peut pas se déclencher plus d’une fois par seconde."
              },
              {
                spellId = 0,
                desc = "Augmente toutes les résistances de 10. Tous les sorts auxquels vous résistez entièrement restaurent 2 % de votre total de mana. Cet effet ne peut pas se déclencher plus d’une fois par seconde."
              }
            }
          },
          {
            id = 105810,
            name = "Concentration des arcanes",
            icon = "spell_shadow_manaburn",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11213,
                desc = "Vous confère 2 % de chances d’entrer dans un état d’Idées claires après qu’un sort de dégâts a touché une cible. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 4 % de chances d’entrer dans un état d’Idées claires après qu’un sort de dégâts a touché une cible. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 6 % de chances d’entrer dans un état d’Idées claires après qu’un sort de dégâts a touché une cible. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 8 % de chances d’entrer dans un état d’Idées claires après qu’un sort de dégâts a touché une cible. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              },
              {
                spellId = 0,
                desc = "Vous confère 10 % de chances d’entrer dans un état d’Idées claires après qu’un sort de dégâts a touché une cible. L’état d’Idées claires réduit de 100 % le coût en mana de votre prochain sort de dégâts."
              }
            }
          },
          {
            id = 105809,
            name = "Résistance des arcanes",
            icon = "spell_arcane_arcaneresilience",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 28574,
                desc = "Augmente votre armure d’un montant égal à 25 % de votre Intelligence."
              },
              {
                spellId = 0,
                desc = "Augmente votre armure d’un montant égal à 50 % de votre Intelligence."
              }
            }
          },
          {
            id = 105808,
            name = "Géométrie des arcanes",
            icon = "inv_ability_mage_radiantspark",
            row = 2,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11247,
                desc = "Augmente la portée de vos sorts des Arcanes de 3 m."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos sorts des Arcanes de 6 m."
              }
            }
          },
          {
            id = 105807,
            name = "Impact des arcanes",
            icon = "spell_nature_wispsplode",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11242,
                desc = "Augmente de 2 % les chances de coup critique de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances de coup critique de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les chances de coup critique de vos sorts des arcanes."
              }
            }
          },
          {
            id = 105806,
            name = "Déflagration des arcanes",
            icon = "spell_arcane_blast",
            row = 2,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 400574,
                desc = "Frappe la cible avec de l’énergie et lui inflige (71.4 % de la puissance des sorts) points de dégâts des arcanes. Chaque fois que vous lancez Déflagration des arcanes, les dégâts de tous vos autres sorts augmentent de 10 %, mais le coût en mana de Déflagration des arcanes augmente de 175 %. Effet cumulable jusqu’à 4 fois. Dure 8 sec ou jusqu’à ce que vous lanciez un autre sort de dégâts."
              }
            }
          },
          {
            id = 105805,
            name = "Sauvegarde des arcanes",
            icon = "spell_shadow_detectlesserinvisibility",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11252,
                desc = "Réduit de 17 % le mana perdu par point de dégâts subi lorsque votre sort Bouclier de mana est actif et augmente de 25 % les résistances conférées par votre sort Armure du mage."
              },
              {
                spellId = 0,
                desc = "Réduit de 33 % le mana perdu par point de dégâts subi lorsque votre sort Bouclier de mana est actif et augmente de 50 % les résistances conférées par votre sort Armure du mage."
              }
            }
          },
          {
            id = 105804,
            name = "Contresort amélioré",
            icon = "spell_frost_iceshock",
            row = 3,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11255,
                desc = "Votre Contresort réduit également la cible au silence pendant 2 s."
              },
              {
                spellId = 0,
                desc = "Votre Contresort réduit également la cible au silence pendant 4 s."
              }
            }
          },
          {
            id = 105803,
            name = "Méditation des arcanes",
            icon = "spell_shadow_siphonmana",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {
              {
                id = 105810,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 18462,
                desc = "Vous confère 17% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 33% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 50% de votre vitesse de récupération du mana normale pendant l'incantation."
              }
            }
          },
          {
            id = 105802,
            name = "Barrage de projectiles",
            icon = "ability_mage_missilebarrage",
            row = 3,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 400588,
                desc = "Confère à votre sort Déflagration des arcanes 40 % de chances, et à vos sorts Boule de feu, Éclair de givre et Éclair de givrefeu 20 % de chances de réduire de 50 % la durée de canalisation de votre prochain sort Projectiles des arcanes, de réduire son coût en mana de 100 % et de faire tirer des projectiles toutes les 0.5 s."
              }
            }
          },
          {
            id = 105801,
            name = "Présence spirituelle",
            icon = "spell_nature_enchantarmor",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12043,
                desc = "Lorsque cette technique est activée, votre prochain sort de mage dont le temps d'incantation est inférieur à 10 sec. devient un sort instantané."
              }
            }
          },
          {
            id = 105800,
            name = "Esprit des arcanes",
            icon = "spell_shadow_charm",
            row = 4,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11232,
                desc = "Augmente de 2 % votre intelligence et de 20 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % votre intelligence et de 40 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % votre intelligence et de 60 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % votre intelligence et de 80 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts des arcanes."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % votre intelligence et de 100 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts des arcanes."
              }
            }
          },
          {
            id = 105799,
            name = "Instabilité des arcanes",
            icon = "spell_shadow_teleport",
            row = 5,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 15058,
                desc = "Augmente de 1 % les dégâts infligés par tous vos sorts et de 1 % vos chances de coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les dégâts infligés par tous vos sorts et de 2 % vos chances de coup critique avec toutes vos attaques."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les dégâts infligés par tous vos sorts et de 3 % vos chances de coup critique avec toutes vos attaques."
              }
            }
          },
          {
            id = 105798,
            name = "Pouvoir des arcanes",
            icon = "spell_nature_lightning",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105801,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 12042,
                desc = "Pendant 15 sec, vos sorts infligent 30 % de points de dégâts supplémentaires et ils vous coûtent 30 % de points de mana supplémentaires."
              }
            }
          }
        }
      },
      {
        id = 41,
        name = "Feu",
        slug = "feu",
        order = 1,
        icon = "spell_fire_firebolt02",
        talents = {
          {
            id = 105797,
            name = "Sillage de feu",
            icon = "spell_fire_lavaspawn",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11078,
                desc = "Réduit le temps de recharge de votre sort Trait de feu de 1 s. L’élimination d’une cible non négligeable augmente de 25 % les chances de coup critique de votre sort Trait de feu lancé dans les 20 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre sort Trait de feu de 2 s. L’élimination d’une cible non négligeable augmente de 50 % les chances de coup critique de votre sort Trait de feu lancé dans les 20 sec."
              }
            }
          },
          {
            id = 105796,
            name = "Incinération",
            icon = "spell_fire_flameshock",
            row = 0,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18459,
                desc = "Augmente de 2 % les chances de coup critique de vos sorts Trait de feu, Javelot de glace, Déflagration des arcanes et Brûlure."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances de coup critique de vos sorts Trait de feu, Javelot de glace, Déflagration des arcanes et Brûlure."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les chances de coup critique de vos sorts Trait de feu, Javelot de glace, Déflagration des arcanes et Brûlure."
              }
            }
          },
          {
            id = 105795,
            name = "Boule de feu améliorée",
            icon = "spell_fire_flamebolt",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11069,
                desc = "Réduit le temps d’incantation de vos sorts Boule de feu et Éclair de givrefeu de 0.1 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Boule de feu et Éclair de givrefeu de 0.2 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Boule de feu et Éclair de givrefeu de 0.3 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Boule de feu et Éclair de givrefeu de 0.4 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts Boule de feu et Éclair de givrefeu de 0.5 s."
              }
            }
          },
          {
            id = 105794,
            name = "Enflammer",
            icon = "spell_fire_incinerate",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11119,
                desc = "Les coups critiques de vos sorts de feu embrasent la cible pendant 4 sec, lui infligeant un montant de dégâts supplémentaires égal à 8 % des dégâts de votre sort."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de vos sorts de feu embrasent la cible pendant 4 sec, lui infligeant un montant de dégâts supplémentaires égal à 16 % des dégâts de votre sort."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de vos sorts de feu embrasent la cible pendant 4 sec, lui infligeant un montant de dégâts supplémentaires égal à 24 % des dégâts de votre sort."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de vos sorts de feu embrasent la cible pendant 4 sec, lui infligeant un montant de dégâts supplémentaires égal à 32 % des dégâts de votre sort."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de vos sorts de feu embrasent la cible pendant 4 sec, lui infligeant un montant de dégâts supplémentaires égal à 40 % des dégâts de votre sort."
              }
            }
          },
          {
            id = 105793,
            name = "Jet de flammes",
            icon = "spell_fire_flare",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11100,
                desc = "Augmente la portée de vos sorts de Feu de 3 mètres."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos sorts de Feu de 6 mètres."
              }
            }
          },
          {
            id = 105792,
            name = "Impact",
            icon = "spell_fire_meteorstorm",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11103,
                desc = "Confère 3 % de chances à vos sorts de Feu d’étourdir vos cibles pendant 2 sec."
              },
              {
                spellId = 0,
                desc = "Confère 7 % de chances à vos sorts de Feu d’étourdir vos cibles pendant 2 sec."
              },
              {
                spellId = 0,
                desc = "Confère 10 % de chances à vos sorts de Feu d’étourdir vos cibles pendant 2 sec."
              }
            }
          },
          {
            id = 105789,
            name = "Ame ardente",
            icon = "spell_fire_fire",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11083,
                desc = "Vos sorts de Feu gagnent 23% de chances de ne pas être retardés lorsque vous subissez des dégâts pendant l'incantation, et la menace qu'ils génèrent est réduite de 10%."
              },
              {
                spellId = 0,
                desc = "Vos sorts de Feu gagnent 47% de chances de ne pas être retardés lorsque vous subissez des dégâts pendant l'incantation, et la menace qu'ils génèrent est réduite de 20%."
              },
              {
                spellId = 0,
                desc = "Vos sorts de Feu gagnent 70% de chances de ne pas être retardés lorsque vous subissez des dégâts pendant l'incantation, et la menace qu'ils génèrent est réduite de 30%."
              }
            }
          },
          {
            id = 105791,
            name = "Choc de flammes amélioré",
            icon = "spell_fire_selfdestruct",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11108,
                desc = "Augmente de 5% vos chances de réaliser un coup critique avec votre sort Choc de flammes."
              },
              {
                spellId = 0,
                desc = "Augmente de 10% vos chances de réaliser un coup critique avec votre sort Choc de flammes."
              },
              {
                spellId = 0,
                desc = "Augmente de 15% vos chances de réaliser un coup critique avec votre sort Choc de flammes."
              }
            }
          },
          {
            id = 105790,
            name = "Explosion pyrotechnique",
            icon = "spell_fire_fireball02",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 11366,
                desc = "Lance un immense rocher enflammé qui inflige (100 % de la puissance des sorts) points de dégâts de Feu et (60 % de la puissance des sorts) points de dégâts de Feu supplémentaires en 12 sec."
              }
            }
          },
          {
            id = 105788,
            name = "Brûlure améliorée",
            icon = "spell_fire_windsofwoe",
            row = 3,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11095,
                desc = "Votre sort Brûlure a 33 % de chances de rendre votre cible vulnérable aux dégâts de feu. Cette vulnérabilité augmente tous les dégâts de feu que vous infligez à votre cible de 3 % et dure 30 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Votre sort Brûlure a 67 % de chances de rendre votre cible vulnérable aux dégâts de feu. Cette vulnérabilité augmente tous les dégâts de feu que vous infligez à votre cible de 3 % et dure 30 sec. Cumulable jusqu’à 5 fois."
              },
              {
                spellId = 0,
                desc = "Votre sort Brûlure a 100 % de chances de rendre votre cible vulnérable aux dégâts de feu. Cette vulnérabilité augmente tous les dégâts de feu que vous infligez à votre cible de 3 % et dure 30 sec. Cumulable jusqu’à 5 fois."
              }
            }
          },
          {
            id = 105787,
            name = "Gardien de feu amélioré",
            icon = "spell_fire_firearmor",
            row = 3,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11094,
                desc = "Confère à votre Gardien de feu 10% de chances de renvoyer les sorts de Feu tant qu'il est actif."
              },
              {
                spellId = 0,
                desc = "Confère à votre Gardien de feu 20% de chances de renvoyer les sorts de Feu tant qu'il est actif."
              }
            }
          },
          {
            id = 105786,
            name = "Bonne série",
            icon = "ability_mage_hotstreak",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 105790,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 400624,
                desc = "Vos coups critiques non périodiques obtenus avec Boule de feu, Éclair de givrefeu, Trait de feu et Brûlure vous confèrent Bonne série pendant 15 sec. Bonne série réduit de 25 % le temps d’incantation d'Explosion pyrotechnique et est cumulable jusqu’à 3 fois."
              }
            }
          },
          {
            id = 105785,
            name = "Maître des éléments",
            icon = "spell_fire_masterofelements",
            row = 3,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 29074,
                desc = "Vos coups critiques de feu et de givre vous rendent 10 % du coût en mana de base de ces sorts."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques de feu et de givre vous rendent 20 % du coût en mana de base de ces sorts."
              },
              {
                spellId = 0,
                desc = "Vos coups critiques de feu et de givre vous rendent 30 % du coût en mana de base de ces sorts."
              }
            }
          },
          {
            id = 105784,
            name = "Masse critique",
            icon = "spell_nature_wispheal",
            row = 4,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11115,
                desc = "Augmente de 2% vos chances d'infliger un coup critique avec vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 4% vos chances d'infliger un coup critique avec vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 6% vos chances d'infliger un coup critique avec vos sorts de Feu."
              }
            }
          },
          {
            id = 105783,
            name = "Vague explosive",
            icon = "spell_holy_excorcism_02",
            row = 4,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 11113,
                desc = "Une vague de flammes se propage autour du personnage lanceur, infligeant (12.9 % de la puissance des sorts) points de dégâts de feu aux personnages adverses pris dans l’explosion et les hébétant pendant 6 sec, ce qui réduit leur vitesse de déplacement de 50 %."
              }
            }
          },
          {
            id = 105782,
            name = "Puissance du feu",
            icon = "spell_fire_immolation",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11124,
                desc = "Augmente de 2% les points de dégâts infligés par vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 4% les points de dégâts infligés par vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 6% les points de dégâts infligés par vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 8% les points de dégâts infligés par vos sorts de Feu."
              },
              {
                spellId = 0,
                desc = "Augmente de 10% les points de dégâts infligés par vos sorts de Feu."
              }
            }
          },
          {
            id = 105781,
            name = "Combustion",
            icon = "spell_fire_sealoffire",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105784,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 11129,
                desc = "Lorsqu’il est activé, ce sort augmente de 10 % les chances de coup critique chaque fois que vous touchez une cible avec un sort de feu. L’effet dure jusqu’à ce que vous ayez infligé 4 coups critiques non périodiques avec des sorts de feu."
              }
            }
          }
        }
      },
      {
        id = 61,
        name = "Givre",
        slug = "givre",
        order = 2,
        icon = "spell_frost_frostbolt02",
        talents = {
          {
            id = 105780,
            name = "Protection contre le Givre",
            icon = "spell_frost_frostward",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11189,
                desc = "Augmente de 15 % l’armure et la résistance conférées par vos sorts Armure de givre et Armure de glace. Votre Gardien de givre a également 10 % de chances de renvoyer les sorts et effets de givre tant qu’il est actif."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % l’armure et la résistance conférées par vos sorts Armure de givre et Armure de glace. Votre Gardien de givre a également 20 % de chances de renvoyer les sorts et effets de givre tant qu’il est actif."
              }
            }
          },
          {
            id = 105779,
            name = "Eclair de givre amélioré",
            icon = "spell_frost_frostbolt02",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11070,
                desc = "Réduit le temps d’incantation de votre sort Éclair de givre de 0.1 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Éclair de givre de 0.2 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Éclair de givre de 0.3 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Éclair de givre de 0.4 s."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Éclair de givre de 0.5 s."
              }
            }
          },
          {
            id = 105778,
            name = "Précision élémentaire",
            icon = "spell_ice_magicdamage",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 29438,
                desc = "Améliore de 1 % vos chances de toucher avec les sorts de feu et de givre."
              },
              {
                spellId = 0,
                desc = "Améliore de 2 % vos chances de toucher avec les sorts de feu et de givre."
              },
              {
                spellId = 0,
                desc = "Améliore de 3 % vos chances de toucher avec les sorts de feu et de givre."
              },
              {
                spellId = 0,
                desc = "Améliore de 4 % vos chances de toucher avec les sorts de feu et de givre."
              },
              {
                spellId = 0,
                desc = "Améliore de 5 % vos chances de toucher avec les sorts de feu et de givre."
              }
            }
          },
          {
            id = 105777,
            name = "Eclats de glace",
            icon = "spell_frost_iceshard",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11207,
                desc = "Augmente de 20% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 40% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 60% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 80% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Givre."
              },
              {
                spellId = 0,
                desc = "Augmente de 100% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Givre."
              }
            }
          },
          {
            id = 105776,
            name = "Gel prolongé",
            icon = "spell_frost_wisp",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11175,
                desc = "Augmente de 11 % la durée de vos effets d’engourdissement et réduit la vitesse de la cible de 3 % supplémentaires."
              },
              {
                spellId = 0,
                desc = "Augmente de 22 % la durée de vos effets d’engourdissement et réduit la vitesse de la cible de 7 % supplémentaires."
              },
              {
                spellId = 0,
                desc = "Augmente de 33 % la durée de vos effets d’engourdissement et réduit la vitesse de la cible de 10 % supplémentaires."
              }
            }
          },
          {
            id = 105775,
            name = "Nova de givre améliorée",
            icon = "spell_frost_freezingbreath",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 11165,
                desc = "Réduit le temps de recharge du sort Nova de givre de 2 secondes."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge du sort Nova de givre de 4 secondes."
              }
            }
          },
          {
            id = 105774,
            name = "Morsure de givre",
            icon = "spell_frost_frostarmor",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11071,
                desc = "Confère 5 % de chances à vos effets d’engourdissement de geler la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère 10 % de chances à vos effets d’engourdissement de geler la cible pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Confère 15 % de chances à vos effets d’engourdissement de geler la cible pendant 5 sec."
              }
            }
          },
          {
            id = 105773,
            name = "Glace perçante",
            icon = "spell_frost_frostbolt",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11151,
                desc = "Augmente les points de dégâts infligés par vos sorts de Givre de 2%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par vos sorts de Givre de 4%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts infligés par vos sorts de Givre de 6%."
              }
            }
          },
          {
            id = 105772,
            name = "Canalisation du givre",
            icon = "spell_frost_stun",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11160,
                desc = "Réduit de 5% le coût en mana de vos sorts de Givre, et réduit de 10% la menace qu'ils génèrent."
              },
              {
                spellId = 0,
                desc = "Réduit de 10% le coût en mana de vos sorts de Givre, et réduit de 20% la menace qu'ils génèrent."
              },
              {
                spellId = 0,
                desc = "Réduit de 15% le coût en mana de vos sorts de Givre, et réduit de 30% la menace qu'ils génèrent."
              }
            }
          },
          {
            id = 105767,
            name = "Javelot de glace",
            icon = "spell_frost_frostblast",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1312002,
                desc = "Inflige 30 points de dégâts de givre à une cible ennemie. Inflige 300 % de dégâts de givre supplémentaires aux cibles gelées."
              }
            }
          },
          {
            id = 105771,
            name = "Blizzard amélioré",
            icon = "spell_frost_icestorm",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11185,
                desc = "Ajoute un effet d’engourdissement à votre sort Blizzard. Il réduit la vitesse de déplacement de la cible de 15 % pendant 1.5 s."
              },
              {
                spellId = 0,
                desc = "Ajoute un effet d’engourdissement à votre sort Blizzard. Il réduit la vitesse de déplacement de la cible de 25 % pendant 1.5 s."
              },
              {
                spellId = 0,
                desc = "Ajoute un effet d’engourdissement à votre sort Blizzard. Il réduit la vitesse de déplacement de la cible de 40 % pendant 1.5 s."
              }
            }
          },
          {
            id = 105770,
            name = "Allonge arctique",
            icon = "spell_shadow_darkritual",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16757,
                desc = "Augmente la portée de vos sorts Eclair de givre et Blizzard et les rayons d'effet de vos sorts Nova de givre et Cône de froid de 10%."
              },
              {
                spellId = 0,
                desc = "Augmente la portée de vos sorts Eclair de givre et Blizzard et les rayons d'effet de vos sorts Nova de givre et Cône de froid de 20%."
              }
            }
          },
          {
            id = 105769,
            name = "Bloc de glace",
            icon = "spell_frost_frost",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 11958,
                desc = "Vous enveloppe dans un bloc de glace qui vous protège des attaques physiques et des sorts pendant 10 sec. En contrepartie, vous ne pouvez pas attaquer, vous déplacer ni lancer de sorts."
              }
            }
          },
          {
            id = 105768,
            name = "Fracasser",
            icon = "spell_frost_frostshock",
            row = 3,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11170,
                desc = "Augmente de 17 % les chances de coup critique de tous vos sorts contre les cibles gelées."
              },
              {
                spellId = 0,
                desc = "Augmente de 33 % les chances de coup critique de tous vos sorts contre les cibles gelées."
              },
              {
                spellId = 0,
                desc = "Augmente de 50 % les chances de coup critique de tous vos sorts contre les cibles gelées."
              }
            }
          },
          {
            id = 105765,
            name = "Cône de froid amélioré",
            icon = "spell_frost_glacier",
            row = 4,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 11190,
                desc = "Augmente de 12% les points de dégâts infligés par votre sort Cône de froid."
              },
              {
                spellId = 0,
                desc = "Augmente de 23% les points de dégâts infligés par votre sort Cône de froid."
              },
              {
                spellId = 0,
                desc = "Augmente de 35% les points de dégâts infligés par votre sort Cône de froid."
              }
            }
          },
          {
            id = 105766,
            name = "Morsure du froid",
            icon = "spell_frost_wizardmark",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 12472,
                desc = "Réinitialise les temps de recharge restants de tous vos autres sorts de givre."
              }
            }
          },
          {
            id = 105764,
            name = "Doigts de givre",
            icon = "ability_mage_wintersgrasp",
            row = 4,
            col = 2,
            maxRank = 2,
            requires = {
              {
                id = 105767,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 400647,
                desc = "Donne à vos effets d’engourdissement 15 % de chances de déclencher l’effet Doigts de givre, qui permet à 1 prochains sorts d’agir comme si la cible était gelée. Dure 15 sec."
              },
              {
                spellId = 0,
                desc = "Donne à vos effets d’engourdissement 15 % de chances de déclencher l’effet Doigts de givre, qui permet à 2 prochains sorts d’agir comme si la cible était gelée. Dure 15 sec."
              }
            }
          },
          {
            id = 105763,
            name = "Froid hivernal",
            icon = "spell_frost_chillingblast",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 11180,
                desc = "Confère à vos sorts de givre 20 % de chances d’appliquer l’effet Froid de l’hiver, qui augmente de 2 % les chances que vos sorts Javelot de glace et Éclair de givre infligent un coup critique à la cible pendant 15 sec. Cumulable jusqu’à 1 fois."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts de givre 40 % de chances d’appliquer l’effet Froid de l’hiver, qui augmente de 2 % les chances que vos sorts Javelot de glace et Éclair de givre infligent un coup critique à la cible pendant 15 sec. Cumulable jusqu’à 2 fois."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts de givre 60 % de chances d’appliquer l’effet Froid de l’hiver, qui augmente de 2 % les chances que vos sorts Javelot de glace et Éclair de givre infligent un coup critique à la cible pendant 15 sec. Cumulable jusqu’à 3 fois."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts de givre 80 % de chances d’appliquer l’effet Froid de l’hiver, qui augmente de 2 % les chances que vos sorts Javelot de glace et Éclair de givre infligent un coup critique à la cible pendant 15 sec. Cumulable jusqu’à 4 fois."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts de givre 100 % de chances d’appliquer l’effet Froid de l’hiver, qui augmente de 2 % les chances que vos sorts Javelot de glace et Éclair de givre infligent un coup critique à la cible pendant 15 sec. Cumulable jusqu’à 5 fois."
              }
            }
          },
          {
            id = 105762,
            name = "Barrière de glace",
            icon = "spell_ice_lament",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105766,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 11426,
                desc = "Vous protège instantanément à l’aide d’un bouclier magique qui absorbe 448 points de dégâts. Dure 1 min. Tant que le bouclier est actif, les incantations de sorts ne peuvent pas être interrompues ou retardées par les dégâts subis."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 9,
    slug = "demoniste",
    name = "Démoniste",
    color = "#9482C9",
    icon = "class_warlock",
    trees = {
      {
        id = 302,
        name = "Affliction",
        slug = "affliction",
        order = 0,
        icon = "spell_shadow_deathcoil",
        talents = {
          {
            id = 105921,
            name = "Connexion améliorée",
            icon = "spell_shadow_burningspirit",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 18182,
                desc = "Augmente de 10% le montant de points de mana gagné par votre sort Connexion."
              },
              {
                spellId = 0,
                desc = "Augmente de 20% le montant de points de mana gagné par votre sort Connexion."
              }
            }
          },
          {
            id = 105925,
            name = "Suppression",
            icon = "spell_shadow_unsummonbuilding",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18174,
                desc = "Améliore de 1 % vos chances de toucher et réduit le niveau de menace que vous générez de 4 %."
              },
              {
                spellId = 0,
                desc = "Améliore de 2 % vos chances de toucher et réduit le niveau de menace que vous générez de 8 %."
              },
              {
                spellId = 0,
                desc = "Améliore de 3 % vos chances de toucher et réduit le niveau de menace que vous générez de 12 %."
              },
              {
                spellId = 0,
                desc = "Améliore de 4 % vos chances de toucher et réduit le niveau de menace que vous générez de 16 %."
              },
              {
                spellId = 0,
                desc = "Améliore de 5 % vos chances de toucher et réduit le niveau de menace que vous générez de 20 %."
              }
            }
          },
          {
            id = 105924,
            name = "Corruption améliorée",
            icon = "spell_shadow_abominationexplosion",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17810,
                desc = "Réduit le temps d’incantation de votre sort Corruption de 0.4 s et augmente les dégâts qu’il inflige de 2 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Corruption de 0.8 s et augmente les dégâts qu’il inflige de 4 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Corruption de 1.2 s et augmente les dégâts qu’il inflige de 6 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Corruption de 1.6 s et augmente les dégâts qu’il inflige de 8 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Corruption de 2 s et augmente les dégâts qu’il inflige de 10 %."
              }
            }
          },
          {
            id = 105923,
            name = "Malédiction",
            icon = "spell_shadow_curseofachimonde",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1225177,
                desc = "Augmente les dégâts périodiques de vos sorts de démoniste de 1 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts périodiques de vos sorts de démoniste de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts périodiques de vos sorts de démoniste de 3 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts périodiques de vos sorts de démoniste de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts périodiques de vos sorts de démoniste de 5 %."
              }
            }
          },
          {
            id = 105922,
            name = "Moisson d’âme",
            icon = "inv_elemental_primal_shadow",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 437032,
                desc = "Vous bénéficiez de Récolte d’âmes pendant 10 sec si une victime meurt alors qu’elle est affectée par votre Drain d’âme. Récolte d’âmes permet à votre mana de se régénérer à 50 % de la vitesse normale lorsque vous lancez des sorts et augmente votre régénération de mana de 50 %."
              },
              {
                spellId = 0,
                desc = "Vous bénéficiez de Récolte d’âmes pendant 10 sec si une victime meurt alors qu’elle est affectée par votre Drain d’âme. Récolte d’âmes permet à votre mana de se régénérer à 100 % de la vitesse normale lorsque vous lancez des sorts et augmente votre régénération de mana de 100 %."
              }
            }
          },
          {
            id = 105920,
            name = "Drains améliorés",
            icon = "spell_shadow_haunting",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 403511,
                desc = "Augmente de 7 % les points de vie drainés ou les dégâts infligés par vos sorts Drain de vie, Drain d’âme et Calvaire."
              },
              {
                spellId = 0,
                desc = "Augmente de 13 % les points de vie drainés ou les dégâts infligés par vos sorts Drain de vie, Drain d’âme et Calvaire."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les points de vie drainés ou les dégâts infligés par vos sorts Drain de vie, Drain d’âme et Calvaire."
              }
            }
          },
          {
            id = 105919,
            name = "Plaie d’agonie améliorée",
            icon = "spell_shadow_curseofsargeras",
            row = 2,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 18827,
                desc = "Augmente de 5 % les dégâts infligés par votre sort Plaie d’agonie."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par votre sort Plaie d’agonie."
              }
            }
          },
          {
            id = 105918,
            name = "Concentration corrompue",
            icon = "spell_shadow_fingerofdeath",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17783,
                desc = "Vous confère 23 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous canalisez ou lancez un sort Drain de vie, Drain de mana, Drain d’âme ou Calvaire."
              },
              {
                spellId = 0,
                desc = "Vous confère 47 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous canalisez ou lancez un sort Drain de vie, Drain de mana, Drain d’âme ou Calvaire."
              },
              {
                spellId = 0,
                desc = "Vous confère 70 % de chances d’éviter l’interruption de vos incantations par des dégâts lorsque vous canalisez ou lancez un sort Drain de vie, Drain de mana, Drain d’âme ou Calvaire."
              }
            }
          },
          {
            id = 105916,
            name = "Malédiction amplifiée",
            icon = "spell_shadow_contagion",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 18288,
                desc = "Augmente de 50 % l’effet de votre prochaine Malédiction de faiblesse ou Plaie d’agonie, ou de 20 % celui de votre prochaine Malédiction de fatigue. Dure 30 sec."
              }
            }
          },
          {
            id = 105917,
            name = "Pandémie",
            icon = "spell_shadow_unstableaffliction_2",
            row = 2,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 427712,
                desc = "Augmente de 33 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts Corruption, Plaie d’agonie, Plaie funeste, Drain d’âme, Drain de vie, Siphon de vie et Calvaire."
              },
              {
                spellId = 0,
                desc = "Augmente de 67 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts Corruption, Plaie d’agonie, Plaie funeste, Drain d’âme, Drain de vie, Siphon de vie et Calvaire."
              },
              {
                spellId = 0,
                desc = "Augmente de 100 % les points de dégâts supplémentaires infligés par les coups critiques de vos sorts Corruption, Plaie d’agonie, Plaie funeste, Drain d’âme, Drain de vie, Siphon de vie et Calvaire."
              }
            }
          },
          {
            id = 110876,
            name = "Malveillance",
            icon = "spell_shadow_focusedpower",
            row = 3,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1310949,
                desc = "Augmente de 1 % les chances d’obtenir un effet critique avec vos sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les chances d’obtenir un effet critique avec vos sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les chances d’obtenir un effet critique avec vos sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les chances d’obtenir un effet critique avec vos sorts d’ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les chances d’obtenir un effet critique avec vos sorts d’ombre."
              }
            }
          },
          {
            id = 105914,
            name = "Crépuscule",
            icon = "spell_shadow_twilight",
            row = 3,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 18094,
                desc = "Confère à vos sorts Corruption, Drain d’âme, Drain de vie et Calvaire 2 % de chances de vous plonger dans une Transe de l’ombre après avoir infligé des dégâts à votre adversaire. Cet état réduit le temps d’incantation de votre prochain sort Trait de l’ombre de 100 %."
              },
              {
                spellId = 0,
                desc = "Confère à vos sorts Corruption, Drain d’âme, Drain de vie et Calvaire 4 % de chances de vous plonger dans une Transe de l’ombre après avoir infligé des dégâts à votre adversaire. Cet état réduit le temps d’incantation de votre prochain sort Trait de l’ombre de 100 %."
              }
            }
          },
          {
            id = 105913,
            name = "Malédiction de fatigue",
            icon = "spell_shadow_grimward",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 105916,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 18223,
                desc = "Réduit la vitesse de la cible de 30% pendant 12 sec. La cible ne peut être victime que d'une malédiction par démoniste présent à la fois."
              }
            }
          },
          {
            id = 105912,
            name = "Siphon de vie",
            icon = "spell_shadow_requiem",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 18265,
                desc = "Transfère 11 points de vie de la cible vers le lanceur ou la lanceuse toutes les 3 s. Dure 30 sec."
              }
            }
          },
          {
            id = 105911,
            name = "Ponction d’âme",
            icon = "spell_shadow_lifedrain02",
            row = 4,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17804,
                desc = "Augmente de 4 % les dégâts infligés ou les points de vie drainés par vos sorts Drain de vie, Drain d’âme et Calvaire pour chacun de vos autres effets d’Affliction actifs sur la cible, jusqu’à un maximum de 12 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % les dégâts infligés ou les points de vie drainés par vos sorts Drain de vie, Drain d’âme et Calvaire pour chacun de vos autres effets d’Affliction actifs sur la cible, jusqu’à un maximum de 24 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 12 % les dégâts infligés ou les points de vie drainés par vos sorts Drain de vie, Drain d’âme et Calvaire pour chacun de vos autres effets d’Affliction actifs sur la cible, jusqu’à un maximum de 36 %."
              }
            }
          },
          {
            id = 105910,
            name = "Maîtrise de l'ombre",
            icon = "spell_shadow_shadetruesight",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18271,
                desc = "Augmente de 1% les points de dégâts infligés ou les points de vie drainés par vos sorts d'Ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 2% les points de dégâts infligés ou les points de vie drainés par vos sorts d'Ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 3% les points de dégâts infligés ou les points de vie drainés par vos sorts d'Ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 4% les points de dégâts infligés ou les points de vie drainés par vos sorts d'Ombre."
              },
              {
                spellId = 0,
                desc = "Augmente de 5% les points de dégâts infligés ou les points de vie drainés par vos sorts d'Ombre."
              }
            }
          },
          {
            id = 105909,
            name = "Calvaire",
            icon = "ability_deathknight_hemorrhagicfever",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105912,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 1316697,
                desc = "Déchire la cible de l’intérieur, ce qui lui inflige (36 % de la puissance des sorts) points de dégâts d’ombre toutes les 1 s et augmente les dégâts qu’elle subit par vos autres effets de dégâts d’ombre de 10 %. Dure 6 sec."
              }
            }
          }
        }
      },
      {
        id = 303,
        name = "Démonologie",
        slug = "demonologie",
        order = 1,
        icon = "spell_shadow_metamorphosis",
        talents = {
          {
            id = 105905,
            name = "Captation de vie améliorée",
            icon = "spell_shadow_lifedrain",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 18703,
                desc = "Augmente le nombre de points de vie transférés par votre sort Captation de vie de 20 %, réduit de 15 % son coût en points de vie et réduit de 50 % le niveau de menace qu’il génère. Vous pouvez utiliser Captation de vie quel que soit le nombre de points de vie de votre familier."
              },
              {
                spellId = 0,
                desc = "Augmente le nombre de points de vie transférés par votre sort Captation de vie de 40 %, réduit de 30 % son coût en points de vie et réduit de 100 % le niveau de menace qu’il génère. Vous pouvez utiliser Captation de vie quel que soit le nombre de points de vie de votre familier."
              }
            }
          },
          {
            id = 105908,
            name = "Diablotin amélioré",
            icon = "spell_shadow_summonimp",
            row = 0,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18694,
                desc = "Augmente les dégâts du sort Éclair de feu de votre diablotin de 10 % et l’effet de son Bouclier de feu de 10 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts du sort Éclair de feu de votre diablotin de 20 % et l’effet de son Bouclier de feu de 20 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts du sort Éclair de feu de votre diablotin de 30 % et l’effet de son Bouclier de feu de 30 %."
              }
            }
          },
          {
            id = 105907,
            name = "Baiser démoniaque",
            icon = "spell_shadow_metamorphosis",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18697,
                desc = "Augmente votre total d'Endurance de 3%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Endurance de 6%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Endurance de 9%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Endurance de 12%."
              },
              {
                spellId = 0,
                desc = "Augmente votre total d'Endurance de 15%."
              }
            }
          },
          {
            id = 105906,
            name = "Puissance impie",
            icon = "spell_shadow_shadowworddominate",
            row = 0,
            col = 3,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18769,
                desc = "Augmente de 2 % les dégâts infligés par vos familiers Diablotin, Marcheur du Vide, Succube, Incube et Chasseur corrompu."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les dégâts infligés par vos familiers Diablotin, Marcheur du Vide, Succube, Incube et Chasseur corrompu."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % les dégâts infligés par vos familiers Diablotin, Marcheur du Vide, Succube, Incube et Chasseur corrompu."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % les dégâts infligés par vos familiers Diablotin, Marcheur du Vide, Succube, Incube et Chasseur corrompu."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par vos familiers Diablotin, Marcheur du Vide, Succube, Incube et Chasseur corrompu."
              }
            }
          },
          {
            id = 105902,
            name = "Égide démoniaque",
            icon = "spell_shadow_ragingscream",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1235316,
                desc = "Augmente de 15 % l’efficacité de vos sorts Peau de démon et Armure démoniaque."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % l’efficacité de vos sorts Peau de démon et Armure démoniaque."
              }
            }
          },
          {
            id = 105904,
            name = "Marcheur du Vide amélioré",
            icon = "spell_shadow_summonvoidwalker",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18705,
                desc = "Augmente de 10 % l’efficacité des sorts Tourment, Consumer les ombres, Sacrifice et Souffrance de votre Marcheur du Vide."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % l’efficacité des sorts Tourment, Consumer les ombres, Sacrifice et Souffrance de votre Marcheur du Vide."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % l’efficacité des sorts Tourment, Consumer les ombres, Sacrifice et Souffrance de votre Marcheur du Vide."
              }
            }
          },
          {
            id = 105903,
            name = "Vitalité gangrenée",
            icon = "spell_shadow_demonictactics",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18731,
                desc = "Augmente de 5 % le maximum de points de vie et de mana de vos diablotins, marcheurs du Vide, succubes, incubes et chasseurs corrompus. De plus, augmente votre maximum de mana de 5 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % le maximum de points de vie et de mana de vos diablotins, marcheurs du Vide, succubes, incubes et chasseurs corrompus. De plus, augmente votre maximum de mana de 10 %."
              },
              {
                spellId = 0,
                desc = "Augmente de 15 % le maximum de points de vie et de mana de vos diablotins, marcheurs du Vide, succubes, incubes et chasseurs corrompus. De plus, augmente votre maximum de mana de 15 %."
              }
            }
          },
          {
            id = 105899,
            name = "Énergie démoniaque",
            icon = "spell_shadow_felmending",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1225214,
                desc = "Vous soignez votre familier d’un montant égal à 8 % de tous les dégâts des sorts que vous infligez. Lorsque vous obtenez du mana avec Connexion, votre démon invoqué reçoit 50 % du mana que vous récupérez."
              },
              {
                spellId = 0,
                desc = "Vous soignez votre familier d’un montant égal à 15 % de tous les dégâts des sorts que vous infligez. Lorsque vous obtenez du mana avec Connexion, votre démon invoqué reçoit 100 % du mana que vous récupérez."
              }
            }
          },
          {
            id = 105901,
            name = "Sayaad amélioré",
            icon = "ability_warlock_randomizesuccubusincubus",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18754,
                desc = "Augmente de 10% les effets des techniques Fouet de la douleur et Baiser apaisant de votre succube et de votre incube. Augmente également la durée des techniques Séduction et Invisibilité inférieure de 10%."
              },
              {
                spellId = 0,
                desc = "Augmente de 20% les effets des techniques Fouet de la douleur et Baiser apaisant de votre succube et de votre incube. Augmente également la durée des techniques Séduction et Invisibilité inférieure de 20%."
              },
              {
                spellId = 0,
                desc = "Augmente de 30% les effets des techniques Fouet de la douleur et Baiser apaisant de votre succube et de votre incube. Augmente également la durée des techniques Séduction et Invisibilité inférieure de 30%."
              }
            }
          },
          {
            id = 105900,
            name = "Sacrifice démoniaque",
            icon = "spell_shadow_psychicscream",
            row = 2,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 18788,
                desc = "À l’activation, sacrifie votre démon invoqué pour renforcer l’aspect opposé de votre pouvoir et vous confère un effet qui dure 2 heures. L’effet est annulé si un démon est invoqué.<br>Diablotin : augmente vos dégâts d’ombre de 15 %.<br>Marcheur du Vide : restaure 2 % de votre total de mana toutes les 4 s.<br>Succube/Incube : augmente vos dégâts de feu de 15 %.<br>Chasseur corrompu : restaure 3 % de votre total de points de vie toutes les 4 s."
              }
            }
          },
          {
            id = 105898,
            name = "Maître invocateur",
            icon = "spell_shadow_impphaseshift",
            row = 2,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 18709,
                desc = "Réduit le temps d’incantation de vos sorts d’invocations de diablotin, de succube, d’incube, de marcheur du Vide ou de chasseur corrompu de 2 s et leur coût en mana de 20%."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de vos sorts d’invocations de diablotin, de succube, d’incube, de marcheur du Vide ou de chasseur corrompu de 4 s et leur coût en mana de 40%."
              }
            }
          },
          {
            id = 105897,
            name = "Décimation",
            icon = "spell_fire_fireball02",
            row = 3,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 440870,
                desc = "Réduit le temps de recharge de votre sort Feu de l’âme de 45 %. Lorsque vous lancez Trait de l’ombre ou Douleur brûlante sur un personnage adverse avec moins de 35 % de ses points de vie, ces sorts infligent 3 % de dégâts supplémentaires. De plus, pendant 10 sec, votre sort Feu de l’âme voit son temps d’incantation réduit de 20 %, et il ne coûte aucun éclat d’âme."
              },
              {
                spellId = 0,
                desc = "Réduit le temps de recharge de votre sort Feu de l’âme de 90 %. Lorsque vous lancez Trait de l’ombre ou Douleur brûlante sur un personnage adverse avec moins de 35 % de ses points de vie, ces sorts infligent 6 % de dégâts supplémentaires. De plus, pendant 10 sec, votre sort Feu de l’âme voit son temps d’incantation réduit de 40 %, et il ne coûte aucun éclat d’âme."
              }
            }
          },
          {
            id = 105895,
            name = "Domination corrompue",
            icon = "spell_nature_removecurse",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 105898,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 18708,
                desc = "Le temps d’incantation de votre prochain sort d’invocation de diablotin, de marcheur du Vide, de succube, d’incube ou de chasseur corrompu est réduit de 5.5 s, et son coût en mana est réduit de 50%."
              }
            }
          },
          {
            id = 105896,
            name = "Marque démoniaque",
            icon = "ability_demonhunter_chaoticimprint_fire",
            row = 3,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1293695,
                desc = "Votre sort Douleur brûlante génère 17 % de menace en moins et marque la cible pendant 10 sec. Les 2 prochaines attaques de votre familier contre la cible génèrent un niveau de menace élevé et infligent entre 65 (+ 7.8 % de la puissance des sorts d’ombre) et 68 (+ 7.8 % de la puissance des sorts d’ombre) points de dégâts de feu ou d’ombre, selon votre familier."
              },
              {
                spellId = 0,
                desc = "Votre sort Douleur brûlante génère 33 % de menace en moins et marque la cible pendant 10 sec. Les 4 prochaines attaques de votre familier contre la cible génèrent un niveau de menace élevé et infligent entre 65 (+ 7.8 % de la puissance des sorts d’ombre) et 68 (+ 7.8 % de la puissance des sorts d’ombre) points de dégâts de feu ou d’ombre, selon votre familier."
              },
              {
                spellId = 0,
                desc = "Votre sort Douleur brûlante génère 50 % de menace en moins et marque la cible pendant 10 sec. Les 6 prochaines attaques de votre familier contre la cible génèrent un niveau de menace élevé et infligent entre 65 (+ 7.8 % de la puissance des sorts d’ombre) et 68 (+ 7.8 % de la puissance des sorts d’ombre) points de dégâts de feu ou d’ombre, selon votre familier."
              }
            }
          },
          {
            id = 105894,
            name = "Chasseur corrompu amélioré",
            icon = "spell_shadow_summonfelhunter",
            row = 4,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1225217,
                desc = "Augmente de 10 % la réduction de puissance d’attaque infligée par la technique Corruption sanguine de votre chasseur corrompu, les soins de sa technique Dévorer la magie, et le niveau de détection de sa technique Paranoïa. De plus, réduit le temps de recharge de sa technique Verrou magique de 2 s."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la réduction de puissance d’attaque infligée par la technique Corruption sanguine de votre chasseur corrompu, les soins de sa technique Dévorer la magie, et le niveau de détection de sa technique Paranoïa. De plus, réduit le temps de recharge de sa technique Verrou magique de 4 s."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % la réduction de puissance d’attaque infligée par la technique Corruption sanguine de votre chasseur corrompu, les soins de sa technique Dévorer la magie, et le niveau de détection de sa technique Paranoïa. De plus, réduit le temps de recharge de sa technique Verrou magique de 6 s."
              }
            }
          },
          {
            id = 105892,
            name = "Lien spirituel",
            icon = "spell_shadow_gathershadows",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105900,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 19028,
                desc = "À l’activation, 30 % de tous les dégâts subis par le personnage lanceur sont transférés à son démon Diablotin, Marcheur du Vide, Succube, Incube ou Chasseur corrompu. De plus, le démon et son maître infligent tous deux 3 % de dégâts supplémentaires. Dure tant que le démon est actif."
              }
            }
          },
          {
            id = 105893,
            name = "Connaissance démoniaque",
            icon = "spell_shadow_improvedvampiricembrace",
            row = 4,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 412732,
                desc = "Augmente les dégâts de vos sorts et ceux des sorts de votre familier démon d’un montant pouvant atteindre 33 % de votre niveau tant que vous avez un familier démon invoqué actif."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts de vos sorts et ceux des sorts de votre familier démon d’un montant pouvant atteindre 67 % de votre niveau tant que vous avez un familier démon invoqué actif."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts de vos sorts et ceux des sorts de votre familier démon d’un montant pouvant atteindre 100 % de votre niveau tant que vous avez un familier démon invoqué actif."
              }
            }
          },
          {
            id = 105891,
            name = "Maître démonologue",
            icon = "spell_shadow_shadowpact",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 23785,
                desc = "Fait bénéficier le personnage démoniste et le démon invoqué d’un effet aussi longtemps que le démon est actif.<br>Diablotin : augmente les dégâts de feu infligés de 2 %.<br>Marcheur du Vide : réduit les dégâts physiques subis de 2 %.<br>Succube/Incube : augmente les dégâts d’ombre infligés de 2 %.<br>Chasseur corrompu : réduit les dégâts magiques subis de 2 %."
              },
              {
                spellId = 0,
                desc = "Fait bénéficier le personnage démoniste et le démon invoqué d’un effet aussi longtemps que le démon est actif.<br>Diablotin : augmente les dégâts de feu infligés de 4 %.<br>Marcheur du Vide : réduit les dégâts physiques subis de 4 %.<br>Succube/Incube : augmente les dégâts d’ombre infligés de 4 %.<br>Chasseur corrompu : réduit les dégâts magiques subis de 4 %."
              },
              {
                spellId = 0,
                desc = "Fait bénéficier le personnage démoniste et le démon invoqué d’un effet aussi longtemps que le démon est actif.<br>Diablotin : augmente les dégâts de feu infligés de 6 %.<br>Marcheur du Vide : réduit les dégâts physiques subis de 6 %.<br>Succube/Incube : augmente les dégâts d’ombre infligés de 6 %.<br>Chasseur corrompu : réduit les dégâts magiques subis de 6 %."
              },
              {
                spellId = 0,
                desc = "Fait bénéficier le personnage démoniste et le démon invoqué d’un effet aussi longtemps que le démon est actif.<br>Diablotin : augmente les dégâts de feu infligés de 8 %.<br>Marcheur du Vide : réduit les dégâts physiques subis de 8 %.<br>Succube/Incube : augmente les dégâts d’ombre infligés de 8 %.<br>Chasseur corrompu : réduit les dégâts magiques subis de 8 %."
              },
              {
                spellId = 0,
                desc = "Fait bénéficier le personnage démoniste et le démon invoqué d’un effet aussi longtemps que le démon est actif.<br>Diablotin : augmente les dégâts de feu infligés de 10 %.<br>Marcheur du Vide : réduit les dégâts physiques subis de 10 %.<br>Succube/Incube : augmente les dégâts d’ombre infligés de 10 %.<br>Chasseur corrompu : réduit les dégâts magiques subis de 10 %."
              }
            }
          },
          {
            id = 105890,
            name = "Pacte démoniaque",
            icon = "inv_ability_soulharvesterwarlock_demonicsoul",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105892,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 425464,
                desc = "Votre effet de Sacrifice démoniaque ne s’annule plus lorsque vous invoquez un autre familier démon. L’effet sera toujours annulé si vous réinvoquez le familier sacrifié."
              }
            }
          }
        }
      },
      {
        id = 301,
        name = "Destruction",
        slug = "destruction",
        order = 2,
        icon = "spell_shadow_rainoffire",
        talents = {
          {
            id = 105881,
            name = "Allonge de destruction",
            icon = "spell_shadow_corpseexplode",
            row = 0,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 17917,
                desc = "Augmente de 10 % la portée de vos sorts de dégâts."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la portée de vos sorts de dégâts."
              }
            }
          },
          {
            id = 105889,
            name = "Trait de l'ombre amélioré",
            icon = "spell_shadow_shadowbolt",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17793,
                desc = "Les coups critiques de votre Trait de l’ombre augmentent les dégâts d’ombre subis par la cible de vos attaques de 4 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de votre Trait de l’ombre augmentent les dégâts d’ombre subis par la cible de vos attaques de 8 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de votre Trait de l’ombre augmentent les dégâts d’ombre subis par la cible de vos attaques de 12 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de votre Trait de l’ombre augmentent les dégâts d’ombre subis par la cible de vos attaques de 16 % pendant 12 sec."
              },
              {
                spellId = 0,
                desc = "Les coups critiques de votre Trait de l’ombre augmentent les dégâts d’ombre subis par la cible de vos attaques de 20 % pendant 12 sec."
              }
            }
          },
          {
            id = 105888,
            name = "Fléau",
            icon = "spell_shadow_deathpact",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17788,
                desc = "Réduit de 0.1 s le temps d’incantation de vos sorts Trait de l’ombre, Immolation et Incinérer, et de 0.4 s celui de votre sort Feu de l’âme."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.2 s le temps d’incantation de vos sorts Trait de l’ombre, Immolation et Incinérer, et de 0.8 s celui de votre sort Feu de l’âme."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.3 s le temps d’incantation de vos sorts Trait de l’ombre, Immolation et Incinérer, et de 1.2 s celui de votre sort Feu de l’âme."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.4 s le temps d’incantation de vos sorts Trait de l’ombre, Immolation et Incinérer, et de 1.6 s celui de votre sort Feu de l’âme."
              },
              {
                spellId = 0,
                desc = "Réduit de 0.5 s le temps d’incantation de vos sorts Trait de l’ombre, Immolation et Incinérer, et de 2 s celui de votre sort Feu de l’âme."
              }
            }
          },
          {
            id = 105885,
            name = "Peau de la fournaise",
            icon = "ability_mage_moltenarmor",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1225220,
                desc = "Réduit tous les dégâts subis de 2 %."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts subis de 4 %."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts subis de 6 %."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts subis de 8 %."
              },
              {
                spellId = 0,
                desc = "Réduit tous les dégâts subis de 10 %."
              }
            }
          },
          {
            id = 105887,
            name = "Cataclysme",
            icon = "spell_fire_windsofwoe",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17778,
                desc = "Réduit le coût en mana de vos sorts de Destruction de 3%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts de Destruction de 6%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts de Destruction de 10%."
              }
            }
          },
          {
            id = 105886,
            name = "Conséquences",
            icon = "spell_fire_fire",
            row = 1,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 18119,
                desc = "Augmente les dégâts initiaux infligés par votre Immolation de 10 % et votre Conflagration a 20 % de chances d’hébéter la cible, ce qui réduit sa vitesse de déplacement de 50 % pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts initiaux infligés par votre Immolation de 20 % et votre Conflagration a 40 % de chances d’hébéter la cible, ce qui réduit sa vitesse de déplacement de 50 % pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts initiaux infligés par votre Immolation de 30 % et votre Conflagration a 60 % de chances d’hébéter la cible, ce qui réduit sa vitesse de déplacement de 50 % pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts initiaux infligés par votre Immolation de 40 % et votre Conflagration a 80 % de chances d’hébéter la cible, ce qui réduit sa vitesse de déplacement de 50 % pendant 5 sec."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts initiaux infligés par votre Immolation de 50 % et votre Conflagration a 100 % de chances d’hébéter la cible, ce qui réduit sa vitesse de déplacement de 50 % pendant 5 sec."
              }
            }
          },
          {
            id = 105883,
            name = "Ruine",
            icon = "spell_shadow_shadowwordpain",
            row = 2,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17959,
                desc = "Augmente de 20% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 40% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 60% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 80% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 100% les points de dégâts supplémentaires infligés par les coups critiques de vos sorts de Destruction."
              }
            }
          },
          {
            id = 105884,
            name = "Brûlure de l'ombre",
            icon = "spell_shadow_scourgebuild",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 17877,
                desc = "Frappe instantanément la cible et lui inflige (42.9 % de la puissance des sorts) points de dégâts d’ombre. Si une cible non négligeable meurt dans les 8 sec après avoir été touchée par Brûlure de l’ombre, le lanceur ou la lanceuse gagne un éclat d’âme."
              }
            }
          },
          {
            id = 105882,
            name = "Intensité",
            icon = "spell_fire_lavaspawn",
            row = 3,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 18135,
                desc = "Vous donne 23% de chances de résister aux interruptions causées par les dégâts lorsque vous lancez ou canalisez n'importe quel sort de Destruction."
              },
              {
                spellId = 0,
                desc = "Vous donne 47% de chances de résister aux interruptions causées par les dégâts lorsque vous lancez ou canalisez n'importe quel sort de Destruction."
              },
              {
                spellId = 0,
                desc = "Vous donne 70% de chances de résister aux interruptions causées par les dégâts lorsque vous lancez ou canalisez n'importe quel sort de Destruction."
              }
            }
          },
          {
            id = 105879,
            name = "Flammes déchirantes",
            icon = "spell_fire_soulburn",
            row = 3,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17927,
                desc = "Augmente de 3 % les chances de coup critique de votre sort Douleur brûlante. De plus, augmente de 3 % les dégâts infligés par tous vos sorts de destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 7 % les chances de coup critique de votre sort Douleur brûlante. De plus, augmente de 7 % les dégâts infligés par tous vos sorts de destruction."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les chances de coup critique de votre sort Douleur brûlante. De plus, augmente de 10 % les dégâts infligés par tous vos sorts de destruction."
              }
            }
          },
          {
            id = 105880,
            name = "Conflagration",
            icon = "spell_fire_fireball",
            row = 3,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1293817,
                desc = "Enflamme une cible qui est déjà affectée par votre sort Immolation, lui inflige (42.9 % de la puissance des sorts) points de dégâts de feu et annule le sort Immolation."
              }
            }
          },
          {
            id = 105878,
            name = "Pyroclasme",
            icon = "spell_fire_volcano",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {
              {
                id = 105882,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 18073,
                desc = "Confère à votre sort Feu de l’âme 13 % de chances d’étourdir la cible pendant 3 sec et à vos sorts Pluie de feu et Flammes infernales 13 % de chances d’étourdir les cibles touchées pendant 3 sec avant que leur effet prenne fin."
              },
              {
                spellId = 0,
                desc = "Confère à votre sort Feu de l’âme 26 % de chances d’étourdir la cible pendant 3 sec et à vos sorts Pluie de feu et Flammes infernales 26 % de chances d’étourdir les cibles touchées pendant 3 sec avant que leur effet prenne fin."
              }
            }
          },
          {
            id = 105876,
            name = "Plaie de tumulte",
            icon = "ability_warlock_baneofhavoc",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1225228,
                desc = "Afflige la cible pendant 5 min. La cible maudite subit 15 % de tous les dégâts infligés par le personnage démoniste à d’autres cibles. Plaie de tumulte est limité à 1 cible, et une seule plaie par démoniste peut être active sur une même cible."
              }
            }
          },
          {
            id = 105877,
            name = "Feu et soufre",
            icon = "spell_fire_meteorstorm",
            row = 4,
            col = 2,
            maxRank = 3,
            requires = {
              {
                id = 105880,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 412751,
                desc = "Augmente de 8 % les chances de coup critique de votre sort Conflagration."
              },
              {
                spellId = 0,
                desc = "Augmente de 17 % les chances de coup critique de votre sort Conflagration."
              },
              {
                spellId = 0,
                desc = "Augmente de 25 % les chances de coup critique de votre sort Conflagration."
              }
            }
          },
          {
            id = 105875,
            name = "Ombre et flammes",
            icon = "spell_fire_playingwithfire",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 426316,
                desc = "Le fait de toucher un personnage adverse avec Conflagration augmente tous les dégâts d’ombre de 2 % pendant 20 sec. Le fait de toucher un personnage adverse avec Brûlure de l’ombre augmente tous les dégâts de feu de 2 % pendant 20 sec. De plus, Conflagration a 20 % de chances de ne pas consommer Immolation, et Brûlure de l’ombre a 20 % de chances de rendre instantanément un éclat d’âme."
              },
              {
                spellId = 0,
                desc = "Le fait de toucher un personnage adverse avec Conflagration augmente tous les dégâts d’ombre de 4 % pendant 20 sec. Le fait de toucher un personnage adverse avec Brûlure de l’ombre augmente tous les dégâts de feu de 4 % pendant 20 sec. De plus, Conflagration a 40 % de chances de ne pas consommer Immolation, et Brûlure de l’ombre a 40 % de chances de rendre instantanément un éclat d’âme."
              },
              {
                spellId = 0,
                desc = "Le fait de toucher un personnage adverse avec Conflagration augmente tous les dégâts d’ombre de 6 % pendant 20 sec. Le fait de toucher un personnage adverse avec Brûlure de l’ombre augmente tous les dégâts de feu de 6 % pendant 20 sec. De plus, Conflagration a 60 % de chances de ne pas consommer Immolation, et Brûlure de l’ombre a 60 % de chances de rendre instantanément un éclat d’âme."
              },
              {
                spellId = 0,
                desc = "Le fait de toucher un personnage adverse avec Conflagration augmente tous les dégâts d’ombre de 8 % pendant 20 sec. Le fait de toucher un personnage adverse avec Brûlure de l’ombre augmente tous les dégâts de feu de 8 % pendant 20 sec. De plus, Conflagration a 80 % de chances de ne pas consommer Immolation, et Brûlure de l’ombre a 80 % de chances de rendre instantanément un éclat d’âme."
              },
              {
                spellId = 0,
                desc = "Le fait de toucher un personnage adverse avec Conflagration augmente tous les dégâts d’ombre de 10 % pendant 20 sec. Le fait de toucher un personnage adverse avec Brûlure de l’ombre augmente tous les dégâts de feu de 10 % pendant 20 sec. De plus, Conflagration a 100 % de chances de ne pas consommer Immolation, et Brûlure de l’ombre a 100 % de chances de rendre instantanément un éclat d’âme."
              }
            }
          },
          {
            id = 105874,
            name = "Incinérer",
            icon = "spell_fire_burnout",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 105876,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 412758,
                desc = "Inflige (71.4 % de la puissance des sorts) points de dégâts de feu à votre cible et 25 % de dégâts supplémentaires si elle est affectée par Immolation."
              }
            }
          }
        }
      }
    }
  },
  {
    id = 11,
    slug = "druide",
    name = "Druide",
    color = "#FF7D0A",
    icon = "class_druid",
    trees = {
      {
        id = 283,
        name = "Équilibre",
        slug = "equilibre",
        order = 0,
        icon = "spell_nature_starfall",
        talents = {
          {
            id = 104923,
            name = "Colère améliorée",
            icon = "spell_nature_abolishmagic",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16814,
                desc = "Réduit le temps d’incantation de votre sort Colère de 0.1 s et son coût en mana de 10 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Colère de 0.2 s et son coût en mana de 20 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Colère de 0.3 s et son coût en mana de 30 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Colère de 0.4 s et son coût en mana de 40 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Colère de 0.5 s et son coût en mana de 50 %."
              }
            }
          },
          {
            id = 104924,
            name = "Genèse",
            icon = "spell_arcane_arcane03",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 1223081,
                desc = "Augmente de 1 % les dégâts et les soins périodiques produits par vos sorts et techniques."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 % les dégâts et les soins périodiques produits par vos sorts et techniques."
              },
              {
                spellId = 0,
                desc = "Augmente de 3 % les dégâts et les soins périodiques produits par vos sorts et techniques."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % les dégâts et les soins périodiques produits par vos sorts et techniques."
              },
              {
                spellId = 0,
                desc = "Augmente de 5 % les dégâts et les soins périodiques produits par vos sorts et techniques."
              }
            }
          },
          {
            id = 104925,
            name = "Lueur de la lune",
            icon = "spell_nature_sentinal",
            row = 1,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16845,
                desc = "Réduit de 8 % le coût en mana de vos sorts de dégâts."
              },
              {
                spellId = 0,
                desc = "Réduit de 17 % le coût en mana de vos sorts de dégâts."
              },
              {
                spellId = 0,
                desc = "Réduit de 25 % le coût en mana de vos sorts de dégâts."
              }
            }
          },
          {
            id = 104931,
            name = "Eclat lunaire amélioré",
            icon = "spell_nature_starfall",
            row = 1,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16821,
                desc = "Augmente les points de dégâts et les chances de porter un coup critique avec votre sort Eclat lunaire de 5%."
              },
              {
                spellId = 0,
                desc = "Augmente les points de dégâts et les chances de porter un coup critique avec votre sort Eclat lunaire de 10%."
              }
            }
          },
          {
            id = 104927,
            name = "Majesté de la nature",
            icon = "inv_staff_01",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1223082,
                desc = "Augmente les chances de coup critique de vos sorts et attaques de mêlée de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente les chances de coup critique de vos sorts et attaques de mêlée de 4 %."
              }
            }
          },
          {
            id = 104929,
            name = "Allonge de la Nature",
            icon = "spell_nature_naturetouchgrow",
            row = 1,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16819,
                desc = "Augmente de 10 % la portée de vos sorts d’Équilibre offensifs et améliore de 2 % vos chances de toucher."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % la portée de vos sorts d’Équilibre offensifs et améliore de 4 % vos chances de toucher."
              }
            }
          },
          {
            id = 104926,
            name = "Sarments améliorés",
            icon = "spell_nature_stranglevines",
            row = 2,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16918,
                desc = "Augmente les dégâts infligés par votre sort Sarments de 25 %. Sa victime peut subir 25 % de dégâts supplémentaires sans interrompre l’effet."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par votre sort Sarments de 50 %. Sa victime peut subir 50 % de dégâts supplémentaires sans interrompre l’effet."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par votre sort Sarments de 75 %. Sa victime peut subir 75 % de dégâts supplémentaires sans interrompre l’effet."
              }
            }
          },
          {
            id = 104928,
            name = "Splendeur de la nature",
            icon = "spell_nature_natureresistancetotem",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {
              {
                id = 104927,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 1223083,
                desc = "Augmente la durée de vos sorts Éclat lunaire et Récupération de 3 s, celle de Rétablissement de 6 s et celle d’Essaim d’insectes de 2 s."
              }
            }
          },
          {
            id = 104930,
            name = "Essaim d'insectes",
            icon = "spell_nature_insectswarm",
            row = 3,
            col = 0,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 5570,
                desc = "La cible adverse est assaillie par des insectes. Ses chances de toucher avec les attaques sont réduites de 2 % et elle subit (48 % de la puissance des sorts) points de dégâts de nature en 12 sec."
              }
            }
          },
          {
            id = 104932,
            name = "Vengeance",
            icon = "spell_nature_purge",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {
              {
                id = 104931,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 16909,
                desc = "Augmente de 20 % le bonus de dégâts des coups critiques de vos sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 40 % le bonus de dégâts des coups critiques de vos sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 60 % le bonus de dégâts des coups critiques de vos sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 80 % le bonus de dégâts des coups critiques de vos sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Augmente de 100 % le bonus de dégâts des coups critiques de vos sorts des arcanes et de nature."
              }
            }
          },
          {
            id = 104933,
            name = "Feu stellaire amélioré",
            icon = "spell_arcane_starfire",
            row = 3,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16850,
                desc = "Réduit le temps d’incantation de Feu stellaire de 0.1 s. Feu stellaire a 3 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de Feu stellaire de 0.2 s. Feu stellaire a 6 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de Feu stellaire de 0.3 s. Feu stellaire a 9 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de Feu stellaire de 0.4 s. Feu stellaire a 12 % de chances d’étourdir la cible pendant 3 sec."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de Feu stellaire de 0.5 s. Feu stellaire a 15 % de chances d’étourdir la cible pendant 3 sec."
              }
            }
          },
          {
            id = 110844,
            name = "Lacis",
            icon = "inv_misc_herb_15",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 17245,
                desc = "Augmente de 1 le nombre maximum de cibles pouvant être affectées par Sarments."
              },
              {
                spellId = 0,
                desc = "Augmente de 2 le nombre maximum de cibles pouvant être affectées par Sarments."
              }
            }
          },
          {
            id = 104934,
            name = "Grâce de la nature",
            icon = "spell_nature_naturesblessing",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 16880,
                desc = "Tous les coups critiques non périodiques des sorts vous confèrent une bénédiction de la nature, qui augmente votre vitesse d’incantation des sorts et réduit votre temps de recharge global de 10 % pendant 3 sec."
              }
            }
          },
          {
            id = 104935,
            name = "Éclipse",
            icon = "ability_druid_eclipse",
            row = 4,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 408248,
                desc = "Votre sort Colère réduit le temps d’incantation de vos 2 prochains sorts Feu stellaire de 0.17 s. Vous pouvez cumuler jusqu’à 4 charges. Dure 15 sec."
              },
              {
                spellId = 0,
                desc = "Votre sort Colère réduit le temps d’incantation de vos 2 prochains sorts Feu stellaire de 0.33 s. Vous pouvez cumuler jusqu’à 4 charges. Dure 15 sec."
              },
              {
                spellId = 0,
                desc = "Votre sort Colère réduit le temps d’incantation de vos 2 prochains sorts Feu stellaire de 0.5 s. Vous pouvez cumuler jusqu’à 4 charges. Dure 15 sec."
              }
            }
          },
          {
            id = 104936,
            name = "Fureur lunaire",
            icon = "spell_nature_moonglow",
            row = 5,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16896,
                desc = "Augmente les dégâts infligés par vos sorts des arcanes et de nature de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos sorts des arcanes et de nature de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos sorts des arcanes et de nature de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos sorts des arcanes et de nature de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos sorts des arcanes et de nature de 10 %."
              }
            }
          },
          {
            id = 104937,
            name = "Forme de sélénien",
            icon = "spell_nature_forceofnature",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 24858,
                desc = "Transforme le druide en sélénien. Sous cette forme, la contribution de l’armure des objets est augmentée de 360 %, Augure de clarté a 100 % de chances supplémentaires de se déclencher, et tous les membres du groupe se trouvant à moins de 45 mètres voient leurs chances de coup critique augmenter de 3 %, cet effet étant exclusif avec Chef de meute. Le sélénien ne peut pas lancer de sorts de soins sous cette forme.<br>Le changement de forme libère le lanceur des effets de Métamorphose et de ralentissement des mouvements."
              }
            }
          }
        }
      },
      {
        id = 281,
        name = "Farouche",
        slug = "farouche",
        order = 1,
        icon = "ability_racial_bearform",
        talents = {
          {
            id = 104938,
            name = "Férocité",
            icon = "ability_hunter_pet_hyena",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 16934,
                desc = "Réduit de 1 point de rage ou d’énergie le coût de vos techniques Mutiler, Mutilation, Balayage, Griffe et Griffure."
              },
              {
                spellId = 0,
                desc = "Réduit de 2 point de rage ou d’énergie le coût de vos techniques Mutiler, Mutilation, Balayage, Griffe et Griffure."
              },
              {
                spellId = 0,
                desc = "Réduit de 3 point de rage ou d’énergie le coût de vos techniques Mutiler, Mutilation, Balayage, Griffe et Griffure."
              },
              {
                spellId = 0,
                desc = "Réduit de 4 point de rage ou d’énergie le coût de vos techniques Mutiler, Mutilation, Balayage, Griffe et Griffure."
              },
              {
                spellId = 0,
                desc = "Réduit de 5 point de rage ou d’énergie le coût de vos techniques Mutiler, Mutilation, Balayage, Griffe et Griffure."
              }
            }
          },
          {
            id = 104939,
            name = "Cœur de fauve",
            icon = "spell_holy_blessingofagility",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17003,
                desc = "Augmente votre Intelligence de 2 %. Sous forme d’ours ou d’ours redoutable, votre Endurance augmente de 4 %. Sous forme de félin, votre Force augmente de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Intelligence de 4 %. Sous forme d’ours ou d’ours redoutable, votre Endurance augmente de 8 %. Sous forme de félin, votre Force augmente de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Intelligence de 6 %. Sous forme d’ours ou d’ours redoutable, votre Endurance augmente de 12 %. Sous forme de félin, votre Force augmente de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Intelligence de 8 %. Sous forme d’ours ou d’ours redoutable, votre Endurance augmente de 16 %. Sous forme de félin, votre Force augmente de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Intelligence de 10 %. Sous forme d’ours ou d’ours redoutable, votre Endurance augmente de 20 %. Sous forme de félin, votre Force augmente de 10 %."
              }
            }
          },
          {
            id = 104943,
            name = "Célérité farouche",
            icon = "spell_nature_spiritwolf",
            row = 1,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 17002,
                desc = "Augmente de 15 % votre vitesse de déplacement et de 2 % vos chances d’esquiver sous votre forme de félin."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % votre vitesse de déplacement et de 4 % vos chances d’esquiver sous votre forme de félin."
              }
            }
          },
          {
            id = 104940,
            name = "Instinct farouche",
            icon = "ability_ambush",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16947,
                desc = "Augmente de 10 % les dégâts infligés par votre technique Balayage et réduit les chances de vous faire détecter par vos ennemis lorsque vous rôdez, comme si vous aviez gagné 1 niveau."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % les dégâts infligés par votre technique Balayage et réduit les chances de vous faire détecter par vos ennemis lorsque vous rôdez, comme si vous aviez gagné 2 niveau."
              },
              {
                spellId = 0,
                desc = "Augmente de 30 % les dégâts infligés par votre technique Balayage et réduit les chances de vous faire détecter par vos ennemis lorsque vous rôdez, comme si vous aviez gagné 3 niveau."
              }
            }
          },
          {
            id = 104941,
            name = "Impact brutal",
            icon = "ability_druid_bash",
            row = 1,
            col = 2,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16940,
                desc = "Augmente la durée d’étourdissement de vos techniques Sonner et Traquenard de 0.5 s et réduit le temps de recharge de Sonner de 15 s."
              },
              {
                spellId = 0,
                desc = "Augmente la durée d’étourdissement de vos techniques Sonner et Traquenard de 1 s et réduit le temps de recharge de Sonner de 30 s."
              }
            }
          },
          {
            id = 104942,
            name = "Peau épaisse",
            icon = "inv_misc_pelt_bear_03",
            row = 1,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16929,
                desc = "Sous forme d’ours, de félin, d’ours redoutable ou de sélénien, vous bénéficiez d’un bonus d’armure de base de 1 par niveau, ainsi que d’un bonus d’armure de base supplémentaire de 0.67 pour chaque point de défense dépassant cinq fois votre niveau. Ce montant peut être augmenté par les multiplicateurs de ces formes."
              },
              {
                spellId = 0,
                desc = "Sous forme d’ours, de félin, d’ours redoutable ou de sélénien, vous bénéficiez d’un bonus d’armure de base de 2 par niveau, ainsi que d’un bonus d’armure de base supplémentaire de 1.33 pour chaque point de défense dépassant cinq fois votre niveau. Ce montant peut être augmenté par les multiplicateurs de ces formes."
              },
              {
                spellId = 0,
                desc = "Sous forme d’ours, de félin, d’ours redoutable ou de sélénien, vous bénéficiez d’un bonus d’armure de base de 3 par niveau, ainsi que d’un bonus d’armure de base supplémentaire de 2 pour chaque point de défense dépassant cinq fois votre niveau. Ce montant peut être augmenté par les multiplicateurs de ces formes."
              }
            }
          },
          {
            id = 104948,
            name = "Furie sauvage",
            icon = "ability_druid_ravage",
            row = 2,
            col = 1,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16998,
                desc = "Augmente de 5 % les dégâts infligés par vos techniques Griffe, Griffure, Lambeau, Mutiler et Balayage."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % les dégâts infligés par vos techniques Griffe, Griffure, Lambeau, Mutiler et Balayage."
              }
            }
          },
          {
            id = 104944,
            name = "Charge farouche",
            icon = "ability_hunter_pet_bear",
            row = 2,
            col = 2,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 1238122,
                desc = "Nécessite la forme d’ours ou la forme d’ours redoutable Vous chargez un personnage adverse, stoppez son déplacement et interrompez le sort qu’il lançait pendant 4 sec.<br>Charge farouche (félin) Portée de 8 - 25 m.Instantané30 s de rechargeRequires Druid Requires level 1Requiert Forme de félin Leap behind an enemy."
              }
            }
          },
          {
            id = 104946,
            name = "Griffes aiguisées",
            icon = "inv_misc_monsterclaw_04",
            row = 2,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 16942,
                desc = "Augmente de 3 % vos chances de coup critique lorsque vous êtes sous forme d’ours, d’ours redoutable ou de félin."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % vos chances de coup critique lorsque vous êtes sous forme d’ours, d’ours redoutable ou de félin."
              }
            }
          },
          {
            id = 104945,
            name = "Attaques lacérantes",
            icon = "spell_shadow_vampiricaura",
            row = 3,
            col = 0,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16966,
                desc = "Réduit de 6 le coût en énergie de votre technique Lambeau et de 1 le coût en rage de votre technique Lacérer."
              },
              {
                spellId = 0,
                desc = "Réduit de 12 le coût en énergie de votre technique Lambeau et de 2 le coût en rage de votre technique Lacérer."
              },
              {
                spellId = 0,
                desc = "Réduit de 18 le coût en énergie de votre technique Lambeau et de 3 le coût en rage de votre technique Lacérer."
              }
            }
          },
          {
            id = 104949,
            name = "Mutilation",
            icon = "ability_druid_mangle2",
            row = 3,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104948,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 407995,
                desc = "Mutile la cible et lui inflige 100 % des dégâts normaux plus 26."
              }
            }
          },
          {
            id = 104952,
            name = "Frappes de prédateur",
            icon = "ability_hunter_pet_cat",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16972,
                desc = "Sous forme de félin, d’ours ou d’ours redoutable, augmente votre puissance d’attaque en mêlée d’un montant correspondant à 50 % de votre niveau."
              },
              {
                spellId = 0,
                desc = "Sous forme de félin, d’ours ou d’ours redoutable, augmente votre puissance d’attaque en mêlée d’un montant correspondant à 100 % de votre niveau."
              },
              {
                spellId = 0,
                desc = "Sous forme de félin, d’ours ou d’ours redoutable, augmente votre puissance d’attaque en mêlée d’un montant correspondant à 150 % de votre niveau."
              }
            }
          },
          {
            id = 104947,
            name = "Fureur primitive",
            icon = "ability_racial_cannibalize",
            row = 3,
            col = 3,
            maxRank = 2,
            requires = {
              {
                id = 104946,
                qty = 2
              }
            },
            ranks = {
              {
                spellId = 16958,
                desc = "Vous confère 50 % de chances de générer 5 points de rage supplémentaires chaque fois que vous réussissez un coup critique en forme d’ours ou d’ours redoutable. De plus, vos coups critiques non périodiques obtenus avec les techniques de la forme de félin ajoutant des points de combo ont 50 % de chances d’ajouter un point de combo supplémentaire."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances de générer 5 points de rage supplémentaires chaque fois que vous réussissez un coup critique en forme d’ours ou d’ours redoutable. De plus, vos coups critiques non périodiques obtenus avec les techniques de la forme de félin ajoutant des points de combo ont 100 % de chances d’ajouter un point de combo supplémentaire."
              }
            }
          },
          {
            id = 104950,
            name = "Instincts prédateurs",
            icon = "ability_druid_predatoryinstincts",
            row = 4,
            col = 0,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 1223242,
                desc = "Augmente de 10 % le bonus de dégâts des coups critiques de vos techniques de mêlée."
              },
              {
                spellId = 0,
                desc = "Augmente de 20 % le bonus de dégâts des coups critiques de vos techniques de mêlée."
              }
            }
          },
          {
            id = 104955,
            name = "Chef de la meute",
            icon = "spell_nature_unyeildingstamina",
            row = 4,
            col = 1,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 17007,
                desc = "Pendant qu’il est en forme de félin, d’ours ou d’ours redoutable, le Chef de la meute augmente de 3 % les chances de tous les membres du groupe se trouvant à moins de 45 m d’obtenir un coup critique. Incompatible avec Aura de sélénien."
              }
            }
          },
          {
            id = 104951,
            name = "Roi de la jungle",
            icon = "ability_druid_kingofthejungle",
            row = 4,
            col = 3,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 417046,
                desc = "Fureur du tigre vous confère désormais instantanément 20 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Fureur du tigre vous confère désormais instantanément 40 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Fureur du tigre vous confère désormais instantanément 60 points d’énergie."
              }
            }
          },
          {
            id = 104954,
            name = "Réaction naturelle",
            icon = "ability_bullrush",
            row = 5,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 417051,
                desc = "Augmente vos chances d’esquiver de 1 % et vous confère 20 % de chances d’obtenir 5 points de rage chaque fois que vous esquivez."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 2 % et vous confère 40 % de chances d’obtenir 5 points de rage chaque fois que vous esquivez."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 3 % et vous confère 60 % de chances d’obtenir 5 points de rage chaque fois que vous esquivez."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 4 % et vous confère 80 % de chances d’obtenir 5 points de rage chaque fois que vous esquivez."
              },
              {
                spellId = 0,
                desc = "Augmente vos chances d’esquiver de 5 % et vous confère 100 % de chances d’obtenir 5 points de rage chaque fois que vous esquivez."
              }
            }
          },
          {
            id = 104953,
            name = "Pourfendre et déchirer",
            icon = "ability_druid_primalagression",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 104952,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 1223246,
                desc = "Augmente les dégâts infligés par vos techniques de mêlée aux cibles qui saignent de 2 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos techniques de mêlée aux cibles qui saignent de 4 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos techniques de mêlée aux cibles qui saignent de 6 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos techniques de mêlée aux cibles qui saignent de 8 %."
              },
              {
                spellId = 0,
                desc = "Augmente les dégâts infligés par vos techniques de mêlée aux cibles qui saignent de 10 %."
              }
            }
          },
          {
            id = 104956,
            name = "Berserk",
            icon = "ability_druid_berserk",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104955,
                qty = 1
              }
            },
            ranks = {
              {
                spellId = 417141,
                desc = "Nécessite la forme de félin, la forme d’ours ou la forme d’ours redoutable Permet à votre technique Mutilation de toucher jusqu’à 3 cibles, supprime son temps de recharge et augmente de 100 % les chances de coup critique de vos techniques générant des points de combo. Dissipe les effets de peur et rend insensible à ces effets jusqu’à la fin. Dure 15 sec."
              }
            }
          }
        }
      },
      {
        id = 282,
        name = "Restauration",
        slug = "restauration",
        order = 2,
        icon = "spell_nature_healingtouch",
        talents = {
          {
            id = 104957,
            name = "Focalisation de la nature",
            icon = "spell_nature_healingwavegreater",
            row = 0,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17063,
                desc = "Vous confère 14 % de chances d’éviter les interruptions provoquées par les dégâts lors de l’incantation de sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Vous confère 28 % de chances d’éviter les interruptions provoquées par les dégâts lors de l’incantation de sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Vous confère 42 % de chances d’éviter les interruptions provoquées par les dégâts lors de l’incantation de sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Vous confère 56 % de chances d’éviter les interruptions provoquées par les dégâts lors de l’incantation de sorts des arcanes et de nature."
              },
              {
                spellId = 0,
                desc = "Vous confère 70 % de chances d’éviter les interruptions provoquées par les dégâts lors de l’incantation de sorts des arcanes et de nature."
              }
            }
          },
          {
            id = 104958,
            name = "Fureur",
            icon = "spell_holy_blessingofstamina",
            row = 0,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17056,
                desc = "Vous confère 20 % de chances de gagner 10 points de rage lorsque vous adoptez la forme d’ours ou d’ours redoutable. Lorsque vous adoptez la forme de félin, vous regagnez 20 % de l’énergie que vous possédiez lors de votre dernière forme de félin, plus 2 points d’énergie pour chaque seconde que vous n’avez pas passée sous forme d’ours, de félin ou d’ours redoutable, jusqu’à un bonus maximum de 20 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Vous confère 40 % de chances de gagner 10 points de rage lorsque vous adoptez la forme d’ours ou d’ours redoutable. Lorsque vous adoptez la forme de félin, vous regagnez 40 % de l’énergie que vous possédiez lors de votre dernière forme de félin, plus 4 points d’énergie pour chaque seconde que vous n’avez pas passée sous forme d’ours, de félin ou d’ours redoutable, jusqu’à un bonus maximum de 40 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Vous confère 60 % de chances de gagner 10 points de rage lorsque vous adoptez la forme d’ours ou d’ours redoutable. Lorsque vous adoptez la forme de félin, vous regagnez 60 % de l’énergie que vous possédiez lors de votre dernière forme de félin, plus 6 points d’énergie pour chaque seconde que vous n’avez pas passée sous forme d’ours, de félin ou d’ours redoutable, jusqu’à un bonus maximum de 60 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Vous confère 80 % de chances de gagner 10 points de rage lorsque vous adoptez la forme d’ours ou d’ours redoutable. Lorsque vous adoptez la forme de félin, vous regagnez 80 % de l’énergie que vous possédiez lors de votre dernière forme de félin, plus 8 points d’énergie pour chaque seconde que vous n’avez pas passée sous forme d’ours, de félin ou d’ours redoutable, jusqu’à un bonus maximum de 80 points d’énergie."
              },
              {
                spellId = 0,
                desc = "Vous confère 100 % de chances de gagner 10 points de rage lorsque vous adoptez la forme d’ours ou d’ours redoutable. Lorsque vous adoptez la forme de félin, vous regagnez 100 % de l’énergie que vous possédiez lors de votre dernière forme de félin, plus 10 points d’énergie pour chaque seconde que vous n’avez pas passée sous forme d’ours, de félin ou d’ours redoutable, jusqu’à un bonus maximum de 100 points d’énergie."
              }
            }
          },
          {
            id = 104922,
            name = "Naturaliste",
            icon = "spell_nature_healingtouch",
            row = 1,
            col = 0,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17069,
                desc = "Réduit le temps d’incantation de votre sort Toucher guérisseur de 0.1 s et augmente tous les dégâts que vous infligez de 1 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Toucher guérisseur de 0.2 s et augmente tous les dégâts que vous infligez de 2 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Toucher guérisseur de 0.3 s et augmente tous les dégâts que vous infligez de 3 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Toucher guérisseur de 0.4 s et augmente tous les dégâts que vous infligez de 4 %."
              },
              {
                spellId = 0,
                desc = "Réduit le temps d’incantation de votre sort Toucher guérisseur de 0.5 s et augmente tous les dégâts que vous infligez de 5 %."
              }
            }
          },
          {
            id = 104920,
            name = "Discrétion",
            icon = "ability_eyeoftheowl",
            row = 1,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17118,
                desc = "Réduit de 10 % le niveau de menace généré par vos sorts de nature et des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit de 20 % le niveau de menace généré par vos sorts de nature et des arcanes."
              },
              {
                spellId = 0,
                desc = "Réduit de 30 % le niveau de menace généré par vos sorts de nature et des arcanes."
              }
            }
          },
          {
            id = 104919,
            name = "Changeforme naturel",
            icon = "spell_nature_wispsplode",
            row = 1,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 16833,
                desc = "Réduit le coût en mana de tous les changements de forme de 10%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les changements de forme de 20%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de tous les changements de forme de 30%."
              }
            }
          },
          {
            id = 104917,
            name = "Renvoi",
            icon = "spell_frost_windwalkon",
            row = 2,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17106,
                desc = "Vous confère 17% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 33% de votre vitesse de récupération du mana normale pendant l'incantation."
              },
              {
                spellId = 0,
                desc = "Vous confère 50% de votre vitesse de récupération du mana normale pendant l'incantation."
              }
            }
          },
          {
            id = 104916,
            name = "Don de la Nature",
            icon = "spell_nature_protectionformnature",
            row = 2,
            col = 2,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 17104,
                desc = "Augmente de 2 % l’effet de tous vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 4 % l’effet de tous vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 6 % l’effet de tous vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 8 % l’effet de tous vos sorts de soins."
              },
              {
                spellId = 0,
                desc = "Augmente de 10 % l’effet de tous vos sorts de soins."
              }
            }
          },
          {
            id = 104918,
            name = "Don de la Terre-mère",
            icon = "spell_nature_spiritarmor",
            row = 2,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 414673,
                desc = "Réduit le temps de recharge global de 0.5 s pour vos sorts Récupération, Prompte guérison et Croissance sauvage."
              }
            }
          },
          {
            id = 104915,
            name = "Tranquillité de l'esprit",
            icon = "spell_holy_elunesgrace",
            row = 3,
            col = 1,
            maxRank = 5,
            requires = {},
            ranks = {
              {
                spellId = 24968,
                desc = "Réduit le coût en mana de vos sorts Toucher guérisseur et Tranquillité de 2%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts Toucher guérisseur et Tranquillité de 4%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts Toucher guérisseur et Tranquillité de 6%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts Toucher guérisseur et Tranquillité de 8%."
              },
              {
                spellId = 0,
                desc = "Réduit le coût en mana de vos sorts Toucher guérisseur et Tranquillité de 10%."
              }
            }
          },
          {
            id = 104914,
            name = "Récupération améliorée",
            icon = "spell_nature_rejuvenation",
            row = 3,
            col = 2,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 17111,
                desc = "Augmente les effets de votre sort Récupération de 5%."
              },
              {
                spellId = 0,
                desc = "Augmente les effets de votre sort Récupération de 10%."
              },
              {
                spellId = 0,
                desc = "Augmente les effets de votre sort Récupération de 15%."
              }
            }
          },
          {
            id = 104912,
            name = "Prompte guérison",
            icon = "inv_relics_idolofrejuvenation",
            row = 3,
            col = 3,
            maxRank = 1,
            requires = {},
            ranks = {
              {
                spellId = 18562,
                desc = "Soigne instantanément une cible avec un effet actif de Récupération ou de Rétablissement pour lui rendre un montant de points de vie équivalent à la durée totale de l’effet périodique de l’un de ces sorts."
              }
            }
          },
          {
            id = 104921,
            name = "Rapidité de la nature",
            icon = "spell_nature_ravenform",
            row = 4,
            col = 0,
            maxRank = 1,
            requires = {
              {
                id = 104922,
                qty = 5
              }
            },
            ranks = {
              {
                spellId = 17116,
                desc = "Lorsque cette technique est activée, votre prochain sort de Nature devient un sort instantané."
              }
            }
          },
          {
            id = 104911,
            name = "Esprit vif",
            icon = "spell_nature_giftofthewaterspirit",
            row = 4,
            col = 1,
            maxRank = 3,
            requires = {},
            ranks = {
              {
                spellId = 1309631,
                desc = "Augmente votre Esprit de 5 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Esprit de 10 %."
              },
              {
                spellId = 0,
                desc = "Augmente votre Esprit de 15 %."
              }
            }
          },
          {
            id = 104909,
            name = "Tranquillité améliorée",
            icon = "spell_nature_tranquility",
            row = 4,
            col = 3,
            maxRank = 2,
            requires = {},
            ranks = {
              {
                spellId = 17123,
                desc = "Diminue le niveau de menace généré par Tranquillité de 50 % et réduit le temps de recharge de 30 %."
              },
              {
                spellId = 0,
                desc = "Diminue le niveau de menace généré par Tranquillité de 100 % et réduit le temps de recharge de 60 %."
              }
            }
          },
          {
            id = 104913,
            name = "Rétablissement amélioré",
            icon = "spell_nature_resistnature",
            row = 5,
            col = 2,
            maxRank = 5,
            requires = {
              {
                id = 104914,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 17074,
                desc = "Augmente les chances d'obtenir un effet critique avec votre sort Rétablissement de 10%."
              },
              {
                spellId = 0,
                desc = "Augmente les chances d'obtenir un effet critique avec votre sort Rétablissement de 20%."
              },
              {
                spellId = 0,
                desc = "Augmente les chances d'obtenir un effet critique avec votre sort Rétablissement de 30%."
              },
              {
                spellId = 0,
                desc = "Augmente les chances d'obtenir un effet critique avec votre sort Rétablissement de 40%."
              },
              {
                spellId = 0,
                desc = "Augmente les chances d'obtenir un effet critique avec votre sort Rétablissement de 50%."
              }
            }
          },
          {
            id = 104910,
            name = "Croissance sauvage",
            icon = "ability_druid_flourish",
            row = 6,
            col = 1,
            maxRank = 1,
            requires = {
              {
                id = 104911,
                qty = 3
              }
            },
            ranks = {
              {
                spellId = 408120,
                desc = "Rend (336 % de la puissance des sorts) point de vie en 7 sec à la cible et aux membres de son groupe se trouvant à moins de 43.5 m d’elle. La quantité de soins prodiguée est importante au début, puis diminue à mesure que Croissance sauvage atteint sa durée maximale."
              }
            }
          }
        }
      }
    }
  }
}
