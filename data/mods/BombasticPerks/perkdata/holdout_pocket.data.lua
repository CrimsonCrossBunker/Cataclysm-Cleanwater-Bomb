local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_holdout_pocket",
    category = "armor",
    name = ccb.content.plural_text("holdout pocket", "holdout pocket"),
    description = ccb.content.text("A secret pocket no one knows about that can easily store a weapon."),
    volume = "10 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh" },
    symbol = "x",
    color = "magenta",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "NO_SALVAGE" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "300 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            moves = 120,
            volume_encumbrance = 0.3,
        },
    },
    armor = { portions = { { covers = { "torso" }, coverage = 0, encumbrance = 0 } } },
    use_actions = { { kind = "holster" } },
}
