local ccb = require("ccb")

ccb.content.define_item {
    id = "copper_infuser",
    copy_from = "copper_bracelet",
    qualities = { { id = "MANA_INFUSE", level = 1 } },
    name = ccb.content.text("copper infusion bracelet"),
    description = ccb.content.text("This bracelet has runes engraved on it.  You sense a faint air of mysticism when you look at it.  It would be useful for imbuing mana into material."),
    armor = {},
}

ccb.content.define_item {
    id = "silver_infuser",
    copy_from = "silver_bracelet",
    qualities = { { id = "MANA_INFUSE", level = 2 } },
    name = ccb.content.text("silver infusion bracelet"),
    description = ccb.content.text("This bracelet has runes engraved on it.  You sense a faint air of mysticism when you look at it.  It would be useful for imbuing mana into material."),
    armor = {},
}

ccb.content.define_item {
    id = "potion_starter",
    copy_from = "mixed_alcohol_strong",
    name = ccb.content.plural_text("potion starter", "potion starter"),
    description = ccb.content.text("Strong alcohol, infused with mana and concentrated into a liquid that can stabilize spells into liquid form.  You can still drink it, if you want."),
    comestible = {},
}

ccb.content.define_item {
    id = "potion_starter_superior",
    copy_from = "chem_ethanol",
    name = ccb.content.plural_text("superior potion starter", "superior potion starter"),
    description = ccb.content.text("Pure ethanol saturated with magical energy.  The sheer power concentrated within causes the surface of the potion to ripple continuously."),
    comestible = { kind = "DRINK", servings = 1 },
}

ccb.content.define_item {
    id = "adrenal_gland_large",
    copy_from = "meat",
    name = ccb.content.text("large adrenal gland"),
    description = ccb.content.text("An organ located above the kidneys responsible for secretion of adrenaline, cortisol, and aldosterone.  This one is huge, whether by nature or mutation."),
    price = "20 USD",
    comestible = { smoking_result = "null" },
}

ccb.content.define_item {
    id = "dragon_essence",
    symbol = "~",
    color = "light_red",
    name = ccb.content.plural_text("dragon essence", "dragon essence"),
    description = ccb.content.text("This is the magical essence from a dragon, distilled into a concentrated form."),
    volume = "250 ml",
    mass = "300 g",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    default_container = "flask_glass",
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, freezing_point = -73 },
}

ccb.content.define_item {
    id = "alumentum",
    category = "spare_parts",
    price = "9 USD",
    name = ccb.content.plural_text("alumentum", "alumentum"),
    symbol = "=",
    color = "light_blue",
    description = ccb.content.text("Alumentum is magically processed coal or charcoal.  It burns as hot as magnesium, and for a significantly longer period of time.  One of the very few magical materials that is still produced in any quantity today due to its usefulness."),
    phase = "solid",
    volume = "250 ml",
    mass = "11 g",
    materials = { "alumentum" },
    stack_size = 10,
    ammunition = { type = "alumentum", count = 50 },
}

ccb.content.define_item {
    id = "alchemist_bomb_act",
    category = "weapons",
    name = ccb.content.plural_text("mana bomb (lit)", "mana bombs (lit)"),
    description = ccb.content.text("The liquid in the bottle is sizzling.  Throwing it away from you, preferably at an enemy, would be a very good idea."),
    mass = "430 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -3,
    materials = { "concentrated_mana", "crystallized_mana" },
    symbol = "*",
    color = "red",
    explode_in_fire = true,
    flags = { "TRADER_AVOID" },
    melee_damage = { bash = 14 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("The reaction has already started - all you can do is get it away from you!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 200 } },
    blast = { power = 200 },
}

ccb.content.define_item {
    id = "copper_circlet",
    name = "copper circlet",
    description = "A wooden band with copper trimmings to be worn on the head.  Touching your temples with it on makes you feel very calm.",
    symbol = "[",
    color = "brown",
    category = "armor",
    mass = "700 g",
    volume = "600ml",
    price = "15 USD",
    survival_price = "1 USD",
    flags = { "BELTED", "PADDED" },
    materials = { "copper", "wood" },
    qualities = {
        { id = "MANA_FOCUS", level = 1 },
    },
    armor = {
        thickness = 1,
        warmth = 0,
        portions = {
            {
                covers = { "head" },
                coverage = 5,
                encumbrance = 1,
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_circlet",
    name = "silver circlet",
    description = "A wooden band with silver trimmings to be worn on the head.  Touching your temples with it on makes you feel very calm.",
    symbol = "[",
    color = "light_gray",
    category = "armor",
    mass = "700 g",
    volume = "600ml",
    price = "30 USD",
    survival_price = "2 USD",
    flags = { "BELTED", "PADDED" },
    materials = { "silver", "wood" },
    qualities = {
        { id = "MANA_FOCUS", level = 2, speed = 0.66 },
    },
    armor = {
        thickness = 1,
        warmth = 0,
        portions = {
            {
                covers = { "head" },
                coverage = 5,
                encumbrance = 1,
            },
        },
    },
}
