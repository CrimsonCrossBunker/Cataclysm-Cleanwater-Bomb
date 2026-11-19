local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_fence_barbed",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_fence_barbed" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_fence_barbed_above",
    layout = {
        size = { width = 1, height = 1 },
        nested = { { id = "1x1_fence_barbed", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_open_air",
    layout = {
        size = { width = 1, height = 1 },
        terrain = { [" "] = "t_open_air" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_trailmap",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "6",
        },
        furniture = { ["6"] = "f_board_map" },
        item_spawns = { ["6"] = { id = "trailmap", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_sewermap",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "6",
        },
        furniture = { ["6"] = "f_board_map" },
        item_spawns = { ["6"] = { id = "sewermap", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_subwaystationmap",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "6",
        },
        furniture = { ["6"] = "f_board_map" },
        item_spawns = { ["6"] = { id = "subwaystationmap", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_t_stairs_up",
    layout = {
        rows = {
            "<",
        },
        terrain = { ["<"] = { { id = "t_stairs_up" } } },
        size = { width = 1, height = 1 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "rolling_trash_can_1x1",
    layout = {
        size = { width = 1, height = 1 },
        vehicle_placements = { { id = "rolling_trash_can", x = 0, y = 0, chance = 80, status = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bile_field",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_bile", x = 0, y = 0, intensity = 1, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "blood_field",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_blood", x = 0, y = 0, intensity = { 1, 3 }, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fire_field",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_fire", x = 0, y = 0, intensity = 2, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "deployed_small_tent",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = {
            { id = "f_canvas_wall", x = 0, y = { 0, 2 } },
            { id = "f_canvas_wall", x = 2, y = { 0, 2 } },
            { id = "f_canvas_wall", x = 1, y = 2 },
            { id = "f_groundsheet", x = 1, y = 1 },
            { id = "f_canvas_door", x = 1, y = 0 },
        },
    },
}

-- A nested map bash damage.
ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_bash",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = { { shape = "point", operation = "bash", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_burn",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = { { shape = "point", operation = "burn", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_bash_burn",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = {
            { shape = "point", operation = "bash", x = 0, y = 0 },
            { shape = "point", operation = "burn", x = 0, y = 0 },
        },
    },
}

-- A nested map bash damage.
ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_2z_bash",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = {
            { shape = "point", operation = "bash", x = 0, y = 0, z = 0 },
            { shape = "point", operation = "bash", x = 0, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "destroyed_small_tent",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_null", x = { 0, 2 }, y = { 0, 2 } } },
        item_placements = {
            { id = "broketent", x = 1, y = 1, chance = 100 },
            { id = "tarp", x = { 0, 2 }, y = { 0, 2 }, chance = 50 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_trail_sign",
    layout = {
        size = { width = 1, height = 1 },
        sign_placements = { { snippet = "trailhead", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_casings_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = {
            { group = "corpses", x = 0, y = 0, chance = 100 },
            { group = "ammo_casings", x = { 0, 2 }, y = { 0, 2 }, chance = 50 },
        },
        field_placements = { { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 }, intensity = 1, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_1x1",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = { { group = "corpses", x = 0, y = 0, chance = 100 } },
        field_placements = { { id = "fd_blood", x = 0, y = 0, intensity = { 1, 3 }, age_turns = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_casings_1x1",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = {
            { group = "corpses", x = 0, y = 0, chance = 50 },
            { group = "casings", x = 0, y = 0, chance = 100, repetitions = { 1, 3 } },
        },
        field_placements = {
            { id = "fd_blood", x = 0, y = 0, intensity = 2, age_turns = 10 },
            { id = "fd_gibs_flesh", x = 0, y = 0, intensity = 1, age_turns = 10 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_hole",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "   ??   ",
            "  ?oo?  ",
            " ?oooo? ",
            "?oooooo?",
            "?oooooo?",
            " ?oooo? ",
            "  ?oo?  ",
            "   ??   ",
        },
        terrain = {
            o = "t_open_air",
            ["?"] = { { id = "t_open_air", copies = 1 }, { id = "t_null", copies = 2 } },
        },
        tile_edits = { { shape = "rectangle", operation = "remove_items", x = 0, y = 0, end_x = 7, end_y = 7 } },
    },
}
