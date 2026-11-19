local ccb = require("ccb")

-- Spawns a special monster fight and ID badge spwan if you have the yellow security badge.
ccb.content.define_mapgen {
    kind = "update",
    id = "magenta_security_card_spawn",
    layout = {
        loot_placements = { { id = "id_science_security_magenta", x = 21, y = 14, chance = 20 } },
        monster_placements = { { choices = { "mon_zombie_brute" }, x = 21, y = 14, chance = 100 } },
    },
}

-- Opens bot release if you lack a red science ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_the_bots",
    layout = {
        terrain_placements = { { id = "t_thconc_r", x = 5, y = 0 } },
    },
}

-- Opens bot release if you lack a green maintenance ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_the_bots_2",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 7, y = 0 },
            { id = "t_thconc_r", x = 11, y = 0 },
            { id = "t_thconc_r", x = 15, y = 0 },
            { id = "t_thconc_r", x = 19, y = 0 },
        },
    },
}

-- Opens bot release if you lack a green maintenance ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_garage",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 10, y = 8 },
            { id = "t_thconc_r", x = 10, y = 9 },
            { id = "t_thconc_r", x = 10, y = 14 },
            { id = "t_thconc_r", x = 10, y = 15 },
        },
    },
}

-- Opens walls for bot pathing if you lack a green maintenance ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "open_walls_garage",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 0, y = 1 },
            { id = "t_thconc_r", x = 0, y = 2 },
            { id = "t_thconc_r", x = 0, y = 21 },
            { id = "t_thconc_r", x = 0, y = 22 },
        },
    },
}

-- Opens bot release if you lack a yellow security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_3",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 1, y = 17 },
            { id = "t_thconc_r", x = 14, y = 21 },
            { id = "t_thconc_r", x = 15, y = 21 },
        },
    },
}

-- Opens bot release if you lack a yellow (ocher) security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_3",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 1, y = 17 },
            { id = "t_thconc_r", x = 14, y = 21 },
            { id = "t_thconc_r", x = 15, y = 21 },
        },
    },
}

-- Opens bot release if you have no ID badges.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_concourse",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 15, y = 3 },
            { id = "t_thconc_r", x = 15, y = 4 },
            { id = "t_thconc_r", x = 16, y = 4 },
            { id = "t_thconc_r", x = 16, y = 5 },
            { id = "t_thconc_r", x = 17, y = 5 },
            { id = "t_thconc_r", x = 17, y = 6 },
            { id = "t_thconc_r", x = 15, y = 20 },
            { id = "t_thconc_r", x = 15, y = 19 },
            { id = "t_thconc_r", x = 16, y = 19 },
            { id = "t_thconc_r", x = 16, y = 18 },
            { id = "t_thconc_r", x = 17, y = 18 },
            { id = "t_thconc_r", x = 17, y = 17 },
        },
    },
}

-- Opens bot release if you have no ID badges.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_concourse_2",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 8, y = 3 },
            { id = "t_thconc_r", x = 8, y = 4 },
            { id = "t_thconc_r", x = 7, y = 4 },
            { id = "t_thconc_r", x = 6, y = 5 },
            { id = "t_thconc_r", x = 7, y = 5 },
            { id = "t_thconc_r", x = 6, y = 6 },
            { id = "t_thconc_r", x = 8, y = 20 },
            { id = "t_thconc_r", x = 8, y = 19 },
            { id = "t_thconc_r", x = 7, y = 19 },
            { id = "t_thconc_r", x = 6, y = 18 },
            { id = "t_thconc_r", x = 7, y = 18 },
            { id = "t_thconc_r", x = 6, y = 17 },
        },
    },
}

-- Opens bot release if you lack a magenta security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_4",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 17,
                y = 3,
                end_x = 23,
                end_y = 3,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 17,
                y = 20,
                end_x = 23,
                end_y = 20,
            },
        },
    },
}

-- Opens bot release if you lack a mutagen security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_5",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 12,
                y = 15,
                end_x = 12,
                end_y = 16,
            },
        },
    },
}

-- Opens bot release if you lack a mutagen security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_6",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 11,
                y = 15,
                end_x = 11,
                end_y = 16,
            },
        },
    },
}

-- Opens bot release if you lack a mutagen security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_7",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 11,
                y = 3,
                end_x = 11,
                end_y = 5,
            },
        },
    },
}

-- Opens bot release if you lack a mutagen ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "release_bots_8",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 12,
                y = 3,
                end_x = 12,
                end_y = 5,
            },
        },
    },
}
