local ccb = require("ccb")

ccb.content.define_item {
    id = "potion_fruit_m_stellatum_berries",
    name = ccb.content.plural_text("potion fruit (starry false Solomon's seal berries)", "potion fruits (starry false Solomon's seal berries)"),
    description = ccb.content.text("A handful of starry false Solomon's seal berries infused with mana.  It will restore your mana."),
    copy_from = "m_stellatum_berries",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME" } }, scale = { quench = 0.5, calories = 0.5 } },
    comestible = { kind = "FOOD", shelf_life = "30 days", on_consume = "eat_potion_fruit_solomon_seal" },
}
