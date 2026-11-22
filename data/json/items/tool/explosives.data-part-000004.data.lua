local ccb = require("ccb")

ccb.content.define_item {
    id = "EMPbomb_act",
    copy_from = "EMPbomb",
    description = ccb.content.text("This EMP bomb is active and will shortly detonate, creating a large EMP field that damages robots and drains bionic energy, as well as a sizeable explosion.  You may not want to be holding it much longer."),
    flags = { "DANGEROUS", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate"),
        },
    },
    countdown_action = {
        kind = "explosion",
        draw_radius = 10,
        draw_color = "light_blue",
        emp_radius = 10,
        blast = {
            power = 600,
            light_effect = "emp_blast",
            shrapnel = { casing_mass = 3214, fragment_mass = 0.5 },
        },
    },
    countdown_interval = "50 seconds",
}

ccb.content.define_item {
    id = "EMPbomb",
    name = "EMP bomb",
    description = "This substantial device is a bomb that generates an electromagnetic pulse.  When activated, the plutonium fuel cell is drained into a flux compression generator, the detonation of which creates a strong magnetic field.  When this magnetic field is fed into the antenna, it creates a strong electro-magnetic pulse.",
    symbol = "*",
    color = "light_gray",
    category = "weapons",
    mass = "4543 g",
    volume = "15500 ml",
    price = "600 USD",
    survival_price = "30 USD",
    explode_in_fire = true,
    flags = {
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "GRENADE",
        "WATER_BREAK",
        "ALLOWS_REMOTE_USE",
    },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 12 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = {
        power = 600,
        light_effect = "emp_blast",
        shrapnel = { casing_mass = 3214, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "EMPbomb_act",
            message = "You activate the EMP bomb.",
            menu_text = "Activate",
        },
    },
    tool = {},
}
