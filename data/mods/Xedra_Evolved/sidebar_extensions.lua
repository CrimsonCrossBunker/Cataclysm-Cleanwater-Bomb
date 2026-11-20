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
    "structured_sidebar",
    "spacebar",
} do
    content.extend_sidebar(sidebar, {
        "xe_current_max_mana_nums_layout",
        "xe_mana_graph_layout",
        "xe_mana_pool_layout",
        "blood_ruach_descriptor",
        "blood_ruach_numbers",
        "blood_ruach_graph",
    })
end

local function pool_widget(handler, vitamin, capacity, lower_fraction, traits)
    local nutrient = services.types.id("vitamin", vitamin)
    ccb.runtime.handler(handler, function(context)
        local character = context.avatar
        local maximum = capacity
        for _, bonus in ipairs(traits) do
            if checked(services.mutations.has_id_text(character, bonus[1])) then
                maximum = maximum + bonus[2]
            end
        end
        return {
            value = checked(services.needs.get_vitamin(character, nutrient)),
            minimum = 0, normal_minimum = math.modf(maximum * lower_fraction),
            normal_maximum = math.modf(maximum * 0.6666666), maximum = maximum,
        }
    end)
end

pool_widget("sidebar_ruach", "lilin_ruach_vitamin", 1680, 0.333333, {
    { "LILIN_HOLD_MORE_RUACH", 1680 },
    { "LILIN_HOLD_MORE_RUACH_2", 1680 },
    { "LILIN_HOLD_MORE_RUACH_3", 1680 },
})
pool_widget("sidebar_blood", "human_blood_vitamin", 5600, 0.3333333, {
    { "VAMPIRE_STORE_MORE_BLOOD", 2300 },
    { "VAMPIRE_STORE_MORE_BLOOD_UPGRADE", 5600 },
    { "VAMPIRE_DISTILLATE_INNER_BLOOD", 11200 },
})
