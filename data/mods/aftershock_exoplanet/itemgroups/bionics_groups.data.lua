local ccb = require("ccb")

ccb.content.define_harvest {
    id = "CBM_SUBS",
    drops = {
        {
            output = "bio_power_storage",
            category = "bionic",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionics_subs",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        {
            output = "bionics_subs",
            category = "bionic_group",
            flags = { "FILTHY", "NO_STERILE", "NO_PACKED" },
            faults = { "fault_bionic_salvaged" },
        },
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
    },
}
