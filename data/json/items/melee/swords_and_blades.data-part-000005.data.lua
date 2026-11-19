local ccb = require("ccb")

ccb.content.define_item {
    id = "hollow_cane",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("hollow cane", "hollow canes"),
    description = ccb.content.text("A cane designed to conceal a blade.  This was a popular fashion accessory for the wealthy during the 18th and 19th centuries."),
    price = "20 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood" },
    mass = "200 g",
    volume = "1532 ml",
    length = "80 cm",
    accuracy = { grip = "weapon", length = "short", surface = "any", balance = "neutral" },
    looks_like = "cane",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            capacity = "1531 ml",
            mass_limit = "2 kg",
            max_item_length = "80 cm",
            moves = 80,
            allowed_flags = { "SHEATH_SWORD" },
        },
    },
    flags = { "CRUTCHES", "COSPLAY_PROPS" },
    weapon_categories = { "BATONS" },
    techniques = { "PRECISE", "RAPID", "WBLOCK_2" },
    faults = { { group = "staff_short" } },
    melee_damage = { bash = 3 },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheath sword"),
            message = ccb.content.text("You sheath your %s"),
        },
    },
}
