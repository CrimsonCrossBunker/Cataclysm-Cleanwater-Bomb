local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_cooking_shack_northeast",
    layout = {
        nested = {
            { id = "fbmh_0_cooking_shack_northeast", x = 19, y = 6, z = 0 },
            { id = "fbmh_0_cooking_shack_roof_northeast", x = 19, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_cooking_tent_northeast",
    layout = {
        nested = {
            { id = "fbmh_0_cooking_tent_northeast", x = 19, y = 6, z = 0 },
            { id = "fbmh_0_cooking_tent_roof_northeast", x = 19, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_bed1_northeast",
    layout = {
        nested = { { id = "fbmh_0_bedset_east", x = 17, y = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_bed2_northeast",
    layout = {
        nested = { { id = "fbmh_0_bedset_east", x = 17, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_tent_bed3_east",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_east", x = 17, y = 11 },
            { id = "fbmh_0_bedset_east", x = 17, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_room_bed3_east",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_east", x = 17, y = 10 },
            { id = "fbmh_0_bedset_east", x = 17, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_tent_bed3_southeast",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_east", x = 17, y = 17 },
            { id = "fbmh_0_bedset_east", x = 17, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_room_bed3_southeast",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_east", x = 17, y = 16 },
            { id = "fbmh_0_bedset_east", x = 17, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_bed3_northwest",
    layout = {
        nested = { { id = "fbmh_0_bedset_west", x = 4, y = 5 }, { id = "fbmh_0_bedset_west", x = 4, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_tent_bed3_west",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_west", x = 4, y = 11 },
            { id = "fbmh_0_bedset_west", x = 4, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_room_bed3_west",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_west", x = 4, y = 10 },
            { id = "fbmh_0_bedset_west", x = 4, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_tent_bed3_southwest",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_west", x = 4, y = 17 },
            { id = "fbmh_0_bedset_west", x = 4, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_room_bed3_southwest",
    layout = {
        nested = {
            { id = "fbmh_0_bedset_west", x = 4, y = 16 },
            { id = "fbmh_0_bedset_west", x = 4, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_table_center",
    layout = {
        nested = {
            { id = "fbmh_core_tableset", x = 11, y = 12 },
            { id = "fbmh_core_tableset", x = 11, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_table_south",
    layout = {
        nested = {
            { id = "fbmh_core_tableset", x = 11, y = 16 },
            { id = "fbmh_core_tableset", x = 11, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_dirt", x = 10, y = 3 },
            { shape = "point", operation = "furniture", id = "f_bulletin", x = 10, y = 3 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_0_brazier_northeast",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_brazier", x = 19, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_fireplace_center",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_counter", x = 13, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 12, y = 11, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 12, y = 11, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_butchery_center",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 12, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_toolrack_center",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bookcase", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_core_tableset",
    layout = {
        size = { width = 3, height = 3 },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_chair", x = 0, y = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 1, y = 1 },
            { shape = "point", operation = "furniture", id = "f_chair", x = 2, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_core_kitchen_stove_south",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_counter", x = 10, y = 19, z = 0 },
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 11, y = 19, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 11, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_well_north",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 13, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_root_cellar_north",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 12, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_radio_tower_north",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_radio_tower", x = 13, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_radio_console_north",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_radio_controls", x = 13, y = 4 } },
    },
}
