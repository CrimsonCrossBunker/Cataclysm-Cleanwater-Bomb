local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "wasp_palette",
    layout = {
        nested_glyphs = { O = { id = "wasp_brood" } },
        monster_glyphs = { ["8"] = { group = "GROUP_WASP_QUEEN" } },
        terrain = {
            x = "t_paper_brood",
            X = "t_paper_hard",
            _ = "t_floor_paper_hard",
            ["*"] = "t_roof_paper_hard",
            ["."] = "t_floor_paper_noroof",
            ["8"] = "t_floor_paper_noroof",
            R = "t_radio_tower",
            a = "t_railing",
            [","] = "t_metal_floor_no_roof",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
            [":"] = "t_null",
            ["#"] = "t_metal_floor_no_roof",
        },
        furniture = { [":"] = "f_cellphone_booster", ["#"] = "f_small_satellite_dish" },
    },
}

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
