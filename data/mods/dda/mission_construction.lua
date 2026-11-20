local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function set_progress(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

local function advance(key)
    local current = checked(variables.get_global_number(key, { strict = true })).value or 0
    set_progress(key, current + 1)
end

local function update_at(character, target, updates)
    for _, name in ipairs(updates) do
        local update = services.mapgen.update_token(services.types.id("update_mapgen", name))
        if update.ok then
            local tile = checked(services.overmap.tile_token(target))
            checked(services.mapgen.run_update(tile, update.value, { mission_source = character }))
        end
    end
end

local function construction(name, hours, key, updates, initial)
    local due = "finish_godco_" .. name
    ccb.runtime.handler("start_godco_" .. name, function(context)
        local position = checked(services.creatures.snapshot(context.giver or context.character)).position
        local target = services.world.find_location(position, nil).position
        if initial then set_progress(key, initial) end
        ccb.tasks.after_character_turn(context.character, hours * 3600, due, { target = target })
    end)
    ccb.runtime.handler(due, function(context)
        -- Old queued construction with an unset location used the zero map square.
        local position = context.data.target or services.coords.tripoint_abs_ms(0, 0, 0)
        update_at(context.character, position:project_to("omt"), updates)
        set_progress(key, 2)
    end)
end

construction("coop", 7 * 24, "darryl_building_coop", { "darryl_place_coop" }, 1)
construction("garden", 72, "kostas_building_garden", { "place_herb_garden" })
construction("wall", 432, "wall_in_progress", {
    "place_right_corner_wall", "place_gate_wall", "place_left_corner_wall",
    "place_straight_up_wall_right", "place_straight_up_wall_left", "place_right_corner_wall_bottom",
    "place_straight_bottom_wall", "place_left_corner_wall_bottom",
})
construction("warehouse", 336, "godco_warehouse_in_progress", { "place_food_warehouse" })

ccb.runtime.handler("start_isherwood_wall", function(context)
    ccb.tasks.after_character_turn(context.character, 24 * 3600, "finish_isherwood_wall")
    advance("isherwood_wall_status")
end)

ccb.runtime.handler("finish_isherwood_wall", function()
    set_progress("isherwood_wall_status", 1)
end)

local function schedule_truck(context)
    ccb.tasks.after_character_turn(context.character, 100, "collect_isherwood_truck")
end
ccb.runtime.handler("start_isherwood_truck", schedule_truck)

ccb.runtime.handler("collect_isherwood_truck", function(context)
    local origin = checked(services.creatures.snapshot(context.character)).position:project_to("omt")
    local location = "trailhead_shack_z0"
    if services.overmap.matches_location_near(origin, location, 2) then
        schedule_truck(context)
        return
    end
    update_at(context.character, services.overmap.find_target(origin, location), { "LUKE_REMOVE_TRUCK" })
    advance("isherwood_luke_truck_status")
end)
