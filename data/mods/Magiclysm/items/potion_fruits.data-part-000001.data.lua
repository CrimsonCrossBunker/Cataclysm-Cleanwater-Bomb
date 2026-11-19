local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_blueberries",
    name = ccb.content.plural_text("handful of potion fruits (blueberries)", "handfuls of potion fruits (blueberries)"),
    description = ccb.content.text("A handful of blueberries infused with mana.  One handful is more satisfying than a whole bottle of water."),
    copy_from = "blueberries",
    comestible = { kind = "FOOD", quench = 100, shelf_life = "25 days" },
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { calories = 0.5 } },
}
