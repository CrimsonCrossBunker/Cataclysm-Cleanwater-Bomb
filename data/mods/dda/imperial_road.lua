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
