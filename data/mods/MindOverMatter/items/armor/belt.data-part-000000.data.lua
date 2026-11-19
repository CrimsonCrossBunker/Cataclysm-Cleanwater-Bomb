local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_shield_belt_on",
    name = ccb.content.plural_text("shield belt (active)", "shield belts (active)"),
    copy_from = "psionic_shield_belt",
    revert_to = "psionic_shield_belt",
    inheritance = { add = { flags = { "NO_TAKEOFF", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "150 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "psionic_shield_belt",
            message = ccb.content.text("You flip the switch on the box and the red LED turns off."),
            menu_text = ccb.content.text("Flip the switch"),
            moves = 75,
        },
    },
}
