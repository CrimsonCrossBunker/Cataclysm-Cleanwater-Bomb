local ccb = require("ccb")

ccb.content.define_item {
    id = "cream_prot_cold",
    name = ccb.content.plural_text("heat retention cream", "heat retention cream"),
    description = ccb.content.text("Rub this on your skin when you are expecting exposure to extreme cold temperatures.  Cannot protect from instant frostbite.  Smells like the inside of a sheep."),
    mass = "265 g",
    volume = "250 ml",
    symbol = "q",
    default_container = "bottle_plastic_small",
    color = "light_blue",
    flags = { "EATEN_COLD" },
    phase = "solid",
    price = "25 USD",
    comestible = { fun = -1, kind = "MED" },
    use_actions = { { kind = "cast_spell", spell = "cream_prot_cold", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "cream_greater_prot_cold",
    name = ccb.content.plural_text("heat retention cream xtreme", "heat retention cream xtreme"),
    description = ccb.content.text("This product was advertised before the Cataclysm for extreme cold environment protection.  You remember a demonstration involving a woman coating her hand in this and plunging it in liquid nitrogen for a second.  You're pretty sure that was staged."),
    mass = "265 g",
    volume = "250 ml",
    symbol = "q",
    default_container = "bottle_plastic_small",
    color = "light_blue",
    flags = { "EATEN_COLD" },
    phase = "solid",
    price = "50 USD",
    comestible = { fun = -3, kind = "MED" },
    use_actions = { { kind = "cast_spell", spell = "cream_greater_prot_cold", no_fail = true, level = 0 } },
}
