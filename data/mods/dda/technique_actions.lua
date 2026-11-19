local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("technique_demo_surrender", function(combat)
    if combat.attacker.subtype ~= "npc" then
        services.messages.add(services.translate("That was so awesome, the foe decides to surrender!"), "good")
    end
    local target = combat.target
    local result
    if target.subtype == "npc" then
        result = services.npcs.follow(target, combat.attacker)
    elseif target.subtype == "monster" then
        result = services.monsters.set_disposition(target, { friendly = 100 })
    end
    if result and not result.ok then
        error(result.error.message)
    end
end)
