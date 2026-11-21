local ccb = require("ccb")

local function vampire_hunt_morale(context)
    ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
        30, 50, { duration = ccb.services.time.duration(24, "hour"),
            decay_start = ccb.services.time.duration(12, "hour") })
end

ccb.runtime.handler("morale_mission_low_vampire_hunter", vampire_hunt_morale)
ccb.runtime.handler("morale_mission_vampire_hunter", vampire_hunt_morale)

ccb.runtime.handler("gamehunt_morale", function(context)
    local hour = ccb.services.time.duration(1, "hour")
    ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
        10, 50, { duration = hour, decay_start = hour })
end)

local function announce(handler, message)
    ccb.runtime.handler(handler, function(context)
        if context.character.subtype == "avatar" then
            ccb.services.messages.add(message(), "good")
        end
    end)
end

announce("announce_dream_drainer_loot", function()
    return ccb.services.translate("As the mosquito fades away, it leaves something behind.")
end)
announce("announce_luna_attuned_loot", function()
    return ccb.services.translate("As the revenant decoheres, it leaves something behind.")
end)
announce("announce_shadow_loot", function()
    return ccb.services.translate("As the shadow dissipates, it leaves something behind.")
end)

ccb.runtime.handler("complete_revenant_vengeance", function(context)
    local services = ccb.services
    local character = context.character
    local awarded = services.achievements.complete(services.types.id("achievement", "achievement_xe_complete_revenant_mission"))
    if not awarded.ok then error(awarded.error.message) end
    local rest = character.subtype ~= "avatar" or services.interaction.confirm(services.translate(
        "Your murderer lies dead.  Your terrible thirst for vengeance is sated.  Bereft of the urge driving you on, you feel yourself falling backwards into the embrace of death.  Do you let yourself go?"))
    if rest then
        local died = services.characters.die(character)
        if not died.ok then error(died.error.message) end
    end
end)

local sacrifice_gamehunts = {
    "mission_best_friend_gamehunt1",
    "mission_best_friend_gamehunt2",
    "mission_best_friend_gamehunt3",
}

ccb.runtime.handler("assign_sacrifice_gamehunt_mission", function(context)
    local services = ccb.services
    local choice = services.random.native_int(1, #sacrifice_gamehunts)
    local mission_id = services.types.id("mission", sacrifice_gamehunts[choice])
    if context.giver and context.character.subtype == "avatar" then
        local assigned = services.npcs.missions.add_assigned(context.giver, context.character, mission_id)
        if not assigned.ok then error(assigned.error.message) end
    else
        local reserved = services.missions.reserve(mission_id)
        if not reserved.ok then error(reserved.error.message) end
        local assigned = services.missions.assign(context.character, reserved.value.token)
        if not assigned.ok then error(assigned.error.message) end
    end
    if context.giver then
        local saved = services.variables.set(context.giver, "randomize_game_find_mission", choice, { include_before = false })
        if not saved.ok then error(saved.error.message) end
    end
end)
