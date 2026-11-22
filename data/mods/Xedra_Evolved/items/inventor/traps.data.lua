local ccb = require("ccb")

ccb.content.define_item {
    id = "stunning_qr_trap",
    name = "stunning QR trap",
    description = "A jagged and eldritch looking QR code ready to be placed wherever you are concerned about mechanical eyes.  Will trap robots if they wander into it.",
    symbol = "*",
    color = "light_gray",
    category = "traps",
    mass = "1 g",
    volume = "5 ml",
    length = "5 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE" },
    materials = { "plastic" },
    properties = { capture_species = "ROBOT" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_robot_snare",
            moves = 150,
            practice = 2,
            done_message = "You set the QR code.",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "stunning_arg_trap",
    name = "stunning arg trap",
    description = "A jagged and eldritch looking QR code ready to be placed wherever you are concerned about mechanical eyes.  Will trap cyborgs if they wander into it.",
    symbol = "*",
    color = "light_gray",
    category = "traps",
    mass = "1 g",
    volume = "5 ml",
    length = "5 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE" },
    materials = { "plastic" },
    properties = { capture_species = "CYBORG" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_cyborg_snare",
            moves = 150,
            practice = 2,
            done_message = "You set the QR code.",
        },
    },
    tool = {},
}
