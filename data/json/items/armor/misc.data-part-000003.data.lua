local ccb = require("ccb")

ccb.content.define_item {
    id = "sleeping_bag_roll",
    copy_from = "sleeping_bag",
    name = ccb.content.plural_text("rolled sleeping bag", "rolled sleeping bags"),
    description = ccb.content.text("A large sleeping bag that covers you head to toe, with a strap for carrying it on your back when not in use.  This one is medium weight.  Activate it to unroll it so you can use it for warmth."),
    looks_like = "sleeping_bag",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        thickness = 4,
        portions = {
            {
                encumbrance = 4,
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unroll"),
            target = "sleeping_bag",
            message = ccb.content.text("You unroll the sleeping bag."),
        },
    },
}

ccb.content.define_item {
    id = "sleeping_bag_fur",
    name = ccb.content.plural_text("fur sleeping bag", "fur sleeping bags"),
    description = ccb.content.text("A large sleeping bag lined with fur, with a strap for carrying it on your back when not in use.  Who needs a tent?  It is currently unrolled; activate it roll it up for easy storage."),
    mass = "1175 g",
    volume = "2 L",
    price = "325 USD",
    survival_price = "20 USD",
    materials = { "cotton", "fur" },
    symbol = "[",
    looks_like = "sleeping_bag",
    color = "brown",
    flags = { "OVERSIZE", "OUTER" },
    armor = {
        warmth = 100,
        thickness = 5,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 80,
                coverage = 100,
                covers = {
                    "torso",
                    "head",
                    "mouth",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Roll up"),
            target = "sleeping_bag_fur_roll",
            message = ccb.content.text("You roll up the sleeping bag, preparing it for transport."),
        },
    },
}

ccb.content.define_item {
    id = "sleeping_bag_fur_roll",
    copy_from = "sleeping_bag_fur",
    name = ccb.content.plural_text("rolled fur sleeping bag", "rolled fur sleeping bags"),
    description = ccb.content.text("A large sleeping bag lined with fur, with a strap for carrying it on your back when not in use.  Who needs a tent?  Activate it to unroll it so you can use it for warmth."),
    looks_like = "sleeping_bag_roll",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        portions = {
            {
                encumbrance = 5,
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Unroll"),
            target = "sleeping_bag_fur",
            message = ccb.content.text("You unroll the sleeping bag."),
        },
    },
}
