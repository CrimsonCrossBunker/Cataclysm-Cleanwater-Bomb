local ccb = require("ccb")

ccb.content.define_item {
    id = "tshirt",
    symbol = "[",
    color = "blue",
    looks_like = "tank_top",
    name = ccb.content.text("t-shirt"),
    description = ccb.content.text("Casual garment covering the torso."),
    materials = { "nylon" },
    mass = "150 g",
    volume = "150 ml",
    price = "1 USD",
    survival_price = "50 cent",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        portions = {
            { coverage = 100, covers = { "torso" } },
            {
                coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                coverage = 40,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "long_tshirt",
    copy_from = "tshirt",
    name = ccb.content.text("long sleeve t-shirt"),
    description = ccb.content.text("Casual garment covering the torso and arms."),
    armor = {
        portions = {
            { coverage = 100, covers = { "torso" } },
            { coverage = 100, covers = { "arm_l", "arm_r" } },
        },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2 }, offset = { warmth = 2 } },
}

ccb.content.define_item {
    id = "tank_top",
    copy_from = "tshirt",
    name = ccb.content.text("tank top"),
    description = ccb.content.text("Breathable shirt leaving the shoulders exposed, it has an all-around loose cut."),
    armor = {
        portions = {
            { coverage = 100, covers = { "torso" }, subparts = { "torso_lower" } },
            { coverage = 80, covers = { "torso" }, subparts = { "torso_upper" } },
        },
    },
    inheritance = { scale = { mass = 0.8, volume = 0.8 }, offset = { warmth = -2 } },
}
