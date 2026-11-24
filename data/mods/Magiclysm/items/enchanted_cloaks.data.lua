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
