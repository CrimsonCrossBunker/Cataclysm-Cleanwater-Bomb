local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function minutes(n)
    return services.time.duration(n, "minute")
end

local function add_effect(actor, effect_id, duration, opts)
    local applied = services.effects.add(actor, id("effect", effect_id), duration, opts)
    if not applied.ok and applied.error.code ~= "rejected" then
        error(applied.error.message)
    end
end

local function add_permanent_random_part_effect(actor, effect_id)
    local part = checked(services.characters.random_body_part(actor, true))
    add_effect(actor, effect_id, services.time.duration(1, "turn"), {
        body_part = part,
        permanent = true,
        intensity = 1,
    })
end

local function add_morale(actor, bonus, max_bonus, duration_min, decay_min)
    checked(services.morale.add(actor, id("morale", "morale_feeling_bad"), bonus, max_bonus, {
        duration = minutes(duration_min),
        decay_start = minutes(decay_min),
    }))
end

local function assign_mission(actor, mission_id)
    local reserved = checked(services.missions.reserve(id("mission", mission_id)))
    checked(services.missions.assign(actor, reserved.token))
end

local function run_mapgen_update_at(omt, update_id)
    local tile = checked(services.overmap.tile_token(omt))
    local update = checked(services.mapgen.update_token(id("update_mapgen", update_id)))
    checked(services.mapgen.run_update(tile, update))
end

local function popup_message(actor, text, severity)
    if actor.subtype ~= "avatar" then
        return
    end
    local translated = services.translate(text)
    ccb.presentation.notice(translated)
    services.activities.offer_interruption("")
    if severity then
        services.messages.add(translated, severity)
    else
        services.messages.add(translated)
    end
end

local function set_global(key, value)
    checked(services.variables.set_global(key, value, { include_before = false }))
end

local function bind_scenario(scenario_id, start_handler, due_handler, callback)
    ccb.runtime.handler(due_handler, callback)
    ccb.runtime.handler(start_handler, function(payload)
        ccb.tasks.after_character_turn(payload.character, 0, due_handler)
    end)
    content.replace(content.Scenario {
        id = scenario_id,
        inherits = scenario_id,
        on_start = start_handler,
    })
end

local function start_infected(actor)
    add_permanent_random_part_effect(actor, "infected")
    assign_mission(actor, "MISSION_INFECTED_START_FIND_ANTIBIOTICS")
end

bind_scenario("infected", "scenario_infected_start", "scenario_infected_due", function(payload)
    start_infected(payload.character)
end)

bind_scenario("fungal_start", "scenario_fungal_start", "scenario_fungal_due", function(payload)
    add_permanent_random_part_effect(payload.character, "fungus")
end)

bind_scenario("fire", "scenario_fire_start", "scenario_fire_due", function(payload)
    local actor_omt = checked(services.creatures.snapshot(payload.character)).position:project_to("omt")
    run_mapgen_update_at(actor_omt, "SCENARIO_FIRE")
    run_mapgen_update_at(actor_omt, "SCENARIO_SMOKE")
end)

bind_scenario("bad_day", "scenario_bad_day_start", "scenario_bad_day_due", function(payload)
    local actor = payload.character
    start_infected(actor)
    add_effect(actor, "flu", minutes(1000), { intensity = 1 })
    add_effect(actor, "drunk", minutes(270), { intensity = 1 })
    add_morale(actor, -100, -100, 50, 50)
end)

bind_scenario("faction_camp_start", "scenario_faction_camp_start", "scenario_faction_camp_due", function(payload)
    local actor_omt = checked(services.creatures.snapshot(payload.character)).position:project_to("omt")
    run_mapgen_update_at(actor_omt, "faction_start_add")
end)

bind_scenario("trapped_in_labyrinth", "scenario_trapped_in_labyrinth_start", "scenario_trapped_in_labyrinth_due", function(payload)
    local actor = payload.character
    checked(services.variables.set_string_notifying(actor, "scenario_trapped_in_labyrinth", "yes"))
    local travel = checked(services.relocation.travel_to_dimension("scarlet", {
        npc_travel_radius = 0,
        npc_travel_filter = "none",
    }))
    if actor.subtype == "avatar" then
        services.messages.add(services.translate(travel.accepted
            and "Your surroundings warp and fold into the recesses of another world."
            or "You feel a prickle at the edge of your senses."))
    end
    assign_mission(actor, "MISSION_FIND_LABYRINTH_SPIRE")

    local origin_omt = checked(services.creatures.snapshot(actor)).position:project_to("omt")
    local omt1 = services.overmap.find_target(origin_omt, "scarlet_sea_reverberation", {
        z = 0,
        min_distance = 0,
        search_range = 5,
        random = true,
    })
    local ms1 = omt1:project_to("ms")
    local loc1 = services.world.find_location(ms1, { kind = "terrain", id = id("terrain", "t_sand_scarlet") }, {
        target_max_radius = 20,
        min_radius = 0,
        max_radius = 0,
    })
    local anchor = (loc1.found and loc1.position) or ms1
    actor = checked(services.relocation.teleport_creature(actor, anchor)).handle

    local omt2 = services.overmap.find_target(
        checked(services.creatures.snapshot(actor)).position:project_to("omt"),
        "scarlet_scrap_metal_spire",
        { special = id("overmap_special", "scarlet_scrap_metal_spire"), create_special = true })
    local loc2 = services.world.find_location(omt2:project_to("ms"), nil)
    local spire = (loc2.found and loc2.position) or omt2:project_to("ms")
    checked(services.variables.set(actor, "scarlet_scrap_metal_spire_loc", spire, { include_before = false }))
    actor = checked(services.relocation.teleport_creature(actor, spire, { force = true })).handle

    local omt3 = services.overmap.find_target(
        checked(services.creatures.snapshot(actor)).position:project_to("omt"),
        "scarlet_sea_reverberation",
        { min_distance = 10, search_range = 15, random = true })
    local loc3 = services.world.find_location(omt3:project_to("ms"), nil)
    local start_pos = (loc3.found and loc3.position) or omt3:project_to("ms")
    checked(services.variables.set(actor, "scenario_trapped_in_labyrinth_start_location", start_pos,
        { include_before = false }))
    actor = checked(services.relocation.teleport_creature(actor, start_pos, { force = true })).handle

    popup_message(actor,
        "During the worst of the portal storms you found yourself exposed, and existence as you knew it folded in upon itself.  It's hard to know how long you were floating through a clawing nothingness.  But you've now come to your senses… somewhere else.\n\nAll around you is a shallow sea, expanding endlessly under a harsh air and a scarlet sky.\n\nAfter regaining your footing, you notice something in the distance: a tall, jagged spire, and a green light atop it.\n\nCould this be your salvation?")
end)

bind_scenario("lone_survivor_start", "scenario_lone_survivor_start", "scenario_lone_survivor_due", function(payload)
    local actor = payload.character
    popup_message(actor,
        "They are all dead.  The group you were surviving with has been annihilated.  Their bodies are still nearby.  You are the last one left alive and their screams will haunt you.",
        "warning")
    add_morale(actor, -100, -100, 1440, 180)
end)

bind_scenario("low_profile_start", "scenario_low_profile_start", "scenario_low_profile_due", function(payload)
    local actor = payload.character
    add_effect(actor, "drunk", minutes(270), { intensity = 1 })
    add_morale(actor, -50, -50, 50, 50)
end)

ccb.runtime.handler("scenario_moonlit_deactivate_due", function()
    set_global("is_moonlit_scenario", 0)
    checked(services.weather.refresh())
end)

bind_scenario("a_moonlit_night_start", "scenario_a_moonlit_night_start", "scenario_a_moonlit_night_due", function(payload)
    local actor = payload.character
    if actor.subtype == "avatar" then
        services.messages.add(services.translate("The moon shines brightly."))
    end
    set_global("is_moonlit_scenario", 1)
    checked(services.weather.refresh())
    ccb.tasks.after_character_turn(actor, services.time.duration(4, "hour").turns,
        "scenario_moonlit_deactivate_due")
end)
