local ccb = require("ccb")

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
