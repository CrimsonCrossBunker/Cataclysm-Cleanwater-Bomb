local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_cherry",
    name = ccb.content.plural_text("handful of potion fruits (cherries)", "handfuls of potion fruits (cherries)"),
    description = ccb.content.text("A handful of cherries infused with mana.  It will prevent you from bleeding."),
    copy_from = "cherries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_cherry" },
}
