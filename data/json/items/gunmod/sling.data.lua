local ccb = require("ccb")

ccb.content.define_item {
    id = "shoulder_strap_simple",
    name = ccb.content.plural_text("two point sling", "two point slings"),
    description = ccb.content.text("A shoulder strap allows the rifle to be worn over a shoulder like a piece of clothing.  However, it offers no protection."),
    mass = "100 g",
    volume = "250 ml",
    integral_volume = "250 ml",
    price = "4 USD 80 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = ":",
    color = "green",
    flags = { "IS_ARMOR", "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    subtype_order = { "armor", "gunmod" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 0,
                volume_encumbrance = 0.33,
                subparts = { "torso_hanging_back" },
            },
        },
    },
    gunmod = {
        install_time = "20 s",
        location = ccb.content.text("sling"),
        targets = {
            ccb.content.text("rifle", "gun_type_type"),
            ccb.content.text("shotgun", "gun_type_type"),
            ccb.content.text("smg", "gun_type_type"),
            ccb.content.text("crossbow", "gun_type_type"),
            ccb.content.text("launcher", "gun_type_type"),
            ccb.content.text("pistol", "gun_type_type"),
        },
    },
}

ccb.content.define_item {
    id = "shoulder_strap",
    name = ccb.content.plural_text("adjustable sling", "adjustable slings"),
    description = ccb.content.text("An adjustable strap that allows the rifle to be worn over your shoulders like a piece of clothing.  However, it offers no protection."),
    copy_from = "shoulder_strap_simple",
    price = "35 USD",
    survival_price = "20 cent",
    materials = { "nylon" },
    gunmod = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You shift the weapon to the front of your body."),
            menu_text = ccb.content.text("Adjust"),
            target = "shoulder_strap_front",
            moves = 600,
        },
    },
}

ccb.content.define_item {
    id = "shoulder_strap_front",
    name = ccb.content.plural_text("adjustable sling (front)", "adjustable slings (front)"),
    description = ccb.content.text("A shoulder strap allows the rifle to be worn over your shoulders like a piece of clothing.  Currently adjusted so the weapon hangs off your front."),
    copy_from = "shoulder_strap",
    subtype_order = { "armor", "gunmod" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 0,
                volume_encumbrance = 0.33,
                subparts = { "torso_hanging_front" },
            },
        },
    },
    gunmod = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You shift the weapon to the back of your body."),
            menu_text = ccb.content.text("Adjust"),
            target = "shoulder_strap",
            moves = 600,
        },
    },
}
