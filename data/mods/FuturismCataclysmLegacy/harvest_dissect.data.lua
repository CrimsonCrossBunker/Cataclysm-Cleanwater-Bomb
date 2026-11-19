local ccb = require("ccb")

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
