local ccb = require("ccb")

ccb.content.define_item {
    id = "dynamite_bomb_act",
    description = ccb.content.text("The fuse on this dynamite bomb is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite_bomb",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 938, shrapnel = { casing_mass = 1597, fragment_mass = 0.5 } },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "dynamite_bomb",
    name = "dynamite bomb",
    description = "Several sticks of explosives stuffed inside a metal container and surrounded with shrapnel.  The fuse is sticking out through a small hole.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "2531 g",
    volume = "2430 ml",
    price = "60 USD",
    survival_price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = {
        { id = "tnt", portions = 95 },
        { id = "steel", portions = 40 },
        { id = "paper", portions = 5 },
    },
    melee_damage = { bash = 4 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = {
        power = 938,
        shrapnel = { casing_mass = 1597, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "dynamite_bomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the dynamite.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
