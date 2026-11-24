local ccb = require("ccb")

-- this tool is small and has no actual battery compartment, but can connect to large batteries.
ccb.content.define_item {
    id = "electrolysis_kit",
    name = ccb.content.plural_text("electrolysis kit", "electrolysis kits"),
    description = ccb.content.text("A set of wiring and electrodes for applying a direct current, usually to a liquid.  Useful for crafting.  Load with a storage battery or 12V vehicle battery to use."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel", "copper", "plastic" },
    symbol = ";",
    flags = { "WATER_BREAK" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "battery_car",
                "battery_motorbike",
                "small_storage_battery",
                "medium_storage_battery",
                "storage_battery",
            },
        },
    },
    tool = { ammo_types = { "battery" } },
    use_actions = { { kind = "link_up", cable_length = 2, charge_rate = "300 W" } },
}

-- based on a 24lb N-butane tank such as https://www.usalab.com/24lb-n-butane-tank/.  That much butane occupies about 19 liters.  Roughly analogous to 5 gal propane tanks.
ccb.content.define_item {
    id = "butane_tank",
    name = ccb.content.plural_text("butane tank", "tanks of butane"),
    description = ccb.content.text("A tank of compressed butane.  Aside from its practicality as fuel, it can also be used to extract essential oils from organic material."),
    category = "tool_magazine",
    mass = "7500 g",
    volume = "24 L",
    length = "50 cm",
    price = "250 USD",
    survival_price = "10 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            airtight = true,
            ammunition = { butane = 19000 },
            watertight = true,
        },
    },
    looks_like = "oxygen_tank",
    flags = {},
    explode_in_fire = true,
    melee_damage = { bash = 10 },
    tool = { charges_per_use = 1 },
}

ccb.content.define_item {
    id = "pressure_tank",
    name = ccb.content.plural_text("pressurized tank", "pressurized tanks"),
    description = ccb.content.text("A tank designed to hold high pressure gases."),
    category = "container",
    mass = "2268 g",
    volume = "3 L",
    price = "10 USD",
    survival_price = "5 USD",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "light_gray",
    looks_like = "oxygen_tank",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            airtight = true,
            capacity = "1600 ml",
            mass_limit = "50 kg",
            watertight = true,
        },
    },
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    melee_damage = { bash = 5 },
}

ccb.content.define_item {
    id = "oxygen_cylinder",
    name = ccb.content.text("oxygen tank"),
    description = ccb.content.text("A large steel cylinder used for storing pressurized gas.  It is marked with a faded, but legible O2 symbol."),
    category = "container",
    mass = "19050 g",
    volume = "28000 ml",
    length = "92 cm",
    price = "134 USD",
    survival_price = "5 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "blue",
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            watertight = true,
            rigid = true,
            ammunition = { oxygen = 300 },
        },
    },
    flags = { "NO_UNLOAD" },
    melee_damage = { bash = 10 },
    magazine = { ammunition = { "oxygen" }, capacity = 300, count = 300 },
}

ccb.content.define_item {
    id = "migo_bio_tech",
    name = ccb.content.plural_text("Mi-go Biotech", "Mi-go Biotech"),
    description = "A piece of mi-go biotechnology.",
    symbol = "!",
    color = "light_red",
    mass = "250 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "100 USD",
    materials = { "alien_resin" },
    conditional_names = {
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "morale",
            name = ccb.content.plural_text("%s (happy)", "%s (happy)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "focus",
            name = ccb.content.plural_text("%s (focus)", "%s (focus)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "pain",
            name = ccb.content.plural_text("%s (pain relief)", "%s (pain relief)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "sleepiness",
            name = ccb.content.plural_text("%s (wake up)", "%s (wake up)"),
        },
    },
    tool = {},
}
