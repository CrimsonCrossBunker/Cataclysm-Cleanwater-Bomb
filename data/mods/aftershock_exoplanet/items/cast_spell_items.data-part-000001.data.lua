local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_recall_rig",
    copy_from = "dimensional_anchor",
    name = ccb.content.plural_text("recall rig", "recall rigs"),
    description = ccb.content.text("A complex antennae assembly worn around the upper torso that allows its user to home and teleport towards previously configured teleport pads.  Although relatively functional, it's much inferior to the translocation systems of old, and a successful teleport requires standing perfectly still for several minutes."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "75 ml",
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_atomic_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1000 },
    armor = {},
    use_actions = { { kind = "cast_spell", spell = "afs_translocation_slow", no_fail = true, level = 1 } },
}
