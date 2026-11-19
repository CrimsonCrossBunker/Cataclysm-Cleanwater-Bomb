local ccb = require("ccb")

ccb.content.define_item {
    id = "right_leg_prosthetic",
    name = ccb.content.plural_text("prosthetic right leg", "prosthetic right legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  This one is for the right leg."),
    mass = "3629 g",
    volume = "10 L",
    length = "122 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "LEG_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "leg_stub_r", "leg_prosthetic_r", "foot_prosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_leg_prosthetic_0" } },
}

ccb.content.define_item {
    id = "left_leg_prosthetic",
    name = ccb.content.plural_text("prosthetic left leg", "prosthetic left legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  This one is for the left leg."),
    mass = "3629 g",
    volume = "10 L",
    length = "122 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "LEG_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "leg_stub_l", "leg_prosthetic_l", "foot_prosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_leg_prosthetic_0" } },
}

ccb.content.define_item {
    id = "right_peg_leg_old",
    name = ccb.content.plural_text("right peg leg", "right peg legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  A primitive peg leg, often remembered for pirate movies and such, this was a go-to replacement for decades for those who couldn't afford an iron or steel one.  This comes up above the knee and is fastened on with straps or rope, with the interior cushioned by stuffing.  This one is for the right leg."),
    mass = "3629 g",
    volume = "10 L",
    length = "122 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "wood", "cotton" },
    symbol = "|",
    color = "brown",
    flags = { "LEG_PROSTHETIC", "FRAGILE", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = { { encumbrance = 0, coverage = 100, covers = { "leg_stub_r", "leg_peg_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_peg_leg_old_0" } },
}

ccb.content.define_item {
    id = "left_peg_leg_old",
    name = ccb.content.plural_text("left peg leg", "left peg legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  A primitive peg leg, often remembered for pirate movies and such, this was a go-to replacement for decades for those who couldn't afford an iron or steel one.  This comes up above the knee and is fastened on with straps or rope, with the interior cushioned by stuffing.  This one is for the left leg."),
    mass = "3629 g",
    volume = "10 L",
    length = "122 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "wood", "cotton" },
    symbol = "|",
    color = "brown",
    flags = { "LEG_PROSTHETIC", "FRAGILE", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = { { encumbrance = 0, coverage = 100, covers = { "leg_stub_l", "leg_peg_l" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_peg_leg_old_0" } },
}

ccb.content.define_item {
    id = "right_leg_prosthetic_steel_old",
    name = ccb.content.plural_text("steel prosthetic right leg", "steel prosthetic right legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  Dating back to the Middle Ages and the Renaissance, this prosthetic is made of iron placed over a framework, and is attached with leather straps to the leg, padding placed inside for comfort.  Made in a better fashion than more common prosthetics at the time, this limb is incredibly durable, with many noble warriors wearing these into battle.  However, they were incredibly expensive, time-consuming to make, and quite heavy, leaving them out of the hands of poorer individuals.  This one is for the right leg."),
    mass = "8164 g",
    volume = "10 L",
    length = "122 cm",
    price = "7 kUSD",
    survival_price = "500 USD",
    accuracy = 1,
    materials = { "steel", "cotton" },
    symbol = "|",
    color = "light_gray",
    flags = { "LEG_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "leg_stub_r", "leg_prosthetic_r", "foot_prosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_leg_prosthetic_steel_old_0" } },
}

ccb.content.define_item {
    id = "left_leg_prosthetic_steel_old",
    name = ccb.content.plural_text("steel prosthetic left leg", "steel prosthetic left legs"),
    description = ccb.content.text("A prosthetic leg, used as a replacement limb for those missing one.  Dating back to the Middle Ages and the Renaissance, this prosthetic is made of iron placed over a framework, and is attached with leather straps to the leg, padding placed inside for comfort.  Made in a better fashion than more common prosthetics at the time, this limb is incredibly durable, with many noble warriors wearing these into battle.  However, they were incredibly expensive, time-consuming to make, and quite heavy, leaving them out of the hands of poorer individuals.  This one is for the left leg."),
    mass = "8164 g",
    volume = "10 L",
    length = "122 cm",
    price = "7 kUSD",
    survival_price = "500 USD",
    accuracy = 1,
    materials = { "steel", "cotton" },
    symbol = "|",
    color = "light_gray",
    flags = { "LEG_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "leg_stub_l", "leg_prosthetic_l", "foot_prosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_leg_prosthetic_steel_old_0" } },
}
