local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_museum_display_mannequin",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        furniture = { ["0"] = "f_mannequin" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            ["0"] = {
                { group = "pants", chance = 100 },
                { group = "alt_shirts", chance = 100 },
                { group = "museum_plaques_visitors", chance = 100 },
                { group = "otherworld_gear", chance = 50 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_museum_displaycase",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        furniture = { ["0"] = "f_displaycase" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            ["0"] = {
                { group = "display_case_items", chance = 100 },
                { group = "museum_plaques_items", chance = 100 },
            },
        },
    },
}
