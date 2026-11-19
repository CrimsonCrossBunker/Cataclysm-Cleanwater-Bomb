local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_apple",
    name = ccb.content.plural_text("potion fruit (apple)", "potion fruits (apple)"),
    description = ccb.content.text("An apple infused with mana.  It will heal you if you eat it."),
    copy_from = "apple",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "66 days 16 hours", on_consume = "consume_potion_fruit_apple" },
}
