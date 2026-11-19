local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "            ; ;;;;;;    ",
            "            ; ;;;;;;    ",
            "            ; ;;;;;;    ",
            "              ;;;;;;    ",
            "              ;;;;;;    ",
            "                        ",
            "                        ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            ";;;;;;                  ",
            "                        ",
            "     ;                  ",
            "                ;;;;    ",
            "    ;;;         ;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmw_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_workshop_2_0",
    layout = {
        nested = { { id = "fbmw_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_2_common_tanner",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " t r",
            " h B",
            "   r",
            "    ",
        },
        palettes = { "fbmw_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_tanner",
    layout = {
        nested = { { id = "fbmw_2_common_tanner", x = 15, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_1",
    layout = {
        loot_placements = { { id = "makeshift_hammer", x = 17, y = 17, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 14, y = 17, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 14, y = 17, z = 1 },
            { shape = "point", operation = "furniture", id = "f_forge_rock", x = 16, y = 17, z = 0 },
            { shape = "point", operation = "furniture", id = "f_table", x = 17, y = 17, z = 0 },
            { shape = "point", operation = "furniture", id = "f_dresser", x = 18, y = 17, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_2",
    layout = {
        loot_placements = { { id = "crucible", x = 17, y = 17, chance = 100 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 17, y = 14, z = 0 },
            { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 18, y = 14, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_3",
    layout = {
        loot_placements = {
            { id = "55gal_drum", x = 16, y = 20, chance = 100 },
            { id = "30gal_drum", x = 16, y = 21, chance = 100 },
        },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_workbench", x = 18, y = 18 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 18, y = 19 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 18, y = 20 },
            { shape = "point", operation = "furniture", id = "f_camp_anvil", x = 16, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_4",
    layout = {
        loot_placements = {
            { id = "metalworking_tongs", x = 18, y = 18, chance = 100 },
            { id = "chisel", x = 18, y = 18, chance = 100 },
            { id = "hammer", x = 18, y = 18, chance = 100 },
            { id = "swage", x = 18, y = 18, chance = 100 },
        },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_table", x = 9, y = 17 },
            { shape = "point", operation = "furniture", id = "f_armchair", x = 10, y = 17 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 11, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack_wood", x = 12, y = 17 },
            { shape = "point", operation = "furniture", id = "f_stool", x = 13, y = 18 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_5",
    layout = {
        loot_placements = {
            { id = "hammer_sledge", x = 18, y = 19, chance = 100 },
            { id = "copper_knife", x = 18, y = 19, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bellows", x = 15, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_smithy_6",
    layout = {
        loot_placements = {
            { id = "wrench", x = 18, y = 20, chance = 100 },
            { id = "pliers", x = 18, y = 20, chance = 100 },
        },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_rack", x = 9, y = 21 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 10, y = 21 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 12, y = 21 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 12, y = 20 },
            { shape = "point", operation = "furniture", id = "f_drophammer", x = 11, y = 21 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_pottery",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_clay_kiln", x = 1, y = 18, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 1, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_pottery_1",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 2, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 4, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 5, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 6, y = 17 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 7, y = 17 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 3, y = 19 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 4, y = 19 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 5, y = 19 },
            { shape = "point", operation = "furniture", id = "f_stool", x = 4, y = 20 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 19 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 20 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 21 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_glassblower",
    layout = {
        loot_placements = {
            { id = "tongs", x = 3, y = 10, chance = 100 },
            { id = "chisel", x = 3, y = 10, chance = 100 },
            { id = "crucible", x = 3, y = 10, chance = 100 },
        },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 1, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_forge_rock", x = 3, y = 8, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 3, y = 8, z = 1 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 1, y = 9, z = 0 },
            { shape = "point", operation = "furniture", id = "f_bookcase", x = 1, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_armchair", x = 2, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_workbench", x = 3, y = 10, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_common_recreation",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_bench", x = 4, y = 15 },
            { shape = "point", operation = "furniture", id = "f_bench", x = 5, y = 15 },
            { shape = "point", operation = "furniture", id = "f_bench", x = 6, y = 15 },
            { shape = "point", operation = "furniture", id = "f_55gal_firebarrel", x = 5, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_salt_water_pump",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirt",
                x = 12,
                end_x = 12,
                y = 0,
                end_y = 1,
            },
            { shape = "point", operation = "terrain", id = "t_salt_water_pump", x = 12, y = 2 },
        },
    },
}
