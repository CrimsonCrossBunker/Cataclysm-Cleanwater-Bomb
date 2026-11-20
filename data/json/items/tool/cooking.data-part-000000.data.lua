local ccb = require("ccb")

-- Based on https://www.amazon.com/dp/B07CDR4KFM
ccb.content.define_item {
    id = "carver_off",
    name = ccb.content.plural_text("electric carver (off)", "electric carvers (off)"),
    description = ccb.content.text("An electric meat carver powered by cord.  It has two serrated blades that vibrate together to slice just about anything from turkey to ham… even zombies!"),
    accuracy = { grip = "solid", length = "short", surface = "line", balance = "good" },
    mass = "680 g",
    volume = "1500 ml",
    length = "482 mm",
    price = "24 USD",
    survival_price = "1 cent",
    materials = { "steel", "plastic" },
    symbol = "/",
    color = "yellow",
    flags = { "SHEATH_SWORD", "NONCONDUCTIVE", "WATER_BREAK_ACTIVE" },
    melee_damage = { bash = 2, cut = 8 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "carver_on",
            message = ccb.content.text("The electric carver's serrated blades start buzzing!"),
            sound_volume = 20,
            menu_text = ccb.content.text("Turn on"),
            moves = 1,
        },
        { kind = "link_up", cable_length = 2, charge_rate = "120 W" },
    },
}

ccb.content.define_item {
    id = "multi_cooker",
    name = ccb.content.plural_text("multi-cooker", "multi-cookers"),
    description = ccb.content.text("A professional-grade multi-cooker, with a short electric cord.  Its multitude of settings and features promise to handle any sort of cooking, from parboiling potatoes to cooking curry to popping popcorn.  There's no manual, but you're sure you can work it out."),
    mass = "11339 g",
    volume = "3750 ml",
    price = "200 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "red",
    flags = { "WATER_BREAK", "ELECTRONIC", "ALLOWS_REMOTE_USE" },
    faults = { { group = "electronic_general" } },
    qualities = { { id = "CONTAIN", level = 1 } },
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "35 cm",
            moves = 50,
        },
    },
    tool = { power_draw = "100 W", ammo_types = { "battery" } },
    use_actions = { "MULTICOOKER", { kind = "link_up", cable_length = 2, charge_rate = "1000 W" } },
    tick_actions = { "MULTICOOKER_TICK" },
}
