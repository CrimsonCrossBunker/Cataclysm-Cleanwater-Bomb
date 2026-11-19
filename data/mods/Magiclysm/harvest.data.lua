local ccb = require("ccb")

-- identical to mutant_mammal_large_fur except that half the fur has been replaced with feathers
ccb.content.define_harvest {
    id = "owlbear",
    copy_from = "mutant_mammal_large_fur",
    delete = { drops = { { output = "raw_fur", category = "skin", mass_ratio = 0.02 } } },
    extend = {
        drops = {
            { output = "owlbear_stone", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
            { output = "raw_fur", category = "skin", mass_ratio = 0.015 },
            { output = "feather", category = "skin", mass_ratio = 0.005 },
            { output = "adrenal_gland_large", category = "bionic", maximum = 2 },
        },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "owlbear_cub",
    copy_from = "mutant_mammal_fur",
    delete = { drops = { { output = "raw_fur", category = "skin", mass_ratio = 0.02 } } },
    extend = {
        drops = {
            { output = "owlbear_stone", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
            { output = "raw_fur", category = "skin", mass_ratio = 0.015 },
            { output = "feather", category = "skin", mass_ratio = 0.005 },
        },
    },
}

-- a large non-mutant flightless bird: more fat, feathers & bone, since weight matters less for them
ccb.content.define_harvest {
    id = "large_bird_flightless",
    drops = {
        { output = "poultry", category = "flesh", mass_ratio = 0.3 },
        { output = "blood", category = "blood", mass_ratio = 0.1 },
        { output = "poultry_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "lung", category = "offal", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "offal", mass_ratio = 0.003 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "fat", category = "flesh", mass_ratio = 0.18 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
        { output = "feather", category = "skin", mass_ratio = 0.02 },
        { output = "down_feather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "bulette",
    copy_from = "mammal_large_leather",
    extend = {
        drops = {
            { output = "bulette_plate", skill_quantity = { 2, 5 }, maximum = 1, category = "skin" },
            { output = "bulette_pearl", skill_quantity = { 1, 4 }, maximum = 1, category = "offal" },
            { output = "adrenal_gland_large", category = "bionic", maximum = 2 },
        },
    },
}

-- Maybe demon blood in future.  But for now, tainted will do.
ccb.content.define_harvest {
    id = "demon_spider",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "meat", category = "flesh", mass_ratio = 0.05 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "demon_chitin_piece", category = "bone", mass_ratio = 0.04 },
        { output = "demon_chitin_plate", category = "skin", mass_ratio = 0.01 },
        {
            output = "demon_spider_fang",
            base_quantity = { 0, 0 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 2,
            category = "flesh",
        },
    },
}

-- separate harvest entry for future special alchemical items
ccb.content.define_harvest {
    id = "demon_spider_queen",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "meat", category = "flesh", mass_ratio = 0.05 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "demon_chitin_piece", category = "bone", mass_ratio = 0.04 },
        { output = "demon_chitin_plate", category = "skin", mass_ratio = 0.01 },
        {
            output = "demon_spider_fang",
            base_quantity = { 0, 0 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 2,
            category = "flesh",
        },
    },
}

ccb.content.define_harvest {
    id = "mammal_small_fur",
    copy_from = "mammal_small_fur",
    extend = { drops = { { output = "hairball", category = "bionic", maximum = 3 } } },
}

ccb.content.define_harvest {
    id = "mammal_large_fur",
    copy_from = "mammal_large_fur",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "mammal_large_leather",
    copy_from = "mammal_large_leather",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "mutant_mammal_large_leather",
    copy_from = "mutant_mammal_large_leather",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "mammal_large_wool",
    copy_from = "mammal_large_wool",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "mammal_small_parabolan_wool",
    copy_from = "mammal_small_wool",
    delete = { drops = { { output = "wool_staple", category = "skin", mass_ratio = 0.02 } } },
    extend = { drops = { { output = "parabolan_wool_staple", category = "skin", mass_ratio = 0.02 } } },
}

ccb.content.define_harvest {
    id = "mammal_large_parabolan_wool",
    copy_from = "mammal_large_wool",
    delete = { drops = { { output = "wool_staple", category = "skin", mass_ratio = 0.21 } } },
    extend = {
        drops = {
            { output = "parabolan_wool_staple", category = "skin", mass_ratio = 0.05 },
            { output = "adrenal_gland_large", category = "bionic", maximum = 2 },
        },
    },
}

ccb.content.define_harvest {
    id = "human_large_leather",
    copy_from = "human_large_fur",
    delete = { drops = { { output = "raw_hfur", category = "skin", mass_ratio = 0.02 } } },
    extend = {
        drops = {
            { output = "raw_hleather", category = "skin", mass_ratio = 0.02 },
            { output = "adrenal_gland_large", category = "bionic", maximum = 2 },
        },
    },
}

ccb.content.define_harvest {
    id = "animal_large_noskin",
    copy_from = "animal_large_noskin",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "mutant_animal_large_noskin",
    copy_from = "mutant_animal_large_noskin",
    extend = { drops = { { output = "adrenal_gland_large", category = "bionic", maximum = 2 } } },
}

ccb.content.define_harvest {
    id = "dragon_black",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "dragon_blood", category = "blood", mass_ratio = 0.1 },
        { output = "meat_dragon", category = "flesh", mass_ratio = 0.18 },
        { output = "dragon_black_scale", category = "skin", mass_ratio = 0.05 },
        { output = "black_dragon_hide_raw", category = "skin", mass_ratio = 0.1 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
    },
}

-- mainly arachnid drops with leather and proboscis
ccb.content.define_harvest {
    id = "stirge",
    drops = {
        { output = "blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.01 },
        { output = "stirge_proboscis", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
    },
}

-- mainly fungaloid drops with scream mushroom
ccb.content.define_harvest {
    id = "shrieker",
    drops = {
        { output = "veggy", category = "flesh", mass_ratio = 0.4 },
        { output = "plant_sac", category = "offal", mass_ratio = 0.2 },
        { output = "stick_fiber", category = "bone", mass_ratio = 0.1 },
        { output = "scream_mush", skill_quantity = { 0.1, 0.3 }, maximum = 10, category = "offal" },
    },
}

-- nothing much aside from big pile of meat and maybe demon blood in future.  But for now, tainted will do.
ccb.content.define_harvest {
    id = "lemure",
    drops = {
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "meat", category = "flesh", mass_ratio = 0.4 },
    },
}

ccb.content.define_harvest {
    id = "lizardfolk",
    copy_from = "demihuman_large_fur",
    delete = {
        drops = {
            { output = "raw_hfur", category = "skin", mass_ratio = 0.02 },
            { output = "demihuman_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
    extend = {
        drops = {
            { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.02 },
            { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

-- taken from mutant flightless bird but with demihuman meat and organs
ccb.content.define_harvest {
    id = "ravenfolk",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.29 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.18 },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.1 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.01 },
        { output = "feather", category = "skin", mass_ratio = 0.02 },
        { output = "down_feather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "zombie_lizardfolk",
    copy_from = "zombie_humanoid",
    delete = {
        drops = {
            { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

-- removes 66% of their feathers due to most being unusable due to being from an undead corpse.
ccb.content.define_harvest {
    id = "zombie_ravenfolk",
    copy_from = "zombie_humanoid",
    delete = {
        drops = {
            { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
    extend = {
        drops = {
            { output = "feather", category = "skin", mass_ratio = 0.007 },
            { output = "down_feather", category = "skin", mass_ratio = 0.003 },
        },
    },
}

ccb.content.define_harvest {
    id = "ogre",
    copy_from = "demihuman_large_fur",
    delete = { drops = { { output = "raw_hfur", category = "skin", mass_ratio = 0.02 } } },
    extend = { drops = { { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.02 } } },
}

ccb.content.define_harvest {
    id = "orc",
    copy_from = "demihuman_large_fur",
    delete = {
        drops = {
            { output = "raw_hfur", category = "skin", mass_ratio = 0.02 },
            { output = "demihuman_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
    extend = {
        drops = {
            { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.02 },
            { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        },
    },
}

-- identical to owlbear except
ccb.content.define_harvest {
    id = "zombie_owlbear",
    drops = {
        { output = "meat_mutant_tainted", category = "flesh", mass_ratio = 0.32 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "owlbear_stone", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.15 },
        { output = "raw_tainted_fur", category = "skin", mass_ratio = 0.015 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.07 },
        { output = "feather", category = "skin", mass_ratio = 0.005 },
        { output = "adrenal_gland_large", category = "bionic", maximum = 2 },
    },
}

ccb.content.define_harvest {
    id = "large_bird_flightless_zombie",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.3 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "poultry_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "tainted_innards", category = "offal", mass_ratio = 0.03 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.18 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.1 },
        { output = "feather", category = "skin", mass_ratio = 0.013 },
        { output = "down_feather", category = "skin", mass_ratio = 0.005 },
    },
}

ccb.content.define_harvest {
    id = "platonic_flower_harv",
    drops = { { output = "platonic_flower", base_quantity = { 1, 1 } } },
}

ccb.content.define_harvest {
    id = "moonflower_harv",
    drops = { { output = "moonflowers", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "kampuch_harv",
    drops = { { output = "kampuch", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "olieribos_harv",
    drops = { { output = "olieribos", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "glowing_mushroom_harv",
    drops = { { output = "glowing_mushroom", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "horn_moss_harv",
    drops = { { output = "horn_moss_capsule", base_quantity = { 1, 1 } } },
}

ccb.content.define_harvest {
    id = "golden_reed_harv",
    drops = { { output = "golden_reed_stalk", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "wood_barnacle_harv",
    drops = { { output = "wood_barnacle", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "dragon_nail_harv",
    drops = { { output = "dragon_nail", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "moly_harv",
    drops = { { output = "moly_tuber", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "flowering_fern_harv",
    drops = { { output = "fern_flower", base_quantity = { 1, 1 } } },
}

ccb.content.define_harvest {
    id = "funnelcap_harv",
    drops = { { output = "funnelcap_chunk", base_quantity = { 10, 25 } } },
}

ccb.content.define_harvest {
    id = "whiskflower_harv",
    drops = { { output = "whiskflower", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "sojourners_palm_harv",
    message = ccb.content.text("As you harvest the flowers from the tree, it vanishes into thin air."),
    drops = { { output = "sojourners_flower", base_quantity = { 1, 5 } } },
}

ccb.content.define_harvest {
    id = "dissect_owlbear_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "bird_sample_small", category = "mutagen_group" },
        { output = "ursine_sample_small", category = "mutagen_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_owlbear_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "bird_sample_single", category = "mutagen_group" },
        { output = "ursine_sample_single", category = "mutagen_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_bulette_sample_large",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "lizard_sample_small", category = "mutagen_group" },
        { output = "beast_sample_small", category = "mutagen_group" },
    },
}

ccb.content.define_harvest {
    id = "dissect_stirge_sample_small",
    message = ccb.content.text("With cuts and pulls equally similar to both extraction and vandalism, you scrape together the most important parts of the creature."),
    drops = {
        { output = "insect_sample_single", category = "mutagen_group" },
        { output = "chiropteran_sample_single", category = "mutagen_group" },
    },
}
