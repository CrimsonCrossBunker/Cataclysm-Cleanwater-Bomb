local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_cranberries",
    name = ccb.content.plural_text("handful of potion fruits (cranberries)", "handfuls of potion fruits (cranberries)"),
    description = ccb.content.text("A handful of cranberries infused with mana.  It will remove impurities in your blood."),
    copy_from = "cranberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_cranberries" },
}
