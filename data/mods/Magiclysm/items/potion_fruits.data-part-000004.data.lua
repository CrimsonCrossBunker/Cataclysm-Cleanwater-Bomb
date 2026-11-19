local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_raspberries",
    name = ccb.content.plural_text("handful of potion fruits (raspberries)", "handfuls of potion fruits (raspberries)"),
    description = ccb.content.text("A handful of raspberries infused with mana.  It will lessen your pain if you eat it."),
    copy_from = "raspberries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_raspberries" },
}
