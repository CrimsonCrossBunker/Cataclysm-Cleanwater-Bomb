local ccb = require("ccb")

ccb.content.define_item {
    id = "kukri",
    category = "weapons",
    name = ccb.content.plural_text("medium steel kukri", "medium steel kukris"),
    description = ccb.content.text("This versatile implement is a custom-forged version of a traditional weapon that originated in Nepal.  Featuring a heavy blade with an inwardly-curved edge, this one is made of medium steel, and is about what you'd expect to see in a hunting shop."),
    mass = "454 g",
    volume = "450 ml",
    length = "46 cm",
    price = "80 USD",
    survival_price = "12 USD 50 cent",
    accuracy = { grip = "weapon", length = "short", surface = "line", balance = "good" },
    materials = { { id = "wood", portions = 0.85 }, { id = "mc_steel", portions = 80 } },
    repair_materials = { "mc_steel" },
    symbol = "/",
    color = "dark_gray",
    looks_like = "kukri",
    techniques = { "WBLOCK_1" },
    qualities = {
        { id = "CUT", level = 2 },
        { id = "AXE", level = 1 },
        { id = "GRASS_CUT", level = 1 },
        { id = "CUT_FINE", level = 1 },
        { id = "BUTCHER", level = 18 },
    },
    flags = { "DURABLE_MELEE", "SHEATH_KNIFE", "NONCONDUCTIVE" },
    weapon_categories = { "SHORT_SWORDS" },
    faults = {
        { group = "handle_short" },
        { group = "blade_general", weight_multiplier = 5 },
        { group = "bladed_weapon_craft_failures" },
    },
    melee_damage = { cut = 20 },
    tool = {},
}

ccb.content.define_item {
    id = "survivor_machete_qt",
    copy_from = "machete",
    name = "tempered steel combat machete",
    description = "This common gardening tool has been tempered to dramatically improve its performance as a weapon.",
    looks_like = "machete",
    replace_materials = { mc_steel = "qt_steel", wood = "kevlar" },
    variants = {
        {
            id = "survivor_machete_qt_standard",
            name = "tempered steel combat machete",
            description = "This common gardening tool has been tempered to dramatically improve its performance as a weapon.",
            color = "dark_gray",
            append = false,
            weight = 1,
        },
        {
            id = "xedra_machete",
            name = "hazardous environment blade",
            description = "This black tempered steel bushcraft machete has been designed for use in exotic environments.  \"HE Blade\" is engraved in the steel.",
            color = "dark_gray",
            append = false,
            weight = 0,
        },
    },
    tool = {},
    inheritance = {
        add = {
            techniques = { "RAPID" },
        },
        scale = { price = 1.15, survival_price = 1.15 },
        offset = {
            survival_price = "20 USD",
            melee_damage = { cut = 7 },
            qualities = {
                { id = "BUTCHER", level = 4 },
            },
        },
    },
}
