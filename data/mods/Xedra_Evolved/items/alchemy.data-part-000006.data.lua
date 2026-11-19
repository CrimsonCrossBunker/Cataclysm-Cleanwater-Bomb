local ccb = require("ccb")

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
