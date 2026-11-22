local ccb = require("ccb")

ccb.content.define_item {
    id = "homemade_demolition_charge_act",
    copy_from = "homemade_demolition_charge",
    looks_like = "homemade_bomb_act",
    description = ccb.content.text("The fuse on this primitive demolition charge is lit and hissing.  It'll explode any moment now."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 2590 } },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "homemade_demolition_charge",
    name = "homemade demolition charge",
    description = "An improvised demolition charge.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  20 seconds after lighting the fuse, it will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    looks_like = "homemade_bomb",
    mass = "3875 g",
    volume = "3900 ml",
    price = "0 cent",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "plastic", "powder" },
    melee_damage = { bash = 4 },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    blast = { power = 2590 },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_demolition_charge_act",
            need_fire = 1,
            message = "You light the fuse on the bomb.  Get rid of it quickly!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
