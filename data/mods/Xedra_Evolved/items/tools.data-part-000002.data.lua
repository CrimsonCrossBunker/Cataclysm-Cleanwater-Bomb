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
