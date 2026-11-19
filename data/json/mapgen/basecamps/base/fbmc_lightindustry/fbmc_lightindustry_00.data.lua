local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 17, y = 22 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_barricades_wood",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 3, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 7, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 11, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 17, y = 10 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 19, y = 10 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 0, y = 12 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 0, y = 17 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 0, y = 21 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 3, y = 23 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 12, y = 23 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 21, y = 23 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_barricades_migo",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 3, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 7, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 11, y = 7 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 17, y = 10 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 19, y = 10 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 0, y = 12 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 0, y = 17 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 0, y = 21 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 3, y = 23 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 12, y = 23 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 21, y = 23 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 14, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_butchery_rack",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 14, y = 7 },
            { shape = "point", operation = "furniture", id = "f_table", x = 14, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_water_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 16, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 20, y = 8 },
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 21, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_reinforce_doors",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 18, y = 10 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 23, y = 15 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 7, y = 23 },
        },
    },
}
