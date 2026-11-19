local ccb = require("ccb")

-- Palette used to randomize the state of the building
-- null_palette represents normal building here
ccb.content.define_mapgen_palette {
    id = "standard_building_general_and_variant_palette",
    layout = {
        parameters = {
            building_variant_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "null_palette", weight = 400 },
                        { id = "standard_building_vandalized_palette", weight = 600 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = {
            "standard_building_shared_palette",
            { parameter = "building_variant_palette" },
            "parametrized_walls_palette",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "standard_building_shared_palette",
    layout = {
        toilets = { "t" },
        item_groups = { t = { group = "SUS_toilet", chance = 50 } },
        palettes = { "parametrized_walls_palette" },
        furniture = { S = "f_sink" },
        terrain = {
            ["."] = {
                { id = "t_region_groundcover_urban", copies = 20 },
                { id = "t_region_shrub_decorative" },
            },
            ["4"] = "t_gutter_downspout",
            ["-"] = "t_sidewalk",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
            ["+"] = {
                { id = "t_door_c", copies = 5 },
                { id = "t_door_o", copies = 5 },
                { id = "t_door_locked_interior", copies = 1 },
            },
            ["*"] = {
                { id = "t_door_locked_peep", copies = 2 },
                { id = "t_door_locked_alarm" },
                { id = "t_door_locked", copies = 10 },
                { id = "t_door_elocked_peep", copies = 4 },
                { id = "t_door_elocked_alarm" },
                { id = "t_door_elocked", copies = 15 },
                { id = "t_door_c" },
                { id = "t_door_o", copies = 2 },
            },
            ["¶"] = "t_door_glass_c",
            [":"] = "t_wall_glass",
            o = "t_window",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "standard_building_vandalized_palette",
    layout = {
        toilets = { "t" },
        nested_glyphs = {
            ["+"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 1 },
                    { id = "destroyed_door_nested", weight = 3 },
                    { id = "null", weight = 4 },
                },
            },
            ["*"] = {
                choices = {
                    { id = "damaged_door_nested", weight = 1 },
                    { id = "destroyed_door_nested", weight = 3 },
                    { id = "null", weight = 4 },
                },
            },
            o = {
                choices = {
                    { id = "damaged_window_nested", weight = 1 },
                    { id = "destroyed_window_nested", weight = 1 },
                    { id = "null", weight = 2 },
                },
            },
            [":"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 1 }, { id = "null", weight = 2 } },
            },
            ["|"] = {
                choices = {
                    { id = "bile_field", weight = 1 },
                    { id = "shelter_graffiti", weight = 2 },
                    { id = "general_graffiti", weight = 2 },
                    { id = "null", weight = 245 },
                },
            },
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 248 },
                },
            },
            [" "] = {
                choices = {
                    { id = "corpse_blood_1x1", weight = 3 },
                    { id = "corpse_blood_casings_1x1", weight = 1 },
                    { id = "blood_field", weight = 8 },
                    { id = "bile_field", weight = 1 },
                    { id = "null", weight = 387 },
                },
            },
            ["¶"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 2 }, { id = "null", weight = 9 } },
            },
        },
    },
}
