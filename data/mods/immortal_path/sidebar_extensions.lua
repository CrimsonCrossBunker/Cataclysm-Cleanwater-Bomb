local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

for _, sidebar in ipairs {
    "legacy_classic_sidebar",
    "legacy_compact_sidebar",
    "legacy_labels_narrow_sidebar",
    "legacy_labels_sidebar",
} do
    content.extend_sidebar(sidebar, {
        "immortal_path_qi_desc_layout",
        "immortal_path_qi_num_layout",
        "immortal_path_qi_power_layout",
        "immortal_path_qi_graph_layout",
    })
end

local qi = services.types.id("vitamin", "qi")

local function unbanded(value, minimum, maximum)
    return {
        value = math.modf(value), minimum = minimum, maximum = math.modf(maximum),
        normal_minimum = -2147483648, normal_maximum = 2147483647,
    }
end

ccb.runtime.handler("sidebar_qi", function(context)
    local character = context.avatar
    return unbanded(checked(services.needs.get_vitamin(character, qi)), 0,
        checked(services.characters.enchantment_value(character, "qi_max", 100)))
end)

ccb.runtime.handler("sidebar_qi_power", function(context)
    local power = checked(services.characters.enchantment_value(context.avatar, "qi_power", 100))
    return unbanded(power, 100, math.max(100, power))
end)
