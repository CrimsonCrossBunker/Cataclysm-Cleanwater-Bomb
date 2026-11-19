local ccb = require("ccb")

ccb.content.define_item {
    id = "oil_lamp",
    name = ccb.content.plural_text("kerosene lamp (off)", "kerosene lamps (off)"),
    description = ccb.content.text("A kerosene-fueled lamp.  It does not provide much light, but it lasts a long time.  Use it to turn it on."),
    mass = "1720 g",
    volume = "1 L",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "glass", "iron" },
    symbol = ";",
    color = "yellow",
    pockets = { { kind = "MAGAZINE", watertight = true, ammunition = { lamp_oil = 750 } } },
    flags = { "ALLOWS_REMOTE_USE" },
    melee_damage = { bash = 1 },
    tool = { charges_per_use = 1, ammo_types = { "lamp_oil" } },
    use_actions = {
        {
            kind = "transform",
            target = "oil_lamp_on",
            menu_text = ccb.content.text("Light", "verb"),
            message = ccb.content.text("You light the lamp."),
            need_fire = 1,
            need_charges = 1,
            need_charges_message = ccb.content.text("The lamp is empty."),
        },
    },
}
