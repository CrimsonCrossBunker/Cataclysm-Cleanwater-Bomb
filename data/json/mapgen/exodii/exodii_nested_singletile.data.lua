local ccb = require("ccb")

-- Places a single crate with low value junk contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c", copies = 10 }, { id = "f_metal_crate_r" } },
                item_groups = { { group = "SUS_exodii_storage_lowvalue", chance = 95 } },
            },
        },
    },
}

-- Places a single crate with low value food contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c", copies = 10 }, { id = "f_metal_crate_r" } },
                item_groups = { { group = "SUS_exodii_storage_dryfood", chance = 95 } },
            },
        },
    },
}

-- Places a single crate with medium value junk contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_2",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c", copies = 5 }, { id = "f_metal_crate_r", copies = 2 } },
                item_groups = { { group = "SUS_exodii_storage_medvalue", chance = 95 } },
            },
        },
    },
}

-- Places a single crate with medium value food contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_2",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c", copies = 5 }, { id = "f_metal_crate_r", copies = 2 } },
                item_groups = { { group = "SUS_exodii_storage_dryfood", chance = 95, repetitions = { 1, 2 } } },
            },
        },
    },
}

-- Places a single crate with high value junk contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_3",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c" }, { id = "f_metal_crate_r", copies = 2 } },
                item_groups = { { group = "SUS_exodii_storage_highvalue", chance = 95 } },
            },
        },
    },
}

-- Places a single crate with high value ammo contents
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_crate_3",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_metal_crate_c" }, { id = "f_metal_crate_r", copies = 2 } },
                item_groups = { { group = "exodii_ammo_crate", chance = 90, repetitions = { 1, 2 } } },
            },
        },
    },
}

-- Oh no, this crate didn't survive transport.  That means it probably contained something organic :(
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_wreckage",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_wreckage",
                item_groups = {
                    { group = "dry_goods", chance = 30, repetitions = { 1, 4 } },
                    { group = "trash_junkyard", chance = 90, repetitions = { 1, 6 } },
                    { group = "SUS_trash_electrical", chance = 90, repetitions = { 1, 6 } },
                    { group = "SUS_trash_metal", chance = 90, repetitions = { 1, 6 } },
                },
            },
        },
    },
}

-- Chooses some machinery that looks good in an Exodii base
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_machinery",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = {
                    { id = "f_machinery_heavy", copies = 2 },
                    { id = "f_machinery_light", copies = 2 },
                    { id = "f_standing_tank" },
                    { id = "f_exodii_scanner" },
                    { id = "f_exodii_pump" },
                    { id = "f_machinery_electronic" },
                    { id = "f_generator_broken" },
                },
            },
        },
    },
}

-- An Exodii bot rack containing frames for not-yet-active bots.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_botrack_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_exodii_botrack",
                item_groups = { { group = "SUS_exodii_botrack", chance = 95, repetitions = { 2, 5 } } },
            },
        },
    },
}

-- A worktable with a chance to have some bot parts.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_worktable",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_metal_table",
                item_groups = { { group = "SUS_exodii_botrack", chance = 1 } },
            },
        },
    },
}

-- A worktable with a chance to have some metal stuff.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_worktable",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_metal_table",
                item_groups = { { group = "trash_junkyard", chance = 10 } },
            },
        },
    },
}

-- A worktable with a chance to have some metal stuff.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_worktable",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_metal_table",
                item_groups = { { group = "supplies_metal", chance = 5 } },
            },
        },
    },
}

-- A worktable with a chance to have some welding tools and things.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_worktable",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = "f_metal_table",
                item_groups = { { group = "exodii_tools", chance = 25 } },
            },
        },
    },
}

-- A tank with some water in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "water_clean", amount = { 100, 200 } },
            },
        },
    },
}

-- A tank with a surprising amount of cooking oil in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "cooking_oil", amount = { 200, 500 } },
            },
        },
    },
}

-- A tank with a surprising amount of motor oil in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "motor_oil", amount = { 100, 200 } },
            },
        },
    },
}

-- A tank with a surprising amount of alcohol in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "denat_alcohol", amount = { 200, 500 } },
            },
        },
    },
}

-- A tank with a surprising amount of alcohol in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_methanol", amount = { 200, 500 } },
            },
        },
    },
}

-- A tank with some spare biodiesel in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_generic_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "biodiesel", amount = { 200, 500 } },
            },
        },
    },
}

-- A tank with a ton of ether in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "ether", amount = { 100, 200 } },
            },
        },
    },
}

-- A tank with a ton of chloroform in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_chloroform", amount = { 100, 200 } },
            },
        },
    },
}

-- A tank with a ton of phenol in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_phenol", amount = { 100, 200 } },
            },
        },
    },
}

-- A tank with a ton of formaldehyde in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_formaldehyde", amount = { 300, 500 } },
            },
        },
    },
}

-- A tank with a ton of acid in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_nitric_acid", amount = { 100, 500 } },
            },
        },
    },
}

-- A tank with a ton of acid in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_sulphuric_acid", amount = { 100, 500 } },
            },
        },
    },
}

-- A tank with a ton of acid in it.
ccb.content.define_mapgen {
    kind = "nested",
    id = "exodii_special_tank",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        glyph_mappings = {
            X = {
                furniture = { { id = "f_standing_tank" } },
                liquids = { id = "chem_muriatic_acid", amount = { 100, 500 } },
            },
        },
    },
}
