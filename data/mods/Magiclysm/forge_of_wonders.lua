local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function remember_gate(character)
    local searched = variables.get_global_number("searched_forge", { strict = true })
    if not searched.ok then
        return searched.error.message
    end
    if searched.value.value == 1 then
        return
    end
    local position = checked(services.creatures.snapshot(character)).position
    local target = services.overmap.find_target(position:project_to("omt"), "forge_x2y2z1", { z = 0 })
    local gate = services.world.find_location(target:project_to("ms"),
        { kind = "furniture", id = services.types.id("furniture", "f_magiclysm_greater_translocator_gate") },
        { distance_origin = position, target_max_radius = 26 })
    if gate.found then
        checked(variables.set_global("loc_forge_of_wonders", gate.position, { include_before = false }))
    end
    checked(variables.set_global("searched_forge", 1, { include_before = false }))
end

ccb.runtime.handler("enter_forge_of_wonders", function(payload)
    local search_error = remember_gate(payload.character)
    local forge_tile = payload.terrain_id:match("^forge_x[0-3]y[0-3]z[0-4]")
    if forge_tile then
        local position = payload.new_position
        local omt = services.coords.tripoint_abs_omt(position.x, position.y, position.z)
        if services.overmap.matches_terrain(omt, forge_tile) then
            checked(services.effects.add(payload.character, services.types.id("effect", "safe_shoppers"),
                services.time.duration(60, "minute"), { intensity = 1 }))
        end
    end
    if search_error then error(search_error) end
end, 1)
