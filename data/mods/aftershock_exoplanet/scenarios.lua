local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local tasks = ccb.tasks

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function apply_ship_update(position, name)
    local target = checked(services.overmap.tile_token(position:project_to("omt")))
    local update = checked(services.mapgen.update_token(id("update_mapgen", name)))
    checked(services.mapgen.run_update(target, update))
end

local function bind_scenario(scenario_id, start_handler, due_handler, callback)
    ccb.runtime.handler(due_handler, callback)
    ccb.runtime.handler(start_handler, function(payload)
        tasks.after_character_turn(payload.character, 0, due_handler)
    end)
    content.replace(content.Scenario {
        id = scenario_id,
        inherits = scenario_id,
        on_start = start_handler,
    })
end

bind_scenario("ship", "scenario_ship_start", "scenario_ship_due", function(payload)
    local actor = payload.character
    local origin = checked(services.creatures.snapshot(actor)).position
    local pad_omt = services.overmap.find_target(origin:project_to("omt"), "afs_shuttlepad_salvors_old_pad", { z = 0 })
    local pad_ms = pad_omt:project_to("ms")
    checked(services.variables.set_global("ship_new", pad_ms, { include_before = false }))
    apply_ship_update(pad_ms, "your_ship_stairs_deployed")
    apply_ship_update(pad_ms, "your_ship_ramp_deployed")
    local ship_upper = services.coords.tripoint_abs_ms(pad_ms.x, pad_ms.y, 1)
    checked(services.variables.set_global("ship_new", ship_upper, { include_before = false }))
    apply_ship_update(ship_upper, "your_ship")
    checked(services.variables.set_global("your_ship_stairs_up", 0, { include_before = false }))
    checked(services.variables.set_global("your_ship_ramp_up", 0, { include_before = false }))
    local reserved = checked(services.missions.reserve(id("mission", "MISSION_thi_location")))
    checked(services.missions.assign(actor, reserved.token))
    checked(services.variables.remove(actor, "ship_new", { include_before = false }))
end)

ccb.runtime.handler("scenario_crashing_ship_die", function(task)
    local actor = task.character
    local pos = checked(services.creatures.snapshot(actor)).position
    if not services.overmap.matches_location_near(pos:project_to("omt"), "crashing_ship_5", 1) then
        return
    end
    if actor.subtype == "avatar" then
        local text = services.translate("A large boom rocks the hull, fire engulfs the decks.  You can do nothing but watch as a wall of burning gas rushes towards you, consumes you as fast as it came, and then all is black.")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text)
    end
    checked(services.characters.die(actor))
end)

bind_scenario("crashing_ship", "scenario_crashing_ship_start", "scenario_crashing_ship_due", function(payload)
    local actor = payload.character
    local origin = checked(services.creatures.snapshot(actor)).position
    local pod_omt = services.overmap.find_target(origin:project_to("omt"), "afs_crashed_escape_pod", { z = 0 })
    local pod_ms = pod_omt:project_to("ms")
    local found = services.world.find_location(pod_ms, { kind = "terrain", id = id("terrain", "t_metal_floor") }, {
        target_max_radius = 30,
        min_radius = 0,
        max_radius = 0,
        distance_origin = origin,
    })
    local landing = found.found and found.position or pod_ms
    checked(services.variables.set_global("new_map", landing, { include_before = false }))
    tasks.after_character_turn(actor, 7 * 60, "scenario_crashing_ship_die")
end)

local esper_damage_parts = { "head", "torso", "arm_r", "arm_l", "leg_l", "leg_r" }

bind_scenario("afs_esper_start", "scenario_afs_esper_start", "scenario_afs_esper_due", function(payload)
    local actor = payload.character
    for _, part in ipairs(esper_damage_parts) do
        local bp = id("body_part", part)
        local current = checked(services.characters.hp(actor, bp))
        checked(services.characters.set_hp(actor, bp, current - services.random.native_int(0, 5), true))
    end
end)
