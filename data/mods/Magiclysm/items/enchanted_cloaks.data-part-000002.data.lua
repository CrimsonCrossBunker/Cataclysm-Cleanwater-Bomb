local ccb = require("ccb")

ccb.content.define_item {
    id = "wildshape_cloak_deer",
    name = ccb.content.plural_text("Wildshape Cloak: Deer", "Wildshape Cloak: Deers"),
    description = ccb.content.text("A magical cloak that feels soft to the touch.  It can be worn to morph your body to a form well-suited to escaping difficult situations.  However, it is not suited for combat."),
    looks_like = "cloak_leather",
    mass = "1525 g",
    volume = "3050 ml",
    price = "1 kUSD 500 USD",
    symbol = "w",
    color = "green",
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
    artifact = { enchantments = { "ench_deerform" } },
}
