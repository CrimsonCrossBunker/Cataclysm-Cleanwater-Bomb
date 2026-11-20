local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function dislodge_parasite(position)
    checked(services.spawns.population(id("monster", "mon_afs_auropacter_parasite"), position,
        { min_radius = 1, max_radius = 1 }))
end

ccb.runtime.handler("moxie_parasite_hit", function(hit)
    dislodge_parasite(hit.target_position)
end)

ccb.runtime.handler("moxie_parasite_death", function(death)
    local position = death.position
    dislodge_parasite(services.coords.tripoint_abs_ms(position.x, position.y, position.z))
end)

ccb.runtime.handler("eject_damaged_reactor", function(hit)
    checked(services.world.spawn_item(hit.target_position, id("item", "afs_reactor_unstable"), 1, true))
    hit.add_target_effect(id("effect", "effect_robot_immobilized"), services.time.duration(1, "turn"), true)
    if hit.source and hit.source.subtype == "avatar" then
        services.messages.add(ccb.services.translate("The malfunctioning reactor is ejected."), "neutral")
    end
end)
