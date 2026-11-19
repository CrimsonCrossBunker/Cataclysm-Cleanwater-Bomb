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
