local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_mindsight_glasses_on",
    category = "clothing",
    copy_from = "psionic_mindsight_glasses",
    name = ccb.content.plural_text("QD944-P 'Mindsight' glasses (on)", "sets of QD944-P 'Mindsight' glasses (on)"),
    description = ccb.content.text("A set of AR-looking glasses.  The code \"QD944-P\" is printed in small letters on the temples.  They are currently active."),
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "3500 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "psionic_mindsight_glasses",
        },
    },
}
