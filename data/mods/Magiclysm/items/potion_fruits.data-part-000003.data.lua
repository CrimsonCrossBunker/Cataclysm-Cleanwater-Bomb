local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_blackberries",
    name = ccb.content.plural_text("handful of potion fruits (blackberries)", "handfuls of potion fruits (blackberries)"),
    description = ccb.content.text("A handful of blackberries infused with mana.  It will harm those who attack you if you eat it."),
    copy_from = "blackberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_blackberries" },
}
