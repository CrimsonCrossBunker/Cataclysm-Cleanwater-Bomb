local ccb = require("ccb")

ccb.content.define_item {
    id = "wildshape_cloak_bear",
    name = ccb.content.plural_text("Wildshape Cloak: Bear", "Wildshape Cloak: Bears"),
    description = ccb.content.text("A magical cloak that smells of the forest.  It can be worn to morph your body to a form that is strong and resilient in melee combat.  However, you feel as if you would lose a part of yourself."),
    looks_like = "cloak_leather",
    mass = "1525 g",
    volume = "3050 ml",
    price = "2 kUSD",
    symbol = "w",
    color = "brown",
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
    artifact = { enchantments = { "ench_bearform" } },
}
