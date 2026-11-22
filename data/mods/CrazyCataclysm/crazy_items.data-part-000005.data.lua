local ccb = require("ccb")

ccb.content.define_item {
    id = "battletorch",
    category = "weapons",
    name = ccb.content.plural_text("Louisville Slaughterer", "Louisville Slaughterers"),
    description = ccb.content.text("This is sturdy wood bat, wrapped in gasoline-soaked rags and flame-resistant Nomex fabric.  Light it, and the ball game will REALLY heat up.  You'll need a lighter or matches to light it."),
    mass = "1485 g",
    volume = "2 L",
    price = "160 USD",
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    materials = { "wood", "nomex" },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "DURABLE_MELEE" },
    melee_damage = { bash = 18 },
    tool = { initial_charges = 25, max_charges = 25, charges_per_use = 1 },
    use_actions = {
        {
            kind = "transform",
            target = "battletorch_lit",
            message = ccb.content.text("You light the Louisville Slaughterer."),
            need_fire = 1,
            menu_text = ccb.content.text("Light", "verb"),
        },
    },
}

ccb.content.define_item {
    id = "zweifire_on",
    name = ccb.content.plural_text("flammenschwert", "flammenschwerter"),
    description = "Ein großes zweihändiges Schwert aus Deutschland, an dessen Klinge sich, unter Zuführung von Benzin, eine anhaltende Flamme erzeugen lässt.  Es ist eine sehr mächtige Waffe.",
    symbol = "/",
    color = "red",
    category = "weapons",
    mass = "3400 g",
    volume = "3750 ml",
    price = "1 kUSD 600 USD",
    revert_to = "zweifire_off",
    light = 240,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "DURABLE_MELEE",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "ALWAYS_TWOHAND",
    },
    techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
    materials = { "steel" },
    melee_damage = { bash = 17, cut = 40 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "zweifire_off",
            message = "Die Flamme deines Schwertes erlischt.",
            menu_text = "Turn off",
        },
        { kind = "firestarter", moves = 30 },
    },
    tick_actions = {
        {
            kind = "fireweapon_on",
            noise_chance = 35,
            noise_message = "Das Feuer um deine Schwertklinge leuchtet hell!",
            charges_extinguish_message = "Deinem Flammenschwert ist der Brennstoff ausgegangen!",
            water_extinguish_message = "Dein Schwert zischt und erlischt.",
        },
    },
    tool = {
        turns_per_charge = 30,
        ammo_types = { "gasoline" },
    },
}
