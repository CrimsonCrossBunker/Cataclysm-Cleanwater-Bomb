local ccb = require("ccb")

-- Top level 'lab_spawn_XXXXX' templates are for use in floorplans.
-- Spawn for a room at least 7x7, walls often but not guaranteed.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_spawn_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = {
            {
                choices = { { id = "lab_room_7x7", weight = 97 }, { id = "lab_room_7x7_rare", weight = 3 } },
                x = 0,
                y = 0,
            },
            { id = "lab_maybe_effects_7x7", x = 0, y = 0 },
        },
    },
}

-- Spawn for a room exactly 7x7 with doors only in the center of each wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_spawn_7x7_crossdoors",
    layout = {
        size = { width = 9, height = 9 },
        nested = {
            {
                choices = {
                    { id = "lab_room_7x7", weight = 33 },
                    { id = "lab_room_7x7_crossdoors", weight = 63 },
                    { id = "lab_room_7x7_rare", weight = 3 },
                },
                x = 0,
                y = 0,
            },
            { id = "lab_maybe_effects_7x7", x = 0, y = 0 },
        },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        furniture = {
            X = {
                { id = "f_crate_c" },
                { id = "f_crate_c" },
                { id = "f_crate_c" },
                { id = "f_crate_o" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_t_machinery",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "A",
        },
        furniture = {
            A = {
                { id = "f_machinery_heavy" },
                { id = "f_machinery_heavy" },
                { id = "f_machinery_electronic" },
                { id = "f_machinery_light" },
                { id = "f_centrifuge" },
                { id = "f_console_broken" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maybe_effects_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = {
            {
                choices = { { id = "null", weight = 98 }, { id = "lab_add_spiders_7x7", weight = 2 } },
                x = 0,
                y = 0,
            },
        },
    },
}
