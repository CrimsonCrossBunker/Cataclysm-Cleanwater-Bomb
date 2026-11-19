local ccb = require("ccb")

ccb.content.define_item {
    id = "wolf_mask_act",
    copy_from = "wolf_mask",
    name = ccb.content.plural_text("wolf's mask (on)", "wolf's masks (on)"),
    revert_to = "wolf_mask",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "5 W" },
    armor = { environmental_protection = 25 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "wolf_mask",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "magnetic_holster",
    name = ccb.content.plural_text("magnetic holster", "magnetic holsters"),
    looks_like = "shoulder_strap",
    description = ccb.content.text("A long strap with small, powerful gravity field emitters on the surface.  Allows one to strap and carry almost anything."),
    mass = "250 g",
    volume = "250 ml",
    materials = { "plastic", "aluminum" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            rigid = true,
            capacity = "20 L",
            mass_limit = "15 kg",
            max_item_length = "300 cm",
            moves = 50,
        },
    },
    flags = { "MORPHIC", "BELTED", "OVERSIZE", "MUNDANE", "INVENTOR_CRAFTED", "TARDIS" },
    armor = {
        sided = true,
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 5, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = { { kind = "holster" } },
}
