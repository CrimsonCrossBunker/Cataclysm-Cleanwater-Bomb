local ccb = require("ccb")

-- drops large stomach and medium skull
ccb.content.define_harvest {
    id = "dino_med_feather_pred",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_pred_med", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.001 },
        },
    },
}

-- drops regular stomach and small skull
ccb.content.define_harvest {
    id = "dino_pred_feather_leather",
    copy_from = "mammal_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_pred_small", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.1 },
            { output = "large_bone", category = "bone", mass_ratio = 0.05 },
            { output = "feather", category = "skin", mass_ratio = 0.002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.001 },
        },
    },
}

ccb.content.define_harvest {
    id = "harvest_lizardfolk",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.32 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.02 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.1 },
    },
}
