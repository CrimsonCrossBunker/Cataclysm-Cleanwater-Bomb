local ccb = require("ccb")

ccb.content.define_item {
    id = "pipebomb_act",
    copy_from = "pipebomb",
    description = ccb.content.text("This pipebomb's fuse is lit, and it will explode any second now.  Throw it immediately!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 300, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "6 seconds",
}

ccb.content.define_item {
    id = "pipebomb",
    name = "pipebomb",
    description = "A section of steel pipe filled with explosives.  Use this item to light the fuse, giving you six seconds to get away from it before it detonates.  You'll need a lighter or some matches to use it.",
    symbol = "*",
    color = "light_gray",
    category = "weapons",
    mass = "840 g",
    volume = "280 ml",
    length = "229 mm",
    price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "CYLINDER_GRENADE" },
    materials = { "steel" },
    melee_damage = { bash = 3 },
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    blast = {
        power = 300,
        shrapnel = { casing_mass = 410, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "pipebomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the pipe bomb.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
