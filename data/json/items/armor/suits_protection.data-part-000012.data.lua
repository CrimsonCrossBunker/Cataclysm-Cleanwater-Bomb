local ccb = require("ccb")

ccb.content.define_item {
    id = "xedra_artifact_cleansuit_on",
    copy_from = "xedra_artifact_cleansuit",
    name = ccb.content.plural_text("S02a hazmat suit (on)", "S02a hazmat suits (on)"),
    looks_like = "xedra_artifact_cleansuit",
    description = ccb.content.text("A bulky hazardous materials handling suit.  This one appears outfitted for the highest levels of protection, featuring built in oversized rubber gloves, sealed boot covers with a rubber sole, and an active temperature control system.  It's clearly designed to accommodate additional equipment, including self-contained breathing apparatuses or powered air purifying respirator systems.  Strange wiring snakes the entire garment, connecting to small electronic pads on all of the joints and the head.  A battery compartment marked with \"X.E.D.R.A PROTOTYPE S02a\" is attached to the back.  The device is currently switched on."),
    revert_to = "xedra_artifact_cleansuit",
    flags = {
        "OVERSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_PROOF", "ELECTRONIC", "TRADER_AVOID",
        "SPAWN_ACTIVE", "PORTAL_PROOF", "ELECTRIC_IMMUNE", "PSYSHIELD_PARTIAL", "SOFT", "OUTER",
    },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 100 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s stops vibrating."),
            target = "xedra_artifact_cleansuit",
        },
    },
}
