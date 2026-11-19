local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_ierde_fists",
    category = "armor",
    name = ccb.content.plural_text("stone fists", "stone fists"),
    description = ccb.content.text("Your stone-like skin means your hands hit like hammers, and can be used like hammers as well."),
    mass = "300 g",
    volume = "500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "stone" },
    symbol = ",",
    color = "brown",
    flags = { "INTEGRATED", "SEMITANGIBLE", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "PADDED" },
    qualities = {
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "PRYING_NAIL", level = 1 },
        { id = "PRY", level = 2 },
    },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_ierde_stone_fists" } },
}
