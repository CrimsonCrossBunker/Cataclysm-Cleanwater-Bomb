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

ccb.content.define_item {
    id = "atomic_butter",
    name = ccb.content.plural_text("atomic butter", "atomic butter"),
    mass = "14180 mg",
    color = "yellow",
    symbol = "%",
    default_container = "wrapper",
    description = ccb.content.text("A yellow stick of milkfat and milk solids, made from cow's milk and the power of the atom.  All radiation levels are confirmed to be in line with background exposure and any cancers later in life have nothing to do with this butter or any products made with this butter.  By consuming this butter you indemnify and hold harmless the Rivtech Corporation, its parent company and subsidiaries and any agents, directors or officers of the Rivtech Corporation from any losses or damages that may occur as a result of consuming this butter in any form or fashion."),
    price = "9 cent",
    survival_price = "23 cent",
    materials = { "milk" },
    volume = "15 ml",
    flags = { "NO_AUTO_CONSUME" },
    comestible = {
        shelf_life = "14 days",
        kind = "FOOD",
        quench = -1,
        calories = 101,
        fun = -1,
        vitamins = { { id = "milk_allergen", amount = 1 } },
    },
}
