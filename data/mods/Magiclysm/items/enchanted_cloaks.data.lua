local ccb = require("ccb")

ccb.content.define_item {
    id = "cloak_of_elvenkind",
    name = ccb.content.plural_text("cloak of elvenkind", "cloaks of elvenkind"),
    description = ccb.content.text("One of the traditional items of the ancient elven warrior societies, this cloth cloak woven with still-living leaves makes its wearer much harder to spot in forests or dense vegetation.  Infamous for their use during the Vietnam War by elves on both sides of the conflict."),
    looks_like = "cloak",
    mass = "1175 g",
    volume = "3 L",
    price = "1 kUSD 500 USD",
    symbol = "w",
    color = "green",
    materials = { "cotton", "veggy" },
    flags = { "BELTED", "OVERSIZE", "NONCONDUCTIVE", "WATER_FRIENDLY", "RAINPROOF" },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            { encumbrance = 3, coverage = 65, covers = { "torso", "arm_l", "arm_r" } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 65,
                encumbrance = 3,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
        },
        warmth = 30,
        thickness = 0.4,
        environmental_protection = 3,
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_cloak_of_elvenkind_0" } },
}
