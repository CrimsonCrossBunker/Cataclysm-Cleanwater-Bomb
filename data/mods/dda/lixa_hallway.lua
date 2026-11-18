local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local recorder = require("nre_recorder")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(actor, key)
    return checked(variables.get_number(actor, key)).value or 0
end

local function set_number(actor, key, value)
    checked(variables.set(actor, key, value, { include_before = false }))
end

local function point(key)
    return checked(variables.get_global_tripoint(key)).value or services.coords.tripoint_abs_ms(0, 0, 0)
end

local function update_map(key, update_id)
    local target = checked(services.overmap.tile_token(point(key):project_to("omt")))
    local update = checked(services.mapgen.update_token(services.types.id("update_mapgen", update_id)))
    checked(services.mapgen.run_update(target, update))
end

local function teleport(actor, key)
    return checked(services.relocation.teleport_creature(actor, point(key), { force = true }))
end

ccb.runtime.handler("lixa_unfold_hallway", function(payload)
    local stage = payload.data.stage
    set_number(payload.character, "LIXA_unfold_level", math.min(stage + 1, 6))
    if stage > 0 then
        update_map("LIXA_unfold_A", "spawn_LIXA_" .. stage .. "a")
        update_map("LIXA_unfold_B", "spawn_LIXA_" .. stage .. "b")
    end
end, 1)

local function is_character(actor)
    return actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character"
end

local function unfold(actor)
    local level = number(actor, "LIXA_unfold_level")
    if level >= 0 then
        local stage = math.floor(math.min(level, 6))
        if stage > 0 then
            update_map("LIXA_unfold_A", "cleanup_LIXA")
            update_map("LIXA_unfold_B", "cleanup_LIXA")
        end
        -- Only Characters have a local queue for the delayed map updates.
        if is_character(actor) then
            ccb.tasks.after_character_turn(actor, 2, "lixa_unfold_hallway", { stage = stage })
        end
    end
end

local function register_hallway_trap(direction, name, description, index)
    local key = direction == 1 and "back" or "forward"
    local suffix = key .. "_" .. index
    local handler = "lixa_" .. suffix
    local spell = "spell_LIXA_" .. suffix
    local variable = "LIXA_tp_" .. key
    local destination = "LIXA_" .. key .. "_tp_" .. index

    ccb.runtime.handler(handler, function(impact)
        local actor = impact.target_creature
        set_number(actor, variable, index)
        local moved = teleport(actor, destination)
        actor = moved.handle
        if moved.accepted and is_character(actor) then
            local message = ccb.services.translate("You walk for a long while.")
            checked(services.characters.add_msg_if_player(actor, "%s", message))
        end

        if number(actor, "LIXA_hallway_direction") == direction then
            unfold(actor)
        end
        set_number(actor, "LIXA_hallway_direction", direction)
    end)

    content.add(content.Spell {
        id = spell,
        name = name,
        description = description,
        valid_targets = { "self", "hostile", "ally" },
        max_level = 1,
        flags = { "SILENT", "NO_EXPLOSION_SFX" },
        base_casting_time = 1,
        shape = "blast",
        min_range = 0,
        min_aoe = 1,
        max_aoe = 1,
    }:lua_impact(handler))

    content.add(content.Trap {
        id = "tr_LIXA_" .. suffix,
        name = "",
        color = "green",
        symbol = "#",
        visibility = 99,
        always_invisible = true,
        avoidance = 99,
        difficulty = 99,
        trap_radius = 0,
        action = "spell",
        spell = spell,
    }:flag("UNDODGEABLE"):flag("UNCONSUMED"))
end

for index = 1, 16 do
    register_hallway_trap(1, "LIXA Back Teleport", "Teleports the victim backwards.", index)
    register_hallway_trap(2, "LIXA Forward Teleport", "Teleports the victim forwards.", index)
end

local unfolded = services.types.id("effect", "LIXA_unfolded_eff")
local anti_shape = services.types.id("mutation", "anti_shape")
local finale = services.types.id("achievement", "achievement_LIXA_finale")
local escape_key = "LIXA_escape_key"
local coordinates = services.coords

ccb.runtime.handler("lixa_final_death", function(payload)
    local intensity = payload.whole_body_effects.LIXA_unfolded_eff
    if not intensity or intensity < -1 then return end

    local category = "You don't die.  Death is something that happens in the plane of time, and now that you are part of this place, you will never see that plane again.  You will very quickly come to wish you had died instead."
    local message = services.snippets.native_random(category)
    if message then
        services.messages.add(checked(services.text.expand_for(message, nil, nil, nil, nil, true)), "bad")
    end
end)
ccb.runtime.on("avatar_death", "lixa_final_death")

local corridor_locations = {
    { "LIXA_unfold_A", "LIXA_device_unfolded_A", -8 },
    { "LIXA_unfold_B", "LIXA_device_unfolded_B", -8 },
    { "LIXA_chamber_1", "LIXA_device_1", -4 },
    { "LIXA_chamber_2", "LIXA_device_2", -4 },
    { "LIXA_chamber_3", "LIXA_device_3", -4 },
    { "LIXA_workfloor_NW", "LIXA_workfloor_1a", -4 },
    { "LIXA_workfloor_NE", "LIXA_workfloor_2a", -3 },
    { "LIXA_workfloor_SW", "LIXA_workfloor_1b", -3 },
    { "LIXA_workfloor_SE", "LIXA_workfloor_2b", -3 },
    { "LIXA_surface_NW", "LIXA_surface_1a", 0 },
    { "LIXA_surface_NE", "LIXA_surface_1b", 0 },
    { "LIXA_surface_SW", "LIXA_surface_2a", 0 },
    { "LIXA_surface_SE", "LIXA_surface_2b", 0 },
}

local function remember_corridor_locations(actor)
    local origin = checked(services.creatures.snapshot(actor)).position:project_to("omt")
    for _, location in ipairs(corridor_locations) do
        local target = services.overmap.find_target(origin, location[2], { z = 0, min_distance = 0 })
        local found = services.world.find_location(target:project_to("ms")).position
        local position = coordinates.tripoint_abs_ms(found.x, found.y, location[3])
        checked(variables.set_global(location[1], position, { include_before = false }))
    end
end

local function show_notice(message)
    ccb.presentation.notice(message)
    services.activities.offer_interruption("")
    services.messages.add(message, "neutral")
end

local function enter_corridor(payload, index)
    local actor = payload.creature
    if not actor then return true end

    local origin = payload.position
    local trap_tile = services.world.to_bubble(coordinates.tripoint_abs_ms(origin.x, origin.y, origin.z))
    set_number(actor, "LIXA_entry", index)
    local place = checked(variables.get_global_string("place_name"))
    local name = place.exists and place.value or ccb.services.translate("Infinite Corridor")
    checked(services.world.override_place_name(name, services.time.duration(1, "day"), escape_key))
    local applied = services.effects.add(actor, unfolded, services.time.duration(1, "turn"), {
        permanent = true, intensity = 1,
    })
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
    actor = teleport(actor, "LIXA_forward_tp_" .. index).handle
    if actor.subtype == "avatar" then
        show_notice(ccb.services.translate("You step into a space that unfolds around you, becoming endless and completely flat.  Every side of every surface is on display.  You look down at your hands; you can see the front, the back, the insides and outsides of every vein and bone, all in the same place on one surface.  You can't imagine what has happened to your eyes to let you understand what you are seeing.  Or your brain."))
    end
    set_number(actor, "LIXA_unfold_level", 0)
    set_number(actor, "LIXA_hallway_direction", 2)
    remember_corridor_locations(actor)
    if is_character(actor) then recorder.capture(actor) end

    -- The native trap action consumes its original bubble tile after running the trigger.
    services.world.remove_trap(services.world.to_absolute(trap_tile))
    return false
end

for index = 1, 16 do
    local handler = "lixa_enter_corridor_" .. index
    ccb.runtime.handler(handler, function(payload)
        return enter_corridor(payload, index)
    end)
    content.add(content.Trap {
        id = "tr_LIXA_unfold_entry_" .. index,
        name = "",
        color = "green",
        symbol = "#",
        visibility = 99,
        always_invisible = true,
        avoidance = 99,
        difficulty = 99,
        trap_radius = 0,
        action = "none",
    }:flag("UNDODGEABLE"):on_trigger(handler))
end

ccb.runtime.handler("lixa_leave_goodbye_cards", function(payload)
    local actor = payload.character
    if number(actor, "LIXA_entry") ~= 0 then
        update_map("LIXA_chamber_3", "LIXA_goodbye_cards")
        set_number(actor, "LIXA_unfold_level", 0)
        set_number(actor, "LIXA_tp_forward", 0)
        set_number(actor, "LIXA_tp_back", 0)
        set_number(actor, "LIXA_entry", 0)
    end
end, 1)

local shutdown_locations = {
    "LIXA_chamber_1", "LIXA_chamber_2", "LIXA_chamber_3",
    "LIXA_workfloor_1a", "LIXA_workfloor_1b", "LIXA_workfloor_2a", "LIXA_workfloor_2b",
    "LIXA_surface_1a", "LIXA_surface_1b", "LIXA_surface_2a", "LIXA_surface_2b",
}

ccb.runtime.handler("lixa_unfold_return", function(impact)
    local actor = impact.target_creature
    if is_character(actor) then
        ccb.tasks.after_character_turn(actor, 0, "lixa_leave_goodbye_cards")
    end
    checked(services.world.reschedule_events(escape_key, services.time.duration(0, "turn")))
    checked(services.effects.remove(actor, unfolded))
    if is_character(actor) then checked(services.mutations.replace(actor, anti_shape)) end
    for _, location in ipairs(shutdown_locations) do
        update_map(location, "turn_off_LIXA")
    end
    if actor.subtype == "avatar" then
        show_notice(ccb.services.translate("There is a soft sound, like a champagne cork popping in an empty concert hall.  The world is almost as it was again, aside from a brief strange feeling.  The LIXA device still hums quietly as it finishes powering down."))
    end
    teleport(actor, "LIXA_return_tp")
    checked(services.achievements.complete(finale))
end)

content.add(content.Spell {
    id = "mon_LIXA_vector_death",
    name = "Unfold Collapse",
    description = "Ends the fight.",
    valid_targets = { "hostile" },
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    base_casting_time = 1,
    min_range = 60,
    max_range = 60,
    min_aoe = 60,
    max_aoe = 60,
    shape = "blast",
}:lua_impact("lixa_unfold_return"))
