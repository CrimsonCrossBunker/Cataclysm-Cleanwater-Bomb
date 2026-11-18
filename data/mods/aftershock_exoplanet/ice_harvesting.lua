local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local bowl = content.TerrainTransform { id = "f_snow_bowl" }
bowl:furniture { inputs = { "f_null" }, results = { { "f_snow_bowl", 1 } } }
content.add(bowl)

local snow_bowl = id("terrain_furniture_transform", "f_snow_bowl")
local water = id("item", "water")
local ice_flags = { id("json_flag", "SHREDDED"), id("json_flag", "FROZEN") }
local environment = services.gameplay.environment

local function check(result)
    if not result.ok then
        error(result.error.message)
    end
end

ccb.runtime.handler("harvest_ice", function(use)
    local center = use.item_position
    local candidates = {}
    for _, entry in ipairs(services.world.points_nearby(center, { max_radius = 1 }).items) do
        local position = entry.position
        if environment.terrain_has_flag(position, "SNOW_SOURCE")
            and environment.furniture_id(position) == "f_null" then
            candidates[#candidates + 1] = position
        end
    end
    local target = services.targeting.choose_adjacent_where_at(center,
        ccb.services.translate("Select ice or snow to harvest from."),
        ccb.services.translate("There's no frozen terrain nearby"), candidates)
    if target then
        check(services.world.transform_radius(target, 0, snow_bowl))
        check(services.world.spawn_item(target, water, 5, true, ice_flags))
    end
    return 0
end)
