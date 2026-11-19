local ccb = require("ccb")

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
