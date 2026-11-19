local ccb = require("ccb")

ccb.content.define_item {
    id = "migo_skin",
    name = ccb.content.plural_text("second skin", "second skins"),
    description = ccb.content.text("A slimy layer of liquid has completely engulfed your body from the neck down and seems to move with you - the sensation is uncomfortable.  The liquid appears bound to the resonating collar at your neck; the inside of the collar reads \"CAREFUL CHOKING HAZARD!  THIS WAY DOWN\".  The ooze flows freely, covering your entire body but never crossing the gorget to get to your head."),
    mass = "1500 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "4 USD",
    materials = { "alien_liquid", "unobtanium" },
    symbol = "[",
    looks_like = "union_suit",
    color = "white",
    flags = { "SKINTIGHT", "STURDY", "TRADER_AVOID", "FILTHY", "NO_CLEAN", "SOFT", "OVERSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "unobtanium", coverage = 10, thickness = 0.5 },
                    { id = "alien_liquid", coverage = 100, thickness = 1 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "unobtanium", coverage = 85, thickness = 0.5 },
                    { id = "alien_liquid", coverage = 100, thickness = 1 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "alien_liquid", coverage = 100, thickness = 1 } },
                covers = { "torso", "arm_l", "arm_r" },
                subparts = {
                    "torso_lower",
                    "arm_upper_l",
                    "arm_elbow_l",
                    "arm_lower_l",
                    "arm_upper_r",
                    "arm_elbow_r",
                    "arm_lower_r",
                },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = { { id = "alien_liquid", coverage = 100, thickness = 1 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r", "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 2,
            },
        },
        warmth = 1,
        thickness = 1,
        environmental_protection = 5,
    },
    use_actions = {
        {
            kind = "transform",
            target = "migo_skin_off",
            message = ccb.content.text("The gorget hums and the liquid gets sucked back into it."),
            menu_text = ccb.content.text("Deactivate"),
        },
    },
}

ccb.content.define_item {
    id = "migo_skin_off",
    name = ccb.content.plural_text("resonating gorget", "resonating gorgets"),
    description = ccb.content.text("A heavy-duty gorget or collar made from odd materials that hums slightly.  It feels damp to the touch and there is a mechanical button of some kind on the front.  The inside reads \"CAREFUL CHOKING HAZARD!  THIS WAY DOWN\"."),
    mass = "1500 g",
    volume = "100 ml",
    price = "25 USD",
    survival_price = "4 USD",
    materials = { "unobtanium" },
    symbol = "[",
    looks_like = "silver_necklace",
    color = "white",
    flags = { "SKINTIGHT", "STURDY", "TRADER_AVOID", "SOFT" },
    armor = {
        portions = {
            {
                materials = { { id = "unobtanium", coverage = 100, thickness = 0.5 } },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 10,
                encumbrance = 0,
            },
            {
                materials = { { id = "unobtanium", coverage = 100, thickness = 0.5 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 85,
                encumbrance = 0,
            },
        },
        warmth = 1,
        thickness = 1,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            need_worn = true,
            target = "migo_skin",
            message = ccb.content.text("Murky ooze begins to leak out of the gorget and engulf your body from the neck down!"),
            menu_text = ccb.content.text("Activate"),
        },
    },
}
