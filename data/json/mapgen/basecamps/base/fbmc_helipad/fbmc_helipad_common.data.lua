local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 15, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_barricade_wood",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 5, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 8, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 10, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 11, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 13, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 14, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 19, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_barricade_migo_resin",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 5, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 8, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 10, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 11, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 13, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 14, y = 16 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 19, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 13, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_butchery_rack",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 10, y = 15 },
            { shape = "point", operation = "furniture", id = "f_table", x = 11, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_reinforce_doors",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 16, y = 16 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 17, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_helipad_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 19, y = 15 },
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 20, y = 15 },
        },
    },
}
