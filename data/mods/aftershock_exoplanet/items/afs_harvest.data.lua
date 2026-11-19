local ccb = require("ccb")

-- your bog standard zombie
ccb.content.define_harvest {
    id = "zombie",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "dissect_human",
    drops = {
        {
            output = "afs_titanium_implant",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE" },
            maximum = 1,
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_human_reaver",
    drops = {
        {
            output = "bio_power_storage_salvaged",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionics_reaver",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_CBM_CIV",
    drops = {
        {
            output = "bio_power_storage",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionics_common",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "afs_titanium_implant",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE" },
            maximum = 1,
        },
    },
}

ccb.content.define_harvest {
    id = "CBM_CIV",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "human",
    drops = {
        { output = "human_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "human_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "blood", category = "blood", mass_ratio = 0.1 },
        { output = "bone_human", category = "bone", mass_ratio = 0.12 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_hleather", category = "skin", mass_ratio = 0.01 },
    },
}
