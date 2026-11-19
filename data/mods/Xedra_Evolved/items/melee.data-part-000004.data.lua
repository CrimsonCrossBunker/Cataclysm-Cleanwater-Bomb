local ccb = require("ccb")

ccb.content.define_item {
    id = "pooka_gladius",
    name = ccb.content.plural_text("pooka gladius", "pooka gladii"),
    copy_from = "wakizashi",
    description = ccb.content.text("A gladius covered in the whorls of Celtic knots.  Sparks seems to pop off the edge of the blade."),
    flags = { "DURABLE_MELEE", "SHEATH_SWORD" },
    length = "60 cm",
    materials = { "moon_tears" },
    weapon_categories = { "SHORT_SWORDS" },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_pooka_gladius_0" } },
}
