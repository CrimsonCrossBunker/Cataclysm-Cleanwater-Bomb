local ccb = require("ccb")

ccb.content.define_item {
    id = "pat_earpiece",
    name = ccb.content.plural_text("transponder earpiece (off)", "transponder earpieces (off)"),
    description = "An earpiece with an inline transponder and two small cables custom-fit for AR headsets.  If you have a compatible headset and it is switched on, Pat can keep track of you and communicate via radio.  Active it to switch it on, or to call Pat.",
    symbol = ";",
    color = "green",
    mass = "10 g",
    volume = "10 ml",
    price = "20 USD",
    survival_price = "7 USD 50 cent",
    flags = {
        "ELECTRONIC",
        "OVERSIZE",
        "POWERARMOR_COMPATIBLE",
        "SKINTIGHT",
        "TRADER_AVOID",
        "SOFT",
    },
    materials = { "plastic" },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        {
            kind = "transform",
            target = "pat_earpiece_on",
            message = "You switch on the transponder.",
            menu_text = "Connect to Pat's system and start transmitting data",
        },
    },
    tool = {},
    armor = {
        thickness = 1,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_ear_l" },
                coverage = 10,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "pat_earpiece_on",
    copy_from = "pat_earpiece",
    name = ccb.content.plural_text("transponder earpiece (on)", "transponder earpieces (on)"),
    description = "An earpiece with an inline transponder and two small cables custom-fit for AR headsets.  If you have a compatible headset and it is switched on, Pat can keep track of you and communicate via radio.  It is currently active.  Active it to switch it off, or to call Pat.",
    use_actions = {
        {
            kind = "transform",
            target = "pat_earpiece",
            message = "You switch off the transponder.",
            menu_text = "Disconnect from Pat's system and stop transmitting data",
        },
    },
    tool = {},
    armor = {},
    subtype_order = { "tool", "armor" },
    inheritance = {
        add = {
            flags = { "SPAWN_ACTIVE" },
        },
    },
}

ccb.content.define_item {
    id = "balthazar_radio",
    name = "modified radio",
    description = "A modified portable radio.  A mess of metal and wires has been attached to the back and the frequency dial has been removed.",
    symbol = ";",
    color = "light_gray",
    mass = "325 g",
    volume = "1250 ml",
    price = "10 USD",
    survival_price = "2 USD",
    flags = { "WATER_BREAK", "ELECTRONIC" },
    materials = { "plastic", "aluminum" },
    melee_damage = { bash = 6 },
    faults = {
        { group = "electronic_general" },
    },
    tool = {},
}
