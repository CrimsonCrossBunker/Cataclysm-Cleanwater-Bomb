local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_strawberries",
    name = ccb.content.plural_text("handful of potion fruits (strawberries)", "handfuls of potion fruits (strawberries)"),
    description = ccb.content.text("A handful of strawberries infused with mana.  It will keep you warm even on an icy-cold day."),
    copy_from = "strawberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_strawberries" },
}
