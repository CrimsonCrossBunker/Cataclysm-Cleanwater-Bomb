local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_apricot",
    name = ccb.content.plural_text("handful of potion fruits (apricots)", "handfuls of potion fruits (apricots)"),
    description = ccb.content.text("A handful of apricots infused with mana.  It will enhance your visual acuity."),
    copy_from = "apricot",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "20 days", on_consume = "consume_potion_fruit_apricot" },
}
