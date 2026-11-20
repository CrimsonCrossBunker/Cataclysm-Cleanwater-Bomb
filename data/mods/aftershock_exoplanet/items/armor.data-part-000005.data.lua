local ccb = require("ccb")

ccb.content.define_item {
    id = "combat_wetsuit_cecalia",
    name = ccb.content.plural_text("combat wetsuit", "combat wetsuits"),
    description = ccb.content.text("The combat version of the Cecaelia wetsuit; made of neoprene and Kevlar, it will provide some level of protection for deep dwellers."),
    mass = "1720 g",
    volume = "4 L",
    price = "120 USD",
    survival_price = "5 USD",
    accuracy = -3,
    materials = { "neoprene", "afs_kevlar" },
    symbol = "[",
    looks_like = "wetsuit",
    color = "light_gray",
    pockets = {
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "350 ml", mass_limit = "1 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        { kind = "CONTAINER", capacity = "250 ml", mass_limit = "1 kg", moves = 100 },
        {
            capacity = "2 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 40,
            allowed_flags = { "BELT_CLIP" },
            rigid = true,
            holster = true,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "3 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY" },
            moves = 60,
        },
        {
            kind = "CONTAINER",
            min_item_volume = "2 L",
            capacity = "3 L",
            mass_limit = "30 kg",
            allowed_flags = { "MAG_BULKY" },
            moves = 60,
        },
    },
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 1,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "neoprene", coverage = 100, thickness = 1.2 },
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 0.3 },
                    { id = "neoprene", coverage = 100, thickness = 0.7 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 2,
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stash ammo"),
            message = ccb.content.text("You stash your %s."),
        },
    },
}
