local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function apply_effect(character, effect, turns, options)
    local result = services.effects.add(character, id("effect", effect),
        services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

ccb.runtime.handler("consume_item_ewwww_de_zombie", function(context)
    local character = context.character
    apply_effect(character, "effect_ewwww_de_zombie", 10800 + services.random.native_int(0, 10800))
end)
