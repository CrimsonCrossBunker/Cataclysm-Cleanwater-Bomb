local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_wet",
    fault_type = "wet",
    name = ccb.content.text("Wet"),
    description = ccb.content.text("Item is too wet to use and has to be dried."),
    item_prefix = ccb.content.text("waterlogged"),
    flags = { "ITEM_BROKEN" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_wet",
    name = ccb.content.text("Passively dry"),
    success_message = ccb.content.text("You dry the %s."),
    duration = "120 m",
    removes = { "fault_wet" },
    skills = { fabrication = 2 },
    requirements = {
        {
            qualities = { { id = "CONTAIN", level = 1 } },
            components = {
                { { "flour", 10 }, { "dry_rice", 10 }, { "dry_beans", 10 }, { "dry_lentils", 10 } },
            },
        },
    },
}

ccb.content.define_fault_fix {
    id = "mend_fault_wet_oven",
    name = ccb.content.text("Dry with hot air in an oven.  Requires good temperature control."),
    success_message = ccb.content.text("You heat up and dry the %s."),
    duration = "60 m",
    removes = { "fault_wet" },
    skills = { cooking = 4 },
    requirements = { { qualities = { { id = "OVEN", level = 2 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_fault_wet_hot_air",
    name = ccb.content.text("Dry with hot air."),
    success_message = ccb.content.text("You dry the %s with hot air."),
    duration = "10 m",
    removes = { "fault_wet" },
    requirements = { { qualities = { { id = "BLOW_HOT_AIR", level = 1 } } } },
}
