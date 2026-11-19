local ccb = require("ccb")

ccb.content.define_harvest {
    id = "frost_human",
    drops = {
        { output = "frost_human_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "frost_hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "frost_human_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "frost_bone_human", category = "bone", mass_ratio = 0.12 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "frost_raw_hleather", category = "skin", mass_ratio = 0.01 },
    },
}

-- animals so tiny they don't drop chunks of meat
ccb.content.define_harvest {
    id = "alien_tiny",
    drops = { { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.5 } },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "alien_small_fur",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.28 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.05 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_fur", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "alien_mammal_fur",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.3 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_fur", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "alien_large_fur",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.32 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_fur", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "alien_small_leather",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.28 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.05 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_leather", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "alien_leather",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.3 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_leather", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "alien_large_leather",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.32 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_alien_leather", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "alien_small_wool",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.28 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.05 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "wool_staple", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "alien_large_wool",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.32 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "wool_staple", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "alien_noskin",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.3 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "alien_large_noskin",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.32 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_liver", category = "offal", mass_ratio = 0.01 },
        { output = "alien_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "alien_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "alien_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "alien_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "alien_bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "alien_arthropod",
    message = "<centipede_harvest>",
    drops = {
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.08 },
    },
}

-- mostly hydrogen bubbles
ccb.content.define_harvest {
    id = "alien_floater",
    message = ccb.content.text("The freeze-burned leather parts easily, and thousands of fleshy floating bubbles erupt from the distended carcass.  Most fly away before you can reach them."),
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.3 },
        { output = "alien_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "mutant_bug_hydrogen_sacs", category = "offal", mass_ratio = 2.0 },
        { output = "sinew", category = "bone", mass_ratio = 0.0035 },
        { output = "raw_alien_leather", category = "skin", mass_ratio = 0.02 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.07 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "alien_moxphore",
    message = "<arachnid_harvest>",
    drops = {
        { output = "alien_flesh", category = "flesh", mass_ratio = 0.33 },
        { output = "alien_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "alien_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "alien_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}
