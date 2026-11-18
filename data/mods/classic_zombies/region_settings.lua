local content = require("ccb").content

-- Increased hunting store chance, decreased gun store/mil surplus chances.
content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_shops = {
        { "s_hunting", 300 },
        { "s_gun_a", 350 },
        { "s_gun_b", 150 },
        { "mil_surplus", 20 },
        { "mil_surplus_1", 20 },
        { "mil_surplus_2", 20 },
    },
})

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
    urbanity_increase = { -1, 0, 0, -1 },
    feature_flag_settings = {
        whitelist = { "CLASSIC" },
    },
})
