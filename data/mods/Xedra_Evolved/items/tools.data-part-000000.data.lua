local ccb = require("ccb")

ccb.content.define_item {
    id = "tailors_kit",
    name = ccb.content.plural_text("tailor's kit", "tailor's kits"),
    description = ccb.content.text("This is a high quality kit consisting of a variety of needles, some wooden spools for thread, some small scissors, and an awl.  Use a tailor's kit to customize your clothing and armor.  This uses your tailoring skill."),
    mass = "100 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "10 USD",
    materials = { "wood", "steel" },
    symbol = ";",
    color = "red",
    qualities = {
        { id = "SEW", level = 4 },
        { id = "SEW_CURVED", level = 1 },
        { id = "KNIT", level = 1 },
        { id = "LEATHER_AWL", level = 2 },
        { id = "CUT", level = 2 },
        { id = "FABRIC_CUT", level = 2 },
    },
    pockets = { { kind = "MAGAZINE", ammunition = { thread = 400 } } },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = { crafting_subtype = "sewing_kit", charges_per_use = 1, ammo_types = { "thread" } },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "neoprene", "gutskin", "canvas", "denim", "fae_fur",
            },
            skill = "tailor",
            tool_quality = 1,
            cost_scaling = 0.1,
            move_cost = 800,
        },
    },
}
