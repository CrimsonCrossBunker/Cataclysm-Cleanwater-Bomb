local ccb = require("ccb")

ccb.content.define_item {
    id = "electric_masonrysaw_off",
    name = ccb.content.plural_text("electric masonry saw (off)", "electric masonry saws (off)"),
    description = ccb.content.text("A construction tool for cutting through concrete or other surfaces.  It uses electric motor with integrated battery and is compatible with a UPS.  Using this item will cause it to turn on, turning it into a very powerful but unwieldy melee weapon or a terrible chainsaw."),
    mass = "4500 g",
    volume = "2500 ml",
    length = "25 cm",
    price = "80 USD",
    survival_price = "5 USD",
    accuracy = { grip = "solid", length = "long", surface = "line", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = "/",
    color = "blue",
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 2970 }, rigid = true } },
    techniques = { "SWEEP" },
    flags = {
        "NONCONDUCTIVE",
        "FRAGILE_MELEE",
        "USE_UPS",
        "NO_UNLOAD",
        "NO_RELOAD",
        "WATER_BREAK",
        "ELECTRONIC",
    },
    faults = { { group = "electronic_general" } },
    melee_damage = { bash = 4 },
    tool = { charges_per_use = 5, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "electric_masonrysaw_on",
            message = ccb.content.text("You turn on the %s."),
        },
        {
            kind = "link_up",
            menu_text = ccb.content.text("Plug in / Unplug"),
            ammo_scale = 0,
            cable_length = 33,
            charge_rate = "2200 W",
        },
    },
}
