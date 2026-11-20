local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

ccb.runtime.handler("inner_cabins_void_trap", function(hit)
    local actor = hit.creature
    if not actor then return true end
    checked(services.effects.add(actor, id("effect", "bleed"), services.time.duration(600, "turn"), { intensity = 21 }))
    if actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You feel your blood start to boil and seep from your pores!"))
    end
    return false
end)

ccb.runtime.handler("disturb_dermatik_trap", function(hit)
    local actor = hit.creature
    if not actor then return true end
    local subject = checked(services.creatures.snapshot(actor))
    services.sound.emit(subject.position, 2, "movement", ccb.services.translate("chitin flexing and earth moving*"))
    if actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate("The ground shifts and writhes below your feet as something burrows out of the earth!"))
    end
    checked(services.spawns.population(id("monster", "mon_dermatik_juvenile_flightless"), subject.position,
        { min_radius = 1, max_radius = 1 }))
    if actor.subtype ~= "avatar" and checked(services.creatures.player_can_see(actor)) then
        local message = ccb.services.translate("The ground shifts and writhes below <u_name>'s feet as something burrows out of the earth!")
        services.messages.add((message:gsub("<u_name>", function() return subject.name end)))
    end
    return false
end)
