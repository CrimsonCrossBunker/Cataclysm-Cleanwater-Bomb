local ccb = require("ccb")
local content = ccb.content

if content.is_mod_active("classic_zombies") then
    local allowed = content.Blacklist { kind = "monster", whitelist = true, exclusive = true }
    allowed:category("XE_CLASSIC")
    content.add(allowed)
end
