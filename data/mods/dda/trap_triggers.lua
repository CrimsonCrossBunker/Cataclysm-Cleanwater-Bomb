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

ccb.runtime.handler("random_telepad", function(hit)
    local actor = hit.creature
    if not actor then return true end
    local subject = checked(services.creatures.snapshot(actor))
    services.sound.emit(subject.position, 6, "movement", ccb.services.translate("vvrrrRRMM*POP!*"))
    if actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate("The air shimmers around you…"))
    elseif checked(services.creatures.player_can_see(actor)) then
        local message = ccb.services.translate("The air shimmers around <u_name>…")
        services.messages.add((message:gsub("<u_name>", function() return subject.name end)))
    end
    local function offset()
        local sign = services.random.native_int(0, 1) == 0 and 1 or -1
        return sign * (2 + services.random.native_int(0, 10))
    end
    local p = hit.position
    checked(services.relocation.teleport_creature(actor, services.coords.tripoint_abs_ms(p.x + offset(), p.y + offset(), p.z)))
    return false
end)

ccb.runtime.handler("swirling_vortex", function(hit)
    if not hit.creature then return true end
    require("portal_storm_dungeon").enter_vortex(hit.creature)
    return false
end)

ccb.runtime.handler("disturb_alien_roots", function(hit)
    if not hit.creature then return true end
    local origin = checked(services.creatures.snapshot(hit.creature)).position
    local tree = services.world.find_location(origin, { kind = "terrain", id = id("terrain", "t_alien_meadow_tree_trap") },
        { target_max_radius = 12 }).position
    if tree then
        local group = id("monster_group", "GROUP_ALIEN_TRAP_TREE")
        checked(services.spawns.population(group, tree, {
            count = function() return services.random.native_int(2, 5) end,
            min_radius = 1, max_radius = 3, outdoor_only = true,
        }))
    end
    return false
end)
