local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 13, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_bed_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bunkbed", x = 10, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 6, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_butchery_rack",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 4, y = 12 },
            { shape = "point", operation = "furniture", id = "f_table", x = 5, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_water_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 6, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_farm",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 2, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 3, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 4, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 5, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 6, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 7, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 8, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 9, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 13, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 14, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 15, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 16, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 17, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 18, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 19, x = 19 },
            { shape = "point", operation = "terrain", id = "t_dirtmound", y = 20, x = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_generator",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_utility_light", x = 5, y = 16 },
            { shape = "point", operation = "terrain", id = "t_utility_light", x = 9, y = 14 },
            { shape = "point", operation = "terrain", id = "t_utility_light", x = 8, y = 17 },
            { shape = "point", operation = "terrain", id = "t_utility_light", x = 17, y = 16 },
            { shape = "point", operation = "terrain", id = "t_utility_light", x = 12, y = 12 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_outpost_normal_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 6, y = 8 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 6, y = 9 },
        },
    },
}
