-- Azeroth Forever : générateur de QR code pur Lua (mode Octet, ECC L).
--
-- Portage fidèle de l'algorithme du paquet npm "qrcode" (soldair/node-qrcode,
-- MIT), réduit au cas utile ici : une seule chaîne ASCII (l'URL du site) en
-- mode Octet, niveau de correction L (capacité maximale = QR le plus petit
-- possible pour une URL donnée). Toutes les tables (blocs/EC par version,
-- nombre de mots de code par version) sont les tables officielles ISO/IEC
-- 18004 telles qu'utilisées par cette implémentation de référence.
local ADDON_NAME, AF = ...

local QR = {}
AF.QR = QR

local Bit = AF.Bit
local band, bor, bxor, lshift, rshift = Bit.band, Bit.bor, Bit.bxor, Bit.lshift, Bit.rshift
local floor, ceil, max, min = math.floor, math.ceil, math.max, math.min

-- ---------- Utils ----------

local CODEWORDS_COUNT = {
  0, 26, 44, 70, 100, 134, 172, 196, 242, 292, 346,
  404, 466, 532, 581, 655, 733, 815, 901, 991, 1085,
  1156, 1258, 1364, 1474, 1588, 1706, 1828, 1921, 2051, 2185,
  2323, 2465, 2611, 2761, 2876, 3034, 3196, 3362, 3532, 3706
}

local function getSymbolSize(version) return version * 4 + 17 end
local function getSymbolTotalCodewords(version) return CODEWORDS_COUNT[version + 1] end

local function getBCHDigit(data)
  local digit = 0
  while data ~= 0 do
    digit = digit + 1
    data = rshift(data, 1)
  end
  return digit
end

-- ---------- EC (niveau L uniquement) ----------

local EC_BLOCKS_L = {
  1, 1, 1, 1, 1, 2, 2, 2, 2, 4, 4, 4, 4, 4, 6, 6, 6, 6, 7, 8,
  8, 9, 9, 10, 12, 12, 12, 13, 14, 15, 16, 17, 18, 19, 19, 20, 21, 22, 24, 25
}
local EC_CODEWORDS_L = {
  7, 10, 15, 20, 26, 36, 40, 48, 60, 72, 80, 96, 104, 120, 132,
  144, 168, 180, 196, 224, 224, 252, 270, 300, 312, 336, 360, 390, 420, 450,
  480, 510, 540, 570, 570, 600, 630, 660, 720, 750
}

local function charCountBits(version)
  return version < 10 and 8 or 16
end

local function getCapacityBytes(version)
  local total = getSymbolTotalCodewords(version)
  local ecTotal = EC_CODEWORDS_L[version]
  local dataBits = (total - ecTotal) * 8
  local reserved = 4 + charCountBits(version)
  local usable = dataBits - reserved
  return floor(usable / 8)
end

local function getBestVersion(byteLength)
  for v = 1, 40 do
    if byteLength <= getCapacityBytes(v) then return v end
  end
  return nil
end

-- ---------- Galois Field GF(256) ----------

local EXP_TABLE, LOG_TABLE = {}, {}
do
  local x = 1
  for i = 0, 254 do
    EXP_TABLE[i] = x
    LOG_TABLE[x] = i
    x = lshift(x, 1)
    if band(x, 0x100) ~= 0 then x = bxor(x, 0x11D) end
  end
  for i = 255, 511 do EXP_TABLE[i] = EXP_TABLE[i - 255] end
end

local function gfMul(x, y)
  if x == 0 or y == 0 then return 0 end
  return EXP_TABLE[LOG_TABLE[x] + LOG_TABLE[y]]
end

-- ---------- Polynômes / Reed-Solomon ----------

local function polyMul(p1, p2)
  local coeff = {}
  for i = 1, #p1 + #p2 - 1 do coeff[i] = 0 end
  for i = 1, #p1 do
    for j = 1, #p2 do
      local idx = i + j - 1
      coeff[idx] = bxor(coeff[idx], gfMul(p1[i], p2[j]))
    end
  end
  return coeff
end

local function polyMod(dividend, divisor)
  local result = {}
  for i = 1, #dividend do result[i] = dividend[i] end
  while (#result - #divisor) >= 0 do
    local coeff = result[1]
    for i = 1, #divisor do
      result[i] = bxor(result[i], gfMul(divisor[i], coeff))
    end
    local offset = 1
    while offset <= #result and result[offset] == 0 do offset = offset + 1 end
    local trimmed = {}
    for i = offset, #result do trimmed[#trimmed + 1] = result[i] end
    result = trimmed
  end
  return result
end

local function generateECPolynomial(degree)
  local poly = { 1 }
  for i = 0, degree - 1 do
    poly = polyMul(poly, { 1, EXP_TABLE[i] })
  end
  return poly
end

local function rsEncode(data, degree)
  local genPoly = generateECPolynomial(degree)
  local padded = {}
  for i = 1, #data do padded[i] = data[i] end
  for i = #data + 1, #data + degree do padded[i] = 0 end
  local remainder = polyMod(padded, genPoly)
  local start = degree - #remainder
  local buff = {}
  for i = 1, degree do buff[i] = 0 end
  for i = 1, #remainder do buff[start + i] = remainder[i] end
  return buff
end

-- ---------- BitBuffer ----------

local BitBuffer = {}
BitBuffer.__index = BitBuffer

function BitBuffer.new()
  return setmetatable({ bytes = {}, length = 0 }, BitBuffer)
end

function BitBuffer:putBit(bit)
  local byteIndex = floor(self.length / 8) + 1
  if not self.bytes[byteIndex] then self.bytes[byteIndex] = 0 end
  if bit ~= 0 then
    self.bytes[byteIndex] = bor(self.bytes[byteIndex], rshift(0x80, self.length % 8))
  end
  self.length = self.length + 1
end

function BitBuffer:put(num, length)
  for i = 0, length - 1 do
    self:putBit(band(rshift(num, length - i - 1), 1))
  end
end

-- ---------- Format / Version info (BCH) ----------

local G15 = bor(bor(bor(bor(bor(bor(lshift(1, 10), lshift(1, 8)), lshift(1, 5)), lshift(1, 4)), lshift(1, 2)), lshift(1, 1)), 1)
local G15_MASK = bor(bor(bor(bor(lshift(1, 14), lshift(1, 12)), lshift(1, 10)), lshift(1, 4)), lshift(1, 1))
local G15_BCH = getBCHDigit(G15)

local G18 = bor(bor(bor(bor(bor(bor(bor(lshift(1, 12), lshift(1, 11)), lshift(1, 10)), lshift(1, 9)), lshift(1, 8)), lshift(1, 5)), lshift(1, 2)), 1)
local G18_BCH = getBCHDigit(G18)

local ECL_BIT = 1 -- niveau L

local function formatEncodedBits(mask)
  local data = bor(lshift(ECL_BIT, 3), mask)
  local d = lshift(data, 10)
  while getBCHDigit(d) - G15_BCH >= 0 do
    d = bxor(d, lshift(G15, getBCHDigit(d) - G15_BCH))
  end
  return bxor(bor(lshift(data, 10), d), G15_MASK)
end

local function versionEncodedBits(version)
  local d = lshift(version, 12)
  while getBCHDigit(d) - G18_BCH >= 0 do
    d = bxor(d, lshift(G18, getBCHDigit(d) - G18_BCH))
  end
  return bor(lshift(version, 12), d)
end

-- ---------- Alignment / Finder positions ----------

local function getRowColCoords(version)
  if version == 1 then return {} end
  local posCount = floor(version / 7) + 2
  local size = getSymbolSize(version)
  local intervals
  if size == 145 then
    intervals = 26
  else
    intervals = ceil((size - 13) / (2 * posCount - 2)) * 2
  end
  local positions = {}
  positions[1] = size - 7
  for i = 2, posCount - 1 do
    positions[i] = positions[i - 1] - intervals
  end
  positions[#positions + 1] = 6
  local rev = {}
  for i = #positions, 1, -1 do rev[#rev + 1] = positions[i] end
  return rev
end

local function getAlignmentPositions(version)
  local coords = {}
  local pos = getRowColCoords(version)
  local n = #pos
  for i = 1, n do
    for j = 1, n do
      if not ((i == 1 and j == 1) or (i == 1 and j == n) or (i == n and j == 1)) then
        coords[#coords + 1] = { pos[i], pos[j] }
      end
    end
  end
  return coords
end

local function getFinderPositions(version)
  local size = getSymbolSize(version)
  return { { 0, 0 }, { size - 7, 0 }, { 0, size - 7 } }
end

-- ---------- BitMatrix ----------

local Matrix = {}
Matrix.__index = Matrix

function Matrix.new(size)
  return setmetatable({ size = size, data = {}, reserved = {} }, Matrix)
end

function Matrix:idx(row, col) return row * self.size + col end

function Matrix:set(row, col, value, reserved)
  local i = self:idx(row, col)
  self.data[i] = value and 1 or 0
  if reserved then self.reserved[i] = true end
end

function Matrix:get(row, col)
  return self.data[self:idx(row, col)] or 0
end

function Matrix:xorAt(row, col, value)
  local i = self:idx(row, col)
  self.data[i] = bxor(self.data[i] or 0, value and 1 or 0)
end

function Matrix:isReserved(row, col)
  return self.reserved[self:idx(row, col)] == true
end

-- ---------- Construction du symbole ----------

local function setupFinderPattern(matrix, version)
  local size = matrix.size
  for _, p in ipairs(getFinderPositions(version)) do
    local row, col = p[1], p[2]
    for r = -1, 7 do
      if not (row + r <= -1 or size <= row + r) then
        for c = -1, 7 do
          if not (col + c <= -1 or size <= col + c) then
            local dark = (r >= 0 and r <= 6 and (c == 0 or c == 6))
              or (c >= 0 and c <= 6 and (r == 0 or r == 6))
              or (r >= 2 and r <= 4 and c >= 2 and c <= 4)
            matrix:set(row + r, col + c, dark, true)
          end
        end
      end
    end
  end
end

local function setupTimingPattern(matrix)
  local size = matrix.size
  for r = 8, size - 9 do
    local value = (r % 2 == 0)
    matrix:set(r, 6, value, true)
    matrix:set(6, r, value, true)
  end
end

local function setupAlignmentPattern(matrix, version)
  for _, p in ipairs(getAlignmentPositions(version)) do
    local row, col = p[1], p[2]
    for r = -2, 2 do
      for c = -2, 2 do
        local dark = (r == -2 or r == 2 or c == -2 or c == 2 or (r == 0 and c == 0))
        matrix:set(row + r, col + c, dark, true)
      end
    end
  end
end

local function setupVersionInfo(matrix, version)
  local size = matrix.size
  local bits = versionEncodedBits(version)
  for i = 0, 17 do
    local row = floor(i / 3)
    local col = (i % 3) + size - 8 - 3
    local mod = band(rshift(bits, i), 1) == 1
    matrix:set(row, col, mod, true)
    matrix:set(col, row, mod, true)
  end
end

local function setupFormatInfo(matrix, mask)
  local size = matrix.size
  local bits = formatEncodedBits(mask)
  for i = 0, 14 do
    local mod = band(rshift(bits, i), 1) == 1
    if i < 6 then
      matrix:set(i, 8, mod, true)
    elseif i < 8 then
      matrix:set(i + 1, 8, mod, true)
    else
      matrix:set(size - 15 + i, 8, mod, true)
    end
    if i < 8 then
      matrix:set(8, size - i - 1, mod, true)
    elseif i < 9 then
      matrix:set(8, 15 - i - 1 + 1, mod, true)
    else
      matrix:set(8, 15 - i - 1, mod, true)
    end
  end
  matrix:set(size - 8, 8, true, true)
end

local function setupData(matrix, data)
  local size = matrix.size
  local inc = -1
  local row = size - 1
  local bitIndex = 7
  local byteIndex = 1
  local col = size - 1
  while col > 0 do
    if col == 6 then col = col - 1 end
    while true do
      for c = 0, 1 do
        if not matrix:isReserved(row, col - c) then
          local dark = false
          if byteIndex <= #data then
            dark = band(rshift(data[byteIndex], bitIndex), 1) == 1
          end
          matrix:set(row, col - c, dark)
          bitIndex = bitIndex - 1
          if bitIndex == -1 then
            byteIndex = byteIndex + 1
            bitIndex = 7
          end
        end
      end
      row = row + inc
      if row < 0 or size <= row then
        row = row - inc
        inc = -inc
        break
      end
    end
    col = col - 2
  end
end

-- ---------- Masque ----------

local function getMaskAt(pattern, i, j)
  if pattern == 0 then return (i + j) % 2 == 0 end
  if pattern == 1 then return i % 2 == 0 end
  if pattern == 2 then return j % 3 == 0 end
  if pattern == 3 then return (i + j) % 3 == 0 end
  if pattern == 4 then return (floor(i / 2) + floor(j / 3)) % 2 == 0 end
  if pattern == 5 then return (i * j) % 2 + (i * j) % 3 == 0 end
  if pattern == 6 then return ((i * j) % 2 + (i * j) % 3) % 2 == 0 end
  if pattern == 7 then return ((i * j) % 3 + (i + j) % 2) % 2 == 0 end
  error("bad mask pattern: " .. tostring(pattern))
end

local function applyMask(pattern, matrix)
  local size = matrix.size
  for col = 0, size - 1 do
    for row = 0, size - 1 do
      if not matrix:isReserved(row, col) then
        matrix:xorAt(row, col, getMaskAt(pattern, row, col))
      end
    end
  end
end

local function penaltyN1(matrix)
  local size = matrix.size
  local points = 0
  for row = 0, size - 1 do
    local sameCol, sameRow = 0, 0
    local lastCol, lastRow = nil, nil
    for col = 0, size - 1 do
      local m = matrix:get(row, col)
      if m == lastCol then
        sameCol = sameCol + 1
      else
        if sameCol >= 5 then points = points + 3 + (sameCol - 5) end
        lastCol = m
        sameCol = 1
      end
      local m2 = matrix:get(col, row)
      if m2 == lastRow then
        sameRow = sameRow + 1
      else
        if sameRow >= 5 then points = points + 3 + (sameRow - 5) end
        lastRow = m2
        sameRow = 1
      end
    end
    if sameCol >= 5 then points = points + 3 + (sameCol - 5) end
    if sameRow >= 5 then points = points + 3 + (sameRow - 5) end
  end
  return points
end

local function penaltyN2(matrix)
  local size = matrix.size
  local points = 0
  for row = 0, size - 2 do
    for col = 0, size - 2 do
      local sum = matrix:get(row, col) + matrix:get(row, col + 1) + matrix:get(row + 1, col) + matrix:get(row + 1, col + 1)
      if sum == 4 or sum == 0 then points = points + 1 end
    end
  end
  return points * 3
end

local function penaltyN3(matrix)
  local size = matrix.size
  local points = 0
  for row = 0, size - 1 do
    local bitsCol, bitsRow = 0, 0
    for col = 0, size - 1 do
      bitsCol = bor(band(lshift(bitsCol, 1), 0x7FF), matrix:get(row, col))
      if col >= 10 and (bitsCol == 0x5D0 or bitsCol == 0x05D) then points = points + 1 end
      bitsRow = bor(band(lshift(bitsRow, 1), 0x7FF), matrix:get(col, row))
      if col >= 10 and (bitsRow == 0x5D0 or bitsRow == 0x05D) then points = points + 1 end
    end
  end
  return points * 40
end

local function penaltyN4(matrix)
  local size = matrix.size
  local dark = 0
  local total = size * size
  for i = 0, total - 1 do dark = dark + (matrix.data[i] or 0) end
  local k = math.abs(ceil((dark * 100 / total) / 5) - 10)
  return k * 10
end

local function getBestMask(matrix)
  local best, bestPenalty = 0, math.huge
  for p = 0, 7 do
    setupFormatInfo(matrix, p)
    applyMask(p, matrix)
    local penalty = penaltyN1(matrix) + penaltyN2(matrix) + penaltyN3(matrix) + penaltyN4(matrix)
    applyMask(p, matrix) -- annule le masque appliqué pour ce test
    if penalty < bestPenalty then
      bestPenalty = penalty
      best = p
    end
  end
  return best
end

-- ---------- Assemblage des données ----------

local function createCodewords(buffer, version)
  local totalCodewords = getSymbolTotalCodewords(version)
  local ecTotalCodewords = EC_CODEWORDS_L[version]
  local dataTotalCodewords = totalCodewords - ecTotalCodewords
  local ecTotalBlocks = EC_BLOCKS_L[version]

  local blocksInGroup2 = totalCodewords % ecTotalBlocks
  local blocksInGroup1 = ecTotalBlocks - blocksInGroup2
  local dataCodewordsInGroup1 = floor(dataTotalCodewords / ecTotalBlocks)
  local dataCodewordsInGroup2 = dataCodewordsInGroup1 + 1
  local totalCodewordsInGroup1 = floor(totalCodewords / ecTotalBlocks)
  local ecCount = totalCodewordsInGroup1 - dataCodewordsInGroup1

  local dcData, ecData = {}, {}
  local offset = 0
  local maxDataSize = 0
  for b = 1, ecTotalBlocks do
    local dataSize = (b <= blocksInGroup1) and dataCodewordsInGroup1 or dataCodewordsInGroup2
    local block = {}
    for i = 1, dataSize do block[i] = buffer.bytes[offset + i] or 0 end
    dcData[b] = block
    ecData[b] = rsEncode(block, ecCount)
    offset = offset + dataSize
    maxDataSize = max(maxDataSize, dataSize)
  end

  local data = {}
  local index = 1
  for i = 1, maxDataSize do
    for r = 1, ecTotalBlocks do
      if i <= #dcData[r] then
        data[index] = dcData[r][i]
        index = index + 1
      end
    end
  end
  for i = 1, ecCount do
    for r = 1, ecTotalBlocks do
      data[index] = ecData[r][i]
      index = index + 1
    end
  end
  return data
end

local function createData(version, text)
  local buffer = BitBuffer.new()
  buffer:put(4, 4) -- indicateur de mode : Octet (0100)
  buffer:put(#text, charCountBits(version))
  for i = 1, #text do
    buffer:put(string.byte(text, i), 8)
  end

  local totalCodewords = getSymbolTotalCodewords(version)
  local ecTotalCodewords = EC_CODEWORDS_L[version]
  local dataTotalCodewordsBits = (totalCodewords - ecTotalCodewords) * 8

  if buffer.length + 4 <= dataTotalCodewordsBits then
    buffer:put(0, 4)
  end
  while buffer.length % 8 ~= 0 do
    buffer:putBit(0)
  end
  local remainingByte = (dataTotalCodewordsBits - buffer.length) / 8
  for i = 1, remainingByte do
    buffer:put((i % 2 == 1) and 0xEC or 0x11, 8)
  end

  return createCodewords(buffer, version)
end

-- ---------- API publique ----------

-- Génère un QR code (mode Octet, ECC L) pour `text` (ASCII).
-- Renvoie { size, isDark = function(row, col) 0-based -> booléen, version }
-- ou nil, message si le texte est trop long (> capacité version 40).
function QR.Generate(text)
  text = tostring(text or "")
  if text == "" then return nil, "Rien à encoder." end
  local version = getBestVersion(#text)
  if not version then
    return nil, "Lien trop long pour un QR code (" .. #text .. " caractères)."
  end

  local dataCodewords = createData(version, text)
  local size = getSymbolSize(version)
  local matrix = Matrix.new(size)

  setupFinderPattern(matrix, version)
  setupTimingPattern(matrix)
  setupAlignmentPattern(matrix, version)
  setupFormatInfo(matrix, 0)
  if version >= 7 then setupVersionInfo(matrix, version) end
  setupData(matrix, dataCodewords)

  local mask = getBestMask(matrix)
  applyMask(mask, matrix)
  setupFormatInfo(matrix, mask)

  return {
    size = size,
    version = version,
    isDark = function(row, col) return matrix:get(row, col) == 1 end
  }
end
