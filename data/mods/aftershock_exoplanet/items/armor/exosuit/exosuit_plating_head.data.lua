local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_helmet_steel",
    category = "exosuit",
    name = ccb.content.plural_text("steel helmet plate (exosuit)", "steel helmet plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's helmet via carbide brackets, this is a sturdy plate of tempered steel."),
    mass = "5 kg",
    volume = "5 L",
    materials = { "afs_steel" },
    symbol = "[",
    looks_like = "power_armor_helmet_basic",
    color = "light_gray",
    flags = { "CANT_WEAR", "ABLATIVE_LARGE", "EXO_HELMET_PLATE", "FRAGILE" },
    faults = { { group = "afs_steel_armor" } },
    armor = {
        portions = {
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 2 } },
                covers = { "head", "eyes", "mouth" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "exo_helmet_plastic",
    category = "exosuit",
    copy_from = "exo_helmet_steel",
    name = ccb.content.plural_text("plastic helmet plate (exosuit)", "plastic helmet plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's helmet, this is a plate of plastic."),
    mass = "1250 g",
    materials = { "plastic" },
    looks_like = "power_armor_helmet_basic",
    armor = {
        broken_item = "damaged_exo_helmet_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 12 } },
                covers = { "head", "eyes", "mouth" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "damaged_exo_helmet_plastic",
    copy_from = "exo_helmet_plastic",
    name = ccb.content.plural_text("damaged plastic helmet plate (exosuit)", "damaged plastic helmet plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic helmet plate after taking a strong impact.  Can be restored to full effectiveness via reforging."),
    looks_like = "exo_helmet_plastic",
    armor = {
        broken_item = "destroyed_exo_helmet_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 6 } },
                covers = { "head", "eyes", "mouth" },
                coverage = 85,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "destroyed_exo_helmet_plastic",
    copy_from = "exo_helmet_plastic",
    name = ccb.content.plural_text("shattered plastic helmet plate (exosuit)", "shattered plastic helmet plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic helmet plate after taking a strong impact.  No longer provides functional protection, just weight."),
    looks_like = "exo_helmet_steel",
    armor = {},
    inheritance = { add = { flags = { "NO_REPAIR" } } },
}

ccb.content.define_item {
    id = "exo_helmet_vcc",
    category = "exosuit",
    copy_from = "exo_helmet_steel",
    name = ccb.content.plural_text("carbide helmet plate (exosuit)", "carbide helmet plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's helmet, this is a plate of vacuum-cast carbide."),
    mass = "7500 g",
    materials = { "vacuum_carbide_hard" },
    faults = { { group = "carbide_armor" } },
    looks_like = "power_armor_helmet_basic",
    armor = {
        portions = {
            {
                materials = { { id = "vacuum_carbide_hard", coverage = 100, thickness = 1 } },
                covers = { "head", "eyes", "mouth" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
    inheritance = { add = { flags = { "NO_REPAIR" } } },
}
