local ccb = require("ccb")

ccb.content.define_item {
    id = "attachable_ear_muffs",
    category = "armor",
    name = ccb.content.plural_text("attachable ear muffs", "attachable ear muffs"),
    description = ccb.content.text("A pair of ear muffs attachable to a hard hat or helmet to reduce noise exposures to safe levels.  Activate to put ear muffs into a working position, blocking most sounds."),
    mass = "185 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "80 cent",
    materials = { "thermo_resin", "cotton" },
    symbol = "[",
    color = "yellow",
    flags = { "HELMET_EAR_ATTACHMENT", "CANT_WEAR" },
    armor = {
        thickness = 1,
        warmth = 8,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_r", "head_ear_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Press tightly to ears"),
            target = "attachable_ear_muffs_on",
            message = ccb.content.text("You put the ear muffs tightly to your ears."),
            moves = 100,
        },
    },
}

ccb.content.define_item {
    id = "attachable_ear_muffs_on",
    name = ccb.content.plural_text("attachable ear muffs (on)", "attachable ear muffs (on)"),
    description = ccb.content.text("A pair of ear muffs attachable to a hard hat or helmet to reduce noise exposures to safe levels.  Activate to put ear muffs into a standby position, letting you clearly hear again."),
    copy_from = "attachable_ear_muffs",
    inheritance = { add = { flags = { "DEAF" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Put away from ears"),
            target = "attachable_ear_muffs",
            message = ccb.content.text("You put the ear muffs away from your ears."),
            moves = 100,
        },
    },
}
