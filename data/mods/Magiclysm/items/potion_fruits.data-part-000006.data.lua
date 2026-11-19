local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_elderberries",
    name = ccb.content.plural_text("handful of potion fruits (elderberries)", "handfuls of potion fruits (elderberries)"),
    description = ccb.content.text("A handful of elderberries infused with mana.  It will keep you alert and awake."),
    copy_from = "elderberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_elderberries" },
}
