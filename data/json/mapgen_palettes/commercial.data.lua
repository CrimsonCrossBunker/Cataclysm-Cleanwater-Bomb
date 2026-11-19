local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "commercial",
    layout = {
        parameters = {
            display_cooler = {
                value_type = "furniture",
                default = {
                    weighted = {
                        { id = "f_glass_fridge", weight = 1 },
                        { id = "f_glass_fridge_double", weight = 1 },
                        { id = "f_display_fridge", weight = 1 },
                        { id = "f_glass_freezer", weight = 1 },
                        { id = "f_display_freezer", weight = 1 },
                    },
                },
            },
            display_fridge = {
                value_type = "furniture",
                default = {
                    weighted = {
                        { id = "f_glass_fridge", weight = 1 },
                        { id = "f_glass_fridge_double", weight = 1 },
                        { id = "f_display_fridge", weight = 1 },
                    },
                },
            },
            display_freezer = {
                value_type = "furniture",
                default = {
                    weighted = {
                        { id = "f_glass_freezer", weight = 1 },
                        { id = "f_display_freezer", weight = 1 },
                    },
                },
            },
            coolers_to_sell = {
                value_type = "furniture",
                default = {
                    weighted = {
                        { id = "f_fridge", weight = 1 },
                        { id = "f_minifridge", weight = 1 },
                        { id = "f_glass_fridge", weight = 1 },
                        { id = "f_glass_fridge_double", weight = 1 },
                        { id = "f_heavy_duty_fridge", weight = 1 },
                        { id = "f_display_fridge", weight = 1 },
                        { id = "f_minifreezer", weight = 1 },
                        { id = "f_chest_minifreezer", weight = 1 },
                        { id = "f_freezer", weight = 1 },
                        { id = "f_heavy_duty_freezer", weight = 1 },
                        { id = "f_glass_freezer", weight = 1 },
                        { id = "f_display_freezer", weight = 1 },
                    },
                },
            },
            freezer_to_sell = {
                value_type = "furniture",
                default = {
                    weighted = {
                        { id = "f_minifreezer", weight = 1 },
                        { id = "f_chest_minifreezer", weight = 1 },
                        { id = "f_freezer", weight = 1 },
                        { id = "f_heavy_duty_freezer", weight = 1 },
                    },
                },
            },
        },
    },
}
