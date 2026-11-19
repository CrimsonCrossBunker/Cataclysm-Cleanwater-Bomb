local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "open_air_market_palette",
    layout = {
        parameters = {
            topleft_market_variant_nests = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        "market_meat",
                        "market_grocery",
                        "market_fish",
                        "market_confectionery",
                        "market_bees",
                    },
                },
            },
            topright_market_variant_nests = {
                value_type = "nested_mapgen",
                default = {
                    weighted = { "market_clothes", "market_botanical", "market_misc", "market_books" },
                },
            },
            midleft_market_variant_nests = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        "market_meat",
                        "market_grocery",
                        "market_fish",
                        "market_confectionery",
                        "market_bees",
                    },
                },
            },
            midright_market_variant_nests = {
                value_type = "nested_mapgen",
                default = { weighted = { "market_clothes", "market_botanical", "market_books" } },
            },
            bottomleft_market_variant_nests = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        "market_meat",
                        "market_grocery",
                        "market_fish",
                        "market_confectionery",
                        "market_bees",
                    },
                },
            },
            bottomright_market_variant_nests = {
                value_type = "nested_mapgen",
                default = {
                    weighted = { "market_clothes", "market_botanical", "market_misc", "market_books" },
                },
            },
        },
        terrain = { [","] = "t_thconc_floor_no_roof" },
    },
}

ccb.content.define_mapgen_palette {
    id = "open_air_stall_palette",
    layout = {
        terrain = { [","] = "t_thconc_floor_no_roof" },
        furniture = {
            c = "f_large_canvas_wall",
            d = "f_displaycase",
            f = "f_glass_fridge",
            h = "f_chair",
            t = "f_table",
            r = "f_rack_wood",
            C = "f_large_canvas_door",
            T = "f_table",
        },
    },
}
