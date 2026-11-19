local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_wintergreen",
    name = ccb.content.plural_text("handful of potion fruits (wintergreen berries)", "handfuls of potion fruits (wintergreen berries)"),
    description = ccb.content.text("A handful of wintergreen berries infused with mana.  It will allow you to see in the dark."),
    copy_from = "wintergreen_berry",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "25 days", on_consume = "consume_potion_fruit_wintergreen" },
}
