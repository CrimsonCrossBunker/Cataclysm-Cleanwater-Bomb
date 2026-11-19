local ccb = require("ccb")

-- nether organs could be in base game.
ccb.content.define_harvest {
    id = "fae_furred",
    drops = {
        { output = "fae_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "fae_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "fae_organs", category = "flesh", mass_ratio = 0.1 },
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "fae_fur", category = "skin", mass_ratio = 0.04 },
        { output = "fat", category = "flesh", mass_ratio = 0.04 },
    },
}

-- nether organs could be in base game.
ccb.content.define_harvest {
    id = "fae_changeling",
    drops = {
        { output = "fae_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "fae_meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "fae_organs", category = "flesh", mass_ratio = 0.1 },
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "fat", category = "flesh", mass_ratio = 0.04 },
    },
}

ccb.content.define_harvest {
    id = "fae_march_lord",
    copy_from = "fae_changeling",
    extend = {
        drops = { { output = "skull_march_lord", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "stoneling",
    drops = {
        { output = "pebble", category = "blood", mass_ratio = 0.1 },
        { output = "rock", category = "flesh", mass_ratio = 0.4 },
    },
}

ccb.content.define_harvest {
    id = "fetch",
    drops = {
        { output = "material_sand", category = "blood", mass_ratio = 0.1 },
        { output = "ash", category = "flesh", mass_ratio = 0.4 },
        { output = "birchbark", category = "skin", mass_ratio = 0.04 },
        { output = "stick", category = "bone", mass_ratio = 0.15 },
    },
}

ccb.content.define_harvest {
    id = "water_elemental",
    drops = {
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
        { output = "fae_meat", category = "flesh", mass_ratio = 0.4 },
    },
}

ccb.content.define_harvest {
    id = "rat_with_skull_arvore",
    drops = {
        { output = "skull_rodent", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "fae_meat_scrap", category = "flesh", mass_ratio = 0.5 },
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "fae_flying",
    drops = {
        { output = "fae_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "fae_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "vampire",
    copy_from = "demihuman",
    extend = { drops = { { output = "vampire_blood", category = "blood", mass_ratio = 0.02 } } },
    delete = { drops = { { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 } } },
}

ccb.content.define_harvest {
    id = "fig_harv",
    drops = { { output = "fig", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pomegranate_harv",
    drops = { { output = "pomegranate", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "elder_ginseng_harv",
    drops = { { output = "xe_elder_ginseng", base_quantity = { 1, 1 } } },
}

ccb.content.define_harvest {
    id = "harvest_thornbear",
    drops = {
        { output = "skull_bear", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "fae_meat", category = "flesh", mass_ratio = 0.28 },
        { output = "veggy", category = "flesh", mass_ratio = 0.04 },
        { output = "fae_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "fae_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "fae_organs", category = "flesh", mass_ratio = 0.008 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "fae_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

ccb.content.define_harvest {
    id = "shrub_goblin_fruits_harv",
    drops = { { output = "goblin_fruit_gacha", base_quantity = { 1, 3 } } },
}

ccb.content.define_harvest {
    id = "harvest_blank_body",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "blank_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.01 },
    },
}
