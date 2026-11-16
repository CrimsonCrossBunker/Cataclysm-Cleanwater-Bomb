local ccb = require("ccb")
local content = ccb.content

if content.is_mod_active("innawood") then
    local blocked = content.Blacklist { kind = "monster" }
    blocked:entry("mon_plasticgolem"):entry("mon_irongolem")
    content.add(blocked)
end
