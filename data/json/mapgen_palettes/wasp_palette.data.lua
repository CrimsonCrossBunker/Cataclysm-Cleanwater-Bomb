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

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_blood", x = 0, y = 0, intensity = { 1, 3 }, repetitions = { 0, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_blood_insect", x = 0, y = 0, intensity = { 1, 3 }, repetitions = { 0, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        field_placements = {
            {
                id = "fd_blood_invertebrate",
                x = 0,
                y = 0,
                intensity = { 1, 3 },
                repetitions = { 0, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 80,
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "bug_parts", x = 0, y = 0, repetitions = { 0, 3 }, chance = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 80,
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "vertebrate_parts", x = 0, y = 0, repetitions = { 0, 3 }, chance = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "wasp_gibs",
    weight = 80,
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = {
            { group = "human_parts", x = 0, y = 0, repetitions = { 0, 3 }, chance = 50 },
            { group = "wasp_lair", x = 0, y = 0, repetitions = { 0, 1 }, chance = 25 },
        },
    },
}
