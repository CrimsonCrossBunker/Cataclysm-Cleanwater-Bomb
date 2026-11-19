local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local offsets = {
    { 0, -1 },
    { 1, 0 },
    { 0, 1 },
    { -1, 0 },
}

local function other_half(point, z)
    for index, offset in ipairs(offsets) do
        local position = services.coords.tripoint_abs_ms(point.x + offset[1], point.y + offset[2], z)
        -- West was the default when the other three neighbours had no marker.
        if index == #offsets or services.gameplay.environment.terrain_id(position) == "t_ret_furn_target" then
            return position
        end
    end
end

ccb.runtime.handler("examine_retractable_furniture", function(ctx)
    local actor = checked(services.creatures.snapshot(ctx.character))
    local other = other_half(ctx.position, actor.position.z)
    local selected = services.interaction.choose({
        { id = "bed", label = "EOC_CHANGE_TO_BED" },
        { id = "shower", label = "EOC_CHANGE_TO_SHOWER" },
    }, { allow_cancel = false })
    if not selected.accepted then
        return
    end

    local point = ctx.position
    local position = services.coords.tripoint_abs_ms(point.x, point.y, point.z)
    local first = selected.id == "bed" and "furn_to_bed" or "furn_to_shower"
    local second = selected.id == "bed" and "furn_to_bed" or "furn_to_null"
    checked(services.world.transform_radius(position, 0, id("terrain_furniture_transform", first)))
    checked(services.world.transform_radius(other, 0, id("terrain_furniture_transform", second)))
end)
