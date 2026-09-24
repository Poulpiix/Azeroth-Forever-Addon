-- Azeroth Forever : grimoire des sorts de la classe (lecture seule).
--
-- Reprend telles quelles les descriptions de rangs fournies par
-- data/talents-data.js (aucune invention de tooltip). Sert l'onglet Sorts.
local ADDON_NAME, AF = ...

local Spellbook = {}
AF.Spellbook = Spellbook

-- Liste à plat des talents d'une classe pour l'onglet Sorts, triés arbre puis
-- ligne puis colonne (ordre d'apprentissage naturel dans l'arbre).
function Spellbook:GetEntries(classId)
  local cls = AF:GetClassData(classId)
  if not cls then return {} end
  local entries = {}
  for _, tree in ipairs(cls.trees) do
    for _, talent in ipairs(tree.talents) do
      entries[#entries + 1] = {
        treeName = tree.name,
        talentId = talent.id,
        name = talent.name,
        icon = talent.icon,
        maxRank = talent.maxRank,
        ranks = talent.ranks -- { spellId, desc } par rang, tel que fourni par la donnée
      }
    end
  end
  return entries
end

-- Description affichée pour le rang courant (ou le rang 1 si non appris) d'un
-- talent. N'invente rien : renvoie la description fournie par la donnée, ou
-- une chaîne vide si absente.
function Spellbook:GetRankDescription(entry, rank)
  rank = math.max(1, math.min(entry.maxRank, rank or 1))
  local r = entry.ranks[rank]
  return r and r.desc or ""
end

function Spellbook:GetRankSpellId(entry, rank)
  rank = math.max(1, math.min(entry.maxRank, rank or 1))
  local r = entry.ranks[rank]
  return r and r.spellId or 0
end
