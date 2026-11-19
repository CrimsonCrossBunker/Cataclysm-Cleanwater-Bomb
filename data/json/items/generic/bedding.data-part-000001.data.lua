local ccb = require("ccb")

ccb.content.define_item {
    id = "sleeping_bag",
    name = ccb.content.plural_text("sleeping bag", "sleeping bags"),
    description = ccb.content.text("A large sleeping bag that covers you head to toe, with a strap for carrying it on your back when not in use.  This one is medium weight.  It is currently unrolled; activate it to roll it up for easy storage."),
    mass = "500 g",
    volume = "1 L",
    price = "205 USD",
    survival_price = "5 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "blanket",
    color = "light_red",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 80,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 80,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l",
                    "arm_wing_bird_r", "wing_l", "wing_r", "gastropod_foot", "beak", "muzzle", "hoof_r",
                    "hoof_l", "avian_talon_l", "avian_talon_r", "animal_paw_l", "animal_paw_r",
                    "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Roll up"),
            target = "sleeping_bag_roll",
            message = ccb.content.text("You roll up the sleeping bag, preparing it for transport."),
        },
    },
}
