local ccb = require("ccb")

ccb.content.define_item {
    id = "sword_xiphos",
    category = "weapons",
    name = ccb.content.plural_text("xiphos", "xiphe"),
    description = ccb.content.text("A bronze sword of ancient Greek origin, wielded as a sidearm to the dory spear."),
    mass = "800 g",
    volume = "2 L",
    length = "50 cm",
    price = "120 USD",
    survival_price = "25 USD",
    accuracy = { grip = "weapon", length = "short", surface = "line", balance = "good" },
    materials = { "bronze" },
    symbol = "!",
    color = "yellow",
    techniques = { "WBLOCK_2" },
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 8 } },
    flags = { "SHEATH_SWORD", "DURABLE_MELEE" },
    weapon_categories = { "SHORT_SWORDS" },
    faults = { { group = "handle_short" }, { group = "blade_general", weight_multiplier = 5 } },
    melee_damage = { bash = 6, cut = 28 },
    tool = {},
}

ccb.content.define_item {
    id = "ch_arming_sword",
    copy_from = "mc_arming_sword",
    name = "hardened steel arming sword",
    description = "A classic medieval sword, just the right size to use one-handed.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor.",
    replace_materials = { mc_steel = "ch_steel", leather = "kevlar" },
    tool = {},
    inheritance = {
        scale = { price = 1.1, survival_price = 1.1 },
        offset = {
            melee_damage = { cut = 3 },
            qualities = {
                { id = "BUTCHER", level = 2 },
            },
        },
    },
}
