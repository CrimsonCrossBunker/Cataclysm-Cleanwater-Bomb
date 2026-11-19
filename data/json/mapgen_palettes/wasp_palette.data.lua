local ccb = require("ccb")

-- Empty cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_brood",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        terrain = { ["0"] = "t_open_air" },
    },
}

-- Egg cell.
ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_brood",
    weight = 200,
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        terrain = { ["0"] = "t_floor_brood_fake" },
        item_spawns = { ["0"] = { id = "egg_wasp" } },
    },
}

-- Hatched larva, unsealed
ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_brood",
    weight = 300,
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        terrain = { ["0"] = "t_open_air" },
        monster_glyphs = { ["0"] = { id = "mon_wasp_larva" } },
    },
}

-- Sealed brood with a pupating wasp.
ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_brood",
    weight = 300,
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        terrain = { ["0"] = "t_floor_brood_wasp" },
        monster_glyphs = { ["0"] = { id = "mon_wasp_pupa" } },
    },
}

-- Just in time for the adult. Lucky you.
ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_brood",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "0",
        },
        terrain = { ["0"] = "t_open_air" },
        monster_glyphs = { ["0"] = { group = "GROUP_WASP_NEST" } },
    },
}
