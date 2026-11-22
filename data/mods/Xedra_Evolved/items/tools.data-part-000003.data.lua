local ccb = require("ccb")

ccb.content.define_item {
    id = "hammer_fey_smith",
    copy_from = "hammer_peen",
    name = "fey smith's hammer",
    description = "This blacksmith's hammer is so full of delicate carvings and filigree it seems like it would snap at the first blow against heated metal.  Despite that, it doesn't have a single scratch or mark on it.",
    materials = {
        { id = "wood", portions = 5 },
        { id = "moon_tears" },
    },
    qualities = {
        { id = "FEY_HAMMER", level = 3, speed = 0.75 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            skill = "fabrication",
            tool_quality = 1,
            move_cost = 100,
            cost_scaling = 0.1,
            materials = { "moon_tears", "moon_tears_fine_chain" },
        },
    },
    tool = {},
}
