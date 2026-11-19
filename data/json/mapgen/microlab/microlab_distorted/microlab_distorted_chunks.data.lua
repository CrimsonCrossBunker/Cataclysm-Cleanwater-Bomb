local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "microlab_distorted_chunk",
    layout = {
        toilets = { ";" },
        clear_glyphs = {
            ["!"] = {},
            ["2"] = {},
            [":"] = {},
            X = {},
            ["3"] = {},
            ["4"] = {},
            ["ó"] = {},
            R = {},
            [">"] = {},
            ["<"] = {},
            [";"] = {},
        },
        item_groups = { [";"] = { group = "SUS_toilet", chance = 50 } },
        terrain = {
            ["."] = { { id = "t_strconc_floor" }, { id = "t_nether_glass_floor" } },
            [","] = { { id = "t_nether_glass_floor" }, { id = "t_strconc_floor_glimmer" } },
            ["!"] = "t_door_locked_interior",
            ["-"] = "t_wall_metal",
            ["|"] = "t_concrete_wall",
            ["2"] = "t_door_glass_frosted_lab_c",
            [":"] = "t_door_glass_c",
            ["="] = "t_wall_glass",
            ["("] = "t_reinforced_glass",
            X = "t_door_metal_locked",
            ["3"] = "t_door_metal_c",
            ["4"] = "t_door_metal_pickable",
            ["ó"] = "t_metal_ventilation_shutter",
            R = "t_railing",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
        },
        furniture = { ["?"] = "f_null" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "||    ..,|..",
            "|.. ,,,,.|..",
            "|..     .||.",
            "| |   ..   .",
            "  .,  ...,||",
            "  |   .....|",
            "|||   |   |.",
            "|..   ...|||",
            "|||   ,  ...",
            "|.,    .  ||",
            "| ||      .|",
            "|..      ..|",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "||    ...|,.",
            "|..   .,.|..",
            "|.|4||||||||",
            "|||    . ..|",
            "  4   .....|",
            " ||  ...,..|",
            "|||...|...||",
            "| 4   ...  |",
            "| |   . ...|",
            " .||4|||||||",
            "| ||,, ,.,.|",
            "|.|.  ||| .|",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "||    ...|..",
            "|..   ...|..",
            "|..,    .||.",
            "||||  |||||.",
            "  .   ...,||",
            "  |,  ..  .|",
            "  |,  |    |",
            "  .,  ...  |",
            "|||   .  ...",
            "|..   ||||||",
            "| ||     ,,|",
            "|..      ..|",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|   ||..| ||",
            "|...,| |  .|",
            "|....|.  ..|",
            "||   |.|  ||",
            ".,. .|.....|",
            "|....|||...ó",
            "| |..|..   |",
            "| ...|...  |",
            "|   .|..., |",
            "||   ||||  |",
            "    ..  |22|",
            "  ||| . |   ",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_hallway_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|         ..",
            "|.        |.",
            ".. |      |.",
            "|  ||       ",
            "|           ",
            "|           ",
            "   |  .    |",
            "      |   . ",
            "           |",
            "            ",
            "            ",
            " ||         ",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_hallway_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|        ||.",
            "|   .,     .",
            "   |..  .. .",
            "    |     . ",
            "            ",
            "            ",
            "   |||  ..,|",
            "   ..    .. ",
            "   ..|  ...|",
            ".    |     .",
            "..         .",
            "|.|.        ",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_hallway_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "| .....  ||.",
            "|.....   ...",
            "     .......",
            "   ....,....",
            "       .... ",
            "            ",
            "           |",
            "     ,    ..",
            ".        ..|",
            "..        . ",
            ",.          ",
            "|           ",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_distorted_hallway_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|..        .",
            "|          .",
            "  ,|    .. .",
            " ,       |||",
            "            ",
            ".        |||",
            "||         |",
            " .        . ",
            "...         ",
            "    . |..,  ",
            "      |.||..",
            "|         ..",
        },
        palettes = { "microlab_distorted_chunk" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "hallway_shrapnel",
    layout = {
        size = { width = 6, height = 6 },
        monster_placements = {
            { id = "mon_structural_spur", x = 0, y = 4, repetitions = { 2, 4 } },
            {
                id = "mon_shrapnel_swarm",
                x = { 0, 6 },
                y = { 0, 6 },
                patrol = {
                    { x = 6, y = 6 },
                    { x = 6, y = 18 },
                    { x = 18, y = 18 },
                    { x = 18, y = 6 },
                    { x = 6, y = 8 },
                    { x = 7, y = 16 },
                    { x = 17, y = 16 },
                    { x = 6, y = 14 },
                },
                repetitions = { 5, 10 },
            },
        },
    },
}
