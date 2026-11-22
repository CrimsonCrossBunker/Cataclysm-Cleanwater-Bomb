local ccb = require("ccb")

ccb.content.define_item {
    id = "full_barrel_bomb",
    name = "100 L barrel bomb",
    description = "A 100 L metal barrel filled with military explosives.  Once it has been activated it will explode after 100 seconds, raining fire and steel on everything in sight.",
    symbol = "(",
    color = "red",
    category = "weapons",
    looks_like = "half_barrel_bomb",
    mass = "110610 g",
    volume = "105 L",
    price = "900 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    materials = { "steel" },
    melee_damage = { bash = 20 },
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    blast = {
        power = 69200,
        shrapnel = { casing_mass = 12000, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "full_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}
