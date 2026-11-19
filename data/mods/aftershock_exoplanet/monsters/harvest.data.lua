local ccb = require("ccb")

ccb.content.define_harvest {
    id = "yum_lichen_harv",
    drops = { { output = "yum_lichen", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "dissect_CBM_DOG",
    drops = {
        {
            output = "bio_power_storage_mkII",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionics_op",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
    },
}

ccb.content.define_harvest {
    id = "CBM_DOG",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.3 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}
