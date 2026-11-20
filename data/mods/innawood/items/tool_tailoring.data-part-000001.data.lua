local ccb = require("ccb")

ccb.content.define_item {
    id = "sewing_kit",
    name = ccb.content.plural_text("sewing kit", "sewing kits"),
    description = ccb.content.text("This is a wrapped leather kit with a variety of needles, some wooden spools for thread, small scissors, and a few other useful textile tools.  Use a sewing kit on an article of clothing to attempt to repair or reinforce that clothing.  This uses your tailoring skill."),
    mass = "85 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "5 USD",
    accuracy = -1,
    materials = { "wood", "steel" },
    symbol = ",",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { thread = 200 } } },
    qualities = { { id = "SEW", level = 3 }, { id = "FABRIC_CUT", level = 1 }, { id = "CUT", level = 2 } },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "gutskin",
            },
            skill = "tailor",
            tool_quality = 0,
            cost_scaling = 0.1,
            move_cost = 1000,
        },
    },
}
