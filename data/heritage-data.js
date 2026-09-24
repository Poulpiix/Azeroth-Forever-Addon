/*
 * Azeroth Forever : données de l'arbre d'Héritage (16 points, 3 arbres).
 * Sorties de heritage-calculator.js (Phase 3) pour être partagées avec
 * heritage-path.js et les tests Node. Contenu identique à la v2 du site.
 *
 * Ordre des nœuds (hors placeholders) = ordre de ?hbuild= et du code AF1H-.
 * Ne pas insérer de nœud au milieu d'un arbre sans changer de version de code.
 */
(function (root) {
  "use strict";

  var TREES = [
    {
      id: "metiers",
      name: "Métiers",
      icon: "inv_hammer_20",
      desc: "Artisanat, récolte et or.",
      nodes: [
        { id: "travail-acharne", name: "Travail acharné", icon: "inv_misc_pocketwatch_03", maxRank: 5, tier: 0, col: 0, row: 1, desc: "Augmente vos chances de gagner un point de compétence en utilisant un métier primaire, secondaire ou de classe de 4%." },
        { id: "marchandage", name: "Marchandage", icon: "inv_misc_coin_06", maxRank: 2, tier: 5, col: 1, row: 1, desc: "Réduit de 5% le prix en or des objets achetés à tous les marchands." },
        { id: "chef-etoile", name: "Chef étoilé", icon: "achievement_profession_chefhat", maxRank: 5, tier: 5, col: 2, row: 0, desc: "Vos recettes de Cuisine ont 10% de chances de créer un résultat supplémentaire." },
        { id: "etude-assidue", name: "Étude assidue", icon: "inv_misc_book_08", maxRank: 1, tier: 10, col: 2, row: 1, meta: "25 sec d'incantation, 23 h de recharge", desc: "Augmente d'un point votre compétence la plus basse parmi vos métiers primaires et secondaires actuels. Si vous avez déjà atteint 300 dans vos deux métiers primaires et vos trois métiers secondaires, vous obtenez 2 à 4 Essences élémentaires aléatoires." },
        { id: "recolte-abondante", name: "Récolte abondante", icon: "inv_misc_bag_18", maxRank: 5, tier: 0, col: 0, row: 2, desc: "Vous trouvez 20% de matériaux Peu communs en plus en Minage, Herboristerie et Dépeçage." },
        { id: "prime-de-rendement", name: "Prime de rendement", icon: "racial_dwarf_findtreasure", maxRank: 3, tier: 5, col: 1, row: 2, desc: "Vous avez 5% de chances de recevoir 100% de Faveur du marchand en plus en livrant une caisse à l'Autorité commerciale d'Azeroth ou à la Logistique de Durotar." },
        { placeholder: true, col: 2, row: 2 },
        { placeholder: true, col: 3, row: 2 },
        { id: "maitre-appateur", name: "Maître-appâteur", icon: "inv_misc_basket_04", maxRank: 2, tier: 5, col: 2, row: 3, desc: "En pêchant avec un Appât actif, vous avez 25% de chances d'attraper un poisson supplémentaire." }
      ]
    },
    {
      id: "aventure",
      name: "Aventure",
      icon: "inv_misc_map_01",
      desc: "Progression, exploration et utilitaires.",
      nodes: [
        { id: "haute-vigilance", name: "Haute vigilance", icon: "spell_shadow_detectlesserinvisibility", maxRank: 2, tier: 5, col: 1, row: 0, desc: "Augmente votre capacité à détecter les cibles furtives à proximité, comme si votre niveau était augmenté de 1. Inefficace en champ de bataille." },
        { id: "bien-repose", name: "Bien reposé", icon: "spell_nature_sleep", maxRank: 5, tier: 0, col: 0, row: 1, desc: "Votre expérience de repos s'accumule 4% plus vite et son plafond est augmenté de 4%." },
        { id: "talentueux", name: "Talentueux", icon: "ability_marksmanship", maxRank: 5, tier: 5, col: 1, row: 1, desc: "Vous gagnez un point de talent à chaque niveau dès le niveau 9 au lieu du niveau 10, sans jamais dépasser 51 points de talent au total." },
        { placeholder: true, col: 2, row: 1 },
        { placeholder: true, col: 3, row: 1 },
        { id: "frisson-aventure", name: "Frisson de l'aventure", icon: "ability_hunter_huntervswild", maxRank: 5, tier: 0, col: 0, row: 2, desc: "Vous récupérez 1% de vos points de vie et de mana maximum sur 10 sec chaque fois que vous portez le coup fatal à un ennemi non négligeable. Inefficace en donjon, en raid et en champ de bataille." },
        { id: "guide-de-terrain", name: "Guide de terrain", icon: "inv_fishingchair", maxRank: 3, tier: 5, col: 1, row: 2, desc: "Réduit de 8% le délai de recharge pour ajouter des éléments de campement." },
        { id: "grand-voyageur", name: "Grand voyageur", icon: "achievement_guild_ridelikethewind", maxRank: 1, tier: 10, col: 2, row: 2, desc: "Vous bénéficiez d'une réduction de 50% sur toutes les liaisons de vol, et votre monture volante vole 20% plus vite." },
        { id: "medecine-de-terrain", name: "Médecine de terrain", icon: "inv_misc_bandage_05", maxRank: 2, tier: 5, col: 1, row: 3, desc: "Réduit de 5 sec la durée de l'effet « Récemment pansé » lorsque vous utilisez un Bandage. Inefficace en donjon, en raid et en champ de bataille." }
      ]
    },
    {
      id: "ingeniosite",
      name: "Ingéniosité",
      icon: "inv_misc_bag_08",
      desc: "Entretien, réputation et honneur.",
      nodes: [
        { id: "pour-un-plus-grand-honneur", name: "Pour un plus grand honneur", icon: "achievement_bg_winwsg", maxRank: 5, tier: 5, col: 1, row: 0, desc: "Augmente les Points d'honneur gagnés de 2%." },
        { id: "gourmet", name: "Gourmet", icon: "inv_misc_food_64", maxRank: 3, tier: 0, col: 0, row: 1, desc: "Augmente de 33% la durée des effets bénéfiques procurés par la nourriture." },
        { id: "permanence", name: "Permanence", icon: "spell_misc_emotionhappy", maxRank: 2, tier: 5, col: 1, row: 1, desc: "Les bonus de statistiques ou d'attributs de longue durée que vos capacités de classe accordent au groupe ou au raid durent 50% plus longtemps, tout comme les bienfaits obtenus en vous reposant à un campement." },
        { placeholder: true, col: 2, row: 1 },
        { placeholder: true, col: 3, row: 1 },
        { id: "les-vifs-et-les-morts", name: "Les vifs et les morts", icon: "spell_shadow_deadofnight", maxRank: 2, tier: 0, col: 0, row: 2, desc: "Augmente votre vitesse de déplacement de 5% lorsque vous êtes mort, et vos sorts et capacités bénéfiques ne coûtent plus de ressources pendant 1 min après une résurrection ou jusqu'à ce que vous entriez en combat." },
        { id: "economie-de-reactifs", name: "Économie de réactifs", icon: "inv_misc_candle_02", maxRank: 1, tier: 10, col: 2, row: 2, desc: "Vos capacités de classe ne nécessitent plus de réactifs achetables chez un marchand, et vos éléments de campement de rang 1 ne coûtent aucun réactif à fabriquer." },
        { id: "renforcement", name: "Renforcement", icon: "inv_misc_armorkit_17", maxRank: 5, tier: 0, col: 0, row: 3, desc: "Vous perdez 8% de durabilité en moins lorsque vous mourez." },
        { id: "diplomate", name: "Diplomate", icon: "inv_scroll_03", maxRank: 5, tier: 5, col: 1, row: 3, desc: "Augmente vos gains de réputation de 2%." }
      ]
    }
  ];

  // Presets (Phase 3). Uniquement des nœuds existants ci-dessus, 16 points,
  // paliers respectés (vérifié par tools/tests/heritage-path.test.mjs).
  // Talentueux : un seul point (seul le rang 1 est connu).
  var PRESETS = [
    {
      id: "leveling",
      name: "Premier perso leveling",
      desc: "Arbre Aventure : repos, soins entre les combats, vols moins chers.",
      ranks: {
        "aventure__bien-repose": 5,
        "aventure__frisson-aventure": 5,
        "aventure__talentueux": 1,
        "aventure__grand-voyageur": 1,
        "aventure__medecine-de-terrain": 2,
        "aventure__haute-vigilance": 2
      }
    },
    {
      id: "metiers",
      name: "Métiers",
      desc: "Arbre Métiers : montée des métiers, récolte, or.",
      ranks: {
        "metiers__travail-acharne": 5,
        "metiers__recolte-abondante": 5,
        "metiers__etude-assidue": 1,
        "metiers__marchandage": 2,
        "metiers__prime-de-rendement": 3
      }
    },
    {
      id: "qdv60",
      name: "Qualité de vie niveau 60",
      desc: "Arbre Ingéniosité : nourriture, durabilité, réactifs, réputation.",
      ranks: {
        "ingeniosite__gourmet": 3,
        "ingeniosite__renforcement": 5,
        "ingeniosite__les-vifs-et-les-morts": 2,
        "ingeniosite__economie-de-reactifs": 1,
        "ingeniosite__permanence": 2,
        "ingeniosite__diplomate": 3
      }
    }
  ];

  var api = { trees: TREES, presets: PRESETS };
  if (typeof module === "object" && module.exports) module.exports = api;
  if (root) root.HERITAGE_FR = api;
})(typeof window !== "undefined" ? window : null);
