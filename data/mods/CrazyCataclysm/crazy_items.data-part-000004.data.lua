local ccb = require("ccb")

-- Lightweight 10 oz denim jeans.
ccb.content.define_item {
    id = "red_jeans",
    name = ccb.content.plural_text("red jeans", "red jeans"),
    description = ccb.content.text("A pair of tight-fitting candy-apple-red jeans with two deep pockets."),
    mass = "600 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD 50 cent",
    materials = { "denim" },
    symbol = "[",
    looks_like = "jeans",
    color = "red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        warmth = 10,
        thickness = 0.65,
        portions = { { encumbrance = { 7, 11 }, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "firekatana_off",
    name = "Rising Sun",
    description = "This is a katana with a nozzle just behind the cutting edge of the blade.  People love fire, and people love katana, so why not put them together?  The gas burners attached to this blade can really turn up the heat on your foes.  Use to ignite.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    mass = "1400 g",
    volume = "2250 ml",
    price = "980 USD",
    flags = { "FIRE", "DURABLE_MELEE", "SHEATH_SWORD" },
    techniques = { "RAPID", "WBLOCK_2" },
    materials = { "steel" },
    melee_damage = { bash = 4, cut = 31 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = 6 },
    },
    use_actions = {
        {
            kind = "fireweapon_off",
            target_id = "firekatana_on",
            moves = 10,
            noise = 10,
            success_message = "The Sun rises.",
        },
    },
    tool = {
        charges_per_use = 1,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "firekatana_on",
    name = "Rising Sun",
    description = "This is a katana that glows with the fury and heat of the SUN!  Well, okay it's not THAT hot, but getting hit with it still stings like the dickens.  Use to shut off the gas.",
    symbol = "/",
    color = "red",
    category = "weapons",
    mass = "1400 g",
    volume = "2250 ml",
    price = "980 USD",
    revert_to = "firekatana_off",
    light = 240,
    flags = { "FIRE", "CHARGEDIM", "FLAMING", "DURABLE_MELEE", "TRADER_AVOID", "WATER_EXTINGUISH" },
    techniques = { "RAPID", "WBLOCK_2" },
    materials = { "steel" },
    melee_damage = { bash = 4, cut = 31 },
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
            target = "firekatana_off",
            message = "The Sun sets.",
            menu_text = "Turn off",
        },
        { kind = "firestarter", moves = 30 },
    },
    tick_actions = {
        {
            kind = "fireweapon_on",
            noise_chance = 35,
            noise_message = "The Sun shines brightly.",
            charges_extinguish_message = "The Light Fades.",
            water_extinguish_message = "Your sword hisses in the water and goes out.",
        },
    },
    tool = {
        turns_per_charge = 30,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "zweifire_off",
    name = ccb.content.plural_text("flammenschwert (aus)", "flammenschwerter (aus)"),
    description = "Ein großes zweihändiges Schwert aus Deutschland, an dessen Klinge sich, unter Zuführung von Benzin, eine anhaltende Flamme erzeugen lässt.  Es ist eine sehr mächtige Waffe.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    mass = "3400 g",
    volume = "3750 ml",
    price = "1 kUSD 600 USD",
    flags = { "DURABLE_MELEE", "SHEATH_SWORD", "ALWAYS_TWOHAND" },
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
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = 1 },
    },
    use_actions = {
        {
            kind = "fireweapon_off",
            target_id = "zweifire_on",
            moves = 10,
            noise = 10,
            success_message = "Die Klinge deines Schwertes brennt!",
        },
    },
    tool = {
        charges_per_use = 1,
        ammo_types = { "gasoline" },
    },
}
