local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_mayapple",
    name = ccb.content.plural_text("potion fruit (mayapple)", "potion fruits (mayapple)"),
    description = ccb.content.text("A mayapple infused with mana.  It will allow you to eat questionable food without harm."),
    copy_from = "mayapple",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "20 days", on_consume = "consume_potion_fruit_mayapple" },
}
