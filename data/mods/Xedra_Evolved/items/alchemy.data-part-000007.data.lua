local ccb = require("ccb")

ccb.content.define_item {
    id = "life_extension_potion",
    name = ccb.content.plural_text("life extension potion", "life extension potions"),
    description = ccb.content.text("A source of considerable wealth for the few alchemists talented enough to distill them, these potions are capable of adding decades to the lifespan of those who can afford the price of the rare and expensive ingredients they require.  They are however not able to prolong a life indefinitely beyond its natural years, and you will need to find other means to achieve immortality, if that is your goal."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_life_extension" },
}

ccb.content.define_item {
    id = "gender_potion",
    name = ccb.content.plural_text("gender change potion", "gender change potions"),
    description = ccb.content.text("This is a potion of change.  It will turn you into the opposite gender.  Turn into your true self, or otherwise experience what lies within the opposite gender."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 3, fun = -1, on_consume = "drink_gender_potion" },
}

ccb.content.define_item {
    id = "potion_dex",
    name = ccb.content.plural_text("potion of wicked quick hands", "potions of wicked quick hands"),
    description = ccb.content.text("This is a potion of wicked quick hands.  It will increase your dexterity for 50 minutes."),
    copy_from = "life_extension_potion",
    color = "green",
    price = "30 USD",
    comestible = { calories = 25 },
    use_actions = { { kind = "cast_spell", spell = "wicked_quick_hands", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "potion_strength",
    name = ccb.content.plural_text("potion of terrible strength", "potions of terrible strength"),
    description = ccb.content.text("This is a potion of terrible strength.  It will increase your strength for 50 minutes."),
    color = "red",
    copy_from = "life_extension_potion",
    comestible = { calories = 50 },
    use_actions = { { kind = "cast_spell", spell = "terrible_strength", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "hares_leap_potion",
    name = ccb.content.plural_text("potion of hare's leap", "potions of hare's leap"),
    description = ccb.content.text("This is a potion of hare's leap.  It allows you to jump afar from danger."),
    color = "green_yellow",
    copy_from = "life_extension_potion",
    comestible = { calories = 50 },
    use_actions = { { kind = "cast_spell", spell = "spell_hare_leap", no_fail = true, level = 0 } },
}
