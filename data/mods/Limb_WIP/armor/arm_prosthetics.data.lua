local ccb = require("ccb")

ccb.content.define_item {
    id = "right_arm_prosthetic",
    name = ccb.content.plural_text("prosthetic right arm", "prosthetic right arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  With grips attached to the hands and inbuilt springs, this prosthetic also allows some use of function.  This one is for the right arm."),
    mass = "2000 g",
    volume = "8 L",
    length = "50 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_r", "arm_prosthetic_r", "hand_prosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_0" } },
}

ccb.content.define_item {
    id = "left_arm_prosthetic",
    name = ccb.content.plural_text("prosthetic left arm", "prosthetic left arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  With grips attached to the hands and inbuilt springs, this prosthetic also allows some use of function.  This one is for the left arm."),
    mass = "2000 g",
    volume = "8 L",
    length = "50 cm",
    price = "5 kUSD",
    survival_price = "200 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_l", "arm_prosthetic_l", "hand_prosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_0" } },
}

ccb.content.define_item {
    id = "right_arm_neuroprosthetic",
    name = ccb.content.plural_text("neuroprosthetic right arm", "neuroprosthetic right arms"),
    description = ccb.content.text("A neuroprosthetic arm, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  As a bleeding edge design, this one relies on wires attached to the forehead to provide motor input, allowing the arm to be operated just like the original limb, a precious commodity in these times.  This one is for the right arm."),
    mass = "2000 g",
    volume = "8 L",
    length = "50 cm",
    price = "7 kUSD 500 USD",
    survival_price = "1 kUSD 500 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_r", "arm_neuroprosthetic_r", "hand_neuroprosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_arm_neuroprosthetic_0" } },
}

ccb.content.define_item {
    id = "left_arm_neuroprosthetic",
    name = ccb.content.plural_text("neuroprosthetic left arm", "neuroprosthetic left arms"),
    description = ccb.content.text("A neuroprosthetic arm, used as a replacement limb for those missing one.  Its modern design and sleek ergonomics make it very comfortable and highly suitable for use, and advanced designing makes it look exactly like the original.  As a bleeding edge design, this one relies on wires attached to the forehead to provide motor input, allowing the arm to be operated just like the original limb, a precious commodity in these times.  This one is for the left arm."),
    mass = "2000 g",
    volume = "8 L",
    length = "50 cm",
    price = "7 kUSD 500 USD",
    survival_price = "1 kUSD 500 USD",
    accuracy = 1,
    materials = { "steel", "plastic" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_l", "arm_neuroprosthetic_l", "hand_neuroprosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_arm_neuroprosthetic_0" } },
}

ccb.content.define_item {
    id = "right_arm_prosthetic_wood_old",
    name = ccb.content.plural_text("wooden prosthetic right arm", "wooden prosthetic right arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Dating back to antiquity, this wooden arm was often used by many individuals as a simple way to hide the loss of one of their limbs.  Outside of that, its rigidity and lack of flexibility make it nearly useless for practical purposes, though it can help with very basic tasks, like lifting objects.  This one is for the right arm."),
    mass = "3154 g",
    volume = "8 L",
    length = "50 cm",
    price = "300 USD",
    survival_price = "130 USD",
    accuracy = 1,
    materials = { "wood", "cotton" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_r", "arm_prosthetic_cosmetic_r", "hand_prosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_wood_old_0" } },
}

ccb.content.define_item {
    id = "left_arm_prosthetic_wood_old",
    name = ccb.content.plural_text("wooden prosthetic left arm", "wooden prosthetic left arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Dating back to antiquity, this wooden arm was often used by many individuals as a simple way to hide the loss of one of their limbs.  Outside of that, its rigidity and lack of flexibility make it nearly useless for practical purposes, though it can help with very basic tasks, like lifting objects.  This one is for the left arm."),
    mass = "3154 g",
    volume = "8 L",
    length = "50 cm",
    price = "300 USD",
    survival_price = "130 USD",
    accuracy = 1,
    materials = { "wood", "cotton" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_l", "arm_prosthetic_cosmetic_l", "hand_prosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_wood_old_0" } },
}

ccb.content.define_item {
    id = "right_arm_prosthetic_steel_old",
    name = ccb.content.plural_text("steel prosthetic right arm", "steel prosthetic right arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Dating back to the Middle Ages and Renaissance, this metallic arm was the cutting edge replacement of its day.  Hinges within the fingers and a simple locking system allow basic function of this prosthetic, such as holding a sword.  Often given to knights and nobility, this arm is quite heavy, but extremely durable.  This one is for the right arm."),
    mass = "4529 g",
    volume = "8 L",
    length = "50 cm",
    price = "700 USD",
    survival_price = "400 USD",
    accuracy = 1,
    materials = { "steel", "leather" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_r", "arm_prosthetic_r", "hand_prosthetic_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_steel_old_0" } },
}

ccb.content.define_item {
    id = "left_arm_prosthetic_steel_old",
    name = ccb.content.plural_text("steel prosthetic left arm", "steel prosthetic left arms"),
    description = ccb.content.text("A prosthetic arm, used as a replacement limb for those missing one.  Dating back to the Middle Ages and Renaissance, this metallic arm was the cutting edge replacement of its day.  Hinges within the fingers and a simple locking system allow basic function of this prosthetic, such as holding a sword.  Often given to knights and nobility, this arm is quite heavy, but extremely durable.  This one is for the left arm."),
    mass = "4529 g",
    volume = "8 L",
    length = "50 cm",
    price = "700 USD",
    survival_price = "400 USD",
    accuracy = 1,
    materials = { "steel", "leather" },
    symbol = "|",
    color = "brown",
    flags = { "ARM_PROSTHETIC", "PADDED", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_stub_l", "arm_prosthetic_l", "hand_prosthetic_l" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_steel_old_0" } },
}
