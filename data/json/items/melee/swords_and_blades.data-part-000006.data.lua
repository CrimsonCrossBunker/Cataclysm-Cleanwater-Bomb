local ccb = require("ccb")

ccb.content.define_item {
    id = "longsword",
    copy_from = "mc_longsword",
    name = ccb.content.plural_text("longsword", "longswords"),
    description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard compared to smaller swords."),
    replace_materials = { mc_steel = "steel" },
    tool = {},
}

ccb.content.define_item {
    id = "ch_estoc",
    copy_from = "mc_estoc",
    name = "hardened steel estoc",
    description = "A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard, compared to smaller swords.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor.",
    replace_materials = { mc_steel = "ch_steel", leather = "kevlar" },
    inheritance = {
        scale = { price = 1.1, survival_price = 1.1 },
        offset = {
            melee_damage = { stab = 5 },
            qualities = {
                { id = "BUTCHER", level = 1 },
            },
        },
    },
}
