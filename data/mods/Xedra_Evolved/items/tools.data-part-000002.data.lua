local ccb = require("ccb")

ccb.content.define_item {
    id = "hammer_bronze",
    copy_from = "hammer_bronze",
    qualities = {
        { id = "FEY_HAMMER", level = 3 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
    },
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "moon_tears", "moon_tears_fine_chain" },
            skill = "fabrication",
            tool_quality = -3,
            cost_scaling = 0.1,
            move_cost = 100,
        },
    },
}

ccb.content.define_item {
    id = "revenant_effigy",
    name = ccb.content.plural_text("revenant's effigy", "revenant's effigy"),
    description = "A macabre effigy made of meat and bone, with a heart filled with glass and faewild dust.  When the full moon will shine upon it, you will be able to use it to summon the Luna-attuned revenant.",
    symbol = "%",
    color = "magenta",
    mass = "91500 g",
    volume = "72500 ml",
    tool = {},
}
