local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_hall_straight",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            {
                choices = {
                    { id = "ls_straight_template_rooms", weight = 60 },
                    { id = "ls_straight_template_chasm", weight = 40 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_hall_curved",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            {
                choices = {
                    { id = "ls_corner_template_chasm", weight = 70 },
                    { id = "ls_corner_template_rooms", weight = 30 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_hall_tee",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            {
                choices = {
                    { id = "ls_tee_template_chasm", weight = 50 },
                    { id = "ls_tee_template_rooms", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_hall_four_way",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            {
                choices = {
                    { id = "ls_4way_template_chasm", weight = 50 },
                    { id = "ls_4way_template_rooms", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "labyrinth_hall_end",
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            {
                choices = {
                    { id = "ls_deadend_template_chasm", weight = 30 },
                    { id = "ls_deadend_template_rooms", weight = 70 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}
