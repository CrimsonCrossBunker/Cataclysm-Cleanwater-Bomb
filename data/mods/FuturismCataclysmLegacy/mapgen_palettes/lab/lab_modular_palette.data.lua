local ccb = require("ccb")

-- for normal medical clinic areas of labs.
ccb.content.define_mapgen_palette {
    id = "fcl_vanilla_lab_medical_palette",
    layout = {
        sealed_item_glyphs = { ["л"] = { item = { id = "seed_rose" }, furniture = "f_planter_harvest" } },
        item_groups = {
            ["8"] = {
                { group = "SUS_bathroom_cabinet", chance = 30, repetitions = { 1, 4 } },
                { group = "SUS_bathroom_medicine", chance = 40 },
                { group = "harddrugs", chance = 2 },
            },
            ["9"] = { group = "shower", chance = 30, repetitions = { 1, 2 } },
            ["@"] = { group = "bed", chance = 50 },
            F = { group = "SUS_fridge", chance = 100 },
            I = {
                { group = "SUS_desks_bedroom_unisex", chance = 5 },
                { group = "SUS_office_desk", chance = 25 },
            },
            J = {
                { group = "hospital_lab", chance = 30 },
                { group = "chem_lab", chance = 20 },
                { group = "tools_science", chance = 30 },
            },
            L = {
                { group = "lab_shoes", chance = 70, repetitions = 2 },
                { group = "lab_pants", chance = 70, repetitions = 2 },
                { group = "lab_torso", chance = 70, repetitions = 2 },
            },
            N = {
                { group = "tools_common", chance = 20, repetitions = { 1, 2 } },
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 10, repetitions = { 1, 2 } },
            },
            P = { group = "SUS_office_filing_cabinet", chance = 100 },
            Q = {
                { group = "harddrugs", chance = 100, repetitions = { 1, 6 } },
                { group = "drugs_rare", chance = 40, repetitions = { 1, 2 } },
            },
            R = {
                { group = "lab_bookshelves", chance = 20, repetitions = { 1, 4 } },
                { group = "games", chance = 5, repetitions = { 1, 2 } },
            },
            S = {
                { group = "cleaning", chance = 80 },
                { group = "SUS_bathroom_medicine", chance = 60 },
            },
            U = {
                { group = "home_hw", chance = 20, repetitions = { 1, 2 } },
                { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
                { group = "supplies_reagents_lab", chance = 5, repetitions = { 1, 2 } },
            },
            V = { group = "softdrugs", chance = 50 },
            Y = { group = "SUS_trash_trashcan", chance = 30 },
            a = {
                { group = "virology_lab_fridge", chance = 30 },
                { group = "supplies_samples_lab", chance = 30 },
                { group = "SUS_fridge_snacks", chance = 15 },
            },
            b = { group = "hospital_bed", chance = 20 },
            c = {
                { group = "hospital_lab", chance = 75, repetitions = { 1, 5 } },
                { group = "chem_lab", chance = 75, repetitions = { 1, 2 } },
            },
            d = { { group = "tools_science", chance = 70, repetitions = { 1, 2 } } },
            f = {
                { group = "tools_science", chance = 30 },
                { group = "baked_goods", chance = 1 },
                { group = "writing_utensils", chance = 10, repetitions = { 1, 2 } },
                { group = "SUS_office_filing_cabinet", chance = 10 },
            },
            l = {
                { group = "elecsto_persele", chance = 10, repetitions = { 1, 3 } },
                { group = "livingroom", chance = 10, repetitions = { 1, 3 } },
            },
            m = {
                { group = "virology_lab_fridge", chance = 30 },
                { group = "supplies_samples_lab", chance = 30 },
                { group = "SUS_fridge_snacks", chance = 15 },
            },
            q = {
                { group = "tools_home", chance = 10 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "tools_science", chance = 20, repetitions = { 1, 2 } },
                { group = "supplies_reagents_lab", chance = 30 },
                { group = "chem_lab", chance = 40, repetitions = { 1, 2 } },
            },
            r = {
                { group = "SUS_office_mess", chance = 5 },
                { group = "SUS_office_supplies", chance = 25 },
                { group = "lab_files_psychology", chance = 10 },
            },
            s = { { group = "consumer_electronics", chance = 10 } },
            w = {
                { group = "chem_lab", chance = 20 },
                { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
            },
            x = { group = "consumer_electronics", chance = 10, repetitions = { 1, 3 } },
            z = {
                { group = "chem_lab", chance = 40, repetitions = { 1, 2 } },
                { group = "supplies_reagents_lab", chance = 30, repetitions = { 1, 2 } },
                { group = "supplies_electronics", chance = 20, repetitions = { 1, 2 } },
                { group = "supplies_plumbing", chance = 3 },
            },
            ["∞"] = {
                { group = "toy_store", chance = 10, repetitions = { 1, 2 } },
                { group = "games", chance = 10, repetitions = { 1, 2 } },
                { group = "snacks", chance = 30 },
            },
        },
        terrain = { ["1"] = "t_elevator_control_off", ["2"] = "t_elevator" },
        furniture = {
            W = {
                { id = "f_generator_broken", copies = 25 },
                { id = "f_portable_generator", copies = 5 },
                { id = "f_diesel_generator", copies = 5 },
                { id = "f_military_generator", copies = 5 },
                { id = "f_12000_gasoline_generator", copies = 5 },
            },
            ["ɔ"] = "f_autodoc",
            ["Я"] = "f_autodoc_couch",
            Z = "f_control_station",
            ["₸"] = "f_machinery_electronic",
            ["Ø"] = "f_CTscan",
            ["Æ"] = {
                { id = "f_GC", copies = 5 },
                { id = "f_NMR", copies = 5 },
                { id = "f_MS", copies = 5 },
            },
            ["3"] = "f_electron_microscope",
            ["4"] = "f_dialysis",
            ["5"] = "f_ventilator",
            ["7"] = "f_anesthetic",
            ["8"] = { { id = "f_MRI", copies = 5 }, { id = "f_CTscan", copies = 5 } },
        },
    },
}
