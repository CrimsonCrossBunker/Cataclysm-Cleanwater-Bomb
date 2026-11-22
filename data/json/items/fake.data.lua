local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_pat_radio",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Infolink: Call Pat", "Infolink: Call Pat"),
    description = "Custom software installed in your Infolink CBM for talking to Pat on your agreed-upon radio frequency.  Activate it to hail Pat.",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "integrated_pat_transponder",
    copy_from = "fake_item",
    name = ccb.content.plural_text("Infolink: Pat's Transponder (off)", "Infolink: Pat's Transponder (off)"),
    description = "Custom software installed on your Infolink CBM for connecting to Pat's radio frequency.  If you have an integrated AR system CBM, or a compatible AR headset, activating this will put you in constant contact with Pat.  It is currently inactive.  Activate it to turn it on.",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_REPAIR", "ALLOWS_NATURAL_ATTACKS" },
    use_actions = {
        {
            kind = "transform",
            target = "integrated_pat_transponder_on",
            message = "You switch on the transponder.",
            menu_text = "Connect to Pat's system and start transmitting data",
        },
    },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
}
