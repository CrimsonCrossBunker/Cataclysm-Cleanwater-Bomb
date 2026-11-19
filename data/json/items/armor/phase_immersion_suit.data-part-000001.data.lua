local ccb = require("ccb")

ccb.content.define_item {
    id = "phase_immersion_suit_on",
    copy_from = "phase_immersion_suit",
    name = ccb.content.plural_text("phase immersion suit (on)", "phase immersion suits (on)"),
    looks_like = "phase_immersion_suit",
    description = ccb.content.text("Covered in interlocking plates of reflective metal, this advanced suit resembles both plate armor and an astronaut's spacesuit.  It is turned on, and continually draining power.  Use it to turn it off."),
    revert_to = "phase_immersion_suit",
    flags = {
        "RAD_PROOF", "PORTAL_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "ELECTRIC_IMMUNE", "GAS_PROOF",
        "TRADER_AVOID", "NO_REPAIR", "NANOFAB_REPAIR", "PADDED", "USE_UPS", "NO_UNLOAD",
        "COMBAT_TOGGLEABLE", "UNBREAKABLE_MELEE", "SPAWN_ACTIVE", "SCBA",
    },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 50 },
    armor = { environmental_protection = 80 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Suit shutting down."),
            target = "phase_immersion_suit",
        },
    },
}
