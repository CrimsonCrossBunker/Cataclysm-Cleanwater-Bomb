local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_firestation1_palette",
    layout = {
        terrain = {
            u = "t_rootcellar",
            ["."] = "t_dirt",
            ["^"] = "t_dirtmound",
            G = "t_privacy_fencegate_c",
            ["#"] = "t_privacy_fence",
        },
        furniture = {
            u = "f_clear",
            ["."] = "f_clear",
            ["^"] = "f_clear",
            G = "f_clear",
            ["#"] = "f_clear",
            h = "f_chair",
            t = "f_table",
            c = "f_counter",
            r = "f_rack",
            L = "f_locker",
            s = "f_sofa",
            C = "f_armchair",
            B = "f_bookcase",
            ["-"] = "f_clear",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_kitchen1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "---   ",
            "---   ",
            "t--   ",
            "t    t",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_kitchen2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "u     ",
            "c     ",
            "   r  ",
            "   r  ",
            "  cc  ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_farm_land",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_sw",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_SW", x = 14, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_nw",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_NW", x = 14, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_ne",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_NE", x = 20, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_se",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_SE", x = 20, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_garden_fence",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "####G#####",
            "         #",
            "         #",
            "         #",
            "         #",
            "         G",
            "         #",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_garden_fence1",
    layout = {
        nested = { { id = "fbmc_firestation1_garden_fence", x = 5, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_quarters_common_room",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "hhh C s",
            "ttt   s",
            "hhh C s",
            "    BBB",
            "       ",
            "       ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_quarters_common",
    layout = {
        nested = { { id = "fbmc_firestation1_quarters_common_room", x = 16, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_kitchen1_cleared",
    layout = {
        nested = { { id = "fbmc_firestation1_kitchen1", x = 1, y = 9 } },
        loot_placements = {
            { id = "2x4", repetitions = 24, x = 2, y = 10, chance = 100 },
            { id = "nail", repetitions = 36, x = 2, y = 10, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_garage_area",
    layout = {
        loot_placements = {
            { id = "wrench", x = 8, y = 21, chance = 100 },
            { id = "hacksaw", x = 8, y = 21, chance = 100 },
            { id = "pliers", x = 8, y = 21, chance = 100 },
            { id = "screwdriver", x = 8, y = 21, chance = 100 },
            { id = "hammer", x = 8, y = 21, chance = 100 },
            { id = "manual_mechanics", x = 8, y = 21, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_forge4",
    layout = {
        loot_placements = {
            { id = "tongs", x = 8, y = 21, chance = 100 },
            { id = "chisel", x = 8, y = 21, chance = 100 },
            { id = "swage", x = 8, y = 21, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_farm",
    layout = {
        nested = { { id = "fbmc_firestation1_farm_land", x = 7, y = 0 } },
        loot_placements = { { id = "pickaxe", x = 8, y = 21, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_0",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_floor", x = 6, y = 12 },
            { shape = "point", operation = "furniture", id = "f_bulletin", x = 6, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 1, y = 13, z = 0, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 1, y = 12, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 1, y = 12, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_brazier",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_brazier", x = 1, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_stove",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 1, y = 12, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 1, y = 12, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 5, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_radio_console",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 5, y = 1 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 3, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_kitchen3",
    layout = {
        size = { width = 6, height = 6 },
        furniture_placements = {
            { id = "f_clear", x = 0, y = 3 },
            { id = "f_clear", x = 0, y = 4 },
            { id = "f_clear", x = 2, y = 1 },
            { id = "f_clear", x = 2, y = 2 },
            { id = "f_clear", x = 1, y = 0 },
            { id = "f_clear", x = 0, y = 0 },
            { id = "f_clear", x = 1, y = 1 },
            { id = "f_clear", x = 1, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_kitchen2_storage",
    layout = {
        nested = {
            { id = "fbmc_firestation1_kitchen3", x = 1, y = 2 },
            { id = "fbmc_firestation1_kitchen2", x = 1, y = 9 },
        },
        loot_placements = { { id = "2x4", repetitions = 8, x = 2, y = 10, chance = 100 } },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_locker", x = 17, y = 21 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_smoking_kiln",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_smoking_rack", x = 1, y = 0 },
            { shape = "point", operation = "furniture", id = "f_smoking_rack", x = 3, y = 0 },
            { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 5, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_butchery_rack",
    layout = {
        loot_placements = { { id = "knife_huge", variant = "knife_butcher", x = 1, y = 4, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 1, y = 5 },
            { shape = "point", operation = "furniture", id = "f_table", x = 1, y = 4 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_fermenting_vat",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fvat_empty", x = 1, y = 2 },
            { shape = "point", operation = "furniture", id = "f_fvat_empty", x = 1, y = 3 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_forge",
    layout = {
        loot_placements = { { id = "hammer", x = 8, y = 21, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_forge_rock", x = 6, y = 17, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 6, y = 17, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_forge2",
    layout = {
        loot_placements = { { id = "crucible", x = 7, y = 17, chance = 100 } },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_anvil", x = 8, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_forge3",
    layout = {
        loot_placements = {
            { id = "glassblowing_book", x = 8, y = 21, chance = 100 },
            { id = "glasses_safety", x = 8, y = 21, chance = 100 },
            { id = "chemistry_set", x = 8, y = 21, chance = 100 },
            { id = "pipe", x = 8, y = 21, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_clay_kiln", x = 6, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_workbench",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_workbench", x = 8, y = 18 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 8, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bellows",
    layout = {
        loot_placements = {
            { id = "30gal_drum", x = 8, y = 16, chance = 100 },
            { id = "hammer_sledge", x = 8, y = 21, chance = 100 },
            { id = "knife_combat", x = 8, y = 21, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bellows", x = 6, y = 18 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_drophammer",
    layout = {
        loot_placements = {
            { id = "wrench", x = 8, y = 21, chance = 100 },
            { id = "pliers", x = 8, y = 21, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_drophammer", x = 7, y = 21 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_living_quarters_SW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "bbL",
            "t  ",
            "bb ",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" }, "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_living_quarters_NW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "bbL",
            "t  ",
            "bbL",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" }, "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_living_quarters_NE",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "Lbb",
            "  t",
            "Lbb",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" }, "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_living_quarters_SE",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "Lbb",
            "  t",
            " bb",
        },
        parameters = {
            fbmc_bed_palette = {
                value_type = "palette",
                default = {
                    weighted = { "fbmc_straw_bed_palette", "fbmc_makeshift_bed_palette", "fbmc_bed_palette" },
                },
                scope = "map_tile",
            },
        },
        palettes = { { parameter = "fbmc_bed_palette" }, "fbmc_firestation1_palette" },
    },
}
