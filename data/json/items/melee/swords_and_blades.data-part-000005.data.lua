local ccb = require("ccb")

ccb.content.define_item {
    id = "mc_estoc",
    category = "weapons",
    name = ccb.content.plural_text("medium steel estoc", "medium steel estocs"),
    description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard, compared to smaller swords.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
    mass = "1994 g",
    volume = "2750 ml",
    length = "130 cm",
    symbol = "/",
    color = "light_gray",
    looks_like = "estoc",
    price = "1 kUSD 350 USD",
    survival_price = "50 USD",
    materials = { { id = "leather", portions = 1.1 }, { id = "mc_steel", portions = 112 } },
    repair_materials = { "mc_steel" },
    techniques = { "WBLOCK_2", "PRECISE", "MOUNTED_CHARGE" },
    flags = { "SHEATH_SWORD", "CONDUCTIVE", "DURABLE_MELEE" },
    weapon_categories = { "LONG_THRUSTING_SWORDS" },
    accuracy = { grip = "weapon", length = "long", surface = "point", balance = "good" },
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 8 } },
    faults = {
        { group = "handle_short" },
        { group = "blade_general", weight_multiplier = 5 },
        { group = "bladed_weapon_craft_failures" },
    },
    melee_damage = { bash = 11, stab = 36 },
    mounted_charge = { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 },
}

ccb.content.define_item {
    id = "qt_scimitar",
    copy_from = "mc_scimitar",
    name = "tempered steel shamshir",
    description = "A curved sword associated with various Middle Eastern and Central Asian countries.  Designed for slashing, and quite deadly against unarmored targets.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft.",
    replace_materials = { mc_steel = "qt_steel", leather = "kevlar" },
    tool = {},
    inheritance = {
        scale = { price = 1.15, survival_price = 1.15 },
        offset = {
            melee_damage = { cut = 5 },
            qualities = {
                { id = "BUTCHER", level = 1 },
            },
        },
    },
}
