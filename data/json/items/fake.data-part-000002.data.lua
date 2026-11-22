local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_nl_psyshield",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Cranial EMF Shielding", "Cranial EMF Shieldings"),
    description = ccb.content.text("Your skull is coated in a microscopically thin layer of some non-newtonian fluid.  It can protect you from some types of electromagnetic fields."),
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "PSYSHIELD_PARTIAL",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

ccb.content.define_item {
    id = "integrated_nl_dimensional_anchor",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Dimensional Anchor", "Dimensional Anchors"),
    description = ccb.content.text("Your body has been wired with advanced technology that locks you into your native dimensionality, protecting you from unwanted teleportation and some other phase altering effects.  It is currently active and draining bionic power."),
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS",
        "DIMENSIONAL_ANCHOR", "SPAWN_ACTIVE",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "fake_appliance_tool",
    abstract = true,
    name = ccb.content.text_without_extraction("fake appliance tool"),
    copy_from = "fake_item",
    pockets = { { kind = "MAGAZINE_WELL" } },
    inheritance = { add = { flags = { "ALLOWS_REMOTE_USE", "PSEUDO" } } },
    tool = { ammo_types = { "battery" } },
}

ccb.content.define_item {
    id = "integrated_ar",
    copy_from = "fake_item",
    name = "Integrated AR System",
    description = "Extremely thin lenses provide user with augmented reality overlay allowing the user to zoom, and it displays handy information about local topology.",
    e_port = "phone",
    flags = {
        "ZOOM",
        "WATCH",
        "ALARMCLOCK",
        "SUN_GLASSES",
        "THERMOMETER",
        "INTEGRATED",
        "UNBREAKABLE",
        "PERSONAL",
        "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS",
        "USES_BIONIC_POWER",
    },
    materials = { "plastic" },
    variables = { browsed = "true" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "2 TB",
            weight_multiplier = 0.0,
            rigid = true,
        },
    },
    use_actions = { "CAMERA", "PORTABLE_GAME", "EBOOKSAVE", "E_FILE_DEVICE" },
    tool = { charges_per_use = 1, transfer_rate = "140 MB" },
    armor = {},
    subtype_order = { "tool", "armor" },
}
