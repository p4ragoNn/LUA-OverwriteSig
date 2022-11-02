function WriteSignatures(targetSignature, overrideSignature, codePage)
  local byteLine = overrideSignature:gsub("%w+", "0x%0,"):sub(1,-2)
  local results = AOBScan(targetSignature, codePage)
  if (results == nil) then  return end
  for i = 0, results.Count-1 do
    local address = getAddress(results.getString(i))
    local lineCode = 'writeBytes('..address..','.. byteLine..')'
    loadstring(lineCode)()
  end
  results.destroy()
end

function Code()
  local a = '31 64 65 65 31 61 61 63 64 65 35 63 36 36 34 34 37 35 37 63 36 32 62 37 61 33 61 63 36 33 31 65' -- Original AOB
  local b = '38 65 31 65 30 32 36 33 30 66 33 36 34 31 35 61 35 35 33 32 62 61 65 32 30 35 34 35 38 63 36 62' -- Our Modified AOB
  local c = '-X*C*W' -- Change our CODE PAGE to WRITEABLE
  WriteSignatures(a, b, c) -- Lastly we overwrite our AOB!
 end