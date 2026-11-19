local ccb = require("ccb")

-- delete jumpsuit variants
ccb.content.define_item {
    id = "jumpsuit_skeleton",
    copy_from = "jumpsuit",
    name = ccb.content.plural_text("skeleton jumpsuit", "skeleton jumpsuits"),
    description = ccb.content.text("A black jumpsuit with a skeleton pattern printed on it.  It can be zipped all the way up to cover your head and face in a skull pattern too.  Use it to zip the head portion closed."),
    variants = {},
    mass = "939 g",
    volume = "3500 ml",
    price = "95 USD",
    survival_price = "60 cent",
    color = "white",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "700 ml",
            mass_limit = "2 kg",
            max_item_length = "15 cm",
            moves = 80,
        },
    },
    inheritance = { add = { flags = { "HOOD", "COSPLAY_COSTUME" } } },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 95, encumbrance = { 1, 1 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 1, 1 } },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = { 1, 2 } },
        },
        warmth = 10,
        thickness = 0.2,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You now have a skull as head."),
            target = "jumpsuit_skeleton_zipped",
            menu_text = ccb.content.text("Zip the head portion"),
        },
    },
}

ccb.content.define_item {
    id = "jumpsuit_skeleton_zipped",
    copy_from = "jumpsuit_skeleton",
    name = ccb.content.plural_text("skeleton jumpsuit (zipped)", "skeleton jumpsuits (zipped)"),
    description = ccb.content.text("A black jumpsuit with a skeleton pattern printed on it.  It covers all the way up to your head and displays a skull pattern over your face.  Use it to unzip the head portion."),
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = { 1, 1 } },
            { covers = { "mouth", "eyes" }, coverage = 100, encumbrance = { 5, 5 } },
            { covers = { "torso" }, coverage = 100, encumbrance = { 1, 1 } },
            { covers = { "arm_l", "arm_r" }, coverage = 95, encumbrance = { 1, 1 } },
            { covers = { "leg_l", "leg_r" }, coverage = 95, encumbrance = { 1, 2 } },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You facial skin is now visible."),
            target = "jumpsuit_skeleton",
            menu_text = ccb.content.text("Unzip the head portion"),
        },
    },
}
