local ccb = require("ccb")

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "cigar_lit",
    name = ccb.content.plural_text("cigar", "cigars"),
    color = "brown",
    symbol = "!",
    description = ccb.content.text("The smoke billowing from this cigar has a sweet, musty odor."),
    mass = "9 g",
    volume = "15 ml",
    category = "drugs",
    emissions = { "emit_tobacco_trail" },
    revert_to = "cigar_butt",
    materials = { "paper" },
    light = 8,
    flags = { "LITCIG", "TOBACCO", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 6,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 25,
                coverage = 70,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "cigar_butt",
            message = ccb.content.text("You extinguish the cigar."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "cig_lit",
    name = ccb.content.plural_text("cigarette", "cigarettes"),
    color = "white",
    symbol = "!",
    description = ccb.content.text("Smoke swirls from the lit end of this cigarette, filling the air with the thrilling smell of burning chemicals."),
    mass = "1 g",
    volume = "4 ml",
    category = "drugs",
    emissions = { "emit_tobacco_trail" },
    revert_to = "cig_butt",
    materials = { "paper" },
    light = 2,
    flags = { "LITCIG", "TOBACCO", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 3,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 15,
                coverage = 25,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "cig_butt",
            message = ccb.content.text("You extinguish the cigarette."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "joint_lit",
    name = ccb.content.plural_text("joint", "joints"),
    color = "light_green",
    symbol = "!",
    description = ccb.content.text("The smell of skunk permeates the air as a thin trail of smoke floats off of this joint."),
    mass = "1 g",
    volume = "4 ml",
    category = "drugs",
    emissions = { "emit_joint_trail" },
    revert_to = "joint_roach",
    materials = { "paper" },
    light = 2,
    flags = { "LITCIG", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 3,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 15,
                coverage = 25,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "joint_roach",
            message = ccb.content.text("You extinguish the joint."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}
