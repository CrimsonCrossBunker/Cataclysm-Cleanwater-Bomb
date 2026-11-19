local ccb = require("ccb")

-- drops regular stomach and small skull
ccb.content.define_harvest {
    id = "dino_feather_leather",
    copy_from = "mammal_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_small", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.1 },
            { output = "large_bone", category = "bone", mass_ratio = 0.05 },
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

-- drops large stomach and regular skull
ccb.content.define_harvest {
    id = "dino_large_feather",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_med", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.001 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0005 },
        },
    },
}

-- drops sauropod stomach and medium skull
ccb.content.define_harvest {
    id = "dino_sauropod",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
            { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_med", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "stomach_sauropod", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
            { output = "large_bone", category = "bone", mass_ratio = 0.15 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "dino_large_pred",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_pred_large", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

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
            { output = "feather", category = "skin", mass_ratio = 0.001 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0005 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "dino_large_feather_pred",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_dino_pred_large", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.0002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "tyrannosaurus",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_tyrannosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.0002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "allosaurus",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_allosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.0002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "acrocanthosaurus",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_acrocanthosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
            { output = "feather", category = "skin", mass_ratio = 0.0002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "giganotosaurus",
    copy_from = "mammal_large_leather",
    delete = {
        drops = {
            { output = "bone", category = "bone", mass_ratio = 0.15 },
            { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        },
    },
    extend = {
        drops = {
            { output = "skull_giganotosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "large_bone", category = "bone", mass_ratio = 0.15 },
            { output = "feather", category = "skin", mass_ratio = 0.002 },
            { output = "down_feather", category = "skin", mass_ratio = 0.001 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "dino_large_leather",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_dino_large", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "torosaurus",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_torosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "lokiceratops",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_lokiceratops", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "styracosaurus",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_styracosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "centrosaurus",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_centrosaurus", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

-- drops large stomach and skull
ccb.content.define_harvest {
    id = "triceratops",
    copy_from = "mammal_large_leather",
    delete = { drops = { { output = "bone", category = "bone", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "skull_triceratops", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
            { output = "bone", category = "bone", mass_ratio = 0.05 },
            { output = "large_bone", category = "bone", mass_ratio = 0.1 },
        },
    },
}

ccb.content.define_harvest {
    id = "zed_dino_leather",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.02 },
    },
}

ccb.content.define_harvest {
    id = "zed_dino_feather",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.02 },
        { output = "feather", category = "skin", mass_ratio = 0.0002 },
        { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
    },
}

ccb.content.define_harvest {
    id = "zed_dino_leather_acid",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_acid", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.02 },
    },
}

ccb.content.define_harvest {
    id = "zed_dino_feather_acid",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_acid", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.02 },
        { output = "feather", category = "skin", mass_ratio = 0.0002 },
        { output = "down_feather", category = "skin", mass_ratio = 0.0001 },
    },
}
