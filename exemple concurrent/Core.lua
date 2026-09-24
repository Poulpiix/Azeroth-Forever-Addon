-- Talents Forever: the calculator's rules, share codes and saved builds, inside the game.
-- Everything in here is a sandbox. Nothing touches your character until Game.Learn is called from a click in the UI.
local ADDON, TF = ...
TalentsForeverBook = TF
local D = TalentsForeverBookData
TF.D = D
TF.VERSION = (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(ADDON, "Version")) or (GetAddOnMetadata and GetAddOnMetadata(ADDON, "Version")) or "?"
TF.SITE = "https://talentsforever.com"
TF.GOLD = "|cffffd75e"

BINDING_HEADER_TALENTSFOREVERBOOK = "Talents Forever"
BINDING_NAME_TALENTSFOREVERBOOK_TOGGLE = "Open or close the planner"
BINDING_NAME_TALENTSFOREVERBOOK_NEXT = "Apply the next planned point"

-- ---------- small helpers ----------
TF.log = {}
function TF.Log(fmt, ...)
  local ok, s = pcall(string.format, fmt, ...)
  s = ok and s or tostring(fmt)
  TF.log[#TF.log + 1] = date("%H:%M:%S ") .. s
  if #TF.log > 200 then table.remove(TF.log, 1) end
end
function TF.Print(fmt, ...)
  local ok, s = pcall(string.format, fmt, ...)
  print(TF.GOLD .. "Talents Forever|r " .. (ok and s or tostring(fmt)))
end
-- call a function that may not exist or may throw, and keep a note instead of an error box
function TF.Try(label, fn, ...)
  if type(fn) ~= "function" then TF.Log("%s: no such function", label); return nil end
  local r = { pcall(fn, ...) }
  if not r[1] then TF.Log("%s: %s", label, tostring(r[2])); return nil end
  return r[2], r[3], r[4], r[5], r[6], r[7], r[8]
end

local callbacks = {}
function TF.On(ev, fn) callbacks[ev] = callbacks[ev] or {}; table.insert(callbacks[ev], fn) end
function TF.Fire(ev, ...) for _, fn in ipairs(callbacks[ev] or {}) do local ok, err = pcall(fn, ...); if not ok then TF.Log("callback %s: %s", ev, tostring(err)) end end end

-- ---------- saved variables ----------
function TF.InitDB()
  if type(TalentsForeverBookDB) ~= "table" then TalentsForeverBookDB = {} end
  local db = TalentsForeverBookDB
  db.version = 1
  db.builds = db.builds or {}
  db.chars = db.chars or {}
  db.settings = db.settings or {}
  db.diag = db.diag or {}
  db.prices = db.prices or {}
  db.sent = db.sent or {}   -- the notes sent from this account: tag, when, class, level, the words; so a reply can find its way back
  local s = db.settings
  if s.levelUpNudge == nil then s.levelUpNudge = true end
  if s.sounds == nil then s.sounds = true end
  if s.minimap == nil then s.minimap = { angle = 200, hide = false } end
  if s.showPlan == nil then s.showPlan = true end
  if s.scale == nil then s.scale = 1 end
  if s.marks == nil then s.marks = false end
  if s.pickRates == nil then s.pickRates = false end
  if s.sideTab == nil then s.sideTab = "plan" end
  if s.autoApply == nil then s.autoApply = false end
  -- 0.31.2: placing on level up starts off. Older saves had it on without a choice (Follow the top build switched it on);
  -- once, it goes off unless the player is still following.
  if not s.autoApplyChosen then s.autoApplyChosen = true; if not s.starter then s.autoApply = false end end
  if s.path == nil then s.path = true end
  if s.overlay == nil then s.overlay = true end
  if s.motes == nil then s.motes = true end
  if s.trainerAlerts == nil then s.trainerAlerts = true end
  if s.starter == nil then s.starter = false end
  if s.talentsKey == nil then s.talentsKey = false end
  TF.db = db
  return db
end
function TF.CharKey() return (UnitName("player") or "?") .. "-" .. (GetRealmName() or "") end
function TF.CharDB()
  local db = TF.db or TF.InitDB()
  local k = TF.CharKey()
  db.chars[k] = db.chars[k] or {}
  return db.chars[k]
end

-- ---------- class data ----------
function TF.PlayerClass() local _, cf = UnitClass("player"); return cf end
function TF.ClassData(cf) return D.classes[cf or TF.PlayerClass()] end
function TF.ClassByName(name)
  name = (name or ""):lower()
  for cf, c in pairs(D.classes) do if c.name:lower() == name then return cf end end
end
function TF.ClassColor(cf)
  local c = D.classes[cf]
  local hex = c and c.color or "ffd75e"
  return tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255, hex
end

-- ---------- the plan ----------
-- plan = { cls = "WARRIOR", level = 60, ranks = { {0,0,...}, {...}, {...} }, order = { {ti, i}, ... }, orderKnown = bool }
function TF.NewPlan(cf, level)
  local c = D.classes[cf]
  local p = { cls = cf, level = level or 60, ranks = {}, order = {}, orderKnown = false }
  for ti, tree in ipairs(c.trees) do p.ranks[ti] = {}; for i = 1, #tree.talents do p.ranks[ti][i] = 0 end end
  return p
end
local function clampPlan(p)
  local c = D.classes[p.cls]; if not c then return nil end
  p.level = math.min(60, math.max(8, tonumber(p.level) or 60))
  p.ranks = p.ranks or {}; p.order = p.order or {}
  for ti, tree in ipairs(c.trees) do
    p.ranks[ti] = p.ranks[ti] or {}
    for i, t in ipairs(tree.talents) do p.ranks[ti][i] = math.min(t.max, math.max(0, tonumber(p.ranks[ti][i]) or 0)) end
    for i = #tree.talents + 1, #p.ranks[ti] do p.ranks[ti][i] = nil end
  end
  return p
end
function TF.LoadPlan()
  local cd = TF.CharDB()
  local p = cd.plan and clampPlan(cd.plan)
  if not p or not D.classes[p.cls] then p = TF.NewPlan(TF.PlayerClass(), 60) end
  TF.plan = p
  cd.plan = p
  return p
end
function TF.SetPlan(p) TF.plan = clampPlan(p); TF.CharDB().plan = TF.plan; TF.Fire("PLAN_CHANGED"); return TF.plan end
-- a hand edit to a followed plan ends the following (the plan is the player's again); a match keeps it
TF.On("PLAN_CHANGED", function()
  local s = TF.db and TF.db.settings; if not s or not s.starter or not TF.starterCode then return end
  local p = TF.Decode(TF.starterCode)
  if not p or TF.plan.cls ~= TF.PlayerClass() then return end   -- looking at another class is not an edit
  local same = true
  for a = 1, #p.ranks do for b = 1, #p.ranks[a] do if (TF.plan.ranks[a] and TF.plan.ranks[a][b] or 0) ~= p.ranks[a][b] then same = false end end end
  if not same then s.starter = false; TF.Fire("STARTER_CHANGED", false, nil, "edited") end
end)
-- plan another class: the plan you leave is kept under its class on this character, the other class's plan comes back if there was one
function TF.SetClass(cf)
  if not D.classes[cf] or cf == TF.plan.cls then return false end
  local cd = TF.CharDB(); cd.plans = cd.plans or {}
  cd.plans[TF.plan.cls] = TF.plan
  local p = cd.plans[cf] and clampPlan(cd.plans[cf]) or TF.NewPlan(cf, TF.plan.level)
  TF.SetPlan(p)
  return true
end

-- Talented (Legacy perk): each rank moves the first talent point one level earlier. Read from the game when it can be, else remembered.
function TF.TalentedRank()
  local g = TF.Game and TF.Game.legacy
  if g and g.talented then return g.talented end
  return TF.CharDB().talented or 0
end

-- ---------- the rules, the same as the site's ----------
function TF.Pool(p) p = p or TF.plan; return math.min(51, math.max(0, p.level - 9 + TF.TalentedRank())) end
function TF.TreePts(p, ti) local n = 0; for _, r in ipairs(p.ranks[ti]) do n = n + r end; return n end
function TF.TotalPts(p) local n = 0; for ti = 1, #p.ranks do n = n + TF.TreePts(p, ti) end; return n end
function TF.Above(p, ti, row)
  local tree = D.classes[p.cls].trees[ti]; local n = 0
  for i, t in ipairs(tree.talents) do if t.row < row then n = n + p.ranks[ti][i] end end
  return n
end
-- why this talent cannot take a point yet (nil when it can, points allowing)
function TF.Gate(p, ti, i)
  local tree = D.classes[p.cls].trees[ti]; local t = tree.talents[i]
  local need = (t.row - 1) * 5
  if TF.Above(p, ti, t.row) < need then return string.format("Requires %d points in %s Talents", need, tree.name) end
  if t.req then
    local pre = tree.talents[t.req]
    if p.ranks[ti][t.req] < pre.max then return string.format("Requires %d point%s in %s", pre.max, pre.max > 1 and "s" or "", pre.name) end
  end
  return nil
end
function TF.CanAdd(p, ti, i)
  local t = D.classes[p.cls].trees[ti].talents[i]
  if p.ranks[ti][i] >= t.max then return "Max rank" end
  local g = TF.Gate(p, ti, i); if g then return g end
  if TF.TotalPts(p) >= TF.Pool(p) then
    if p.level < 60 then return string.format("All %d points at level %d are placed. Raise the level to plan further.", TF.Pool(p), p.level) end
    return string.format("All %d points spent. Take one back from another talent to move it.", TF.Pool(p))
  end
  return nil
end
function TF.CanRemove(p, ti, i)
  local tree = D.classes[p.cls].trees[ti]; local r = p.ranks[ti]
  if r[i] <= 0 then return false end
  r[i] = r[i] - 1
  local ok = true
  for j = 1, #tree.talents do if r[j] > 0 and TF.Gate(p, ti, j) then ok = false; break end end
  r[i] = r[i] + 1
  return ok
end
function TF.Status(p, ti, i)
  local t = D.classes[p.cls].trees[ti].talents[i]; local r = p.ranks[ti][i]
  if r >= t.max then return "maxed" elseif r > 0 then return "partial" elseif TF.Gate(p, ti, i) then return "locked" else return "avail" end
end

-- the order points were placed in, kept in step with the ranks (points taken back drop out, points the order never saw are appended tree by tree)
function TF.FixOrder(p)
  local seen, keep = {}, {}
  for _, o in ipairs(p.order or {}) do
    local k = o[1] .. ":" .. o[2]; seen[k] = (seen[k] or 0) + 1
    if p.ranks[o[1]] and p.ranks[o[1]][o[2]] and seen[k] <= p.ranks[o[1]][o[2]] then keep[#keep + 1] = { o[1], o[2] } end
  end
  for ti, tr in ipairs(p.ranks) do for i, v in ipairs(tr) do
    local k = ti .. ":" .. i
    for _ = math.min(seen[k] or 0, v) + 1, v do keep[#keep + 1] = { ti, i } end
  end end
  p.order = keep
  return keep
end
function TF.StartLevel() return 10 - TF.TalentedRank() end

function TF.Add(ti, i)
  local p = TF.plan
  local why = TF.CanAdd(p, ti, i)
  if why then return false, why end
  p.ranks[ti][i] = p.ranks[ti][i] + 1
  p.order = p.order or {}; p.order[#p.order + 1] = { ti, i }; p.orderKnown = true
  TF.Fire("PLAN_CHANGED", ti, i, 1)
  return true
end
-- within: only the first `within` points of the order are in view (a lower level is being looked at), so the point
-- that goes is the last one of this talent inside that window
function TF.Remove(ti, i, within)
  local p = TF.plan
  if not TF.CanRemove(p, ti, i) then return false, p.ranks[ti][i] > 0 and "Other talents depend on this point" or nil end
  TF.FixOrder(p)
  p.ranks[ti][i] = p.ranks[ti][i] - 1
  local from = #(p.order or {}); if within then from = math.min(from, within) end
  local gone = false
  for k = from, 1, -1 do if p.order[k][1] == ti and p.order[k][2] == i then table.remove(p.order, k); gone = true; break end end
  if not gone then for k = #p.order, 1, -1 do if p.order[k][1] == ti and p.order[k][2] == i then table.remove(p.order, k); break end end end
  TF.Fire("PLAN_CHANGED", ti, i, -1)
  return true
end
-- a copy of the plan before a move that replaces it, so Undo can bring it back
function TF.Remember()
  local p = TF.plan
  local snap = { cls = p.cls, level = p.level, ranks = {}, order = {}, orderKnown = p.orderKnown }
  for ti, row in ipairs(p.ranks) do snap.ranks[ti] = {}; for i, r in ipairs(row) do snap.ranks[ti][i] = r end end
  for k, o in ipairs(p.order) do snap.order[k] = { o[1], o[2] } end
  TF.undo = snap
end
function TF.Undo()
  local snap = TF.undo
  if not snap then return false end
  TF.undo = nil
  if snap.cls ~= TF.plan.cls then TF.SetClass(snap.cls) end
  TF.SetPlan(snap)
  return true
end
function TF.Reset()
  TF.Remember()
  local p = TF.plan
  for ti = 1, #p.ranks do for i = 1, #p.ranks[ti] do p.ranks[ti][i] = 0 end end
  p.order = {}; p.orderKnown = false
  TF.Fire("PLAN_CHANGED")
end
-- The level is where you look at the build from. Nothing is taken back when it drops: points that level cannot pay
-- for yet wait in the order and come back as it rises. TF.ViewRanks is what the trees show.
function TF.SetLevel(level)
  local p = TF.plan
  local to = math.min(60, math.max(TF.StartLevel(), math.floor((tonumber(level) or 60) + 0.5)))
  if to == p.level then return end
  p.level = to
  TF.Fire("PLAN_CHANGED")
end
-- the build as it stands at the plan's level: the first points of the order the level can pay for.
-- Returns the ranks and whether that is only part of the plan.
function TF.ViewRanks(p)
  p = p or TF.plan
  local pool = TF.Pool(p)
  if TF.TotalPts(p) <= pool then return p.ranks, false end
  local out = {}
  for ti, tr in ipairs(p.ranks) do out[ti] = {}; for i in ipairs(tr) do out[ti][i] = 0 end end
  local order = TF.FixOrder(p)
  for k = 1, math.min(pool, #order) do local o = order[k]; out[o[1]][o[2]] = out[o[1]][o[2]] + 1 end
  return out, true
end
-- the level a plan needs for every point it holds, and the level it travels with in a code
function TF.NeedLevel(p) p = p or TF.plan; return math.min(60, math.max(TF.StartLevel(), TF.TotalPts(p) + 9 - TF.TalentedRank())) end
function TF.FullLevel(p) p = p or TF.plan; return math.max(p.level, TF.NeedLevel(p)) end

-- ---------- share codes: exactly the site's ----------
-- v3 (18 Sep 2026): class/level/ranks-per-tree [-legacy x3, only when a perk is set] [-order] -3
-- Every digit segment loses its trailing zeros. The order is one symbol per run of points in the same talent (SYMS, flat
-- across the trees), with a digit 1-4 after it when the run stops short of the plan's total for that talent.
-- Older codes still read (TF.Decode): v2 ("-2": two digits per point, Legacy always along) and v1 (no marker, pre-beta order).
local SYMS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz056789"
local function trim0(s) return (s:gsub("0+$", "")) end
-- flat talent index across a class's trees: idx[ti * 100 + i] = f, at[f] = { ti, i }
local function flatIndex(c) local idx, at, f = {}, {}, 0 for ti, tree in ipairs(c.trees) do for i = 1, #tree.talents do f = f + 1; idx[ti * 100 + i] = f; at[f] = { ti, i } end end return idx, at end
function TF.Encode(p, legacyRanks)
  p = p or TF.plan
  local c = D.classes[p.cls]
  local segs = {}
  for ti = 1, #c.trees do segs[#segs + 1] = trim0(table.concat(p.ranks[ti], "")) end
  local order = TF.FixOrder(p)
  local oc = ""
  if p.orderKnown and #order > 0 then
    local idx = flatIndex(c); local left, out, k = {}, {}, 1
    for ti = 1, #c.trees do left[ti] = {}; for i, v in ipairs(p.ranks[ti]) do left[ti][i] = v end end
    while k <= #order do
      local ti, i = order[k][1], order[k][2]; local n = 1
      while order[k + n] and order[k + n][1] == ti and order[k + n][2] == i do n = n + 1 end
      local f, l = idx[ti * 100 + i], left[ti] and left[ti][i] or 0
      if f and l > 0 then out[#out + 1] = SYMS:sub(f, f) .. (n < l and tostring(n) or "") end
      if left[ti] then left[ti][i] = l - n end
      k = k + n
    end
    oc = table.concat(out)
  end
  local lg = legacyRanks or (TF.Game and TF.Game.legacy and TF.Game.legacy.ranks)
  local lTotal = 0
  if lg then for _, tr in ipairs(lg) do for _, v in ipairs(tr) do lTotal = lTotal + v end end end
  if lTotal > 0 then
    for li, tree in ipairs(D.legacy.trees) do
      local s = {}
      for i = 1, #tree.perks do s[i] = tostring(lg and lg[li] and lg[li][i] or 0) end
      segs[#segs + 1] = trim0(table.concat(s, ""))
    end
  end
  if oc ~= "" then segs[#segs + 1] = oc end
  segs[#segs + 1] = D.codeVersion
  return string.format("%s/%d/%s", c.name:lower(), TF.FullLevel(p), table.concat(segs, "-"))
end
-- every link the addon makes ends in ?a, so the site can count a visit that came from the addon. Two characters, nobody reads them.
TF.LINK_MARK = "?a"
function TF.ShareURL(p) return TF.SITE .. "/" .. TF.Encode(p) .. TF.LINK_MARK end

-- read a code, a site link or a pasted URL. Returns a plan, or nil and a reason.
function TF.Decode(str)
  str = tostring(str or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("[?#].*$", "")   -- a query or hash on a pasted link is not part of the code
  local cname, level, rest = str:match("(%a+)/(%d+)/([%w%-]*)%s*$")
  if not cname then return nil, "That does not look like a Talents Forever link or code." end
  local cf = TF.ClassByName(cname)
  if not cf then return nil, "Unknown class in that code: " .. cname end
  local c = D.classes[cf]
  local p = TF.NewPlan(cf, tonumber(level))
  local all = {}
  for s in (rest .. "-"):gmatch("([^%-]*)%-") do all[#all + 1] = s end
  local nt = #c.trees
  local last = all[#all]
  local v = (#all > nt and (last == "2" or last == "3")) and tonumber(last) or 1   -- the code's generation: 1 pre-beta, 2, 3
  local segs = {}
  for k = 1, (v > 1 and #all - 1 or #all) do segs[k] = all[k] end
  local old = D.orderV1 and D.orderV1[cf]
  if v == 1 and old then
    -- codes from before the beta trees list ranks in the old talent order: carry them over by name
    local byName = {}
    for ti, tree in ipairs(c.trees) do for i, t in ipairs(tree.talents) do byName[t.name] = { ti, i } end end
    for ti = 1, nt do
      local s = segs[ti] or ""
      for i = 1, #s do
        local nm = old[ti] and old[ti][i]; local at = nm and byName[nm]
        if at then p.ranks[at[1]][at[2]] = math.min(c.trees[at[1]].talents[at[2]].max, tonumber(s:sub(i, i)) or 0) end
      end
    end
  else
    for ti = 1, nt do
      local s = segs[ti] or ""
      for i = 1, #s do if p.ranks[ti][i] ~= nil then p.ranks[ti][i] = math.min(c.trees[ti].talents[i].max, tonumber(s:sub(i, i)) or 0) end end
    end
  end
  p.legacy = nil
  local extra = #segs - nt
  if extra >= 3 then
    p.legacy = {}
    for li, tree in ipairs(D.legacy.trees) do
      local s = segs[nt + li] or ""; p.legacy[li] = {}
      for i = 1, #tree.perks do p.legacy[li][i] = math.min(tree.perks[i].max, tonumber(s:sub(i, i)) or 0) end
    end
  end
  -- the order: after Legacy when Legacy is there, else (v3 only) straight after the trees
  local oseg = (extra >= 4 and segs[nt + 4]) or (v == 3 and extra == 1 and segs[nt + 1]) or nil
  if oseg then
    if v == 3 then
      local _, at = flatIndex(c); local taken, k = {}, 1
      while k <= #oseg do
        local f = SYMS:find(oseg:sub(k, k), 1, true)
        if f and at[f] then
          local ti, i = at[f][1], at[f][2]; local key = ti * 100 + i
          local n = (p.ranks[ti][i] or 0) - (taken[key] or 0)
          local nx = oseg:sub(k + 1, k + 1)
          if nx:match("^[1-4]$") then n = math.min(n, tonumber(nx)); k = k + 1 end
          for _ = 1, n do p.order[#p.order + 1] = { ti, i } end
          taken[key] = (taken[key] or 0) + n
        end
        k = k + 1
      end
    else
      for k = 1, #oseg - 1, 2 do
        local x = tonumber(oseg:sub(k, k + 1)) or 0
        local ti, i = math.floor(x / 20) + 1, (x % 20) + 1
        if c.trees[ti] and c.trees[ti].talents[i] then p.order[#p.order + 1] = { ti, i } end
      end
    end
    if #p.order > 0 then p.orderKnown = true end
  end
  -- never carry more points than the level allows
  clampPlan(p)
  return p
end

-- ---------- the plan against the character ----------
-- what the character has in game, as a plan-shaped rank table (nil when the game gave no answer)
function TF.LiveRanks(cf)
  local G = TF.Game
  if not G or not G.live or G.live.cls ~= (cf or TF.plan.cls) then return nil end
  local c = D.classes[G.live.cls]; local out = {}
  for ti, tree in ipairs(c.trees) do out[ti] = {}; for i in ipairs(tree.talents) do out[ti][i] = G.Rank(ti, i) or 0 end end
  return out
end
-- every point the plan has that the character does not, in the plan's order, with the level each point belongs to
function TF.NextUp(p)
  p = p or TF.plan
  local live = TF.LiveRanks(p.cls)
  local order = TF.FixOrder(p)
  local out, have, start = {}, {}, TF.StartLevel()
  for ti = 1, #p.ranks do have[ti] = {}; for i = 1, #p.ranks[ti] do have[ti][i] = live and live[ti][i] or 0 end end
  local counted = {}
  for k, e in ipairs(order) do
    local ti, i = e[1], e[2]
    local key = ti .. ":" .. i
    counted[key] = (counted[key] or 0) + 1
    local rank = counted[key]
    out[#out + 1] = { ti = ti, i = i, rank = rank, level = start + k - 1, done = live and (have[ti][i] >= rank) or false }
  end
  return out
end
function TF.Diff(p)
  p = p or TF.plan
  local live = TF.LiveRanks(p.cls); if not live then return nil end
  local missing, extra = 0, 0
  for ti = 1, #p.ranks do for i = 1, #p.ranks[ti] do
    local d = p.ranks[ti][i] - live[ti][i]
    if d > 0 then missing = missing + d elseif d < 0 then extra = extra - d end
  end end
  return missing, extra
end
function TF.PlanFromGame()
  TF.Remember()
  local live = TF.LiveRanks(TF.PlayerClass()); if not live then return false, "The game has not answered about your talents yet." end
  local p = TF.NewPlan(TF.PlayerClass(), math.max(TF.plan.level, UnitLevel("player")))
  p.ranks = live; p.order = {}; p.orderKnown = false
  TF.SetPlan(p)
  return true
end

-- ---------- trying a build: its talents ringed on your trees, next to yours ----------
-- Try lays another build over the plan as outlines: every tile it takes gets a gold ring, your own points stay exactly
-- as they are and nothing is swapped. Load it makes it the plan (with Undo); Stop takes the rings off.
TF.trial = nil
function TF.TryBuild(p, name)
  if not p then return false end
  TF.trial = { name = name or "a build", cls = p.cls, ranks = p.ranks, level = p.level, p = p }
  TF.Fire("PLAN_CHANGED")
  return true
end
function TF.TrialRank(ti, i)
  local t = TF.trial; if not t or t.cls ~= TF.plan.cls then return 0 end
  return t.ranks[ti] and t.ranks[ti][i] or 0
end
-- how the plan and the tried build differ: points only in the plan, only in the tried build, shared
function TF.TrialDiff()
  local t = TF.trial; if not t or t.cls ~= TF.plan.cls then return nil end
  local onlyPlan, onlyTrial, shared = 0, 0, 0
  for ti, tr in ipairs(TF.plan.ranks) do for i, r in ipairs(tr) do
    local g = t.ranks[ti] and t.ranks[ti][i] or 0
    shared = shared + math.min(r, g); if r > g then onlyPlan = onlyPlan + (r - g) elseif g > r then onlyTrial = onlyTrial + (g - r) end
  end end
  return onlyPlan, onlyTrial, shared
end
function TF.TrialBack()   -- Stop
  if not TF.trial then return false end
  TF.trial = nil; TF.Fire("PLAN_CHANGED")
  return true
end
function TF.TrialKeep()   -- Load it
  local t = TF.trial; if not t then return false end
  TF.Remember()
  if t.cls ~= TF.plan.cls then TF.SetClass(t.cls) end
  TF.trial = nil
  TF.SetPlan(t.p)
  return true
end

-- ---------- saved builds (account wide) ----------
function TF.SaveBuild(name)
  local p = TF.plan
  name = (name or ""):gsub("^%s+", ""):gsub("%s+$", "")
  if name == "" then name = D.classes[p.cls].name .. " " .. date("%d %b %H:%M") end
  local rec = { name = name, cls = p.cls, level = p.level, code = TF.Encode(p), when = time(), pts = {}, who = UnitName and UnitName("player") or nil }
  for ti = 1, #p.ranks do rec.pts[ti] = TF.TreePts(p, ti) end
  table.insert(TF.db.builds, 1, rec)
  TF.Fire("BUILDS_CHANGED")
  return rec
end
function TF.DeleteBuild(idx) table.remove(TF.db.builds, idx); TF.Fire("BUILDS_CHANGED") end
function TF.LoadBuild(idx)
  local b = TF.db.builds[idx]; if not b then return false end
  local p, err = TF.Decode(b.code); if not p then return false, err end
  TF.Remember()
  TF.SetPlan(p); return true
end
function TF.Popular(cf) return D.popular[cf or TF.plan.cls] end
-- the #1 build on the site for this class (the most shared, saved and opened one), the one Follow the top build takes
function TF.TopBuild(cf)
  local pop = TF.Popular(cf or TF.PlayerClass()); if not pop or not pop.top or not pop.top[1] then return nil end
  local b = pop.top[1]; local p = TF.Decode(b.code); if not p then return nil end
  return p, b
end
-- Follow the top build: the #1 popular build becomes the plan and each level the card asks before a point goes in. Off
-- again when the plan is changed by hand, so it never fights the player. Retail calls this Starter Build.
-- 0.32: it no longer switches hands-free placing on by itself. A Warrior nine points into Protection pressed Follow, the
-- next level-up put a point in another tree and the respec cost 2g (23 Sep). Placing without asking is its own switch.
function TF.SetStarter(on)
  local s = TF.db.settings
  if not on then s.starter = false; TF.Fire("STARTER_CHANGED", false); return true end
  local p, b = TF.TopBuild(TF.PlayerClass())
  if not p then return false, "No popular builds for this class yet." end
  if TF.plan.cls == p.cls and TF.Encode(TF.plan) ~= TF.Encode(p) then TF.Remember() end
  s.starter = true
  TF.starterCode = b.code
  TF.SetPlan(p)
  TF.Fire("STARTER_CHANGED", true, b)
  return true
end
function TF.LoadCode(str)
  TF.Remember()
  local p, err = TF.Decode(str)
  if not p then return false, err end
  TF.SetPlan(p)
  return true
end

-- ---------- the trainer: which spells and ranks arrive at a level (from the beta client's spellbook data) ----------
-- Is this trainer entry for this character? Rank 1 of a talent ability comes from the talent, not the trainer, and its later
-- ranks only matter to a plan that takes the talent. Some spells belong to certain races of a class (the Priest's racial
-- spells): those count only for a character of that race, and never while planning another class.
local raceOnly = {}
local function raceSpells(cf)
  if raceOnly[cf] == nil then
    local m = {}
    local cr = D.racials and D.racials.classRacials and D.racials.classRacials[cf]
    for race, lst in pairs(cr and cr.races or {}) do for _, a in ipairs(lst) do m[a.name] = m[a.name] or {}; m[a.name][race] = true end end
    raceOnly[cf] = m
  end
  return raceOnly[cf]
end
function TF.TrainerTeaches(cf, name, rec, rank)
  -- a rank the recorded city trainer does not list (src 2): a tome, a quest or a drop, nothing the trainer sells
  if rec.src and rec.src[rank] == 2 then return false end
  if rec.talent then
    if rank == 1 then return false end
    local p = TF.plan
    if not p or p.cls ~= cf then return false end
    local has = false
    for ti, tree in ipairs(D.classes[cf].trees) do for i, t in ipairs(tree.talents) do if t.name == name and p.ranks[ti][i] > 0 then has = true end end end
    if not has then return false end
  end
  local ro = raceSpells(cf)[name]
  if ro and not rec.seen then
    if cf ~= TF.PlayerClass() then return false end
    local race = (UnitRace("player")) or ""
    local mine = false
    for r in pairs(ro) do if race:find(r, 1, true) then mine = true end end
    if not mine then return false end
  end
  return true
end
function TF.NewSpellsAt(cf, level)
  local L = D.learn and D.learn[cf]; if not L then return {} end
  local out = {}
  for name, rec in pairs(L) do
    for r, lv in ipairs(rec.levels) do
      if lv == level and TF.TrainerTeaches(cf, name, rec, r) then out[#out + 1] = { name = name, rank = r, ranks = #rec.levels, icon = rec.icon, passive = rec.passive, portal = rec.src and rec.src[r] == 1 or nil } end
    end
  end
  -- brand new abilities first, then new ranks, each by name
  table.sort(out, function(a, b)
    if (a.rank == 1) ~= (b.rank == 1) then return a.rank == 1 end
    if a.name == b.name then return a.rank < b.rank end
    return a.name < b.name
  end)
  return out
end
-- the next level above `from` that brings something from the trainer for this character
function TF.NextTrainerLevel(cf, from)
  local L = D.learn and D.learn[cf]; if not L then return nil end
  local best
  for name, rec in pairs(L) do
    for r, lv in ipairs(rec.levels) do
      if lv > from and (not best or lv < best) and TF.TrainerTeaches(cf, name, rec, r) then best = lv end
    end
  end
  return best, best and TF.NewSpellsAt(cf, best) or {}
end
function TF.SpellsSummary(list, limit)
  local parts = {}
  for k, s in ipairs(list) do
    if limit and k > limit then parts[#parts + 1] = string.format("and %d more", #list - limit); break end
    local words = s.ranks > 1 and string.format("%s (rank %d)", s.name, s.rank) or s.name
    if s.portal then words = words .. " (portal trainer)" end
    parts[#parts + 1] = words
  end
  return table.concat(parts, ", ")
end

-- ---------- builds between players: a short addon message with the share code ----------
TF.PREFIX = "TFOREVER"
function TF.SendBuild(chatType, target, p)
  p = p or TF.plan
  local code = TF.Encode(p)
  local link = TF.SITE .. "/" .. code
  local c = D.classes[p.cls]
  local okA = false
  if C_ChatInfo and C_ChatInfo.SendAddonMessage then okA = pcall(C_ChatInfo.SendAddonMessage, TF.PREFIX, "B1\t" .. code, chatType, target) end
  local text = string.format("Talents Forever, %s build at level %d: %s", c.name, TF.FullLevel(p), link)
  if SendChatMessage then pcall(SendChatMessage, text, chatType, nil, target) end
  return okA
end
-- ask the group for everyone's build; each addon in the group answers with its plan as a build message (the usual card)
function TF.AskParty()
  local inGroup = (IsInGroup and IsInGroup()) or (GetNumGroupMembers and (GetNumGroupMembers() or 0) > 0)
  if not inGroup then return false, "You are not in a group." end
  if not (C_ChatInfo and C_ChatInfo.SendAddonMessage) then return false, "This client cannot send addon messages." end
  local ch = (IsInRaid and IsInRaid()) and "RAID" or "PARTY"
  local ok = pcall(C_ChatInfo.SendAddonMessage, TF.PREFIX, "Q1\t", ch)
  return ok and true or false, ok and nil or "Could not send."
end
function TF.AnswerParty(channel)
  local s = TF.db and TF.db.settings
  if s and s.answerParty == false then return false end
  local p = TF.plan; if not p or p.cls ~= TF.PlayerClass() or TF.TotalPts(p) == 0 then return false end
  local ch = (channel == "RAID" or channel == "PARTY" or channel == "INSTANCE_CHAT") and channel or "PARTY"
  return pcall(C_ChatInfo.SendAddonMessage, TF.PREFIX, "B1\t" .. TF.Encode(p), ch) and true or false
end
-- builds group members sent this session (their answer to Ask your group, or one they shared): shown on the Popular page
TF.group = {}
function TF.RememberGroupBuild(who, p, code)
  if not who or not p then return end
  TF.group[who] = { who = who, p = p, code = code, cls = p.cls, when = time() }
  TF.Fire("GROUP_CHANGED")
end
function TF.GroupBuilds()
  local out, now = {}, time()
  for who, g in pairs(TF.group) do if now - g.when > 3 * 3600 then TF.group[who] = nil else out[#out + 1] = g end end
  table.sort(out, function(a, b) if a.when ~= b.when then return a.when > b.when end; return a.who < b.who end)
  return out
end
function TF.ClearGroup() TF.group = {}; TF.Fire("GROUP_CHANGED") end
function TF.Ago(when)
  local d = time() - (when or 0)
  if d < 90 then return "just now" elseif d < 3600 then return string.format("%d min ago", math.floor(d / 60)) else return string.format("%d h ago", math.floor(d / 3600)) end
end
function TF.ReceiveBuild(text, sender)
  local kind, code = text:match("^(%u%d)\t(.+)$")
  if kind ~= "B1" or not code then return nil end
  local p = TF.Decode(code)
  if not p then return nil end
  return p, code
end

-- ---------- the trainer, for real: what this character could learn right now and has not ----------
-- Every trainer-sold rank at or under the character's level that the spellbook lacks (only the highest such rank of a
-- spell: the trainer sells that one). nil when this client cannot say which spells are known.
local function known(id)
  if not id then return nil end
  if IsPlayerSpell then local ok, r = pcall(IsPlayerSpell, id); if ok then return r and true or false end end
  if IsSpellKnown then local ok, r = pcall(IsSpellKnown, id); if ok then return r and true or false end end
  return nil
end
-- a rank this character has said no to (What's Training's ignore): kept per character, out of every reminder
function TF.SkipKey(name, rank) return name .. "|" .. tostring(rank or 1) end
function TF.IsSkipped(name, rank) local c = TF.CharDB(); return (c.skip and c.skip[TF.SkipKey(name, rank)]) == true end
function TF.SkipSpell(name, rank, on)
  local c = TF.CharDB(); c.skip = c.skip or {}
  c.skip[TF.SkipKey(name, rank)] = on and true or nil
  TF.Fire("SKIP_CHANGED", name, rank, on and true or false)
end
-- returns two lists: what is owed, and what this character skipped (each entry: name, rank, ranks, icon, level, id, portal)
function TF.OwedSpells(cf, level)
  cf = cf or TF.PlayerClass(); level = level or UnitLevel("player") or 1
  local L = D.learn and D.learn[cf]; if not L then return nil end
  if not (IsPlayerSpell or IsSpellKnown) then return nil end
  local out, skipped = {}, {}
  for name, rec in pairs(L) do
    if rec.ids then
      local top
      for r, lv in ipairs(rec.levels) do if lv <= level and rec.ids[r] and TF.TrainerTeaches(cf, name, rec, r) then top = r end end
      if top and known(rec.ids[top]) == false then
        local e = { name = name, rank = top, ranks = #rec.levels, icon = rec.icon, level = rec.levels[top], id = rec.ids[top], portal = rec.src and rec.src[top] == 1 or nil,
                    cost = (rec.cost and rec.cost[top] and rec.cost[top] > 0 and rec.cost[top]) or TF.KnownPrice(cf, name, top) }
        if TF.IsSkipped(name, top) then skipped[#skipped + 1] = e else out[#out + 1] = e end
      end
    end
  end
  local function byLevel(a, b) if a.level ~= b.level then return a.level > b.level end; return a.name < b.name end
  table.sort(out, byLevel); table.sort(skipped, byLevel)
  return out, skipped
end
-- the trainer's whole list for this character, the way the trainer lays it out: every spell it sells, with the rank
-- you would deal with next and its state: "now" (sold at your level, not in your book), "later" (the next rank comes
-- at a higher level), "known" (every rank up to your level is in the book). nil when this client cannot say what is known.
function TF.TrainerList(cf, level)
  cf = cf or TF.PlayerClass(); level = level or UnitLevel("player") or 1
  local L = D.learn and D.learn[cf]; if not L then return nil end
  if not (IsPlayerSpell or IsSpellKnown) then return nil end
  local out = {}
  for name, rec in pairs(L) do
    if rec.ids then
      local top, later
      for r, lv in ipairs(rec.levels) do
        if rec.ids[r] and TF.TrainerTeaches(cf, name, rec, r) then
          if lv <= level then top = r elseif not later then later = r end
        end
      end
      local function entry(r, state)
        return { name = name, rank = r, ranks = #rec.levels, icon = rec.icon, level = rec.levels[r], id = rec.ids[r], state = state, portal = rec.src and rec.src[r] == 1 or nil,
                 cost = (rec.cost and rec.cost[r] and rec.cost[r] > 0 and rec.cost[r]) or TF.KnownPrice(cf, name, r), skipped = TF.IsSkipped(name, r) }
      end
      if top then local k = known(rec.ids[top]); if k == false then out[#out + 1] = entry(top, "now") elseif k then out[#out + 1] = entry(top, "known") end end
      if later then out[#out + 1] = entry(later, "later") end
    end
  end
  local ORDER = { now = 1, later = 2, known = 3 }
  table.sort(out, function(a, b)
    if ORDER[a.state] ~= ORDER[b.state] then return ORDER[a.state] < ORDER[b.state] end
    if a.level ~= b.level then if a.state == "known" then return a.level > b.level end; return a.level < b.level end
    return a.name < b.name
  end)
  return out
end
-- the whole spellbook by level: every trainer-taught rank of every spell from 1 to 60, in the order they come, with
-- whether it is in the book already. What the game's own spellbook never shows: what is coming.
function TF.SpellbookList(cf)
  cf = cf or TF.PlayerClass()
  local L = D.learn and D.learn[cf]; if not L then return nil end
  local out = {}
  for name, rec in pairs(L) do
    for r, lv in ipairs(rec.levels or {}) do
      if TF.TrainerTeaches(cf, name, rec, r) then
        local id = rec.ids and rec.ids[r]
        out[#out + 1] = { name = name, rank = r, ranks = #rec.levels, icon = rec.icon, level = lv, id = id, known = id and known(id) or nil,
                          cost = (rec.cost and rec.cost[r] and rec.cost[r] > 0 and rec.cost[r]) or TF.KnownPrice(cf, name, r), portal = rec.src and rec.src[r] == 1 or nil }
      end
    end
  end
  table.sort(out, function(a, b) if a.level ~= b.level then return a.level < b.level end; if a.rank ~= b.rank then return a.rank < b.rank end; return a.name < b.name end)
  return out
end
-- the money a list of owed spells takes: total, how many carry a price, how many do not (no trainer recorded for that class yet)
function TF.OwedCost(list)
  local total, priced, unpriced = 0, 0, 0
  for _, s in ipairs(list or {}) do if s.cost then total = total + s.cost; priced = priced + 1 else unpriced = unpriced + 1 end end
  return total, priced, unpriced
end
-- "1g 40s" when every price is known, "1g 40s for 3 of them" when only some are, nothing when none
function TF.OwedCostText(list)
  local total, priced, unpriced = TF.OwedCost(list)
  if priced == 0 then return nil end
  if unpriced == 0 then return TF.Money(total) end
  return string.format("%s for %d of them", TF.Money(total), priced)
end
-- every talent whose name, or one of the spells it changes, contains the words (case does not matter)
function TF.SearchTalents(cf, q)
  q = (q or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
  local out = {}
  if q == "" then return out end
  local c = D.classes[cf or TF.plan.cls]; if not c then return out end
  for ti, tree in ipairs(c.trees) do
    for i, t in ipairs(tree.talents) do
      local hit = t.name:lower():find(q, 1, true) and "name" or nil
      if not hit and t.mentions then for _, m in ipairs(t.mentions) do if m:lower():find(q, 1, true) then hit = m; break end end end
      if hit then out[#out + 1] = { ti = ti, i = i, t = t, by = hit } end
    end
  end
  return out
end
-- ---------- Blizzard's talent string (the game's export/import format), read and written in plain Lua ----------
-- Bits go into the stream lowest first, six per character. Version 1: per node selected(1), then partial(1) [ranks(6)],
-- choice(1) [index(2)]. Version 2 adds purchased(1) right after selected. The nodes come in C_Traits.GetTreeNodes order.
local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function bitWriter()
  local w = { bits = {} }
  function w:put(v, n) for k = 0, n - 1 do self.bits[#self.bits + 1] = (math.floor(v / 2 ^ k) % 2 == 1) and 1 or 0 end end
  function w:text()
    local out, bits = {}, self.bits
    for c = 1, #bits, 6 do
      local v = 0
      for k = 0, 5 do local b = bits[c + k]; if b then v = v + b * 2 ^ k end end
      out[#out + 1] = B64:sub(v + 1, v + 1)
    end
    return table.concat(out)
  end
  return w
end
local function bitReader(str)
  local r = { bits = {}, pos = 1 }
  for c = 1, #str do
    local v = B64:find(str:sub(c, c), 1, true); if not v then return nil end
    v = v - 1
    for k = 0, 5 do r.bits[#r.bits + 1] = (math.floor(v / 2 ^ k) % 2 == 1) and 1 or 0 end
  end
  function r:get(n) local v = 0; for k = 0, n - 1 do local b = self.bits[self.pos]; self.pos = self.pos + 1; if b == 1 then v = v + 2 ^ k end end; return v end
  function r:left() return #self.bits - self.pos + 1 end
  return r
end
local function nodeMap(cf)
  local c = D.classes[cf]; local m = {}
  if not c then return m end
  for ti, tree in ipairs(c.trees) do for i, t in ipairs(tree.talents) do if t.node then m[t.node] = { ti = ti, i = i, max = t.max } end end end
  return m
end
local function treeNodes(cf)
  local c = D.classes[cf]; if not c then return nil end
  if C_Traits and C_Traits.GetTreeNodes then local ok, ids = pcall(C_Traits.GetTreeNodes, c.tree); if ok and type(ids) == "table" and #ids > 0 then return ids end end
  -- no client: the nodes we know, in id order (what the client hands out too)
  local ids = {}; for ti, tree in ipairs(c.trees) do for _, t in ipairs(tree.talents) do if t.node then ids[#ids + 1] = t.node end end end
  table.sort(ids); return ids
end
function TF.EncodeBlizzard(p, version)
  version = version or 2
  local ids = treeNodes(p.cls); if not ids then return nil end
  local m = nodeMap(p.cls); local w = bitWriter()
  w:put(version, 8); w:put(0, 16); for _ = 1, 16 do w:put(0, 8) end
  for _, id in ipairs(ids) do
    local at = m[id]; local r = at and p.ranks[at.ti][at.i] or 0
    if r > 0 then
      w:put(1, 1)
      if version >= 2 then w:put(1, 1) end
      if at and r < at.max then w:put(1, 1); w:put(r, 6) else w:put(0, 1) end
      w:put(0, 1)
    else w:put(0, 1) end
  end
  return w:text()
end
function TF.DecodeBlizzard(str, cf)
  local r = bitReader(str or ""); if not r or r:left() < 8 + 16 + 128 then return nil, "That is not a talent string." end
  local version = r:get(8); local spec = r:get(16); for _ = 1, 16 do r:get(8) end
  if version < 1 or version > 3 then return nil, "A talent string from a client this addon does not know (version " .. version .. ")." end
  local ids = treeNodes(cf); if not ids then return nil, "No trees for that class." end
  local m = nodeMap(cf); local p = TF.NewPlan(cf, 60)
  for _, id in ipairs(ids) do
    if r:left() < 1 then break end
    if r:get(1) == 1 then
      local purchased = true
      if version >= 2 then purchased = r:get(1) == 1 end
      local ranks
      if purchased then
        local partial = r:get(1) == 1
        if partial then ranks = r:get(6) end
      end
      if r:get(1) == 1 then r:get(2) end
      local at = m[id]
      if at and purchased then p.ranks[at.ti][at.i] = math.min(at.max, ranks or at.max) end
    end
  end
  p.level = TF.NeedLevel(p); p.orderKnown = false
  return p, spec
end
-- another player's build: the game hands over their talent string once an inspect has come back
function TF.InspectBuild(unit)
  unit = unit or "target"
  if not (UnitIsPlayer and UnitIsPlayer(unit)) then return nil, "Target a player first." end
  local _, cf = UnitClass(unit); if not cf or not D.classes[cf] then return nil, "Not a class this addon knows." end
  if not (C_Traits and C_Traits.GenerateInspectImportString) then return nil, "This client cannot share another player's talents." end
  local ok, str = pcall(C_Traits.GenerateInspectImportString, unit)
  if not ok or type(str) ~= "string" or str == "" then return nil, "The game gave no talents for them yet. Try once more." end
  local p, err = TF.DecodeBlizzard(str, cf)
  if not p then return nil, err end
  p.who = UnitName(unit)
  return p, cf
end
-- the player asked to look at a target: the game answers with INSPECT_READY, Game.lua turns it into INSPECT
TF.inspectSeen = {}
function TF.RequestInspect(unit)
  unit = unit or "target"
  if not (UnitIsPlayer and UnitIsPlayer(unit)) then return false, "Target a player first." end
  if CanInspect and not CanInspect(unit) then return false, "They are too far away to inspect." end
  if not NotifyInspect then return false, "This client cannot inspect." end
  TF.inspectWant = UnitGUID and UnitGUID(unit) or true
  pcall(NotifyInspect, unit)
  return true
end
-- an INSPECT_READY we did not ask for earns a card only while the game's own Inspect window is open on that person.
-- Other addons inspect everyone under the mouse all day (item level tooltips and the like), and each of those answers
-- used to put up a card, one per person walked past (u/Diamond-Intelligent, 23 Sep 2026).
local function inspectWindowOn(guid)
  local f = InspectFrame
  if not (f and f.IsShown and f:IsShown()) then return false end
  local u = f.unit
  if u and UnitGUID and UnitGUID(u) ~= guid then return false end
  return true
end
function TF.OnInspectReady(guid)
  local wanted = TF.inspectWant == guid or TF.inspectWant == true
  if wanted then TF.inspectWant = nil end
  if not wanted then
    local s = TF.db and TF.db.settings
    if s and s.othersBuilds == false then return end   -- they said no to other people's builds
    if not inspectWindowOn(guid) or TF.inspectSeen[guid] then return end   -- not the game's window, or seen once already
  end
  local unit
  for _, u in ipairs({ "target", "mouseover", "focus" }) do if UnitGUID and UnitGUID(u) == guid and UnitIsPlayer and UnitIsPlayer(u) then unit = u; break end end
  if not unit then return end
  TF.inspectSeen[guid] = true
  local p, cf = TF.InspectBuild(unit)
  if p then TF.Fire("INSPECTED", p, cf, unit) elseif wanted then TF.Fire("INSPECT_FAILED", cf) end
end
-- ---------- why this point, here: what the plan's order and the site's numbers say about the k-th point ----------
-- returns up to three short lines: the row it opens, the talent it unlocks, the rank it completes, how many take it, the #1 build
function TF.WhyPoint(p, k)
  p = p or TF.plan
  local order = TF.FixOrder(p); local e = order[k]; if not e then return {} end
  local ti, i = e[1], e[2]
  local c = D.classes[p.cls]; local tree = c.trees[ti]; local t = tree.talents[i]
  -- the plan as it stands once this point is placed
  local after = { cls = p.cls, level = p.level, ranks = {} }
  for a = 1, #p.ranks do after.ranks[a] = {}; for b = 1, #p.ranks[a] do after.ranks[a][b] = 0 end end
  for n = 1, k do local x = order[n]; after.ranks[x[1]][x[2]] = after.ranks[x[1]][x[2]] + 1 end
  local r = after.ranks[ti][i]
  local out = {}
  -- opens a row the plan goes on to use
  local pts = TF.TreePts(after, ti)
  if pts % 5 == 0 then
    local row = pts / 5 + 1
    local uses = false
    for n = k + 1, #order do local x = order[n]; if x[1] == ti and tree.talents[x[2]].row == row then uses = true; break end end
    if uses then out[#out + 1] = string.format("Opens row %d of %s.", row, tree.name) end
  end
  -- the last rank, and what it unlocks
  if r == t.max then
    local needs = {}
    for n = k + 1, #order do local x = order[n]; local u = tree.talents[x[2]]; if x[1] == ti and u.req == i and not needs[u.name] then needs[u.name] = true; needs[#needs + 1] = u.name end end
    if #needs > 0 then out[#out + 1] = string.format("Unlocks %s.", TF.JoinNames(needs))
    elseif t.max > 1 then out[#out + 1] = string.format("%s is complete.", t.name) end
  end
  -- what other players do
  local pop = D.popular[p.cls]
  local pick = pop and pop.pick and pop.pick[ti] and pop.pick[ti][i]
  if pick then
    if pick >= 60 then out[#out + 1] = string.format("%d%% of %ss on the site take it.", pick, c.name)
    elseif pick <= 15 then out[#out + 1] = string.format("Rare: %d%% of %ss take it.", pick, c.name) end
  end
  if #out < 3 then
    local top, rec = TF.TopBuild(p.cls)
    local same = top ~= nil
    if same then for a = 1, #p.ranks do for b = 1, #p.ranks[a] do if p.ranks[a][b] ~= top.ranks[a][b] then same = false end end end end
    if top and rec and not same and top.ranks[ti][i] >= r then out[#out + 1] = string.format("The #1 %s build takes it too.", rec.lead or c.name) end
  end
  while #out > 3 do table.remove(out) end
  return out
end
-- the next point the character has not placed yet, with its reasons
function TF.WhyNext(p)
  p = p or TF.plan
  for k, e in ipairs(TF.NextUp(p)) do
    if not e.done then return e, TF.WhyPoint(p, k) end
  end
  return nil, {}
end
-- ---------- the safety lock: talents reset at a trainer means hands-free placing stops, so no gold is spent behind your back ----------
local lastSpent
function TF.LiveSpent(cf)
  local live = TF.LiveRanks(cf or TF.PlayerClass()); if not live then return nil end
  local n = 0; for _, tr in ipairs(live) do for _, r in ipairs(tr) do n = n + r end end
  return n
end
TF.On("GAME_CHANGED", function()
  local spent = TF.LiveSpent(); if spent == nil then return end
  if lastSpent and lastSpent > 0 and spent == 0 and (UnitLevel("player") or 1) >= 10 then
    local s = TF.db.settings; local was = s.autoApply or s.starter
    s.autoApply = false; s.starter = false; TF.starterCode = nil
    TF.Fire("RESPEC", was and true or false)
  end
  lastSpent = spent
end)

-- ---------- a data broker line (TitanPanel, ChocolateBar, Bazooka...): "12 / 51 · 3 at the trainer" ----------
local broker
function TF.BrokerText()
  local p = TF.plan; if not p then return "" end
  local parts = { string.format("%d / %d", TF.TotalPts(p), TF.Pool(p)) }
  local owed = TF.OwedSpells()
  if owed and #owed > 0 then parts[#parts + 1] = string.format("%d at the trainer", #owed) end
  return table.concat(parts, "  ")
end
function TF.UpdateBroker()
  if not broker then
    local ldb = LibStub and LibStub("LibDataBroker-1.1", true); if not ldb or not ldb.NewDataObject then return false end
    local ok, obj = pcall(ldb.NewDataObject, ldb, "TalentsForeverBook", {
      type = "data source", label = "Talents Forever", icon = "Interface\\AddOns\\TalentsForeverBook\\Media\\book-round.tga", text = "",
      OnClick = function() if TF.UI and TF.UI.Toggle then TF.UI.Toggle() end end,
      OnTooltipShow = function(tt)
        tt:AddLine("Talents Forever", 1, 0.82, 0)
        local p = TF.plan; if p then tt:AddDoubleLine("Plan", string.format("%d of %d points", TF.TotalPts(p), TF.Pool(p)), 1, 1, 1, 0.74, 0.74, 0.74) end
        local e, why = TF.WhyNext(p)
        if e then local t = D.classes[p.cls].trees[e.ti].talents[e.i]; tt:AddDoubleLine("Next", string.format("%s (%d/%d) at %d", t.name, e.rank, t.max, e.level), 1, 1, 1, 0.74, 0.74, 0.74) end
        local owed = TF.OwedSpells()
        if owed and #owed > 0 then local ct = TF.OwedCostText(owed); tt:AddDoubleLine("At the trainer", string.format("%d spell%s%s", #owed, #owed == 1 and "" or "s", ct and (", " .. ct) or ""), 1, 1, 1, 0.74, 0.74, 0.74) end
        tt:AddLine("Click to open the planner.", 0.54, 0.54, 0.54)
      end,
    })
    if not ok or not obj then return false end
    broker = obj
  end
  broker.text = TF.BrokerText()
  return true
end
TF.On("PLAN_CHANGED", function() if broker then TF.UpdateBroker() end end)
TF.On("GAME_CHANGED", function() if broker then TF.UpdateBroker() end end)
TF.On("SKIP_CHANGED", function() if broker then TF.UpdateBroker() end end)
function TF.JoinNames(list)
  if #list <= 1 then return list[1] or "" end
  return table.concat(list, ", ", 1, #list - 1) .. " and " .. list[#list]
end

-- ---------- the trainer window: everything you want, in one click (Class Trainer Plus's shift-Train) ----------
TF.trainer = { open = false }
function TF.Money(c)
  c = math.floor(tonumber(c) or 0)
  local g, s, k = math.floor(c / 10000), math.floor(c / 100) % 100, c % 100
  if g > 0 then return s > 0 and string.format("%dg %ds", g, s) or string.format("%dg", g) end
  if s > 0 then return k > 0 and string.format("%ds %dc", s, k) or string.format("%ds", s) end
  return string.format("%dc", k)
end
-- the rows of the open trainer window. This client's GetTrainerServiceInfo gives name, state, icon; older ones name, rank, category.
function TF.TrainerRows()
  if not (GetNumTrainerServices and GetTrainerServiceInfo) then return {} end
  local ok, n = pcall(GetNumTrainerServices); n = ok and tonumber(n) or 0
  local rows = {}
  for i = 1, n do
    local ok2, name, a, b = pcall(GetTrainerServiceInfo, i)
    if ok2 and name and a ~= "header" and b ~= "header" then
      local state = (a == "available" or a == "unavailable" or a == "used") and a or ((b == "available" or b == "unavailable" or b == "used") and b or tostring(a))
      local cost = 0
      if GetTrainerServiceCost then local ok3, c = pcall(GetTrainerServiceCost, i); if ok3 then cost = tonumber(c) or 0 end end
      local lvl
      if GetTrainerServiceLevelReq then local ok4, l = pcall(GetTrainerServiceLevelReq, i); if ok4 then lvl = tonumber(l) end end
      rows[#rows + 1] = { i = i, name = name, state = state, cost = cost, level = lvl }
    end
  end
  return rows
end
-- what Train all would buy: every available row this character has not skipped, in the trainer's order, with the money it takes
function TF.TrainerPlan()
  local owed, skipped = TF.OwedSpells()
  local rank = {}
  for _, s in ipairs(owed or {}) do rank[s.name] = s.rank end
  for _, s in ipairs(skipped or {}) do rank[s.name] = s.rank end
  local plan = { rows = {}, cost = 0, skipped = 0, short = 0, money = (GetMoney and GetMoney()) or nil }
  for _, r in ipairs(TF.TrainerRows()) do
    if r.state == "available" then
      if TF.IsSkipped(r.name, rank[r.name] or 1) then plan.skipped = plan.skipped + 1
      else plan.rows[#plan.rows + 1] = r; plan.cost = plan.cost + (r.cost or 0) end
    end
  end
  if plan.money and plan.cost > plan.money then
    -- what the purse covers, in the trainer's order; the rest is short
    local left = plan.money; local keep = {}
    for _, r in ipairs(plan.rows) do if (r.cost or 0) <= left then left = left - (r.cost or 0); keep[#keep + 1] = r else plan.short = plan.short + 1 end end
    plan.rows = keep; plan.cost = plan.money - left
  end
  return plan
end
-- one purchase per TRAINER_UPDATE (the list re-numbers after each), so the queue holds names, not indexes
function TF.TrainAll()
  local plan = TF.TrainerPlan()
  if #plan.rows == 0 then return 0 end
  local t = TF.trainer
  t.queue = {}; for _, r in ipairs(plan.rows) do t.queue[#t.queue + 1] = r.name end
  t.bought, t.spent, t.short = 0, 0, plan.short
  TF.TrainNext()
  return #plan.rows
end
function TF.TrainNext()
  local t = TF.trainer
  if not t.queue then return end
  if not t.open then t.queue = nil; return end
  while #t.queue > 0 do
    local name = table.remove(t.queue, 1)
    for _, r in ipairs(TF.TrainerRows()) do
      if r.name == name and r.state == "available" then
        if GetMoney and (r.cost or 0) > GetMoney() then t.short = t.short + 1; break end
        if BuyTrainerService and pcall(BuyTrainerService, r.i) then
          t.bought = t.bought + 1; t.spent = t.spent + (r.cost or 0); t.waiting = true
          if C_Timer then C_Timer.After(1.5, function() if t.waiting then t.waiting = false; TF.TrainNext() end end) end   -- if no update comes
          return
        end
        break
      end
    end
  end
  t.queue = nil
  TF.Fire("TRAINED", t.bought or 0, t.spent or 0, t.short or 0)
end
-- a price seen at any trainer is kept for every character of that class, so the owed list can say what things cost
-- before the walk, for classes no trainer was recorded for. Keyed by name and rank; the rank comes from the row's level
-- requirement when the client gives one, else from the rank this character is owed (the row the trainer sells now).
function TF.KnownPrice(cf, name, rank)
  local p = TF.db and TF.db.prices and TF.db.prices[cf]
  local v = p and p[name .. "|" .. tostring(rank)]
  return v and v > 0 and v or nil
end
function TF.RememberPrices()
  local cf = TF.PlayerClass(); if not cf or not TF.db then return 0 end
  local L = D.learn and D.learn[cf]; if not L then return 0 end
  local owed, skipped = TF.OwedSpells(); local rank = {}
  for _, s in ipairs(owed or {}) do rank[s.name] = s.rank end
  for _, s in ipairs(skipped or {}) do rank[s.name] = s.rank end
  TF.db.prices[cf] = TF.db.prices[cf] or {}
  local n = 0
  for _, r in ipairs(TF.TrainerRows()) do
    local rec = L[r.name]
    if rec and r.cost and r.cost > 0 then
      local k
      if r.level then for i, lv in ipairs(rec.levels) do if lv == r.level then k = i end end end
      if not k and r.state == "available" then k = rank[r.name] end
      if k then TF.db.prices[cf][r.name .. "|" .. k] = r.cost; n = n + 1 end
    end
  end
  return n
end
function TF.TrainerEvent(kind)
  local t = TF.trainer
  if kind == "show" or kind == "update" then pcall(TF.RememberPrices) end
  if kind == "show" then t.open = true; t.queue = nil; t.waiting = false; if SetTrainerServiceTypeFilter then pcall(SetTrainerServiceTypeFilter, "available", 1) end
  elseif kind == "closed" then t.open = false; t.queue = nil; t.waiting = false
  elseif kind == "update" and t.waiting then t.waiting = false; if C_Timer then C_Timer.After(0.2, TF.TrainNext) else TF.TrainNext() end end
  TF.Fire("TRAINER", kind)
end

-- ---------- build links in chat: a site link becomes a link you can click, for anyone with the addon ----------
TF.LINK_TYPE = "addon:TalentsForeverBook:"
function TF.LinkText(p)
  local c = D.classes[p.cls]; local parts = {}
  for ti = 1, #p.ranks do parts[ti] = TF.TreePts(p, ti) end
  return string.format("[%s %s, level %d]", c and c.name or "?", table.concat(parts, "/"), TF.FullLevel(p))
end
function TF.LinkifyChat(msg)
  if type(msg) ~= "string" or not msg:find("talentsforever.com/", 1, true) then return msg end
  return (msg:gsub("(https?://)(w?w?w?%.?)talentsforever%.com/([%w%-%._/]+)(%??[%w=&]*)", function(proto, www, path, query)
    local p = TF.Decode(TF.SITE .. "/" .. path)
    if not p then return proto .. www .. "talentsforever.com/" .. path .. query end
    return string.format("|H%s%s|h%s%s|r|h", TF.LINK_TYPE, path, TF.GOLD, TF.LinkText(p))
  end))
end
local function chatFilter(_, _, msg, ...)
  local m = TF.LinkifyChat(msg)
  if m ~= msg then return false, m, ... end
end
function TF.InstallChatLinks()
  if TF.chatLinksOn or not ChatFrame_AddMessageEventFilter then return false end
  TF.chatLinksOn = true
  for _, ev in ipairs({ "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER",
                        "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_CHANNEL", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER_INFORM" }) do
    pcall(ChatFrame_AddMessageEventFilter, ev, chatFilter)
  end
  if hooksecurefunc and SetItemRef then
    pcall(hooksecurefunc, "SetItemRef", function(link) if type(link) == "string" and link:sub(1, #TF.LINK_TYPE) == TF.LINK_TYPE then TF.OpenLink(link:sub(#TF.LINK_TYPE + 1)) end end)
  end
  return true
end
function TF.OpenLink(path)
  local p = TF.Decode(TF.SITE .. "/" .. path); if not p then return false end
  TF.Fire("LINK_OPENED", p, path)
  return true
end
-- put a plan's site link where the cursor is in the chat box (shift-click on a build); opens the box when it is closed
function TF.InsertLink(p)
  local url = TF.ShareURL(p or TF.plan)
  local box = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
  if box and ChatEdit_InsertLink then local ok, done = pcall(ChatEdit_InsertLink, url); if ok and done then return true end end
  if box and box.Insert then local ok = pcall(box.Insert, box, url); if ok then return true end end
  if ChatFrame_OpenChat then local ok = pcall(ChatFrame_OpenChat, url); if ok then return true end end
  return false
end

-- ---------- the coach: what a careful friend would say about this plan ----------
-- returns a list of { kind = "good"|"note"|"warn", icon = , text = }
function TF.Coach(p)
  p = p or TF.plan
  local c = D.classes[p.cls]; local pop = D.popular[p.cls]; local cname = c.name
  local out = {}
  local function add(kind, icon, head, text) out[#out + 1] = { kind = kind, icon = icon, head = head, text = text } end
  local function few(list, n)
    n = n or 3
    if #list <= n then return TF.JoinNames(list) end
    local first = {}; for k = 1, n do first[k] = list[k] end
    return table.concat(first, ", ") .. string.format(" and %d more", #list - n)
  end
  local total, pool = TF.TotalPts(p), TF.Pool(p)
  if total == 0 then add("note", c.trees[1].icon, "Nothing planned yet", string.format("Click a talent on the trees, or take a popular build. Then this page says where you stand, what other %ss do, and the one thing worth a look.", cname)); return out end
  local order = TF.FixOrder(p); local start = TF.StartLevel()
  local lead, best = 1, -1
  for ti = 1, #c.trees do local n = TF.TreePts(p, ti); if n > best then best, lead = n, ti end end
  local leadName = c.trees[lead].name
  -- 1. where you stand
  do
    local parts = {}
    for ti, tree in ipairs(c.trees) do if TF.TreePts(p, ti) > 0 then parts[#parts + 1] = string.format("%s %d", tree.name, TF.TreePts(p, ti)) end end
    local e = TF.WhyNext(p)
    local line = table.concat(parts, ", ") .. "."
    if e then local t = c.trees[e.ti].talents[e.i]; line = line .. string.format(" Next comes %s %d/%d at level %d.", t.name, e.rank, t.max, e.level)
    elseif total >= pool then line = line .. " Every point is placed." end
    add("note", c.trees[lead].icon, string.format("%d of %d points planned", total, pool), line)
  end
  -- 2. what other players do
  do
    local share, topSpec
    for _, sp in ipairs(pop and pop.spec or {}) do if sp[1] == leadName then share = sp[2] end; if not topSpec or sp[2] > topSpec[2] then topSpec = sp end end
    local head = share and string.format("%s, like %d%% of %ss", leadName, share, cname) or string.format("%s is your lead tree", leadName)
    local text = ""
    local top, rec = TF.TopBuild(p.cls)
    if top and rec then
      local shared, mine, theirs = 0, {}, {}
      for ti, tr in ipairs(p.ranks) do for i, r in ipairs(tr) do
        local g = top.ranks[ti] and top.ranks[ti][i] or 0
        shared = shared + math.min(r, g)
        if r > g then mine[#mine + 1] = c.trees[ti].talents[i].name elseif g > r then theirs[#theirs + 1] = c.trees[ti].talents[i].name end
      end end
      if #mine == 0 and #theirs == 0 then text = string.format("This is the #1 %s build on the site, point for point.", rec.lead or cname)
      else
        text = string.format("You match the #1 %s build on %d of %d points.", rec.lead or cname, shared, total)
        if #theirs > 0 then text = text .. string.format(" It takes %s where you do not.", few(theirs)) end
        if #mine > 0 then text = text .. string.format(" You take %s where it does not.", few(mine)) end
      end
    elseif topSpec and topSpec[1] ~= leadName then text = string.format("Most %ss on the site lead %s, %d%%.", cname, topSpec[1], topSpec[2]) end
    if text ~= "" then add("note", nil, head, text) end
  end
  -- 3. the one thing worth a look
  do
    local kind, head, text
    local live = TF.LiveRanks(p.cls)
    local missing, extra = 0, 0
    if live then missing, extra = TF.Diff(p) end
    local missed, rare = {}, {}
    if pop and pop.pick then
      for ti, tree in ipairs(c.trees) do for i, t in ipairs(tree.talents) do
        local pr = pop.pick[ti] and pop.pick[ti][i]
        if pr and p.ranks[ti][i] == 0 and pr >= 60 and TF.TreePts(p, ti) >= (t.row - 1) * 5 then missed[#missed + 1] = { t.name, pr } end
        if pr and p.ranks[ti][i] > 0 and pr <= 10 then rare[#rare + 1] = { t.name, pr } end
      end end
    end
    local split = false
    if #order >= 10 then local seen, n = {}, 0; for k = 1, 10 do seen[order[k][1]] = true end; for _ in pairs(seen) do n = n + 1 end; split = n > 1 end
    if extra > 0 then
      kind, head, text = "warn", string.format("%d point%s on your character the plan does not have", extra, extra == 1 and "" or "s"), "Those only come back with a reset at the trainer. Or press From character and plan on from what you have."
    elseif #missed > 0 then
      kind, head = "warn", string.format("Most %ss take %s", cname, missed[1][1])
      text = string.format("%d%% of %s builds on the site put a point in it, and the row is open in your plan. Worth a look.", missed[1][2], cname)
    elseif split then
      kind, head, text = "warn", "Your first ten points are split", "Rows open every five points in one tree, so a split start reaches the strong talents later."
    elseif #rare > 0 then
      kind, head, text = "note", string.format("%s is a rare pick", rare[1][1]), string.format("%d%% of %ss on the site take it. Fine if it is on purpose.", rare[1][2], cname)
    elseif live and missing > 0 and (TF.Game.Unspent() or 0) > 0 then
      kind, head, text = "good", string.format("%d unspent point%s ready to place", TF.Game.Unspent(), TF.Game.Unspent() == 1 and "" or "s"), "Apply next point places it. Nothing on your character changes until you press it."
    elseif total >= pool then
      kind, head, text = "good", "Nothing I would change", "A full build, no rare picks, the popular talents in. Share it from the Builds page."
    else
      kind, head, text = "good", "Nothing I would change so far", "The popular talents are in and the rows open in order. Keep going."
    end
    add(kind, nil, head, text)
  end
  return out
end

-- ---------- feedback: a note to the person who builds this, as a link ----------
-- The game gives an addon no way to send anything. So the note becomes a link to the site's ideas page; pasted in a
-- browser, the page posts the words to the inbox (the same one the ideas page feeds) and shows them sent. The link
-- carries the addon's version, the class and the level in front of the words, so a report can be placed.
local function urlEnc(str) return (tostring(str):gsub("[^%w%-%._~ ]", function(ch) return string.format("%%%02X", ch:byte()) end):gsub(" ", "+")) end
-- A note's tag: six letters and digits the addon makes up (no 0, O, 1 or I), kept with the note on this account and sent in
-- the link. A reply shipped with a later version carries the same tag, so the Feedback page can show it under "your note".
-- The tag says nothing about who sent the note; it is the only thing that ties a reply to it.
local TAG_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
function TF.NoteTag()
  local t = {}
  for i = 1, 6 do local k = math.random(1, #TAG_ALPHABET); t[i] = TAG_ALPHABET:sub(k, k) end
  return table.concat(t)
end
function TF.FeedbackURL(text, who)
  local c = D.classes[TF.plan.cls]
  local words = (text or ""):gsub("^%s+", ""):gsub("%s+$", "")
  local head = string.format("[addon %s, %s %d] ", TF.VERSION or "?", c and c.name or "?", UnitLevel("player") or 0)
  local tag = TF.NoteTag()
  local url = TF.SITE .. "/said?say=" .. urlEnc(head .. words) .. "&id=" .. tag
  if who and who:gsub("%s", "") ~= "" then url = url .. "&who=" .. urlEnc(who:gsub("^%s+", ""):gsub("%s+$", "")) end
  local sent = TF.db and TF.db.sent
  if sent then
    sent[#sent + 1] = { tag = tag, ts = time(), cls = c and c.name or "?", level = UnitLevel("player") or 0, text = words:sub(1, 460) }
    while #sent > 40 do table.remove(sent, 1) end
  end
  return url, tag
end
-- The replies shipped with this version, in order, each with mine = true when it answers a note sent from this account.
-- The list itself comes from the site (data/replies.json, hand-picked), through Data.lua's replies block.
function TF.Replies()
  local R = D.replies; if not R or not R.list then return nil end
  local mine = {}
  for _, n in ipairs((TF.db and TF.db.sent) or {}) do if n.tag then mine[n.tag] = n end end
  local out = {}
  for _, r in ipairs(R.list) do
    local x = {}; for k, v in pairs(r) do x[k] = v end
    x.mine = (r.tag and mine[r.tag]) and true or false
    out[#out + 1] = x
  end
  return out, R
end
-- how a spell scales with spell power, as the client's files carry it ("40.7% of spell power (direct)"), by spell id. nil when it
-- does not scale, and for every physical ability: the files hold no attack power coefficients, those scale with the weapon.
function TF.Coef(id) return id and D.coef and D.coef[id] or nil end

-- ---------- QR: the build's link as a code a phone can read ----------
-- Byte mode, error correction L, versions 1 to 10 (up to 271 characters), all eight masks scored.
-- TF.QR(text) returns a table m[y][x] of booleans (0-based, true = dark) and its size, or nil when the text is too long.
do
  local bxor = (bit and bit.bxor) or function(a, b)
    local r, p = 0, 1
    while a > 0 or b > 0 do
      local x, y = a % 2, b % 2
      if x ~= y then r = r + p end
      a, b, p = (a - x) / 2, (b - y) / 2, p * 2
    end
    return r
  end
  local EXP, LOG = {}, {}
  do
    local x = 1
    for i = 0, 254 do EXP[i] = x; LOG[x] = i; x = x * 2; if x >= 256 then x = bxor(x, 285) end end
    for i = 255, 511 do EXP[i] = EXP[i - 255] end
  end
  local function gmul(a, b) if a == 0 or b == 0 then return 0 end; return EXP[LOG[a] + LOG[b]] end
  local function rsGenerator(n)
    local g = { 1 }
    for i = 0, n - 1 do
      local ng = {}
      for j = 1, #g + 1 do ng[j] = 0 end
      for j = 1, #g do
        ng[j] = bxor(ng[j], g[j])
        ng[j + 1] = bxor(ng[j + 1], gmul(g[j], EXP[i]))
      end
      g = ng
    end
    return g
  end
  local function rsRemainder(data, n, gen)
    local rem = {}
    for i = 1, n do rem[i] = 0 end
    for _, d in ipairs(data) do
      local factor = bxor(d, rem[1])
      table.remove(rem, 1); rem[n] = 0
      for i = 1, n do rem[i] = bxor(rem[i], gmul(gen[i + 1], factor)) end
    end
    return rem
  end
  -- per version at level L: error codewords per block, and each block's data length
  local SPEC = {
    { 7, { 19 } }, { 10, { 34 } }, { 15, { 55 } }, { 20, { 80 } }, { 26, { 108 } },
    { 18, { 68, 68 } }, { 20, { 78, 78 } }, { 24, { 97, 97 } }, { 30, { 116, 116 } }, { 18, { 68, 68, 69, 69 } },
  }
  local CAP = { 17, 32, 53, 78, 106, 134, 154, 192, 230, 271 }
  local function bitAt(v, i) return math.floor(v / 2 ^ i) % 2 == 1 end
  local function alignPos(ver)
    if ver == 1 then return {} end
    local n = math.floor(ver / 7) + 2
    local step = math.floor((ver * 4 + n * 2 + 1) / (n * 2 - 2)) * 2
    local tmp, p = {}, 17 + 4 * ver - 7
    for _ = 1, n - 1 do tmp[#tmp + 1] = p; p = p - step end
    local res = { 6 }
    for i = #tmp, 1, -1 do res[#res + 1] = tmp[i] end
    return res
  end
  local MASK = {
    function(x, y) return (x + y) % 2 == 0 end,
    function(x, y) return y % 2 == 0 end,
    function(x, y) return x % 3 == 0 end,
    function(x, y) return (x + y) % 3 == 0 end,
    function(x, y) return (math.floor(x / 3) + math.floor(y / 2)) % 2 == 0 end,
    function(x, y) return (x * y) % 2 + (x * y) % 3 == 0 end,
    function(x, y) return ((x * y) % 2 + (x * y) % 3) % 2 == 0 end,
    function(x, y) return ((x + y) % 2 + (x * y) % 3) % 2 == 0 end,
  }
  function TF.QR(text)
    text = tostring(text or "")
    local ver
    for v = 1, #CAP do if #text <= CAP[v] then ver = v; break end end
    if not ver then return nil end
    local spec = SPEC[ver]; local ec = spec[1]
    local totalData = 0; for _, len in ipairs(spec[2]) do totalData = totalData + len end
    -- the bit stream: byte mode, the length, the bytes, a terminator, padding
    local bits = {}
    local function put(val, n) for i = n - 1, 0, -1 do bits[#bits + 1] = math.floor(val / 2 ^ i) % 2 end end
    put(4, 4); put(#text, ver >= 10 and 16 or 8)
    for i = 1, #text do put(text:byte(i), 8) end
    for _ = 1, math.min(4, totalData * 8 - #bits) do bits[#bits + 1] = 0 end
    while #bits % 8 ~= 0 do bits[#bits + 1] = 0 end
    local cw = {}
    for i = 1, #bits, 8 do local v = 0; for j = 0, 7 do v = v * 2 + bits[i + j] end; cw[#cw + 1] = v end
    local pad = 236
    while #cw < totalData do cw[#cw + 1] = pad; pad = (pad == 236) and 17 or 236 end
    -- blocks, their error correction, interleaved
    local gen = rsGenerator(ec)
    local blocks, ecs, pos = {}, {}, 1
    for bi, len in ipairs(spec[2]) do
      local d = {}
      for k = 1, len do d[k] = cw[pos]; pos = pos + 1 end
      blocks[bi] = d; ecs[bi] = rsRemainder(d, ec, gen)
    end
    local out, maxLen = {}, 0
    for _, d in ipairs(blocks) do if #d > maxLen then maxLen = #d end end
    for k = 1, maxLen do for bi = 1, #blocks do if blocks[bi][k] then out[#out + 1] = blocks[bi][k] end end end
    for k = 1, ec do for bi = 1, #blocks do out[#out + 1] = ecs[bi][k] end end
    -- the square, with the parts that never carry data marked
    local size = 17 + 4 * ver
    local m, fn = {}, {}
    for y = 0, size - 1 do m[y], fn[y] = {}, {}; for x = 0, size - 1 do m[y][x] = false; fn[y][x] = false end end
    local function set(x, y, dark) if x >= 0 and x < size and y >= 0 and y < size then m[y][x] = dark and true or false; fn[y][x] = true end end
    for i = 0, size - 1 do set(6, i, i % 2 == 0); set(i, 6, i % 2 == 0) end
    local function finder(cx, cy)
      for dy = -4, 4 do for dx = -4, 4 do local d = math.max(math.abs(dx), math.abs(dy)); set(cx + dx, cy + dy, d ~= 2 and d ~= 4) end end
    end
    finder(3, 3); finder(size - 4, 3); finder(3, size - 4)
    local ap = alignPos(ver)
    for i = 1, #ap do for j = 1, #ap do
      if not ((i == 1 and j == 1) or (i == 1 and j == #ap) or (i == #ap and j == 1)) then
        for dy = -2, 2 do for dx = -2, 2 do set(ap[i] + dx, ap[j] + dy, math.max(math.abs(dx), math.abs(dy)) ~= 1) end end
      end
    end end
    local function drawFormat(mask)
      local data = 8 + mask
      local rem = data
      for _ = 1, 10 do rem = rem * 2; if rem >= 1024 then rem = bxor(rem, 1335) end end
      local fb = bxor(data * 1024 + rem, 21522)
      for i = 0, 5 do set(8, i, bitAt(fb, i)) end
      set(8, 7, bitAt(fb, 6)); set(8, 8, bitAt(fb, 7)); set(7, 8, bitAt(fb, 8))
      for i = 9, 14 do set(14 - i, 8, bitAt(fb, i)) end
      for i = 0, 7 do set(size - 1 - i, 8, bitAt(fb, i)) end
      for i = 8, 14 do set(8, size - 15 + i, bitAt(fb, i)) end
      set(8, size - 8, true)
    end
    drawFormat(0)
    if ver >= 7 then
      local rem = ver
      for _ = 1, 12 do rem = rem * 2; if rem >= 4096 then rem = bxor(rem, 7973) end end
      local vb = ver * 4096 + rem
      for i = 0, 17 do local a, b = size - 11 + i % 3, math.floor(i / 3); set(a, b, bitAt(vb, i)); set(b, a, bitAt(vb, i)) end
    end
    -- the data, in the zigzag from the bottom right
    local idx, nbits = 0, #out * 8
    local right = size - 1
    while right >= 1 do
      if right == 6 then right = 5 end
      for vert = 0, size - 1 do
        for j = 0, 1 do
          local x = right - j
          local upward = math.floor((right + 1) / 2) % 2 == 0
          local y = upward and (size - 1 - vert) or vert
          if not fn[y][x] and idx < nbits then
            local byte = out[math.floor(idx / 8) + 1]
            m[y][x] = bitAt(byte, 7 - idx % 8)
            idx = idx + 1
          end
        end
      end
      right = right - 2
    end
    -- the mask that leaves the calmest pattern
    local function penalty(g)
      local score = 0
      for pass = 1, 2 do
        for a = 0, size - 1 do
          local run, last = 0, nil
          for b = 0, size - 1 do
            local v = (pass == 1) and g[a][b] or g[b][a]
            if v == last then run = run + 1; if run == 5 then score = score + 3 elseif run > 5 then score = score + 1 end
            else last = v; run = 1 end
          end
          for b = 0, size - 11 do
            local function at(k) if pass == 1 then return g[a][b + k] else return g[b + k][a] end end
            if at(0) and not at(1) and at(2) and at(3) and at(4) and not at(5) and at(6) and not at(7) and not at(8) and not at(9) and not at(10) then score = score + 40 end
            if not at(0) and not at(1) and not at(2) and not at(3) and at(4) and not at(5) and at(6) and at(7) and at(8) and not at(9) and at(10) then score = score + 40 end
          end
        end
      end
      local dark = 0
      for y = 0, size - 1 do for x = 0, size - 1 do
        if g[y][x] then dark = dark + 1 end
        if x < size - 1 and y < size - 1 and g[y][x] == g[y][x + 1] and g[y][x] == g[y + 1][x] and g[y][x] == g[y + 1][x + 1] then score = score + 3 end
      end end
      score = score + 10 * math.floor(math.abs(dark * 100 / (size * size) - 50) / 5)
      return score
    end
    local best, bestScore
    for k = 1, 8 do
      local g = {}
      for y = 0, size - 1 do g[y] = {}; for x = 0, size - 1 do
        local v = m[y][x]
        if not fn[y][x] and MASK[k](x, y) then v = not v end
        g[y][x] = v
      end end
      local sc = penalty(g)
      if not bestScore or sc < bestScore then best, bestScore = k, sc end
    end
    for y = 0, size - 1 do for x = 0, size - 1 do if not fn[y][x] and MASK[best](x, y) then m[y][x] = not m[y][x] end end end
    drawFormat(best - 1)
    return m, size, ver, best - 1
  end
end

-- ---------- for other addons ----------
TF.API = {
  GetPlanCode = function() return TF.Encode(TF.plan) end,
  GetShareURL = function() return TF.ShareURL(TF.plan) end,
  ImportCode = function(code) return TF.LoadCode(code) end,
  GetPlan = function() return TF.plan end,
  OnChange = function(fn) TF.On("PLAN_CHANGED", fn) end,
  Toggle = function() if TF.Toggle then TF.Toggle() end end,
}
