local ccb = require("ccb")

ccb.content.define_item {
    id = "dynamite_act",
    description = ccb.content.text("The fuse on this dynamite is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 938 } },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "dynamite",
    name = "dynamite",
    description = "Several sticks of explosives, bundled together with a fuse attached.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "1133 g",
    volume = "750 ml",
    price = "60 USD",
    survival_price = "10 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = {
        { id = "tnt", portions = 95 },
        { id = "paper", portions = 5 },
    },
    melee_damage = { bash = 4 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = { power = 938 },
    use_actions = {
        {
            kind = "transform",
            target = "dynamite_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the dynamite.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
