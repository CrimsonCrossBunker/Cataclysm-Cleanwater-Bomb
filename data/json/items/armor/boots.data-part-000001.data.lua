local ccb = require("ccb")

ccb.content.define_item {
    id = "boots_western",
    copy_from = "boots",
    name = ccb.content.plural_text("western boots (pair)", "western boots (pair)"),
    description = ccb.content.text("Stiff leather boots with intricate embroidery and one-inch heels.  They look good, but these boots are made for walking, not running for your life.  Each boot is large enough to conceal a small holdout pistol."),
    survival_price = "7 USD 50 cent",
    materials = { "leather" },
    pockets = {
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "600 g", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "600 g", moves = 80 },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2, price = 2, encumbrance = 2 } },
    armor = {
        thickness = 2.5,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                encumbrance = 12,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 20, thickness = 21.0 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = { { kind = "holster" } },
}
