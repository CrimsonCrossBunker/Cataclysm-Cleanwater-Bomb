local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = require("portal_storm_state")
local checked = state.checked
local duration = services.time.duration
local coords = services.coords
local zero = coords.tripoint_abs_ms(0, 0, 0)

local function spawn(actor, monster, count, inner, outer, shortest, longest)
    local options = { count = count, min_radius = inner, max_radius = outer }
    if shortest then
        options.lifespan = { minimum = duration(shortest, "second"), maximum = duration(longest, "second") }
    end
    checked(services.spawns.population(id("monster", monster), state.position(actor), options))
end

local function random_location(actor, inner, outer)
    return services.world.find_location(state.position(actor), nil, {
        min_radius = inner, max_radius = outer, allow_unloaded_candidates = true,
    }).position
end

local function teleport(actor, position)
    return checked(services.relocation.teleport_creature(actor, position)).handle
end

local function one_in(n)
    return services.random.native_int(0, n - 1) == 0
end

local function nest(actor)
    if checked(services.monsters.count_nearby(state.position(actor), { id("monster", "mon_void_spider") })) < 1 then
        return actor
    end
    state.message(actor, ccb.services.translate("The shadows of frenzied limbs slip into reality"), "info")
    spawn(actor, "mon_void_spider_spiderling", function() return services.random.native_int(1, 3) end, 6, 12, 5, 25)

    local location = state.position(actor)
    state.set("void_spider_eggs", location + coords.tripoint_rel_omt(1, 0, 0):project_to("ms"))
    state.set("void_spider_corpses", location + coords.tripoint_rel_omt(0, 1, 0):project_to("ms"))
    if one_in(10) then
        local where = random_location(actor, 25, 30)
        if where then state.set("void_spider_chaos_point_player", where) end
        actor = teleport(actor, state.point("void_spider_chaos_point_player"))
        state.message(actor, ccb.services.translate("The cavern shifts under unseen pressure."))
    end
    if one_in(10) then spawn(actor, "mon_void_spider_spiderling_skewered", 1, 6, 12) end
    if one_in(3) and state.number("void_spider_nest_eggs_spawned") ~= 1 then
        state.update_map(state.point("void_spider_eggs"), "void_spider_lair_eggs")
        state.set("void_spider_nest_eggs_spawned", 1)
    end
    if one_in(6) and state.number("void_spider_nest_corpses_spawned") ~= 1 then
        state.update_map(state.point("void_spider_corpses"), "void_spider_lair_corpses")
        state.set("void_spider_nest_corpses_spawned", 1)
    end
    ccb.tasks.after_avatar_turn(services.random.native_int(8, 10), "void_spider_nest_due")
    return actor
end

ccb.runtime.handler("void_spider_nest_due", function(task)
    nest(task.character)
end)

local function disturb(actor, target)
    local hp = checked(services.creatures.snapshot(actor)).hp
    if hp < 350 and checked(services.variables.get_number(actor, "void_spider_nest_disturbed")).value ~= 1 then
        checked(services.monsters.set_hp(actor, hp + 150))
        checked(services.effects.remove(actor, id("effect", "maimed_armor")))
        services.sound.emit(state.position(actor), 60, "speech", ccb.services.translate("the spider mimic an anguished scream"))
        actor = nest(actor)
        actor = teleport(actor, random_location(target, 40, 50) or zero)
        checked(services.variables.set(actor, "void_spider_nest_disturbed", 1, { include_before = false }))
    end
    return actor
end

local function spawn_limbs(actor, monster, hp_per_limb, radius)
    spawn(actor, monster, function()
        return math.modf(checked(services.creatures.snapshot(actor)).hp / hp_per_limb)
    end, radius, radius, 2, 3)
end

ccb.runtime.handler("void_spider_control", function(attack)
    local actor = disturb(attack.attacker, attack.target)
    spawn_limbs(actor, "mon_void_spider_maw", 300, 1)
    spawn_limbs(actor, "mon_void_spider_limb", 150, 2)
    local target = state.position(attack.target)
    if state.position(actor):game_distance(target) >= 15 then
        local count = state.number("spider_gore")
        if count < 10 then
            state.message(actor, ccb.services.translate("Foul heaps of rotten flesh rain down from the Weaver's maw!"), "bad")
            checked(services.monsters.cast_spell(actor, id("spell", "void_spider_gore"), { target = target }))
            state.set("spider_gore", count + 1)
            -- The monster caster has no character-turn queue for a follow-up cast.
        else
            state.set("spider_gore", 0)
        end
    end
    -- The former close-range attack used a Character-only melee action.
    checked(services.monsters.cast_spell(actor, id("spell", "void_spider_empty"), { hit_self = true }))
    return true
end)
