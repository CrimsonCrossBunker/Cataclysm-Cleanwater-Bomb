local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_apple",
    name = ccb.content.plural_text("potion fruit (apple)", "potion fruits (apple)"),
    description = ccb.content.text("An apple infused with mana.  It will heal you if you eat it."),
    copy_from = "apple",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "66 days 16 hours", on_consume = "consume_potion_fruit_apple" },
}

ccb.content.define_item {
    id = "potion_fruit_peach",
    name = ccb.content.plural_text("potion fruit (peach)", "potion fruits (peach)"),
    description = ccb.content.text("A peach infused with mana.  It will cure illness if you eat it."),
    copy_from = "peach",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "30 days", on_consume = "consume_potion_fruit_peach" },
}

ccb.content.define_item {
    id = "potion_fruit_pear",
    name = ccb.content.plural_text("potion fruit (pear)", "potion fruits (pear)"),
    description = ccb.content.text("A pear infused with mana.  It will allow your blows to strike quicker if you eat it."),
    copy_from = "pear",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "40 days", on_consume = "consume_potion_fruit_pear" },
}

ccb.content.define_item {
    id = "potion_fruit_blackberries",
    name = ccb.content.plural_text("handful of potion fruits (blackberries)", "handfuls of potion fruits (blackberries)"),
    description = ccb.content.text("A handful of blackberries infused with mana.  It will harm those who attack you if you eat it."),
    copy_from = "blackberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_blackberries" },
}

ccb.content.define_item {
    id = "potion_fruit_raspberries",
    name = ccb.content.plural_text("handful of potion fruits (raspberries)", "handfuls of potion fruits (raspberries)"),
    description = ccb.content.text("A handful of raspberries infused with mana.  It will lessen your pain if you eat it."),
    copy_from = "raspberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_raspberries" },
}

ccb.content.define_item {
    id = "potion_fruit_strawberries",
    name = ccb.content.plural_text("handful of potion fruits (strawberries)", "handfuls of potion fruits (strawberries)"),
    description = ccb.content.text("A handful of strawberries infused with mana.  It will keep you warm even on an icy-cold day."),
    copy_from = "strawberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_strawberries" },
}

ccb.content.define_item {
    id = "potion_fruit_elderberries",
    name = ccb.content.plural_text("handful of potion fruits (elderberries)", "handfuls of potion fruits (elderberries)"),
    description = ccb.content.text("A handful of elderberries infused with mana.  It will keep you alert and awake."),
    copy_from = "elderberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_elderberries" },
}

ccb.content.define_item {
    id = "potion_fruit_blueberries",
    name = ccb.content.plural_text("handful of potion fruits (blueberries)", "handfuls of potion fruits (blueberries)"),
    description = ccb.content.text("A handful of blueberries infused with mana.  One handful is more satisfying than a whole bottle of water."),
    copy_from = "blueberries",
    comestible = { kind = "FOOD", quench = 100, shelf_life = "25 days" },
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { calories = 0.5 } },
}

ccb.content.define_item {
    id = "potion_fruit_cranberries",
    name = ccb.content.plural_text("handful of potion fruits (cranberries)", "handfuls of potion fruits (cranberries)"),
    description = ccb.content.text("A handful of cranberries infused with mana.  It will remove impurities in your blood."),
    copy_from = "cranberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_cranberries" },
}

ccb.content.define_item {
    id = "potion_fruit_huckleberries",
    name = ccb.content.plural_text("handful of potion fruits (huckleberries)", "handfuls of potion fruits (huckleberries)"),
    description = ccb.content.text("A handful of huckleberries infused with mana.  It will make you much more flexible."),
    copy_from = "huckleberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_huckleberries" },
}

ccb.content.define_item {
    id = "potion_fruit_wintergreen",
    name = ccb.content.plural_text("handful of potion fruits (wintergreen berries)", "handfuls of potion fruits (wintergreen berries)"),
    description = ccb.content.text("A handful of wintergreen berries infused with mana.  It will allow you to see in the dark."),
    copy_from = "wintergreen_berry",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_wintergreen" },
}

ccb.content.define_item {
    id = "potion_fruit_cherry",
    name = ccb.content.plural_text("handful of potion fruits (cherries)", "handfuls of potion fruits (cherries)"),
    description = ccb.content.text("A handful of cherries infused with mana.  It will prevent you from bleeding."),
    copy_from = "cherries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_cherry" },
}

ccb.content.define_item {
    id = "potion_fruit_apricot",
    name = ccb.content.plural_text("handful of potion fruits (apricots)", "handfuls of potion fruits (apricots)"),
    description = ccb.content.text("A handful of apricots infused with mana.  It will enhance your visual acuity."),
    copy_from = "apricot",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "20 days", on_consume = "consume_potion_fruit_apricot" },
}

ccb.content.define_item {
    id = "potion_fruit_grapes",
    name = ccb.content.plural_text("handful of potion fruits (grapes)", "handfuls of potion fruits (grapes)"),
    description = ccb.content.text("A handful of grapes infused with mana.  It will cure intoxication."),
    copy_from = "grapes",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "20 days", on_consume = "eat_potion_fruit_grapes" },
}

ccb.content.define_item {
    id = "potion_fruit_mayapple",
    name = ccb.content.plural_text("potion fruit (mayapple)", "potion fruits (mayapple)"),
    description = ccb.content.text("A mayapple infused with mana.  It will allow you to eat questionable food without harm."),
    copy_from = "mayapple",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "20 days", on_consume = "consume_potion_fruit_mayapple" },
}

ccb.content.define_item {
    id = "potion_fruit_m_stellatum_berries",
    name = ccb.content.plural_text("potion fruit (starry false Solomon's seal berries)", "potion fruits (starry false Solomon's seal berries)"),
    description = ccb.content.text("A handful of starry false Solomon's seal berries infused with mana.  It will restore your mana."),
    copy_from = "m_stellatum_berries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "30 days", on_consume = "eat_potion_fruit_solomon_seal" },
}
