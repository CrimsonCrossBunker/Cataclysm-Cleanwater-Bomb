local ccb = require("ccb")

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
