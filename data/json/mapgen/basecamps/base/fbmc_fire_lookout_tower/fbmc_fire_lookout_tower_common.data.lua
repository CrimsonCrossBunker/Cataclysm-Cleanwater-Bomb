local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 20, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 10, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_water_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 7, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 18, y = 19 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 18, y = 18 },
        },
    },
}
