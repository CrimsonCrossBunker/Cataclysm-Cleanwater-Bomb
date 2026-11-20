local ccb = require("ccb")

ccb.content.define_item {
    id = "oil_lamp_clay",
    name = ccb.content.plural_text("clay oil lamp (off)", "clay oil lamps (off)"),
    description = ccb.content.text("A specialized small clay container with a wick, an ancient form of oil lamp.  Unlike newer designs, it isn't windproof, so the flame is likely to be extinguished if exposed to wind; better use it indoors.  It does not provide much light, but it lasts a long time.  Use it to light it."),
    mass = "620 g",
    volume = "300 ml",
    price = "8 USD",
    survival_price = "1 USD",
    materials = { "clay" },
    symbol = ";",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE",
            watertight = true,
            ammunition = { crude_lamp_oil = 250, lamp_oil = 250 },
        },
    },
    flags = { "ALLOWS_REMOTE_USE" },
    melee_damage = { bash = 1 },
    tool = { charges_per_use = 1, ammo_types = { "crude_lamp_oil", "lamp_oil" } },
    use_actions = {
        {
            kind = "transform",
            target = "oil_lamp_clay_on",
            menu_text = ccb.content.text("Light", "verb"),
            message = ccb.content.text("You light the lamp."),
            need_fire = 1,
            need_charges = 1,
            need_charges_message = ccb.content.text("The lamp is empty."),
        },
    },
}
