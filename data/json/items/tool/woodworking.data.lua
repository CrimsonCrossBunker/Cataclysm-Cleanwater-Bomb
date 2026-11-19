local ccb = require("ccb")

ccb.content.define_item {
    id = "polesaw_off",
    name = ccb.content.plural_text("pole saw (off)", "pole saws (off)"),
    description = ccb.content.text("A lumbering tool intended for trimming hedges and tree branches at a distance.  If loaded with gas, using this item will cause it to turn on, making it into an unwieldy polearm."),
    mass = "9525 g",
    volume = "2500 ml",
    length = "275 cm",
    price = "400 USD",
    survival_price = "4 USD 50 cent",
    accuracy = { grip = "solid", length = "long", surface = "line", balance = "clumsy" },
    looks_like = "chainsaw_off",
    materials = { "steel", "plastic" },
    symbol = "/",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { gasoline = 450 }, watertight = true, rigid = true } },
    techniques = { "SWEEP" },
    flags = { "POLEARM", "NONCONDUCTIVE", "FRAGILE_MELEE", "REACH_ATTACK" },
    melee_damage = { bash = 6 },
    tool = { charges_per_use = 5, ammo_types = { "gasoline" } },
    use_actions = {
        {
            kind = "transform",
            target = "polesaw_on",
            message = ccb.content.text("With a roar, the pole saw screams to life!"),
            sound_volume = 20,
            menu_text = ccb.content.text("Turn on"),
            moves = 1,
        },
    },
}

ccb.content.define_item {
    id = "circsaw_off",
    name = ccb.content.plural_text("circular saw (off)", "circular saws (off)"),
    description = ccb.content.text("A lightweight, handheld cordless circular saw.  Spins a circular blade fast enough to cut wood, or in an emergency, pizza."),
    mass = "2940 g",
    volume = "750 ml",
    length = "44 cm",
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "solid", length = "long", surface = "line", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = "/",
    color = "yellow",
    flags = { "NONCONDUCTIVE" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    melee_damage = { bash = 2, cut = 4 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "circsaw_on",
            message = ccb.content.text("With a loud buzz, the %s roars to life!"),
            sound_volume = 15,
            menu_text = ccb.content.text("Turn on"),
            moves = 1,
        },
    },
}
