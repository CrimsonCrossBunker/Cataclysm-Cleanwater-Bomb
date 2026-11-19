local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 22, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_barricades_wood",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 2, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 3, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 7, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 8, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 12, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 13, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 16, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 17, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 2, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 3, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 7, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 8, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 12, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 13, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 20, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_wood", x = 21, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_barricades_migo",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 2, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 3, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 7, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 8, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 12, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 13, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 16, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 17, y = 3 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 2, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 3, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 7, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 8, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 12, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 13, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 20, y = 15 },
            { shape = "point", operation = "terrain", id = "t_wall_resin", x = 21, y = 15 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 19, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_butchery_rack",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 22, y = 16 },
            { shape = "point", operation = "furniture", id = "f_table", x = 21, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_water_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 20, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 14, y = 16 },
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 13, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_reinforce_doors",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 16, y = 15 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 17, y = 15 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 0, y = 10 },
            { shape = "point", operation = "terrain", id = "t_rdoor_c", x = 23, y = 9 },
        },
    },
}
