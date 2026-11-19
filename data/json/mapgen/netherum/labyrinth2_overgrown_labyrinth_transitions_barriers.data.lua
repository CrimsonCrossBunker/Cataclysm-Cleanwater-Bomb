local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_9x9_grass_transition",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "         ",
            "         ",
            " 222 222 ",
            "2... ...2",
            "2.......2",
            "2... ...2",
            " 222 222 ",
            "         ",
            "         ",
        },
        palettes = { "labyrinthine_overgrown_cave_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_9x9_grass_transition",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "         ",
            "         ",
            "     222 ",
            "   2 ...2",
            "   2....2",
            "   2 ...2",
            "     222 ",
            "         ",
            "         ",
        },
        palettes = { "labyrinthine_overgrown_cave_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_9x9_grass_transition",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "     2222",
            "     2222",
            " 222 2222",
            "2... ...2",
            "2.......2",
            "2... ...2",
            " 222 222 ",
            "         ",
            "         ",
        },
        palettes = { "labyrinthine_overgrown_cave_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_9x9_grass_transition",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "     2222",
            "     2222",
            "     2222",
            "   2 ...2",
            "   2....2",
            "   2 ...2",
            "     222 ",
            "         ",
            "         ",
        },
        palettes = { "labyrinthine_overgrown_cave_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_4x4_barrier",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "   I",
            "===#",
            "    ",
        },
        palettes = { "labyrinthine_overgrown_room_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_4x4_barrier",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "===#",
            "   I",
            "    ",
        },
        palettes = { "labyrinthine_overgrown_room_palette" },
        erase_before_terrain = true,
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth_4x4_barrier",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   I",
            "===#",
            "   I",
            "    ",
        },
        palettes = { "labyrinthine_overgrown_room_palette" },
        erase_before_terrain = true,
    },
}
