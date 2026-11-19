local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_pear",
    name = ccb.content.plural_text("potion fruit (pear)", "potion fruits (pear)"),
    description = ccb.content.text("A pear infused with mana.  It will allow your blows to strike quicker if you eat it."),
    copy_from = "pear",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "40 days", on_consume = "consume_potion_fruit_pear" },
}
