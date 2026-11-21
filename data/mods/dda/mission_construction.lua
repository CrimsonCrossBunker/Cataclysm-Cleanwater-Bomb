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

ccb.runtime.handler("schedule_robofac_hq_ancilla_autodoc", function(context)
    ccb.tasks.after_character_turn(context.character, 14 * 24 * 3600, "place_robofac_hq_ancilla_autodoc")
end)

ccb.runtime.handler("place_robofac_hq_ancilla_autodoc", function(context)
    local placed = checked(variables.get_global_number("ancilla_autodoc_placed", { strict = true })).value or 0
    if placed == 1 then return end
    local character = context.character
    local origin = checked(services.creatures.snapshot(character)).position:project_to("omt")
    local target = services.overmap.find_target(origin, "robofachq_subcc_a1")
    update_at(character, target, { "robofachq_ancilla_bar_autodoc" })
    checked(variables.set_global("ancilla_autodoc_loc", target:project_to("ms"), { include_before = false }))
    set_progress("ancilla_autodoc_placed", 1)
    ccb.tasks.after_character_turn(character, 7 * 24 * 3600, "place_robofac_hq_ancilla_bionic_garage")
end)

ccb.runtime.handler("place_robofac_hq_ancilla_bionic_garage", function(context)
    local character = context.character
    if services.gameplay.environment.dimension() ~= "default" then
        ccb.tasks.after_character_turn(character, 2 * 24 * 3600, "place_robofac_hq_ancilla_bionic_garage")
        return
    end
    -- Preserves native EOC_ROBOFAC_HQ_FORCE_PLACE_ANCILLA_BIONIC_GARAGE guard on ancilla_autodoc_placed.
    local placed = checked(variables.get_global_number("ancilla_autodoc_placed", { strict = true })).value or 0
    if placed == 1 then return end
    local origin = checked(services.creatures.snapshot(character)).position:project_to("omt")
    local target = services.overmap.find_target(origin, "robofachq_surface_car_entrance")
    update_at(character, target, { "robofachq_ancilla_bionic_garage" })
    checked(variables.set_global("ancilla_bionic_garage_loc", target:project_to("ms"), { include_before = false }))
    set_progress("ancilla_bionic_garage_placed", 1)
    local completed = checked(variables.get_number(character, "hub01_completed_missions", { strict = true })).value or 0
    if completed < 1 and services.mutations.has_id_text(character, "EXODII_CYBERFRAME_GENERIC").value then
        local entrance = services.overmap.find_target(origin, "robofachq_surface_entrance")
        update_at(character, entrance, { "remove_robofac_intercom" })
        set_progress("hub01_intercom_locked", 1)
        for _, faction_id in ipairs({ "robofac", "robofac_auxiliaries_chop_shop", "robofac_auxiliaries" }) do
            checked(services.factions.set_reputation(services.types.id("faction", faction_id),
                { likes = -100, respects = -100, trusts = -100 }))
        end
    end
end)
