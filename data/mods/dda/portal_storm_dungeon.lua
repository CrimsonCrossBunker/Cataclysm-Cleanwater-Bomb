local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local environment = services.gameplay.environment
local id = services.types.id
local M = {}

ccb.runtime.handler("portal_dungeon_final_death", function(payload)
    if payload.dimension ~= "portal_storm_dungeon_dimension" then return end
    local message
    if payload.position.z <= -1 then
        message = services.translate("You fall, and fall, and fall, through an endless black void devoid of stars.  No light.  No sound.  No sensation of wind.  You try to shout, to scream, but hear nothing.  When you try to grab your own hand, you cannot feel it.  There is only the dark.\n\nPerhaps fortunately, your mind gives way before your body does.")
    else
        message = services.translate("Your ultimate fate is hard to sum up in words but suffice to say, the thing that used to be you wishes it had hidden from the storm.")
    end
    ccb.presentation.notice(message)
    services.activities.offer_interruption("")
    services.messages.add(message, "neutral")
end)
ccb.runtime.on("avatar_death", "portal_dungeon_final_death")

local function teleport(character, position)
    return state.checked(services.relocation.teleport_character(character, position)).handle
end

local function snippet(character, category)
    if character.subtype ~= "avatar" then return end
    local text = services.snippets.native_random(category) or ""
    text = state.checked(services.text.expand_for(text, character, nil, nil, nil, true))
    services.messages.add(text, "neutral")
end

ccb.runtime.handler("portal_dungeon_return_transport", function(character)
    local result = state.checked(services.relocation.travel_to_dimension("default",
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    state.message(character, result.accepted
        and services.translate("The shifting halls warp and fold on themselves and turn inside out, revealing the shape of the world you know.")
        or services.translate("You feel a prickle at the edge of your senses."))
end)

function M.return_to_world(character)
    if state.checked(services.monsters.count_nearby(state.position(character), nil,
        { radius = 8, attitude = "hostile" })) ~= 0 then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."), "bad")
        return
    end
    state.add_effect(character, "blind", 0)
    state.add_effect(character, "effect_temporary_levitation", 0)
    character = teleport(character, state.point("portal_dungeon_original_loc"))
    ccb.runtime.call_character("portal_dungeon_return_transport", character)
    environment.clear_saved_dimension("portal_storm_dungeon_dimension")
    state.checked(services.inventory.remove_type(character, id("item", "item_portal_storm_dimension_returner")))
    state.set("portal_dungeon_level", 0)
    state.checked(services.world.reschedule_events("portal_dungeon", services.time.duration(0, "turn")))
end

ccb.runtime.handler("portal_dungeon_return_item", function(payload)
    if payload.character then M.return_to_world(payload.character) end
    return 0
end)

local fragment = ccb.content.Item {
    id = "item_portal_storm_dimension_returner",
    name = ccb.content.plural_text("fragment of reality", "fragment of reality"),
    description = ccb.content.text("You can leave this place, if you want.  Focus on the world you left behind in the storm."),
    category = "armor", mass_grams = 0, volume_ml = 0,
    price_cents = 0, price_postapoc_cents = 0,
    symbol = "V", color = "dark_gray",
}
fragment:material("bone", 1)
fragment:armor()
for _, flag in ipairs { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "AURA", "PADDED", "NO_SALVAGE" } do
    fragment:flag(flag)
end
fragment:on_use("portal_dungeon_return_item", ccb.content.text("Activate"),
    ccb.content.text("Return.  Return.  Return.  Return."))
ccb.content.add(fragment)

ccb.runtime.handler("portal_dungeon_crawl_due", function(payload)
    if environment.dimension() ~= "portal_storm_dungeon_dimension" then return end
    local character = payload.character
    local effect = services.effects.get(character, id("effect", "effect_portal_storm_dungeon_time_tracker"))
    local intensity = 0
    if effect.ok then
        intensity = effect.value.intensity
    elseif effect.error.code ~= "not_found" then
        error(effect.error.message)
    end
    if intensity >= 0 then
        local monster = intensity >= 15 and "mon_better_half" or intensity >= 10 and "mon_dark_reflection"
            or intensity >= 5 and "mon_twisted_reflection" or "mon_pale_reflection"
        local spawned = state.checked(services.spawns.population(id("monster", monster), state.position(character),
            { count = 1, min_radius = 10, max_radius = 24 }))
        if spawned.visible > 0 then
            services.messages.add(services.translate("Something your mind can't fully parse appears, despite the distance and obstacles you know where it is.  You can feel its presence as if it was a part of you."), "bad")
        end
    end
    ccb.tasks.after_character_turn(character, 120, "portal_dungeon_crawl_due")
end)

function M.enter(character)
    state.set("portal_dungeon_original_loc", state.position(character))
    local names = { services.translate("Somewhere"), services.translate("Nowhere"), services.translate("Everywhere"),
        services.translate("Yesterday"), services.translate("Tomorrow") }
    state.set("place_name", names[services.random.native_int(0, #names - 1) + 1])
    local name = state.checked(services.variables.get_global_string("place_name")).value or "Error"
    state.checked(services.world.override_place_name(name, services.time.infinite_duration(), "portal_dungeon"))
    state.add_effect(character, "blind", 0)
    state.add_effect(character, "effect_temporary_levitation", 0)
    local moved = state.checked(services.relocation.travel_to_dimension("portal_storm_dungeon_dimension",
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    state.message(character, moved.accepted
        and services.translate("The screaming rage of the portal storm folds in upon itself.")
        or services.translate("Nothing seems to change."))
    local position = state.position(character)
    character = teleport(character, services.coords.tripoint_abs_ms(position.x, position.y, 0))
    if environment.terrain_id(state.position(character)) == "t_open_air" then
        local target = services.overmap.find_target(state.position(character):project_to("omt"),
            "default_portal_storm_dungeon_overmap", { min_distance = 1, search_range = 10, random = true })
        local floor = services.world.find_location(target:project_to("ms"),
            { kind = "terrain", id = id("terrain", "t_floor_warped") },
            { target_max_radius = 24, distance_origin = state.position(character) })
        character = teleport(character, floor.position or services.coords.tripoint_abs_ms(0, 0, 0))
    end
    state.set("portal_dungeon_level", 1)
    state.set("visited_a_portal_dungeon", 1)
    local message = state.checked(services.text.expand_for(services.translate("You are trapped in <global_val:place_name>!"),
        character, nil, nil, nil, true))
    state.message(character, message)
    state.checked(services.inventory.receive_item(character, id("item", "item_portal_storm_dimension_returner"), 1,
        { force_equip = true }))
    state.add_effect(character, "effect_portal_storm_dungeon_time_tracker", 2 * 86400)
    local mood = state.checked(services.variables.get_global_string("portal_storm_voice_mood")).value or "none"
    snippet(character, mood)
    state.message(character, services.translate("You can faintly feel the real world, somewhere in a direction you couldn't name, a fragment of reality in this unearthly place.  With enough effort, you could follow the trail back to the world you left behind."), "info")
    ccb.tasks.after_character_turn(character, 60, "portal_dungeon_crawl_due")
end

function M.teleport(character)
    if state.checked(services.effects.has(character, id("effect", "effect_portal_dungeon_multi_trigger_limiter"))) then return end
    local origin = state.position(character)
    environment.set_trap_area(origin, "tr_portal_dungeon_teleporter", 0, false)
    local target = services.overmap.find_target(origin:project_to("omt"), "portal_storm_dungeon_teleporter",
        { special = id("overmap_special", "portal_storm_dungeon_teleporter"), create_special = true,
          min_distance = 6, search_range = 40, random = true })
    local found = services.world.find_location(target:project_to("ms"),
        { kind = "trap", id = id("trap", "tr_portal_dungeon_teleporter") },
        { target_max_radius = 24, distance_origin = origin })
    local destination = found.position or services.coords.tripoint_abs_ms(0, 0, 0)
    state.add_effect(character, "effect_portal_dungeon_multi_trigger_limiter", 0)
    teleport(character, destination)
    environment.set_trap_area(destination, "tr_portal_dungeon_teleporter", 0, false)
end

function M.next_level(character)
    state.set("portal_dungeon_level", state.number("portal_dungeon_level") + 1)
    state.update_map(state.point("dungeon_loc"), "portal_dungeon_cleanup")
    local moved = state.checked(services.relocation.teleport_avatar(character, state.point("dungeon_start"), { force = true }))
    character = moved.handle
    if not moved.accepted then state.message(character, services.translate("Something is very wrong!")) end
    -- The obsolete reflection-spawn condition contains empty math and always evaluates to zero.
    require("nre_recorder").capture(character)
    state.update_map(state.point("dungeon_loc"), "portal_dungeon")
    state.message(character, services.translate("Weren't you just here?  It feels thicker somehow though."))
    local mood = state.checked(services.variables.get_global_string("portal_storm_voice_mood")).value or "none"
    snippet(character, mood)
end

local function trigger_vortex(payload)
    if not payload.creature or payload.creature.subtype ~= "avatar" then return nil end
    -- Consume the captured trap before travel; its original map must own cleanup.
    local origin = services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z)
    environment.set_trap_area(origin, "tr_null", 0, false)
    -- Native trap inheritance appends the dungeon action after the base vortex.
    local vortex = state.checked(services.relocation.teleport_character(payload.creature, state.point("nether_dungeon_door")))
    if vortex.accepted then state.message(vortex.handle, services.translate("How did you get here?")) end
    return vortex.handle
end

ccb.runtime.handler("portal_dungeon_entrance_trigger", function(payload)
    local character = trigger_vortex(payload)
    if not character then return false end
    M.enter(character)
    return true
end)
local entrance = ccb.content.Trap {
    id = "tr_portal_dungeon_entrance", name = ccb.content.text("swirling vortex"),
    color = "green", symbol = "#", visibility = -1, avoidance = 99, difficulty = 99,
    trap_radius = 2, action = "none",
}
entrance:flag("UNDODGEABLE")
entrance:flag("AVATAR_ONLY")
ccb.content.add(entrance:on_trigger("portal_dungeon_entrance_trigger"))

ccb.runtime.handler("portal_dungeon_teleporter_trigger", function(payload)
    local character = trigger_vortex(payload)
    if not character then return false end
    M.teleport(character)
    return true
end)
local teleporter = ccb.content.Trap {
    id = "tr_portal_dungeon_teleporter", name = ccb.content.text("elsewhere"),
    color = "green", symbol = "#", visibility = -1, avoidance = 99, difficulty = 99,
    trap_radius = 0, action = "none",
}
teleporter:flag("UNDODGEABLE")
teleporter:flag("AVATAR_ONLY")
ccb.content.add(teleporter:on_trigger("portal_dungeon_teleporter_trigger"))

ccb.runtime.handler("portal_dungeon_next_level_trigger", function(payload)
    local character = trigger_vortex(payload)
    if not character then return false end
    M.next_level(character)
    return true
end)
local next_level = ccb.content.Trap {
    id = "tr_portal_dungeon_next_level", name = ccb.content.text("swirling vortex"),
    color = "blue", symbol = "#", visibility = -1, avoidance = 99, difficulty = 99,
    trap_radius = 2, action = "none",
}
next_level:flag("UNDODGEABLE")
next_level:flag("AVATAR_ONLY")
ccb.content.add(next_level:on_trigger("portal_dungeon_next_level_trigger"))

return M
