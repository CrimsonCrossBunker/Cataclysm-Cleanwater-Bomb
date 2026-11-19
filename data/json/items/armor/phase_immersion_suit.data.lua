local ccb = require("ccb")

-- floating, attached to helmet
-- floating, attached to helmet
ccb.content.define_item {
    id = "phase_immersion_cca",
    name = ccb.content.plural_text("phase immersion CCA", "phase immersion CCAs"),
    description = ccb.content.text("A DARPA Communications Carrier Assembly - a bundle of electronics, including a battery, microphone, headphones with active noise suppression, and slimmed down ground panoramic night vision goggles.  The assembly cannot be worn on its own - it must be attached to an appropriate helmet.  Activate it to turn it on."),
    mass = "800 g",
    volume = "1600 ml",
    price = "80 kUSD",
    survival_price = "150 USD",
    materials = { "plastic", "glass", "steel" },
    symbol = "[",
    color = "dark_gray",
    flags = { "CANT_WEAR", "ELECTRONIC", "WATERPROOF", "USE_UPS", "NO_UNLOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2000 } } },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 0, rigid_only = true },
            { covers = { "head" }, encumbrance = 0, coverage = 80 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Initiating\nRunning CCA integrity diagnostics…\nAll systems operational."),
            target = "phase_immersion_cca_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Warning: Low power."),
        },
    },
}

-- floating, attached to helmet
-- floating, attached to helmet
ccb.content.define_item {
    id = "phase_immersion_cca_on",
    copy_from = "phase_immersion_cca",
    name = ccb.content.plural_text("phase immersion CCA (on)", "phase immersion CCAs (on)"),
    description = ccb.content.text("A DARPA communications carrier assembly - a bundle of electronics, including a battery, microphone, headphones with active noise suppression, and slimmed down ground panoramic night vision goggles.  The assembly cannot be worn on its own.  It must be attached to an appropriate helmet.  Activate it to turn it off."),
    revert_to = "phase_immersion_cca",
    inheritance = {
        add = {
            flags = {
                "GNV_EFFECT", "SPAWN_ACTIVE", "HYGROMETER", "THERMOMETER", "WATCH", "ALARMCLOCK",
                "PARTIAL_DEAF", "TWO_WAY_RADIO",
            },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "360 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 10, encumbrance = 15, rigid_only = true },
            { covers = { "head" }, encumbrance = 0, coverage = 80 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "phase_immersion_cca",
        },
    },
}
