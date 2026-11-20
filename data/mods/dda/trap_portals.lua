local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local environment = services.gameplay.environment
local portals = {}

local function zero()
    return services.coords.tripoint_abs_ms(0, 0, 0)
end

function portals.destination(actor, omt, options, kind, tile, radius)
    local origin = state.position(actor)
    local target = services.overmap.find_target(origin:project_to("omt"), omt, options)
    local selector = tile and { kind = kind, id = id(kind, tile) }
    return services.world.find_location(target:project_to("ms"), selector,
        { target_max_radius = radius or 0, distance_origin = origin }).position
end

local function special(name, z)
    return { special = id("overmap_special", name), create_special = true, z = z }
end

function portals.travel(actor, dimension, success, failure)
    local result = services.relocation.travel_to_dimension(dimension,
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 })
    if not result.ok and result.error.code ~= "invalid_dimension" then state.checked(result) end
    if result.ok and result.value.accepted then
        if success then state.message(actor, success) end
    elseif failure then
        state.message(actor, failure)
    end
end

function portals.teleport(actor, position, force, failure)
    local moved = state.checked(services.relocation.teleport_creature(actor, position or zero(), { force = force or false }))
    if not moved.accepted and failure then state.message(moved.handle, failure) end
    return moved.handle
end

function portals.trap(handler, action)
    ccb.runtime.handler(handler, function(hit)
        if not hit.creature then return true end
        action(hit.creature)
        return false
    end)
end

local function use_stair(actor, downward)
    local next_dimension = downward and "netherum_labyrinth2" or "netherum_labyrinth"
    local old_dimension = downward and "netherum_labyrinth" or "netherum_labyrinth2"
    portals.travel(actor, next_dimension, ccb.services.translate("You experience brief vertigo and the mist before you fades away."),
        ccb.services.translate("Nope!"))
    local omt = downward and "labyrinth2" or "labyrinth_hall"
    local landing
    if downward then
        landing = portals.destination(actor, omt, nil, "terrain", "t_nl_scrap_floor", 50)
    else
        landing = portals.destination(actor, omt, special("labyrinthine_structure", 0))
    end
    if landing then state.set("labyrinth_nl_new_loc", landing) end
    state.update_map(state.point("labyrinth_nl_new_loc"), downward and "labyrinth_stairs_2_to_1" or "labyrinth_stairs_1_to_2")
    local destination = portals.destination(actor, omt, not downward and special("labyrinthine_structure") or nil,
        "terrain", "t_nl_archway", 1000)
    portals.teleport(actor, destination, true, ccb.services.translate("Nope!"))
    environment.clear_saved_dimension(old_dimension)
end
portals.trap("labyrinth_stairs_down", function(actor) use_stair(actor, true) end)
portals.trap("labyrinth_stairs_up", function(actor) use_stair(actor, false) end)

function portals.can_leave(actor)
    return actor.subtype == "monster" or travel.can_leave(actor)
end

local function may_cross(actor, denied)
    if portals.can_leave(actor) then return true end
    state.message(actor, denied)
    return false
end

local function tickle() return ccb.services.translate("Something tickles at the edge of your senses.") end
local function prickle() return ccb.services.translate("You feel a prickle at the edge of your senses.") end

function portals.leave_cabins(actor)
    if not may_cross(actor, tickle()) then return end
    local exit = portals.destination(actor, "inner_cabins_warped_cabin_1", special("inner_cabins_warped_cabin"), "terrain", "t_floor", 20)
    if exit then state.set("inner_cabins_exit_loc", exit) end
    actor = portals.teleport(actor, state.point("inner_cabins_exit_loc"), true, ccb.services.translate("Nope!"))
    state.message(actor, ccb.services.translate("You step through the swirling vortex and into a cabin, which quickly unfolds itself in space and time, dizzying your senses.  Then, you find your footing."), "neutral", true)
end
portals.trap("step_out_of_inner_cabins", portals.leave_cabins)

portals.trap("enter_ka_moonpool", function(actor)
    if not may_cross(actor, tickle()) then return end
    portals.travel(actor, "string_dimension_ka")
    local exit = portals.destination(actor, "string_dimension_ka_facility_x4y0z0", special("string_dimension_ka_facility"),
        "furniture", "f_string_dimension_floor_portal_enclosure", 100)
    actor = portals.teleport(actor, exit)
    state.message(actor, ccb.services.translate("You step into the moonpool and it's as if your entire world slowly rotated, leaving you to step upon the ceiling on the level below you.  You reorient and find yourself somewhere new."), "neutral", true)
end)

portals.trap("leave_ka_moonpool", function(actor)
    if not may_cross(actor, tickle()) then return end
    portals.travel(actor, "string_dimension", ccb.services.translate("Your surroundings warp and fold into an ever-expanding plane of light."),
        ccb.services.translate("You experience brief vertigo, but nothing dangerous seems to happen."))
    local exit = portals.destination(actor, "string_dimension_crossroads", { z = 0, min_distance = 0, search_range = 100, random = true },
        "terrain", "t_string_xy", 20)
    actor = portals.teleport(actor, exit)
    state.message(actor, ccb.services.translate("You fall for a brief moment, then find your footing somewhere familiar."), "neutral", true)
end)

local function set_travel_variable(actor, key, value)
    if actor.subtype ~= "monster" then
        services.variables.set_string_notifying(actor, key, value)
    else
        services.random.native_int(0, 0)
        state.checked(services.variables.set(actor, key, value, { include_before = false }))
        services.native_events.emit("u_var_changed", { key, value })
    end
end

portals.trap("labyrinth_string_tunnel", function(actor)
    if not may_cross(actor, prickle()) then return end
    state.message(actor, ccb.services.translate("Zworunk."), "neutral", true)
    set_travel_variable(actor, "traveled_string_dimension_to_labyrinth", "yes")
    portals.travel(actor, "string_dimension", ccb.services.translate("Your surroundings warp and fold into the recesses of another world."), prickle())
    local exit = portals.destination(actor, "string_dimension_dome_x1y1z-2", special("string_dimension_dome"),
        "furniture", "f_exodii_floor_portal_enclosure", 100)
    portals.teleport(actor, exit)
    state.checked(services.weather.append_light_event(125, services.time.duration(9999, "day"), "string_dimension_lights_on"))
    environment.clear_saved_dimension("netherum_labyrinth")
end)

portals.trap("labyrinth_scarlet_tunnel", function(actor)
    if not may_cross(actor, prickle()) then return end
    set_travel_variable(actor, "stuck_in_labyrinth", "yes")
    set_travel_variable(actor, "player_location_temp_labyrinth_return_dimension", "netherum_labyrinth2")
    portals.travel(actor, "scarlet", ccb.services.translate("You experience brief vertigo."), prickle())
    local exit = portals.destination(actor, "scarlet_scrap_metal_spire", special("scarlet_scrap_metal_spire"),
        "terrain", "t_nl_archway", 100)
    portals.teleport(actor, exit)
    environment.clear_saved_dimension("netherum_labyrinth2")
end)

ccb.runtime.handler("examine_inner_cabins_portal", function(ctx)
    local actor = ctx.character
    local choice = services.interaction.choose({
        { id = "look", label = ccb.services.translate("Look inside."), description = ccb.services.translate("Just a peek."), enabled = environment.dimension() == "inner_cabins" },
        { id = "walk", label = ccb.services.translate("Walk through the portal."), description = ccb.services.translate("Is there another side?"), enabled = portals.can_leave(actor) },
    }, { title = ccb.services.translate("There is a ledge here.  What do you want to do?"), allow_cancel = true, show_descriptions = true })
    if not choice.accepted then return end
    if choice.id == "look" then
        state.message(actor, ccb.services.translate("You see the inside of a cabin, not unlike the ones you've seen before.  It's so clear that you think you could walk to it, through this thing, like a door."), "neutral", true)
    elseif choice.id == "walk" then
        portals.leave_cabins(actor)
    end
end)

return portals
