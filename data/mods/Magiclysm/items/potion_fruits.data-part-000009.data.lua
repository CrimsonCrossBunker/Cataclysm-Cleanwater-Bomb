local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_huckleberries",
    name = ccb.content.plural_text("handful of potion fruits (huckleberries)", "handfuls of potion fruits (huckleberries)"),
    description = ccb.content.text("A handful of huckleberries infused with mana.  It will make you much more flexible."),
    copy_from = "huckleberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_huckleberries" },
}
