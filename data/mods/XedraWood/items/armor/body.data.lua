local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_lamellar_bronze",
    copy_from = "armor_lamellar_lc",
    materials = { "bronze" },
    name = ccb.content.plural_text("bronze lamellar cuirass", "bronze lamellar cuirasses"),
    description = ccb.content.text("A cuirass made of small strips of bronze laced together, heavier but more protective than leather."),
    replace_materials = { lc_steel = "bronze" },
    armor = {},
}
