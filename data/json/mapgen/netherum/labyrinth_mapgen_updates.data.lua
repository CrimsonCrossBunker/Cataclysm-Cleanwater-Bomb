local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_deadend_1_room0",
    layout = {
        nested = { { id = "LS_10x10_deadend_1_room0", x = 7, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_deadend_1_room1",
    layout = {
        nested = { { id = "LS_10x10_deadend_1_room1", x = 7, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_deadend_1_room2",
    layout = {
        nested = { { id = "LS_10x10_deadend_1_room2", x = 7, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_deadend_1_room3",
    layout = {
        nested = { { id = "LS_10x10_deadend_1_room3", x = 7, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "labyrinth_stairs_1_to_2",
    layout = {
        nested = { { id = "labyrinth_stairs_1_to_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "labyrinth_stairs_2_to_1",
    layout = {
        nested = { { id = "labyrinth_stairs_2_to_1", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "labyrinth_nl_string_dimension_encounter",
    layout = {
        monster_placements = { { id = "mon_fleshborg_2_3_string_dimension", x = 11, y = 11, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_Bridge_control_deadend_1_extend",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "terrain",
                id = "t_nl_catwalk",
                x = 11,
                end_x = 12,
                y = 7,
                end_y = 8,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_Unlock",
    layout = {
        transform_placements = { { id = "nl_unlock_door", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_Lock",
    layout = {
        transform_placements = { { id = "nl_lock_door", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_ReallyUnlock",
    layout = {
        transform_placements = { { id = "nl_door_to_floor", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_Passcode_Generator_1",
    layout = {
        transform_placements = { { id = "nl_obelisk_0_to_1", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_Passcode_Generator_2",
    layout = {
        transform_placements = { { id = "nl_obelisk_0_to_2", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "UM_LS_Passcode_Generator_3",
    layout = {
        transform_placements = { { id = "nl_obelisk_0_to_3", x = { 0, 23 }, y = { 0, 23 } } },
    },
}
