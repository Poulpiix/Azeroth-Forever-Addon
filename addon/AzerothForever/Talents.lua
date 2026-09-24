-- Azeroth Forever : arbres de talents de classe.
--
-- Section 1 : portage Lua de data/build-path.js (docs/BUILD_CODEC.md).
-- Logique pure, sans UI : catalogue, ?build=, ?path=, règles, ordre automatique.
-- Doit rester bit-à-bit compatible avec le site (mêmes tests que
-- tools/tests/build-path.test.mjs côté site).
local ADDON_NAME, AF = ...

local BP = {}
AF.BuildPath = BP

local C = AF.Data.Constants
local ALPHABET = C.ALPHABET
local PATH_VERSION = C.PATH_VERSION
local MAX_POINTS = C.MAX_POINTS
local MAX_LEVEL = C.MAX_LEVEL
local TALENTED_KNOWN_MAX = C.TALENTED_KNOWN_MAX
local TALENTED_MAX_STORED = C.TALENTED_MAX_STORED

local ALPHABET_INDEX = {}
for i = 1, #ALPHABET do
  ALPHABET_INDEX[ALPHABET:sub(i, i)] = i - 1
end

-- ---------- Catalogue ----------

-- Catalogue stable d'une classe : les talents à plat, arbre par arbre, dans
-- l'ordre des données (= ordre de ?build=). L'index (0-based, comme le site)
-- sert de caractère dans ?path=.
function BP.catalog(cls)
  local entries = {}
  local byId = {}
  for treeIdx, tree in ipairs(cls.trees) do
    for talentIdx, talent in ipairs(tree.talents) do
      local entry = {
        index = #entries, -- 0-based, comme ALPHABET[index] côté site
        treeIdx = treeIdx,
        talentIdx = talentIdx,
        tree = tree,
        talent = talent
      }
      entries[#entries + 1] = entry
      byId[talent.id] = entry
    end
  end
  if #entries > #ALPHABET then
    error("Catalogue trop grand pour ?path= : " .. #entries .. " talents")
  end
  return { cls = cls, entries = entries, byId = byId }
end

function BP.emptyRanks(cat)
  local ranks = {}
  for _, e in ipairs(cat.entries) do ranks[e.talent.id] = 0 end
  return ranks
end

-- ---------- ?build= (format historique, inchangé) ----------

function BP.parseBuild(cat, str)
  local ranks = BP.emptyRanks(cat)
  if not str or str == "" then return ranks end
  local blocks = {}
  for block in (str .. "-"):gmatch("([^%-]*)%-") do
    blocks[#blocks + 1] = block
  end
  for treeIdx, tree in ipairs(cat.cls.trees) do
    local block = blocks[treeIdx] or ""
    for talentIdx, talent in ipairs(tree.talents) do
      local ch = block:sub(talentIdx, talentIdx)
      local rank = tonumber(ch)
      if rank then
        ranks[talent.id] = math.max(0, math.min(talent.maxRank, rank))
      end
    end
  end
  return ranks
end

function BP.serializeBuild(cat, ranks)
  local blocks = {}
  for _, tree in ipairs(cat.cls.trees) do
    local chars = {}
    for _, t in ipairs(tree.talents) do
      chars[#chars + 1] = tostring(ranks[t.id] or 0)
    end
    blocks[#blocks + 1] = table.concat(chars)
  end
  return table.concat(blocks, "-")
end

function BP.totalOf(ranks)
  local sum = 0
  for _, v in pairs(ranks) do sum = sum + (v or 0) end
  return sum
end

function BP.sameRanks(cat, a, b)
  for _, e in ipairs(cat.entries) do
    if (a[e.talent.id] or 0) ~= (b[e.talent.id] or 0) then return false end
  end
  return true
end

-- ---------- Niveaux ----------

function BP.effectiveTalented(talented)
  local t = tonumber(talented) or 0
  return math.max(0, math.min(TALENTED_KNOWN_MAX, t))
end

function BP.firstLevel(talented)
  return 10 - BP.effectiveTalented(talented)
end

function BP.pointsAvailable(level, talented)
  local lvl = tonumber(level) or 0
  local pts = lvl - (BP.firstLevel(talented) - 1)
  return math.max(0, math.min(MAX_POINTS, pts))
end

function BP.levelOfPoint(n, talented)
  return math.min(MAX_LEVEL, BP.firstLevel(talented) - 1 + n)
end

-- ---------- ?path= ----------

-- Format : <version "1"><Talentueux 0-7><1 caractère par point>.
function BP.encodePath(cat, order, talented)
  local t = math.max(0, math.min(TALENTED_MAX_STORED, tonumber(talented) or 0))
  local chars = { PATH_VERSION, tostring(t) }
  for _, idx in ipairs(order) do
    chars[#chars + 1] = ALPHABET:sub(idx + 1, idx + 1)
  end
  return table.concat(chars)
end

function BP.decodePath(cat, str)
  local result = { ok = false, talented = 0, order = {}, error = "" }
  if type(str) ~= "string" or #str < 2 then
    result.error = "Parcours vide ou tronqué."
    return result
  end
  if str:sub(1, 1) ~= PATH_VERSION then
    result.error = "Version de parcours inconnue."
    return result
  end
  local t = str:sub(2, 2)
  if not t:match("^[0-7]$") then
    result.error = "En-tête de parcours invalide."
    return result
  end
  result.talented = tonumber(t)
  local body = str:sub(3)
  if #body > MAX_POINTS then
    result.error = "Parcours trop long (plus de 51 points)."
    return result
  end
  for i = 1, #body do
    local ch = body:sub(i, i)
    local idx = ALPHABET_INDEX[ch]
    if idx == nil or idx >= #cat.entries then
      result.error = "Caractère de parcours invalide."
      result.order = {}
      return result
    end
    result.order[#result.order + 1] = idx
  end
  result.ok = true
  return result
end

-- ---------- Règles ----------

local function tierNeeded(talent)
  return 5 * talent.row
end

local function findInTree(tree, id)
  for _, t in ipairs(tree.talents) do
    if t.id == id then return t end
  end
  return nil
end

-- Vérifie qu'on peut acheter le prochain rang de `entry` dans l'état courant.
function BP.checkStep(cat, entry, ranks, treePts, total)
  if not entry then
    return { ok = false, code = "unknown", message = "Talent inconnu dans ce parcours." }
  end
  local talent = entry.talent
  local current = ranks[talent.id] or 0
  if current >= talent.maxRank then
    return { ok = false, code = "maxed", message = talent.name .. " est déjà au rang maximum (" .. talent.maxRank .. ")." }
  end
  if total >= MAX_POINTS then
    return { ok = false, code = "cap", message = "Plafond de 51 points atteint." }
  end
  for _, req in ipairs(talent.requires or {}) do
    if (ranks[req.id] or 0) < req.qty then
      local reqTalent = findInTree(entry.tree, req.id)
      return {
        ok = false,
        code = "prereq",
        message = talent.name .. " nécessite " .. (reqTalent and reqTalent.name or "un autre talent") .. " au rang " .. req.qty .. "."
      }
    end
  end
  local need = tierNeeded(talent)
  local have = treePts[entry.treeIdx] or 0
  if have < need then
    return {
      ok = false,
      code = "tier",
      message = talent.name .. " nécessite " .. need .. " points dans l'arbre " .. entry.tree.name .. " (" .. have .. " à ce moment du parcours)."
    }
  end
  return { ok = true }
end

-- Rejoue un ordre (indices 0-based). Renvoie { ok, step (0-based), code, message }.
function BP.validateOrder(cat, order)
  local ranks = BP.emptyRanks(cat)
  local treePts = {}
  for i = 1, #cat.cls.trees do treePts[i] = 0 end
  local total = 0
  for i, idx in ipairs(order) do
    local entry = cat.entries[idx + 1]
    local check = BP.checkStep(cat, entry, ranks, treePts, total)
    if not check.ok then
      return { ok = false, step = i - 1, code = check.code, message = check.message, level = i }
    end
    ranks[entry.talent.id] = ranks[entry.talent.id] + 1
    treePts[entry.treeIdx] = treePts[entry.treeIdx] + 1
    total = total + 1
  end
  return { ok = true, step = -1 }
end

-- Rangs obtenus après les `count` premiers points de l'ordre (tous si omis).
function BP.ranksFromOrder(cat, order, count)
  local ranks = BP.emptyRanks(cat)
  local n = count
  if n == nil or n > #order then n = #order end
  if n < 0 then n = 0 end
  for i = 1, n do
    local entry = cat.entries[order[i] + 1]
    if entry then ranks[entry.talent.id] = ranks[entry.talent.id] + 1 end
  end
  return ranks
end

-- Ordre automatique déterministe (Mode Fin) : arbre par arbre dans l'ordre de
-- l'UI, rangée par rangée, prérequis avant le talent qui en dépend, chaque
-- talent monté jusqu'à son rang final avant le suivant.
function BP.autoOrder(cat, ranks)
  local order = {}
  local placed = {}

  local function place(entry, guard)
    local talent = entry.talent
    if placed[talent.id] or guard[talent.id] then return end
    local target = ranks[talent.id] or 0
    if target <= 0 then return end
    guard[talent.id] = true
    for _, req in ipairs(talent.requires or {}) do
      local reqEntry = cat.byId[req.id]
      if reqEntry and reqEntry.treeIdx == entry.treeIdx then place(reqEntry, guard) end
    end
    placed[talent.id] = true
    for _ = 1, target do order[#order + 1] = entry.index end
  end

  for _, entry in ipairs(cat.entries) do place(entry, {}) end
  return order
end

-- ---------- Opérations d'édition (Mode Parcours) ----------

-- Ajoute un rang de `index` (0-based) à la fin de l'ordre.
function BP.append(cat, order, index)
  local entry = cat.entries[index + 1]
  local ranks = BP.ranksFromOrder(cat, order)
  local treePts = {}
  for i = 1, #cat.cls.trees do treePts[i] = 0 end
  for _, idx in ipairs(order) do
    local e = cat.entries[idx + 1]
    treePts[e.treeIdx] = treePts[e.treeIdx] + 1
  end
  local check = BP.checkStep(cat, entry, ranks, treePts, #order)
  if not check.ok then
    return { ok = false, order = order, code = check.code, message = check.message }
  end
  local next_ = {}
  for _, v in ipairs(order) do next_[#next_ + 1] = v end
  next_[#next_ + 1] = index
  return { ok = true, order = next_ }
end

local function lowerFirst(s)
  if not s or s == "" then return s end
  return s:sub(1, 1):lower() .. s:sub(2)
end

-- Retire le DERNIER rang de ce talent dans l'ordre (pas forcément le dernier
-- point global). Refusé si l'ordre devient invalide.
function BP.removeLastOf(cat, order, index)
  local pos = nil
  for i = #order, 1, -1 do
    if order[i] == index then pos = i; break end
  end
  if not pos then
    return { ok = false, order = order, code = "empty", message = "" }
  end
  local next_ = {}
  for i, v in ipairs(order) do
    if i ~= pos then next_[#next_ + 1] = v end
  end
  local wasValid = BP.validateOrder(cat, order).ok
  local check = BP.validateOrder(cat, next_)
  if wasValid and not check.ok then
    local talent = cat.entries[index + 1].talent
    return {
      ok = false,
      order = order,
      code = check.code,
      message = "Impossible de retirer " .. talent.name .. " : " .. lowerFirst(check.message)
    }
  end
  return { ok = true, order = next_ }
end

function BP.withoutTree(cat, order, treeIdx)
  local out = {}
  for _, idx in ipairs(order) do
    if cat.entries[idx + 1].treeIdx ~= treeIdx then out[#out + 1] = idx end
  end
  return out
end

-- Lignes de la liste « Parcours de montée ».
function BP.steps(cat, order, talented)
  local ranks = BP.emptyRanks(cat)
  local out = {}
  for i, idx in ipairs(order) do
    local entry = cat.entries[idx + 1]
    ranks[entry.talent.id] = ranks[entry.talent.id] + 1
    out[#out + 1] = {
      n = i,
      level = BP.levelOfPoint(i, talented),
      treeIdx = entry.treeIdx,
      treeName = entry.tree.name,
      talentId = entry.talent.id,
      talentName = entry.talent.name,
      rank = ranks[entry.talent.id],
      maxRank = entry.talent.maxRank
    }
  end
  return out
end

-- =======================================================================
-- Section 2 : état du plan (par personnage/classe) et application en jeu.
-- Planifier ne dépense rien : seul un clic joueur sur Appliquer appelle
-- LearnTalent. Pas d'auto-apply par défaut (voir option ci-dessous).
-- =======================================================================

local Talents = {}
AF.Talents = Talents

local catalogCache = {}

function Talents:GetCatalog(classId)
  if not catalogCache[classId] then
    local cls = AF:GetClassData(classId)
    if cls then catalogCache[classId] = BP.catalog(cls) end
  end
  return catalogCache[classId]
end

function Talents:GetPlan(classId)
  return AF:GetPlanFor(classId)
end

function Talents:GetPlannedRanks(classId)
  local cat = self:GetCatalog(classId)
  local plan = self:GetPlan(classId)
  if not cat then return {} end
  return BP.ranksFromOrder(cat, plan.order)
end

function Talents:GetMode()
  return (AzerothForeverDB and AzerothForeverDB.options and AzerothForeverDB.options.mode) or "final"
end

function Talents:SetMode(mode)
  AzerothForeverDB.options.mode = mode
end

-- Mode "Build au niveau 60" (Mode Fin du site) : fixe le rang final d'un
-- talent, l'ordre est recalculé automatiquement. Refusé si ça rend le build
-- impossible à obtenir point par point.
function Talents:SetFinalRank(classId, index, newRank)
  local cat = self:GetCatalog(classId)
  if not cat then return false, "Classe inconnue." end
  local plan = self:GetPlan(classId)
  local ranks = BP.ranksFromOrder(cat, plan.order)
  local entry = cat.entries[index + 1]
  if not entry then return false, "Talent inconnu." end
  newRank = math.max(0, math.min(entry.talent.maxRank, newRank))
  ranks[entry.talent.id] = newRank
  local newOrder = BP.autoOrder(cat, ranks)
  local check = BP.validateOrder(cat, newOrder)
  if not check.ok then
    return false, check.message
  end
  plan.order = newOrder
  return true
end

-- Mode "Build niveau par niveau" (Mode Parcours du site) : ajoute/retire un
-- rang à la fin de l'ordre planifié.
function Talents:AppendPoint(classId, index)
  local cat = self:GetCatalog(classId)
  if not cat then return false, "Classe inconnue." end
  local plan = self:GetPlan(classId)
  local res = BP.append(cat, plan.order, index)
  if not res.ok then return false, res.message end
  plan.order = res.order
  return true
end

function Talents:RemoveLastPoint(classId, index)
  local cat = self:GetCatalog(classId)
  if not cat then return false, "Classe inconnue." end
  local plan = self:GetPlan(classId)
  local res = BP.removeLastOf(cat, plan.order, index)
  if not res.ok then return false, res.message end
  plan.order = res.order
  return true
end

function Talents:ResetPlan(classId)
  local plan = self:GetPlan(classId)
  plan.order = {}
  plan.talented = 0
end

-- Charge un ordre + Talentueux dans le plan (utilisé par l'import AF1-).
function Talents:LoadOrder(classId, order, talented)
  local plan = self:GetPlan(classId)
  plan.order = order
  plan.talented = talented or 0
end

function Talents:UndoLastPoint(classId)
  local plan = self:GetPlan(classId)
  if #plan.order == 0 then return false end
  table.remove(plan.order)
  return true
end

-- ---------- Lecture de l'état réellement appris en jeu ----------

-- Table (treeOrder,row,col) -> talent, pour retrouver vite l'API du jeu.
local function buildSlotIndex(cat)
  local byTab = {}
  for _, tree in ipairs(cat.cls.trees) do
    byTab[tree.order + 1] = tree
  end
  return byTab
end

function Talents:GetActualRanks(classId)
  local cat = self:GetCatalog(classId)
  local ranks = BP.emptyRanks(cat)
  if not cat or type(GetNumTalents) ~= "function" then return ranks end
  local byTab = buildSlotIndex(cat)
  for tabIndex, tree in pairs(byTab) do
    local n = GetNumTalents(tabIndex) or 0
    for i = 1, n do
      local _, _, tier, column, rank = GetTalentInfo(tabIndex, i)
      for _, talent in ipairs(tree.talents) do
        if talent.row == tier and talent.col == column then
          ranks[talent.id] = rank or 0
        end
      end
    end
  end
  return ranks
end

-- Retrouve l'emplacement (tabIndex, talentIndex) du jeu pour un talent du
-- catalogue, en comparant ligne/colonne (mêmes conventions que le jeu : 0-based).
function Talents:FindGameSlot(entry)
  if type(GetNumTalents) ~= "function" then return nil end
  local tabIndex = entry.tree.order + 1
  local n = GetNumTalents(tabIndex) or 0
  for i = 1, n do
    local _, _, tier, column = GetTalentInfo(tabIndex, i)
    if tier == entry.talent.row and column == entry.talent.col then
      return tabIndex, i
    end
  end
  return nil
end

-- Premier point du plan pas encore appris en jeu (dans l'ordre planifié), ou nil.
function Talents:NextPendingStep(classId)
  local cat = self:GetCatalog(classId)
  if not cat then return nil end
  local plan = self:GetPlan(classId)
  local actual = self:GetActualRanks(classId)
  local seen = {}
  for _, idx in ipairs(plan.order) do
    local entry = cat.entries[idx + 1]
    seen[entry.talent.id] = (seen[entry.talent.id] or 0) + 1
    if seen[entry.talent.id] > (actual[entry.talent.id] or 0) then
      return entry
    end
  end
  return nil
end

-- Recharge le plan depuis l'état réellement appris en jeu.
function Talents:SyncPlanFromGame(classId)
  local cat = self:GetCatalog(classId)
  if not cat then return end
  local ranks = self:GetActualRanks(classId)
  local plan = self:GetPlan(classId)
  plan.order = BP.autoOrder(cat, ranks)
end

-- ---------- Application (Appliquer le prochain / Appliquer tout) ----------
-- Ces deux fonctions ne sont appelées que depuis un OnClick de bouton
-- (Core.lua/UI.lua) : jamais depuis un évènement automatique.

function Talents:ApplyNext()
  local classId = AF.classId
  if not classId then return end
  local entry = self:NextPendingStep(classId)
  if not entry then
    AF:Print("Rien à appliquer : le plan est déjà appris en jeu.")
    return
  end
  local tabIndex, talentIndex = self:FindGameSlot(entry)
  if not tabIndex then
    AF:Print("Talent introuvable en jeu (" .. entry.talent.name .. ") : le catalogue a peut-être changé, mets à jour l'addon.")
    return
  end
  LearnTalent(tabIndex, talentIndex)
end

function Talents:ApplyAll()
  self._applyAllPending = true
  self:ApplyNext()
end

function Talents:CancelApplyAll()
  self._applyAllPending = false
end

-- Appelé par Core.lua sur PLAYER_TALENT_UPDATE / CHARACTER_POINTS_CHANGED.
function Talents:OnGameTalentsChanged()
  if AF.UI and AF.UI.RefreshTalents then AF.UI:RefreshTalents() end
  if self._applyAllPending then
    local classId = AF.classId
    local entry = classId and self:NextPendingStep(classId)
    if entry then
      self:ApplyNext()
    else
      self._applyAllPending = false
    end
  end
end
