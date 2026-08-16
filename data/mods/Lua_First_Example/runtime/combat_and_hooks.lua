local ccb = require("ccb")

local hooks = {}

function hooks.on_craft_result(payload)
    if not payload then return end
    local count = ccb.state.character.get("lua_first_crafts_total", 0) + 1
    ccb.state.character.set("lua_first_crafts_total", count)
end

function hooks.on_melee_attacked(payload)
    if not payload then return end
    local hits = ccb.state.character.get("lua_first_melee_encounters", 0) + 1
    ccb.state.character.set("lua_first_melee_encounters", hits)
end

return hooks
