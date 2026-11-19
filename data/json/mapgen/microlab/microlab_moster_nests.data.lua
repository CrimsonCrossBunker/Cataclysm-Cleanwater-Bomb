local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_more_density",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_MICROLAB", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 3, 7 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_acid_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_ACID_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_hunter_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_HUNTER_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_rust_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_RUST_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_phase_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_PHASE_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_raptor_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_RAPTOR_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_medical_zombies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MLAB_MEDICAL_ZOMBIE",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 7 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_robots",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_MLAB_ROBOT", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 2, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_mutants",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_MLAB_MUTANTS", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 2, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_wasps",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { id = "3x3_wasp_pod", x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_wasp_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
        },
        monster_placements = { { group = "GROUP_WASP_GUARD", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_leech_pod",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            " x ",
            "xAx",
            " x ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_glyphs = { A = { id = "mon_leech_stalk" }, x = { id = "mon_leech_pod_cluster", chance = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_leech_plants",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            { choices = { "3x3_leech_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_leech_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_leech_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
            { choices = { "3x3_leech_pod", "null" }, x = { 1, 20 }, y = { 1, 20 } },
        },
        monster_placements = {
            {
                group = "GROUP_MLAB_LEECH_PLANT",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_slimes",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_SLIME", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_shadows",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { id = "mon_darkman", x = { 0, 23 }, y = { 0, 23 }, chance = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_vampire",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { id = "mon_star_vampire_coiling", x = { 0, 23 }, y = { 0, 23 }, chance = 25 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_fungaloids",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_FUNGI", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 6, 12 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_migo",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_MI-GO_CAMP_OM", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_tindalos",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            { id = "mon_hound_tindalos", x = { 0, 23 }, y = { 0, 23 }, chance = 25 },
            { id = "mon_tindalos", x = { 0, 23 }, y = { 0, 23 }, chance = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_yrax",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = { { group = "GROUP_MLAB_YRAX", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mnm_triffids",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
            "^^^^^^^^^^^^^^^^^^^^^^^^",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        transform_glyphs = { ["^"] = { id = "microlab_triffidize" } },
        monster_placements = { { group = "GROUP_TRIFFID", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 6, 12 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_unique_foe",
    layout = {
        size = { width = 24, height = 24 },
        nested = { { x = 0, y = 0, id = { parameter = "unique_foe", fallback = "mnm_more_density" } } },
        parameters = {
            unique_foe = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        { id = "mnm_more_density", weight = 10 },
                        { id = "mnm_acid_zombies", weight = 10 },
                        { id = "mnm_hunter_zombies", weight = 10 },
                        { id = "mnm_rust_zombies", weight = 10 },
                        { id = "mnm_phase_zombies", weight = 10 },
                        { id = "mnm_raptor_zombies", weight = 10 },
                        { id = "mnm_robots", weight = 10 },
                        { id = "mnm_mutants", weight = 10 },
                        { id = "mnm_wasps", weight = 10 },
                        { id = "mnm_leech_plants", weight = 10 },
                        { id = "mnm_slimes", weight = 10 },
                        { id = "mnm_shadows", weight = 10 },
                        { id = "mnm_vampire", weight = 10 },
                        { id = "mnm_triffids", weight = 5 },
                        { id = "mnm_fungaloids", weight = 10 },
                        { id = "mnm_migo", weight = 10 },
                        { id = "mnm_tindalos", weight = 2 },
                        { id = "mnm_yrax", weight = 2 },
                    },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_serum_unique_foe",
    layout = {
        size = { width = 24, height = 24 },
        nested = { { x = 0, y = 0, id = { parameter = "unique_foe_serum", fallback = "mnm_more_density" } } },
        parameters = {
            unique_foe_serum = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        { id = "mnm_more_density", weight = 10 },
                        { id = "mnm_acid_zombies", weight = 10 },
                        { id = "mnm_hunter_zombies", weight = 10 },
                        { id = "mnm_rust_zombies", weight = 10 },
                        { id = "mnm_raptor_zombies", weight = 10 },
                        { id = "mnm_medical_zombies", weight = 20 },
                        { id = "mnm_robots", weight = 10 },
                        { id = "mnm_wasps", weight = 10 },
                        { id = "mnm_slimes", weight = 5 },
                        { id = "mnm_triffids", weight = 5 },
                        { id = "mnm_migo", weight = 25 },
                        { id = "mnm_yrax", weight = 3 },
                    },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_meat_unique_foe",
    layout = {
        size = { width = 24, height = 24 },
        nested = { { x = 0, y = 0, id = { parameter = "unique_foe_meat", fallback = "mnm_more_density" } } },
        parameters = {
            unique_foe_meat = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        { id = "mnm_acid_zombies", weight = 10 },
                        { id = "mnm_rust_zombies", weight = 10 },
                        { id = "mnm_robots", weight = 10 },
                        { id = "mnm_leech_plants", weight = 10 },
                        { id = "mnm_slimes", weight = 10 },
                        { id = "mnm_shadows", weight = 10 },
                        { id = "mnm_triffids", weight = 5 },
                        { id = "mnm_migo", weight = 10 },
                        { id = "mnm_yrax", weight = 2 },
                    },
                },
            },
        },
    },
}
