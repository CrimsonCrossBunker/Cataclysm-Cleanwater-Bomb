local ccb = require("ccb")

ccb.content.define_item {
    id = "wildshape_cloak_fish",
    name = ccb.content.plural_text("Wildshape Cloak: Fish", "Wildshape Cloaks: Fish"),
    description = ccb.content.text("A magical cloak that shimmers like fresh water under a warm sun.  It can be worn to morph your body to a form that is excellent for swimming, but ill-suited for combat.  You should probably stand in water before you put it on."),
    looks_like = "cloak_leather",
    mass = "1525 g",
    volume = "3050 ml",
    price = "1 kUSD",
    symbol = "w",
    color = "blue",
    materials = { "magical_material" },
    flags = { "BELTED", "OVERSIZE", "NONCONDUCTIVE", "WATER_FRIENDLY", "RAINPROOF" },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_fishform" } },
}
