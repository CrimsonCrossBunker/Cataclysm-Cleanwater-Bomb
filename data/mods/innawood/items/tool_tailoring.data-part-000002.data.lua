local ccb = require("ccb")

ccb.content.define_item {
    id = "fibercloth_patchwork",
    category = "spare_parts",
    name = ccb.content.plural_text("fibercloth patch", "fibercloth patches"),
    description = ccb.content.text("A 6 inch square fibercloth patch, suitable for use in repairing and tailoring of clothing."),
    mass = "5 g",
    volume = "6 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "fibercloth" },
    symbol = ",",
    color = "green",
    flags = { "NO_SALVAGE" },
    tool = {},
    use_actions = {
        {
            kind = "heal",
            moves = 200,
            bleed = 1,
            byproduct = { id = "fibercloth_patchwork", quantity = 1, flags = { "FILTHY" } },
        },
        "WASH_HARD_ITEMS",
    },
}
