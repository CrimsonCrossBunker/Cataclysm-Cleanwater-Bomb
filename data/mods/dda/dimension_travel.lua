local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local environment = services.gameplay.environment
local id = services.types.id
local M = {}

function M.number(owner, key)
    return state.checked(services.variables.get_number(owner, key)).value or 0
end

function M.set(owner, key, value)
    state.checked(services.variables.set(owner, key, value, { include_before = false }))
end

function M.unanchored(character)
    return not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "DIMENSIONAL_ANCHOR")))
end

function M.can_leave(character)
    return M.unanchored(character) and not state.checked(services.characters.snapshot(character, 0)).movement.driving
end

function M.notice(character, text)
    if character.subtype ~= "avatar" then return end
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
end

function M.at(character, terrain)
    return services.overmap.matches_location(state.position(character):project_to("omt"), terrain)
end

function M.reverberation_entry(character)
    return M.at(character, "radio_tower_top") or M.at(character, "wasp_tower_top")
        or M.at(character, "cabin_roof_3") or M.at(character, "cabin_roof_3_reverberation_hint")
end

local function travel(character, dimension, success, failure)
    local result = state.checked(services.relocation.travel_to_dimension(dimension,
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    local message = result.accepted and success or failure
    if message then state.message(character, services.translate(message)) end
end

local function teleport(character, position, force)
    state.checked(services.relocation.teleport_character(character, position, { force = force or false }))
end

local function zero()
    return services.coords.tripoint_abs_ms(0, 0, 0)
end

local function local_floor(character, position, terrain, radius)
    return services.world.find_location(position, { kind = "terrain", id = id("terrain", terrain) },
        { target_max_radius = radius, distance_origin = state.position(character) })
end

local function distant_floor(character, terrain, options, local_terrain, match)
    local selector = { terrain = terrain }
    if match then selector.match = services.enums.value("OtMatchType", match) end
    local target = services.overmap.find_target(state.position(character):project_to("omt"), selector, options)
    return local_floor(character, target:project_to("ms"), local_terrain, 60)
end

local function ground(character)
    local position = state.position(character)
    return services.coords.tripoint_abs_ms(position.x, position.y, 0)
end

local function ire(character)
    M.set(character, "ire", M.number(character, "ire") - 5)
end

local function schedule(character, name, minimum, maximum)
    local delay = maximum and services.random.native_int(minimum, maximum) or minimum
    ccb.tasks.after_character_turn(character, delay, "portal_" .. name .. "_return_due")
end

local function scientist_visit(character)
    if state.checked(services.variables.get_string(character, "general_yrax_u_met_apeirohedra")).value == "yes" then
        ccb.tasks.after_character_turn(character, services.random.native_int(3, 6), "portal_yrax_visit_due")
    end
end

ccb.runtime.handler("portal_yrax_visit_due", function(payload)
    if state.number("yrax_to_spawn") + 1 <= state.number("yrax_spawned") then
        state.set("yrax_spawned", 0)
        return
    end
    state.set("yrax_to_spawn", services.random.native_int(0, 2) + 2)
    state.set("yrax_spawned", state.number("yrax_spawned") + 1)
    local location = services.world.find_location(state.position(payload.character), nil,
        { passable_only = true, min_radius = 5, max_radius = 10, target_max_radius = 4 })
    local target = location.position or payload.data.target or zero()
    state.checked(services.characters.cast_spell(payload.character, id("spell", "yrax_science_team"),
        { target = target }))
    ccb.tasks.after_character_turn(payload.character, services.random.native_int(1, 2),
        "portal_yrax_visit_due", { target = target })
end)

function M.highlands(character)
    if not M.can_leave(character) then return end
    travel(character, "highlands",
        "Your surroundings warp and fold before reforming into a strange landscape.",
        "You experience brief vertigo, but nothing dangerous seems to happen.")
    local target = services.overmap.find_target(state.position(character):project_to("omt"), "highlands", { z = 0 })
    local location = services.world.find_location(target:project_to("ms"), nil)
    M.set(character, "safe_highland", location.position)
    teleport(character, location.position)
    scientist_visit(character)
    schedule(character, "highlands", 3 * 3600, 48 * 3600)
    ire(character)
end

local function cabin_light_cycle()
    state.checked(services.world.reschedule_events("cabin_daylight_cycle", services.time.duration(0, "turn")))
    if environment.dimension() ~= "cabins" then return end
    local amount = math.tointeger(math.modf(math.min(125, math.max(0, 160 * math.sin(services.time.now().turn / 3600)))))
    state.checked(services.weather.append_light_event(amount, services.time.duration(6, "minute"), "cabin_daylight_cycle"))
    ccb.tasks.after_avatar_turn(300, "portal_cabin_light_due")
end
ccb.runtime.handler("portal_cabin_light_due", cabin_light_cycle)

function M.radiosphere(character)
    if not M.can_leave(character) then return end
    state.add_effect(character, "blind", 0)
    travel(character, "radiosphere", "Your surroundings warp and fold before reforming into a dark industrial area.",
        "You experience brief vertigo, but nothing dangerous seems to happen.")
    local location = local_floor(character, state.position(character), "t_grate", 60)
    teleport(character, location.position or zero())
    M.notice(character, services.translate("Darkness envelops you."))
    schedule(character, "radiosphere", 20 * 60, 2 * 3600)
    ire(character)
end

function M.cabins(character)
    if not M.can_leave(character) then return end
    state.add_effect(character, "blind", 0)
    travel(character, "cabins")
    local location = local_floor(character, state.position(character), "t_tar_flat_roof", 60)
    teleport(character, location.position or zero())
    M.notice(character, services.translate("Your surroundings change."))
    schedule(character, "cabins", 6 * 3600, 12 * 3600)
    cabin_light_cycle()
    ire(character)
end

function M.reverberation(character)
    if M.at(character, "radio_tower_top") or M.at(character, "wasp_tower_top") then M.radiosphere(character) end
    if M.at(character, "cabin_roof_3") or M.at(character, "cabin_roof_3_reverberation_hint") then M.cabins(character) end
end
ccb.runtime.handler("portal_reverberation_enter_due", function(payload) M.reverberation(payload.character) end)

function M.string_dimension(character)
    if not M.can_leave(character) or M.number(character, "string_dimension_ziggurat_exit") > 3 then
        if state.checked(services.inventory.has_items(character, id("item", "inert_glowing_string"), 1, 0)) then
            state.message(character, services.translate("Your glowing string rattles in its container.  There is almost a futile sadness to its struggle."))
        end
        return
    end
    travel(character, "string_dimension", "Your surroundings warp and fold into an ever-expanding plane of light.",
        "You experience brief vertigo, but nothing dangerous seems to happen.")
    local target = services.overmap.find_target(state.position(character):project_to("omt"), "string_dimension_crossroads",
        { z = 0, min_distance = 0, search_range = 100, random = true })
    local location = local_floor(character, target:project_to("ms"), "t_string_xy", 20)
    scientist_visit(character)
    teleport(character, location.position or zero())
    local visits = M.number(character, "string_dimension_visits") + 1
    M.set(character, "string_dimension_visits", visits)
    ire(character)
    if visits == 1 then
        schedule(character, "string_dimension", 8 * 60)
        state.message(character, services.translate("You are somewhere new - an afterimage of where you were is burned into your vision, slowly fading."), "neutral", true)
    elseif visits == 2 then
        schedule(character, "string_dimension", 64 * 60)
        state.message(character, services.translate("You are somewhere you remember - an afterimage of where you were lingers at the edge of your mind's eye."), "neutral", true)
    elseif visits == 3 then
        schedule(character, "string_dimension", 4096 * 60)
        state.message(character, services.translate("You are somewhere familiar - an afterimage of where you were flashes past your mind."), "neutral", true)
    elseif visits >= 4 then
        state.message(character, services.translate("You quickly and naturally orient yourself to this place - it's as if you stepped through a door that shut and vanished."), "neutral", true)
    end
    state.checked(services.weather.append_light_event(125, services.time.duration(9999, "day"), "string_dimension_lights_on"))
end

function M.scarlet(character)
    if not M.can_leave(character) then return end
    state.add_effect(character, "blind", 0)
    travel(character, "scarlet", "Your surroundings warp and fold before reforming into a vast sea, bathed in scarlet light.",
        "You experience brief vertigo, but nothing dangerous seems to happen.")
    M.notice(character, services.translate("Darkness envelops you."))
    schedule(character, "scarlet", 20 * 60, 2 * 3600)
end

local function push(character)
    state.message(character, services.translate("You feel a slight push in a direction you can't name, but soon it ceases.  You have a feeling it'll happen again later."))
end

ccb.runtime.handler("portal_highlands_return", function(character)
    if M.unanchored(character) then
        travel(character, "default", "Your surroundings warp and fold into the recesses of the world you know.", "Nothing seems to change.")
        state.checked(services.achievements.complete(id("achievement", "achievement_reach_highlands")))
    elseif environment.dimension() == "highlands" or environment.dimension() == "imperial_road" then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        schedule(character, "highlands", 36 * 3600, 60 * 3600)
    end
end)

ccb.runtime.handler("portal_radiosphere_return", function(character)
    if M.can_leave(character) and environment.dimension() == "radiosphere" then
        state.add_effect(character, "blind", 0)
        travel(character, "default", "Your surroundings warp and fold into the recesses of the world you know.", "Nothing seems to change.")
        local location = distant_floor(character, "radio_tower_top",
            { z = 6, min_distance = 50, search_range = 250, random = true }, "t_ladder_down")
        teleport(character, location.position or ground(character))
        environment.clear_saved_dimension("radiosphere")
        M.notice(character, services.translate("You're back."))
    elseif environment.dimension() == "radiosphere" then
        push(character)
        schedule(character, "radiosphere", 20 * 60, 2 * 3600)
    end
end)

ccb.runtime.handler("portal_cabins_return", function(character)
    if M.can_leave(character) and environment.dimension() == "cabins" then
        state.add_effect(character, "blind", 0)
        travel(character, "default", "Your surroundings warp and fold into the recesses of the world you know.", "Nothing seems to change.")
        local location = distant_floor(character, "cabin_roof_3",
            { z = 1, min_distance = 50, search_range = 250, random = true }, "t_tar_flat_roof", "prefix")
        local destination = location.position
        if destination then destination = services.coords.tripoint_abs_ms(destination.x, destination.y, 1) end
        teleport(character, destination or ground(character))
        state.checked(services.world.reschedule_events("cabin_daylight_cycle", services.time.duration(0, "turn")))
        environment.clear_saved_dimension("cabins")
        M.notice(character, services.translate("You're back."))
    elseif environment.dimension() == "cabins" then
        push(character)
        schedule(character, "cabins", 6 * 3600, 12 * 3600)
    end
end)

ccb.runtime.handler("portal_string_dimension_return", function(character)
    if M.can_leave(character) and environment.dimension() == "string_dimension" then
        travel(character, "default", "Your surroundings warp and fold into the recesses of the world you know.",
            "You feel a prickle at the edge of your senses.")
        teleport(character, ground(character))
        state.checked(services.world.reschedule_events("string_dimension_lights_on", services.time.duration(0, "turn")))
        state.checked(services.achievements.complete(id("achievement", "achievement_reach_string_dimension")))
    elseif environment.dimension() == "string_dimension" then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        schedule(character, "string_dimension", 2 * 60)
    end
end)

ccb.runtime.handler("portal_scarlet_return", function(character)
    if M.can_leave(character) and environment.dimension() == "scarlet" then
        state.add_effect(character, "blind", 0)
        travel(character, "default", "Your surroundings warp and fold into the recesses of the world you know.", "Nothing seems to change.")
        teleport(character, state.point("scarlet_storm_center"), true)
        M.notice(character, services.translate("Your surroundings warp and fold into the recesses of the world you know."))
    elseif environment.dimension() == "scarlet" then
        push(character)
        schedule(character, "scarlet", 20 * 60, 2 * 3600)
    end
end)

for _, dimension in ipairs { "highlands", "radiosphere", "cabins", "string_dimension", "scarlet" } do
    ccb.runtime.handler("portal_" .. dimension .. "_return_due", function(payload)
        ccb.runtime.call_character("portal_" .. dimension .. "_return", payload.character)
    end)
end

return M
