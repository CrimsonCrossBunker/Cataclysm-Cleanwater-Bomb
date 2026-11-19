local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_peach",
    name = ccb.content.plural_text("potion fruit (peach)", "potion fruits (peach)"),
    description = ccb.content.text("A peach infused with mana.  It will cure illness if you eat it."),
    copy_from = "peach",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "30 days", on_consume = "consume_potion_fruit_peach" },
}
