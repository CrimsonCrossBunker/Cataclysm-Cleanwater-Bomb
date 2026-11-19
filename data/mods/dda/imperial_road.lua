local ccb = require("ccb")
local state = require("portal_storm_state")
local services = ccb.services
local variables = services.variables
local environment = services.gameplay.environment
local due_handler = "maintain_imperial_road_gate"

local function schedule_gate_check()
    ccb.tasks.after_avatar_turn(1, due_handler)
end

local function can_open_gate(character)
    local id = services.types.id
    if state.checked(services.characters.has_flag(character, id("json_flag", "IMPERIAL_ROAD_TRAVELER"))) then
        return true
    end
    local combat = state.checked(services.characters.snapshot(character)).combat
    return math.modf(combat.artifact_resonance) >= 4500
        and state.checked(services.inventory.has_worn_flag(character, id("json_flag", "IMPERIAL_ROAD_KEY")))
end

local function on_bronze_floor(position)
    return environment.terrain_id(position) == "t_highland_bronze_floor"
end

ccb.runtime.handler("enter_imperial_road", schedule_gate_check, 1)

ccb.runtime.handler(due_handler, function(payload)
    local character = payload.character
    local position = state.position(character)
    if not services.overmap.matches_terrain(position:project_to("omt"), "conquerors_road") then
        return
    end

    local gate = variables.get_global_number("gate_open", { strict = true })
    if not gate.ok then
        schedule_gate_check()
        error(gate.error.message)
    end

    local is_open = gate.value.value == 1
    if on_bronze_floor(position) and not is_open and can_open_gate(character) then
        state.update_map(position, "conquerors_road_open")
        state.set("gate_open", 1)
        is_open = true
    end
    if not on_bronze_floor(position) and is_open then
        state.update_map(position, "conquerors_road_close")
        state.set("gate_open", 0)
    end
    schedule_gate_check()
end, 1)

local function gate_message(character, tag, trap_position)
    local message = state.checked(services.text.expand_for(tag, character, nil, nil,
        { trap_location = trap_position }, true))
    state.message(character, message)
end

local function use_gateway(character, trap_position)
    if not can_open_gate(character) then
        return
    end

    if environment.dimension() ~= "imperial_road" then
        local travel = state.checked(services.relocation.travel_to_dimension("imperial_road",
            { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
        if not travel.accepted then
            state.message(character, services.translate(
                "You feel like the weight of the air around you has shifted, but nothing else happens."))
        end
        gate_message(character, "<imperial_road_early>", trap_position)
    end

    local position = state.position(character)
    local target = services.overmap.find_target(position:project_to("omt"), "conquerors_road",
        { z = 0, unseen_only = true })
    local id = services.types.id
    local found = services.world.find_location(target:project_to("ms"),
        { kind = "terrain", id = id("terrain", "t_highland_bronze_floor") },
        { distance_origin = position, target_max_radius = 26 })
    if found.found then
        state.checked(variables.set(character, "gateway", found.position, { include_before = false }))
    end
    local destination = state.checked(variables.get_tripoint(character, "gateway")).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
    character = state.checked(services.relocation.teleport_character(character, destination)).handle

    local trips = variables.get_global_number("imperial_gates_traveled", { strict = true })
    if trips.ok then
        local count = (trips.value.value or 0) + 1
        state.set("imperial_gates_traveled", count)
        if count >= 3 then
            gate_message(character, "<imperial_road_late>", trap_position)
        end
    end
    state.checked(services.world.transform_radius(destination, 20,
        id("terrain_furniture_transform", "deactivate_imperial_road_gate")))
    if not trips.ok then error(trips.error.message) end
end

ccb.runtime.handler("use_imperial_road_gateway", function(payload)
    if not payload.creature then
        return true
    end
    local position = payload.position
    use_gateway(payload.creature, services.coords.tripoint_abs_ms(position.x, position.y, position.z))
    return false
end, 1)

local gateway = ccb.content.Trap {
    id = "tr_imperial_road_go",
    name = "",
    color = "white",
    symbol = "^",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "none",
    always_invisible = true,
}
ccb.content.add(gateway:flag("UNDODGEABLE"):flag("AVATAR_ONLY"):flag("CONSUME_ON_TRIGGER")
    :on_trigger("use_imperial_road_gateway"))
