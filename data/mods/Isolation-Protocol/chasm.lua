local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("fall_into_chasm", function(hit)
    local actor = hit.creature
    if not actor then return true end
    -- The inherited vortex fires before the chasm's fall.
    ccb.runtime.call_creature("enter_swirling_vortex", actor)
    if actor.subtype == "avatar" then
        local message = ccb.services.translate("You fell forever into the dark chasm…")
        ccb.presentation.notice(message)
        services.activities.offer_interruption("")
        services.messages.add(message)
    end
    local result
    if actor.subtype == "monster" then result = services.monsters.die(actor)
    else result = services.characters.die(actor) end
    if not result.ok then error(result.error.message) end
    return false
end)
