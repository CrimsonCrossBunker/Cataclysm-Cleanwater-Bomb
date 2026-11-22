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

ccb.content.define_item {
    id = "qt_zweihander",
    copy_from = "mc_zweihander",
    name = "tempered steel zweihänder",
    description = "A huge two-handed sword from Germany.  It packs a real wallop.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft.",
    replace_materials = { mc_steel = "qt_steel", leather = "kevlar" },
    tool = {},
    inheritance = {
        scale = { price = 1.15, survival_price = 1.15 },
        offset = {
            melee_damage = { cut = 5 },
            qualities = {
                { id = "BUTCHER", level = 3 },
            },
        },
    },
}
