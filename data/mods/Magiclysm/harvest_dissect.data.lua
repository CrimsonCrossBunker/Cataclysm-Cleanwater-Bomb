local ccb = require("ccb")

ccb.content.define_harvest {
    id = "dissect_mon_feral_technomancer",
    message = ccb.content.text("You search for any salvageable hardware in what's left of the technomancer.  They have not given much care to their bionics, but some of the electronics look surprisingly intact."),
    drops = {
        {
            output = "feral_technomancer_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 1 },
            skill_quantity = { 0.1, 0.4 },
            maximum = 2,
        },
        {
            output = "feral_technomancer_CBM_harvest_power",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 2 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 5,
        },
    },
}

ccb.content.define_harvest {
    id = "dissect_mon_feral_high_technomancer",
    message = ccb.content.text("You search for any salvageable hardware in what's left of the technomancer.  They have not given much care to their bionics, but some of the electronics look surprisingly intact."),
    drops = {
        {
            output = "feral_high_technomancer_CBM_harvest",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 2 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 4,
        },
        {
            output = "feral_high_technomancer_CBM_harvest_power",
            category = "bionic_group",
            flags = { "NO_STERILE", "NO_PACKED", "FILTHY" },
            faults = { "fault_bionic_salvaged" },
            base_quantity = { 0, 2 },
            skill_quantity = { 0.1, 0.6 },
            maximum = 5,
        },
    },
}
