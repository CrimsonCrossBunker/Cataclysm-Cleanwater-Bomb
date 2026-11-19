local ccb = require("ccb")

-- Random chemicals mixed together is bound to create toxic gas, also makes it harder to get to any loot.
ccb.content.define_mapgen {
    kind = "nested",
    id = "toxic_gas_vent",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_gas_vent", x = 0, y = 0, intensity = 3, age_turns = 0 } },
        loot_placements = { { group = "toxic_waste_mx_chems", x = 0, y = 0, repetitions = { 2, 3 } } },
        tile_edits = { { shape = "point", operation = "terrain", id = "t_pit", x = 0, y = 0 } },
    },
}

-- Lore. Lab folks may dump their now dead, useless and perhaps incriminating experiments there to get rid of them.
ccb.content.define_mapgen {
    kind = "nested",
    id = "toxic_waste_lab_corpses",
    layout = {
        size = { width = 3, height = 3 },
        corpse_placements = { { group = "GROUP_TOXIC_WASTE_CORPSES", x = { 0, 2 }, y = { 0, 2 } } },
        item_placements = { { id = "toxic_waste_labnote", x = { 0, 2 }, y = { 0, 2 }, chance = 40 } },
    },
}

-- Three spawning spots, 90% chance to have at least one toxic gas vent.
-- Since there are two potential corpse spawning spots, make the overall chance to encounter at least one corpse 10%. Obtaining the lore note is thus at 4% per map extra.
-- These liquids are cosmetic only because you can not pick them up. Can contain rare chemicals because of this.
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_toxic_waste",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "      -                 ",
            "         ---! --        ",
            "       - -%^~-          ",
            "       --~-~---^        ",
            "       -~~~~~~--        ",
            "     ! ---~~---         ",
            "        -~-%-- -        ",
            "       --^-~-~-         ",
            "        ---~ !          ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            ["~"] = { { id = "t_sewage" } },
            ["-"] = { { id = "t_sewage" }, { id = "t_dirt" }, { id = "t_grass_dead" } },
            ["%"] = { { id = "t_dirt" }, { id = "t_grass_dead" } },
        },
        furniture = {
            ["~"] = {
                { id = "f_rubble_landfill" },
                { id = "f_rubble" },
                { id = "f_wreckage" },
                { id = "f_null", copies = 3 },
            },
            ["-"] = {
                { id = "f_rubble_landfill" },
                { id = "f_rubble" },
                { id = "f_wreckage" },
                { id = "f_null", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["^"] = { choices = { { id = "null", weight = 70 }, { id = "toxic_gas_vent", weight = 30 } } },
            ["%"] = {
                choices = { { id = "null", weight = 95 }, { id = "toxic_waste_lab_corpses", weight = 5 } },
            },
        },
        liquid_glyphs = {
            ["-"] = {
                { id = "chem_acetic_acid", amount = { 1, 4 }, one_in = 100 },
                { id = "acetic_anhydride", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_acetone", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_formaldehyde", amount = { 1, 4 }, one_in = 140 },
                { id = "chem_muriatic_acid", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_hydrogen_peroxide", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_hydrogen_peroxide_conc", amount = { 1, 2 }, one_in = 100 },
                { id = "chem_nitric_acid", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_sulphuric_acid", amount = { 1, 4 }, one_in = 100 },
                { id = "ammonia_liquid", amount = { 1, 4 }, one_in = 100 },
                { id = "ammonia_hydroxide", amount = { 1, 4 }, one_in = 100 },
                { id = "bleach", amount = { 1, 4 }, one_in = 80 },
                { id = "lye", amount = { 1, 4 }, one_in = 100 },
                { id = "lye_potassium", amount = { 1, 2 }, one_in = 150 },
                { id = "ether", amount = { 1, 2 }, one_in = 120 },
                { id = "chem_DMSO", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_chloroform", amount = { 1, 2 }, one_in = 130 },
                { id = "chem_phenol", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_benzene", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_toluene", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_glycerol", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_ethanol", amount = { 1, 4 }, one_in = 100 },
                { id = "methed_alcohol", amount = { 1, 4 }, one_in = 100 },
                { id = "denat_alcohol", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_methanol", amount = { 1, 4 }, one_in = 100 },
                { id = "diesel", amount = { 1, 4 }, one_in = 100 },
                { id = "motor_oil", amount = { 1, 4 }, one_in = 100 },
                { id = "chem_turpentine", amount = { 1, 4 }, one_in = 100 },
                { id = "camphine", amount = { 1, 4 }, one_in = 100 },
                { id = "soapy_water", amount = { 1, 4 }, one_in = 150 },
                { id = "gasoline", amount = { 1, 4 }, one_in = 100 },
            },
        },
        monster_group_glyphs = { ["!"] = { group = "GROUP_TOXIC_WASTE", density = 0.1, chance = 40 } },
        loot_placements = { { group = "toxic_waste_mx", x = { 10, 13 }, y = { 10, 12 }, repetitions = { 1, 2 } } },
    },
}
