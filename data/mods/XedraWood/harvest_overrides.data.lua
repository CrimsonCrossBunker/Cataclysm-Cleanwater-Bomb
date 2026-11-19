local ccb = require("ccb")

ccb.content.define_harvest {
    id = "arachnid",
    message = "<arachnid_harvest>",
    drops = {
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "insect_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_acid",
    message = "<acidant_harvest>",
    drops = {
        { output = "blood_acid_insect", category = "blood", mass_ratio = 0.1 },
        { output = "insect_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "acidchitin_piece", category = "bone", mass_ratio = 0.04 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.06 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_acid_queen",
    message = ccb.content.text("You laboriously dissect the colossal insect.  <acidant_harvest>"),
    drops = {
        {
            output = "insect_meat",
            base_quantity = { 40, 55 },
            skill_quantity = { 0.5, 0.7 },
            maximum = 80,
            category = "flesh",
        },
        {
            output = "acidchitin_piece",
            base_quantity = { 2, 4 },
            skill_quantity = { 0.3, 0.6 },
            maximum = 10,
            category = "bone",
        },
        {
            output = "chitin_piece",
            base_quantity = { 0, 3 },
            skill_quantity = { 0.3, 0.6 },
            maximum = 10,
            category = "bone",
        },
        { output = "blood_acid_insect", category = "blood", mass_ratio = 0.1 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        {
            output = "insect_fat",
            base_quantity = { 5, 8 },
            skill_quantity = { 0.6, 0.8 },
            maximum = 18,
            category = "flesh",
        },
    },
}

-- More legs = more sinew, more endochitin, less rest
ccb.content.define_harvest {
    id = "arachnid_centipede",
    message = "<centipede_harvest>",
    drops = {
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "insect_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.08 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_centipede_mom",
    message = "<centipede_mom_harvest>",
    drops = {
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "insect_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.08 },
        {
            output = "egg_centipede",
            category = "offal",
            base_quantity = { 3, 10 },
            skill_quantity = { 0.5, 1 },
            maximum = 30,
        },
    },
}

-- Chitin plate comes here, lots of muscle
ccb.content.define_harvest {
    id = "arachnid_centipede_mega",
    message = "<centipede_mega_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.4 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.015 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.2 },
        {
            output = "egg_centipede",
            category = "offal",
            base_quantity = { 0, 3 },
            skill_quantity = { 0.5, 1 },
            maximum = 10,
        },
    },
}

-- replace some chitin with plate when added
ccb.content.define_harvest {
    id = "arachnid_beetle",
    message = "<ground_beetle_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.25 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.06 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.3 },
    },
}

-- replace most chitin with plate when added
ccb.content.define_harvest {
    id = "arachnid_beetle_mega",
    message = "<ground_beetle_mega_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.25 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.06 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.3 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_flying",
    message = "<arachnid_flying_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_bee",
    message = ccb.content.text("What appeared to be insect hairs on the chitin of this creature look more like tiny feathers as you pare them back.  Inside is a bundle of bubble-like tissue sacs that appear to be floating, which doesn't fit with what you know about real bees."),
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.23 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "bee_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "venom_bee", category = "offal", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_dragonfly_mega",
    message = ccb.content.text("As you hack away at the chitinous amalgamation you can't help but follow the tunnel the (male?) dragonfly's tail bore into the flesh of its mate, ending up at a formless amalgamation of eyes, jaws, eggs, and ganglia deep within.  Love truly knows no bounds."),
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        {
            output = "egg_dragonfly",
            category = "offal",
            base_quantity = { 5, 35 },
            skill_quantity = { 0.3, 0.5 },
        },
    },
}

-- copied from arachnid_flying+egg
ccb.content.define_harvest {
    id = "arachnid_firefly",
    message = "<firefly_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.01 },
        { output = "egg_firefly", category = "offal", base_quantity = { 0, 3 } },
    },
}

ccb.content.define_harvest {
    id = "arachnid_spider",
    message = "<spider_harvest>",
    copy_from = "arachnid",
    drops = {
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "insect_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "insect_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_tainted",
    message = "<arachnid_harvest>",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_wasp",
    message = "<wasp_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "wasp_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "venom_wasp", category = "offal", base_quantity = { 0, 3 }, skill_quantity = { 0, 2 } },
    },
}

ccb.content.define_harvest {
    id = "arachnid_wasp_queen",
    message = "<wasp_queen_harvest>",
    drops = {
        { output = "insect_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "insect_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "wasp_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "egg_wasp", category = "offal", base_quantity = { 10, 30 }, skill_quantity = { 5, 5 } },
        { output = "venom_wasp", category = "offal", base_quantity = { 5, 25 }, skill_quantity = { 5, 2 } },
    },
}
