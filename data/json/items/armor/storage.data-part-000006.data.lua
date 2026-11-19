local ccb = require("ccb")

-- Based on Pelican 1495 Protector Laptop Case
ccb.content.define_item {
    id = "laptop_hard_case",
    name = ccb.content.plural_text("laptop hard case", "laptop hard cases"),
    description = ccb.content.text("A rugged hard case for a laptop, frequently used by military, scientists, and others working in the field.  This model is waterproof and lined with impact-resistant foam.  The shoulder strap is current cinched up so it can be carried by hand.  Activate it to extend the shoulder strap."),
    mass = "3800 g",
    volume = "29740 ml",
    length = "55 cm",
    price = "240 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "plastic_shopping_bag",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            fire_protection = true,
            capacity = "16 L",
            mass_limit = "30 kg",
            max_item_length = "48 cm",
            moves = 200,
        },
    },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY", "STURDY" },
    accuracy = { grip = "none", length = "long", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 8 },
    armor = {
        sided = true,
        thickness = 6,
        portions = { { encumbrance = 30, coverage = 10, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You extend the shoulder strap."),
            menu_text = ccb.content.text("Extend shoulder strap"),
            target = "laptop_hard_case_shoulder",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "laptop_hard_case_shoulder",
    name = ccb.content.plural_text("laptop hard case", "laptop hard cases"),
    copy_from = "laptop_hard_case",
    description = ccb.content.text("A rugged hard case for a laptop, frequently used by military, scientists, and others working in the field.  This model is waterproof and lined with impact-resistant foam.  The shoulder strap is extended to be worn on the side.  Activate it to wear it on your back."),
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.25,
                coverage = 40,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You move the bag to your back."),
            menu_text = ccb.content.text("Switch to back"),
            target = "laptop_hard_case_back",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "laptop_hard_case_back",
    name = ccb.content.plural_text("laptop hard case", "laptop hard cases"),
    copy_from = "laptop_hard_case",
    description = ccb.content.text("A rugged hard case for a laptop, frequently used by military, scientists, and others working in the field.  This model is waterproof and lined with impact-resistant foam.  The shoulder strap is extended to be worn on the back.  Activate it cinch the strap and carry it by the handle."),
    armor = {
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.25,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You cinch up the shoulder strap."),
            menu_text = ccb.content.text("Cinch the shoulder strap"),
            target = "laptop_hard_case",
            moves = 120,
        },
    },
}
