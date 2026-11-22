local ccb = require("ccb")

ccb.content.define_item {
    id = "military_explosive_pipebomb_act",
    copy_from = "military_explosive_pipebomb",
    looks_like = "pipebomb_act",
    description = ccb.content.text("This pipebomb's pin is pulled, and it will explode any second now.  Throw it immediately!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 920, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "military_explosive_pipebomb",
    copy_from = "grenade",
    name = "military explosive pipebomb",
    description = "A section of steel pipe filled with military explosives.  Use this item to pull the pin, giving you six seconds to get away from it before it detonates.",
    symbol = "*",
    color = "light_gray",
    looks_like = "pipebomb",
    mass = "1140 g",
    volume = "280 ml",
    length = "229 mm",
    price = "30 USD",
    survival_price = "30 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "CYLINDER_GRENADE" },
    materials = { "steel" },
    melee_damage = { bash = 4 },
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    blast = {
        power = 920,
        shrapnel = { casing_mass = 410, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_pipebomb_act",
            need_wielding = true,
            message = "You pull the pin on the %s.",
            menu_text = "Pull pin",
        },
    },
    tool = {},
}
