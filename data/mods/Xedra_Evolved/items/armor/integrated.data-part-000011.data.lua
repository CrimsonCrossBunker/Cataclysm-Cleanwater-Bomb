local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_trow_fists",
    category = "armor",
    name = ccb.content.plural_text("stone fists", "stone fists"),
    description = ccb.content.text("Your thick skin and nails means your hands can be used as simple tools.  You also do slightly more damage when punching."),
    mass = "300 g",
    volume = "500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "fae_flesh" },
    symbol = ",",
    color = "brown",
    flags = { "INTEGRATED", "SEMITANGIBLE", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "PADDED" },
    qualities = {
        { id = "HAMMER", level = 2 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "PRYING_NAIL", level = 1 },
        { id = "PRY", level = 2 },
    },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_trow_stone_fists" } },
}
