local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_goblin_teeth",
    copy_from = "integrated_fangs",
    category = "armor",
    name = ccb.content.plural_text("goblin teeth", "goblin teeth"),
    description = ccb.content.text("A set of goblin teeth, small but needle-sharp."),
    techniques = { "FANGS_BITE_GOBLIN", "FANGS_BITE_GOBLIN_GRAB", "FANGS_BITE_GOBLIN_CRIT" },
    melee_damage = { stab = 6 },
    armor = {},
}

ccb.content.define_item {
    id = "integrated_lizardfolk_teeth",
    copy_from = "integrated_fangs",
    category = "armor",
    name = ccb.content.plural_text("lizardfolk teeth", "lizardfolk teeth"),
    description = ccb.content.text("A set of lizardfolk teeth, made for biting chunks of out their prey."),
    techniques = { "FANGS_BITE_LIZARDFOLK", "LIZARDFOLK_BITE_CRIT" },
    melee_damage = { stab = 20 },
    armor = {},
}

ccb.content.define_item {
    id = "integrated_raven_feathers",
    copy_from = "integrated_feathers",
    name = ccb.content.plural_text("feathers", "feathers"),
    armor = {
        portions = {
            {
                materials = { { id = "mut_feather", coverage = 100, thickness = 4 } },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "leg_l", "leg_r", "arm_l", "arm_r", "torso",
                    "head", "wing_ravenfolk_l", "wing_ravenfolk_r",
                },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_scaled_hands",
    category = "armor",
    name = ccb.content.plural_text("talons", "talons"),
    description = ccb.content.text("Your scales have grown to cover your hands and elongate the tips in to jagged claws that can be serviceable as cutting and piercing weapons in unarmed combat."),
    mass = "100 g",
    volume = "350 ml",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 6 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "black_dragon_scales" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 5, stab = 5 },
    armor = {
        portions = {
            {
                materials = { { id = "black_dragon_scales", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_demon_claws",
    category = "armor",
    name = ccb.content.plural_text("talons", "talons"),
    description = ccb.content.text("Your index fingers have become talons.  They make for wicked natural daggers.  Unfortunately, they get in the way of everything including gloves."),
    mass = "100 g",
    volume = "350 ml",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 12 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "demon_chitin" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 10 },
    armor = {
        portions = {
            {
                materials = { { id = "demon_chitin", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 10,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_dragon_talons_black",
    category = "armor",
    name = ccb.content.plural_text("talons", "talons"),
    description = ccb.content.text("All of your fingers have developed into huge scaled talons.  They prevent wearing gloves, but you can use them to powerful effect in melee combat and you appear to have uncovered some secrets about black dragons."),
    mass = "100 g",
    volume = "350 ml",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 12 } },
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "black_dragon_scales" },
    symbol = ";",
    color = "dark_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "NO_SALVAGE" },
    melee_damage = { cut = 10, stab = 10 },
    armor = {
        portions = {
            {
                materials = { { id = "black_dragon_scales", coverage = 100, thickness = 3 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 7,
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_black_dragonscale",
    category = "armor",
    name = ccb.content.plural_text("Black dragon scales", "Black dragon scales"),
    description = ccb.content.text("Thin but as tough as titanium, your draconic black scale can even withstand bullets from small firearms"),
    mass = "3 kg",
    volume = "2400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "x",
    color = "dark_gray",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "WATER_FRIENDLY",
        "IRRITANT_IMMUNE", "PADDED", "TOUGH_FEET", "ALLOWS_TALONS", "NO_SALVAGE",
    },
    armor = {
        warmth = 5,
        environmental_protection = 4,
        portions = {
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 2.0 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 3.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 8,
            },
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 2.0 },
                },
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 6,
            },
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 1.0 },
                },
                covers = { "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 4,
            },
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 1.0 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                },
                coverage = 100,
                encumbrance = 4,
            },
            {
                materials = { { id = "black_dragon_hide", coverage = 100, thickness = 2.0 } },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                coverage = 100,
                encumbrance = 1,
            },
            {
                materials = {
                    { id = "black_dragon_hide", coverage = 100, thickness = 2.0 },
                    { id = "black_dragon_scales", coverage = 95, thickness = 1.0 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 3,
            },
        },
    },
}
