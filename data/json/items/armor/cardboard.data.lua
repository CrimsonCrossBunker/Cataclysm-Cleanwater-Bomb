local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_cardboard",
    category = "armor",
    looks_like = "helmet_larmor",
    name = ccb.content.text("cardboard 'great' helm"),
    description = ccb.content.text("A cardboard helmet shaped to look like a medieval great helm.  Very unencumbering in comparison to actual helmets, with rather obvious drawbacks in exchange.  The interior is lined with aluminum, apparently to 'divert the zombie beta rays'.  It sure doesn't help with comfort."),
    mass = "1250 g",
    volume = "2750 ml",
    price = "400 USD",
    survival_price = "50 USD",
    materials = { "cardboard", "aluminum" },
    symbol = "[",
    color = "brown_yellow",
    techniques = { "WBLOCK_1" },
    flags = { "WATER_DISSOLVE", "VARSIZE", "HARD", "PSYSHIELD_PARTIAL", "FRAGILE" },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 15 },
            { covers = { "eyes" }, rigid_only = true, coverage = 95, encumbrance = 15 },
        },
        warmth = 15,
        thickness = 5,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "armor_cardboard",
    category = "armor",
    looks_like = "armor_larmor",
    name = ccb.content.text("cardboard 'plate' armor"),
    description = ccb.content.text("A set of cardboard armor that's been duct taped and superglued into place, with paper padding the interior in an unsuccessful attempt to increase comfort.  Despite the triple-layering, tensile and shear strength diagrams, and careful design considerations, there's just no way this is going to hold up to a single attack."),
    mass = "3450 g",
    volume = "17500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "cardboard", "paper" },
    symbol = "[",
    color = "brown_yellow",
    length = "120 cm",
    flags = { "WATER_DISSOLVE", "OUTER", "BLOCK_WHILE_WORN", "HARD", "FRAGILE" },
    armor = {
        warmth = 15,
        thickness = 2,
        portions = {
            {
                materials = {
                    { id = "cardboard", coverage = 95, thickness = 2.5 },
                    { id = "paper", coverage = 100, thickness = 0.3 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "cardboard", coverage = 95, thickness = 2.5 },
                    { id = "paper", coverage = 100, thickness = 0.3 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 21,
            },
            {
                materials = {
                    { id = "cardboard", coverage = 95, thickness = 2.5 },
                    { id = "paper", coverage = 100, thickness = 0.3 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 23,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_cardboard_cuirass",
    looks_like = "hoodie_brown",
    name = ccb.content.plural_text("cardboard cuirass", "cardboard cuirasses"),
    category = "armor",
    description = ccb.content.text("While this isn't quite the 'heavy ballistic vest' the blueprints pretend it is, the layering makes it almost passable as a form of extremely rudimentary armor.  It's still nowhere near as good as basically any other choice, while still being hard to move around in."),
    mass = "2105 g",
    volume = "6 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "cardboard", "paper" },
    symbol = "[",
    color = "brown_yellow",
    length = "60 cm",
    flags = { "WATER_DISSOLVE", "FRAGILE_MELEE", "VARSIZE", "OUTER", "HARD" },
    armor = {
        warmth = 15,
        thickness = 6,
        portions = { { encumbrance = 12, coverage = 90, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "cardboard_crown",
    name = ccb.content.plural_text("cardboard crown", "cardboard crowns"),
    description = ccb.content.text("A piece of cardboard crudely bent into shape and cut to look like a crown."),
    mass = "200 g",
    volume = "100 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "cardboard" },
    looks_like = "crown_golden",
    symbol = "[",
    color = "brown_yellow",
    flags = { "WATER_DISSOLVE", "FRAGILE_MELEE", "NO_WEAR_EFFECT", "FRAGILE", "SOFT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Loosen"),
            target = "cardboard_crown_loose",
            message = ccb.content.text("You loosen your cardboard crown."),
        },
    },
}

ccb.content.define_item {
    id = "cardboard_crown_loose",
    name = ccb.content.plural_text("cardboard crown (loosened)", "cardboard crowns (loosened)"),
    description = ccb.content.text("A piece of cardboard crudely bent into shape and cut to look like a crown.  This one's been loosened up somewhat, allowing it to be worn over some headgear comfortably."),
    copy_from = "cardboard_crown",
    flags = {
        "WATER_DISSOLVE",
        "FRAGILE_MELEE",
        "NO_WEAR_EFFECT",
        "FRAGILE",
        "OUTER",
        "POWERARMOR_COMPATIBLE",
        "SOFT",
    },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Adjust"),
            target = "cardboard_crown",
            message = ccb.content.text("You adjust your cardboard crown."),
        },
    },
}

ccb.content.define_item {
    id = "badge_cardboard",
    copy_from = "badge_abstract",
    name = ccb.content.text("cardboard badge"),
    description = ccb.content.text("An honorable badge identifying the owner as a \"Knight Errant\" of \"House Da\".  The large letters slowly dwindle in size as the badge runs out of space, leaving out the last two letters of Dino Dave's name."),
    flags = { "WATER_DISSOLVE", "FRAGILE_MELEE", "NO_WEAR_EFFECT", "FRAGILE" },
    armor = {},
}
