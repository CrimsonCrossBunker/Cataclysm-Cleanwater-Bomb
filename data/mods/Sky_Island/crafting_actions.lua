local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local island_map = require("island_map")
local id = services.types.id
local environment = services.gameplay.environment

ccb.runtime.handler("sky_craft_random_artifact", function(payload)
    for _ = 1, payload.batch do
        state.checked(services.inventory.receive_group(payload.character, id("item_group", "random_artifact_pool")))
    end
end)

local function choose_water(character)
    local center = state.position(character)
    local candidates = {}
    for y = center.y - 1, center.y + 1 do
        for x = center.x - 1, center.x + 1 do
            local point = services.coords.tripoint_abs_ms(x, y, center.z)
            local terrain = environment.terrain_id(point)
            if environment.terrain_has_flag(point, "LIQUID")
                or terrain == "t_wooden_well" or terrain == "t_water_pump" then
                candidates[#candidates + 1] = point
            end
        end
    end
    return services.targeting.choose_adjacent_where_at(center,
        services.translate("Select nearby water source"), "", candidates, false, true)
end

local pond_locations = {
    { "northwest", -1, -1,
        function() return services.translate("Northwest") end,
        function() return services.translate("Place a pond in the northwest.") end },
    { "northeast", 1, -1,
        function() return services.translate("Northeast") end,
        function() return services.translate("Place a pond in the northeast.") end },
    { "southwest", -1, 1,
        function() return services.translate("Southwest") end,
        function() return services.translate("Place a pond in the southwest.") end },
    { "southeast", 1, 1,
        function() return services.translate("Southeast") end,
        function() return services.translate("Place a pond in the southeast.") end },
}

local function create_pond()
    local entries = {}
    for _, location in ipairs(pond_locations) do
        entries[#entries + 1] = { id = location[1], label = location[4](), description = location[5]() }
    end
    local choice = services.interaction.choose(entries, {
        title = services.translate("Choose the location for a pond"), allow_cancel = false,
        highlight_disabled = false, show_descriptions = true,
    })
    if not choice.accepted then return end
    local location = pond_locations[choice.index]
    local origin = state.position(services.characters.avatar()):project_to("omt")
    local position = services.overmap.find_target(origin, "sky_island_core", {
        offset = services.coords.tripoint_rel_omt(location[2], location[3], 0),
    })
    island_map.pond(position)
end

ccb.runtime.handler("sky_craft_warped_pond", function(payload)
    -- The native recipe dialogue retains its selected source across batch iterations.
    local water_was_selected = false
    for _ = 1, payload.batch do
        if choose_water(payload.character) then water_was_selected = true end
        if water_was_selected then
            create_pond()
        else
            state.checked(services.inventory.receive_item(payload.character, id("item", "warptoken"), 30))
            state.message(payload.character,
                services.translate("You must be near a water source to created a warped pond."))
        end
    end
end)
