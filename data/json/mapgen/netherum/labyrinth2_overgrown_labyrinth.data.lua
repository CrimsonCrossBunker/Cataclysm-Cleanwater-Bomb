local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_overgrown_hall_straight",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "ls_straight_template_overgrown", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_overgrown_hall_curved",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "ls_corner_template_overgrown", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_overgrown_hall_tee",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "ls_tee_template_overgrown", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_overgrown_hall_four_way",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "ls_four_way_template_overgrown", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_overgrown_hall_end",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "ls_deadend_template_overgrown", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_left", x = 0, y = 0 },
            { id = "labyrinth_overgrown_8x24_cave_ns_right", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 4,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 8,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 16,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 20,
            },
            {
                choices = {
                    { id = "null", weight = 25 },
                    { id = "labyrinth_overgrown_straight_hall_room", weight = 75 },
                },
                x = 0,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    ##vvvvvvv!",
            "!vvvvvvvv#     ########!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#     ########!",
            "!vvvvvvvv#    ##vvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_left", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 20,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    ##vvvvvvv!",
            "!vvvvvvvv#     ########!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#            #!",
            "!vvvvvvvv#     ########!",
            "!vvvvvvvv#    ##vvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_left", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 8,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 16,
            },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 10,
                y = 20,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvv##    ##vvvvvvv!",
            "!vvvvvv##    ##vvvvvvvv!",
            "!vvvvv##    ##vvvvvvvvv!",
            "!vvvv##    ##vvvvvvvvvv!",
            "!vvv##    ##vvvvvvvvvvv!",
            "!vv##    ##vvvvvvvvvvvv!",
            "!v##    ##vvvvvvvvvvvvv!",
            "!##    ##vvvvvvvvvvvvvv!",
            "!#    ##vvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    ##vvvvvvvvvvvvvvv!",
            "!##    ##vvvvvvvvvvvvvv!",
            "!v##    ##vvvvvvvvvvvvv!",
            "!vv##    ##vvvvvvvvvvvv!",
            "!vvv##    ##vvvvvvvvvvv!",
            "!vvvv##    ##vvvvvvvvvv!",
            "!vvvvv##    ##vvvvvvvvv!",
            "!vvvvvv##    ##vvvvvvvv!",
            "!vvvvvvv##    ##vvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_right_bulbous", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 2,
                y = 9,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 2,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvv##  --##vvvvvvv!",
            "!vvvvvv##  --##vvvvvvvv!",
            "!vvvvv##  --##vvvvvvvvv!",
            "!vvvv##  --##vvvvvvvvvv!",
            "!vvv##  --##vvvvvvvvvvv!",
            "!vv##  --##vvvvvvvvvvvv!",
            "!v##  --##vvvvvvvvvvvvv!",
            "!##  --##vvvvvvvvvvvvvv!",
            "!#   -##vvvvvvvvvvvvvvv!",
            "!#   -#vvvvvvvvvvvvvvvv!",
            "!#   -#vvvvvvvvvvvvvvvv!",
            "!#   -#vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    #vvvvvvvvvvvvvvvv!",
            "!#    ##vvvvvvvvvvvvvvv!",
            "!##    ##vvvvvvvvvvvvvv!",
            "!v##    ##vvvvvvvvvvvvv!",
            "!vv##    ##vvvvvvvvvvvv!",
            "!vvv##    ##vvvvvvvvvvv!",
            "!vvvv##    ##vvvvvvvvvv!",
            "!vvvvv##    ##vvvvvvvvv!",
            "!vvvvvv##    ##vvvvvvvv!",
            "!vvvvvvv##    ##vvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_right_bulbous", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 2,
                y = 9,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 2,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_straight_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvv##    ##vvvvvvv!",
            "!vvvvvv##    ##vvvvvvvv!",
            "!vvvvv##    ##vvvvvvvvv!",
            "!vvvv##    ##vvvvvvvvvv!",
            "!vvvv#    ##vvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    #vvvvvvvvvvvv!",
            "!vvvv#    ##vvvvvvvvvvv!",
            "!vvvv##    ##vvvvvvvvvv!",
            "!vvvvv##    ##vvvvvvvvv!",
            "!vvvvvv##    ##vvvvvvvv!",
            "!vvvvvvv##    ##vvvvvvv!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_right", x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 95 }, { id = "labyrinth_4x4_barrier", weight = 5 } },
                x = 2,
                y = 9,
            },
            {
                choices = {
                    { id = "null", weight = 25 },
                    { id = "labyrinth_overgrown_crooked_hall_room", weight = 75 },
                },
                x = 0,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 1,
                y = 1,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 1,
                y = 10,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 6,
                y = 1,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 6,
                y = 10,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_overgrown_straight_hall_cave_override", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!#####vvvvvvvvvvvvvvvvvv",
            "!###vvvvvvvvvvvvvvvvvvvv",
            "!##vvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvv############vvvvvv",
            "!vvvvv#          #vvvvvv",
            "!vvvvv#          #vvvvvv",
            "!vvvvv#          #######",
            "!vvvvv#                 ",
            "!vvvvv#                 ",
            "!vvvvv#                 ",
            "!vvvvv#                 ",
            "!vvvvv#          #######",
            "!vvvvv#          #vvvvvv",
            "!vvvvv#          #vvvvvv",
            "!vvvvv####    ####vvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_curved_outside", x = 0, y = 0 },
            { id = "labyrinth_overgrown_12x12_room", x = 6, y = 6 },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!#####vvvvvvvvvvvvvvvvvv",
            "!###vvvvvvvvvvvvvvvvvvvv",
            "!##vvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvv###############",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#    ##########",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_curved_outside", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_curved_inside", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!#####vvvvvvvvvvvvvvvvvv",
            "!###vvvvvvvvvvvvvvvvvvvv",
            "!##vvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvv###############",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#   -----------",
            "!vvvvvvvv#   -##########",
            "!vvvvvvvv#   -#vvvvvvvvv",
            "!vvvvvvvv#   -#vvvvvvvvv",
            "!vvvvvvvv#   -#vvvvvvvvv",
            "!vvvvvvvv#   -#vvvvvvvvv",
            "!vvvvvvvv#   -#vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_curved_outside", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_curved_inside", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!#####vvvvvvvvvvvvvvvvvv",
            "!###vvvvvvvvvvvvvvvvvvvv",
            "!##vvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvv##############",
            "!vvvvvvvv##             ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#              ",
            "!vvvvvvvv#     #########",
            "!vvvvvvvv#    ##vvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
            "!vvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_curved_outside", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_curved_inside", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_corner_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "!#####vvvvvvvvvvvvvvvvvv",
            "!###vvvvvvvvvvvvvvvvvvvv",
            "!##vvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!#vvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvvvv",
            "!vvvvvvvvvvvvvvvvvvvvv##",
            "!vvvvvvvvvvvvvvvvvvvv## ",
            "!vvvvvvvvvvvvvvvvvvv##  ",
            "!vvvvvvvvvvvvvvvvvv##   ",
            "!vvvvvvvvvvvvvvvvv##    ",
            "!vvvvvvvvvvvvvvvv##    #",
            "!vvvvvvvvvvvvvvv##    ##",
            "!vvvvvvvvvvvvvv##    ##v",
            "!vvvvvvvvvvvvv##    ##vv",
            "!vvvvvvvvvvvv##    ##vvv",
            "!vvvvvvvvvvv##    ##vvvv",
            "!vvvvvvvvvv##    ##vvvvv",
            "!vvvvvvvvv##    ##vvvvvv",
            "!vvvvvvvv##    ##vvvvvvv",
            "!vvvvvvvv#    ##vvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_curved_outside_wide", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_curved_inside_small", x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "vvvvvvvvvv####vvvvvvvvvv",
            "vvvvvvvvvvv##vvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvv############vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "#######          #######",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "#######          #######",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_tee_n", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_sw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_se", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 6,
                y = 6,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "vvvvvvvvvv####vvvvvvvvvv",
            "vvvvvvvvvvv##vvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvv############vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "#######          #######",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "#######          #######",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_tee_n", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_sw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_se", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "vvvvvvvvvv####vvvvvvvvvv",
            "vvvvvvvvvvv##vvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "########################",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "##########    ##########",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_tee_n", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_tee_sw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_tee_se", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 1,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "vvvvvvvvvv####vvvvvvvvvv",
            "vvvvvvvvvvv##vvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "########################",
            " ---------------------- ",
            "                        ",
            "                        ",
            "                        ",
            "##########    ##########",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_tee_n", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_tee_sw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_tee_se", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 1,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 1,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_tee_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!!!!!!!!!!!!!!!!!!!!!!!!",
            "vvvvvvvvvv####vvvvvvvvvv",
            "vvvvvvvvvvv##vvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "##vvvvvvvvvvvvvvvvvvvv##",
            " ##vvvvvvvvvvvvvvvvvv## ",
            "  ##vvvvvvvvvvvvvvvv##  ",
            "   ##vvvvvvvvvvvvvv##   ",
            "    ##vvvvvvvvvvvv##    ",
            "#    ##vvvvvvvvvv##    #",
            "##    ##vvvvvvvv##    ##",
            "v##    ##vvvvvv##    ##v",
            "vv##    ##vvvv##    ##vv",
            "vvv##    ##vv##    ##vvv",
            "vvvv##    ####    ##vvvv",
            "vvvvv##    ##    ##vvvvv",
            "vvvvvv##        ##vvvvvv",
            "vvvvvvv##      ##vvvvvvv",
            "vvvvvvvv##    ##vvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_cave_tee_n_wide", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_sw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_cave_v_se", x = 0, y = 0 },
            { id = "labyrinth_overgrown_v_room", x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_four_way_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "#######          #######",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "#######          #######",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_9x9_cave_nw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_sw", x = 0, y = 15 },
            { id = "labyrinth_overgrown_9x9_cave_ne", x = 15, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_se", x = 15, y = 15 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 6,
                y = 6,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_24x24_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_four_way_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "#######          #######",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "#######          #######",
            "vvvvvv#          #vvvvvv",
            "vvvvvv#          #vvvvvv",
            "vvvvvv####    ####vvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_9x9_cave_nw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_sw", x = 0, y = 15 },
            { id = "labyrinth_overgrown_9x9_cave_ne", x = 15, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_se", x = 15, y = 15 },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_24x24_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_four_way_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "##########    ##########",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "##########    ##########",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_9x9_cave_nw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_sw", x = 0, y = 15 },
            { id = "labyrinth_overgrown_9x9_cave_ne", x = 15, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_se", x = 15, y = 15 },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 50 },
                },
                x = 6,
                y = 6,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_24x24_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_four_way_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "##########    ##########",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "##########    ##########",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
            "vvvvvvvvv#    #vvvvvvvvv",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_9x9_cave_nw", x = 0, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_sw", x = 0, y = 15 },
            { id = "labyrinth_overgrown_9x9_cave_ne", x = 15, y = 0 },
            { id = "labyrinth_overgrown_9x9_cave_se", x = 15, y = 15 },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 0,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_12x12_room", weight = 25 },
                },
                x = 11,
                y = 11,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 75 },
                    { id = "labyrinth_overgrown_24x24_room", weight = 25 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_deadend_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!!!!!!!!!#    #!!!!!!!!!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_deadend_left", x = 0, y = 0 },
            { id = "labyrinth_overgrown_8x24_cave_ns_deadend_right", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 25 },
                    { id = "labyrinth_overgrown_straight_hall_room", weight = 75 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_deadend_template_overgrown",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#-   #vvvvvvvv!",
            "!vvvvvvvv#    #vvvvvvvv!",
            "!!!!!!!!!#    #!!!!!!!!!",
        },
        palettes = { "labyrinthine_overgrown_palette" },
        nested = {
            { id = "labyrinth_overgrown_8x24_cave_ns_deadend_left", x = 0, y = 0 },
            { id = "labyrinth_overgrown_8x24_cave_ns_deadend_right", x = 0, y = 0 },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 4,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "labyrinth_9x9_grass_transition", weight = 20 },
                },
                x = 10,
                y = 15,
            },
            {
                choices = {
                    { id = "null", weight = 25 },
                    { id = "labyrinth_overgrown_straight_hall_room", weight = 75 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}
