local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_pat_transponder_on",
    copy_from = "integrated_pat_transponder",
    name = ccb.content.plural_text("Infolink: Pat's Transponder (on)", "Infolink: Pat's Transponder (on)"),
    description = ccb.content.text("Custom software installed on your Infolink CBM for connecting to Pat's radio frequency.  If you have an integrated AR system CBM, or a compatible AR headset, this will put you in constant contact with Pat.  It is currently active.  Activate it to turn it off."),
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Disconnect from Pat's system and stop transmitting data"),
            message = ccb.content.text("You switch off the transponder."),
            target = "integrated_pat_transponder",
        },
    },
}
