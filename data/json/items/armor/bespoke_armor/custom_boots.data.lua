local ccb = require("ccb")

ccb.content.define_item {
    id = "boots_survivor",
    category = "armor",
    name = ccb.content.plural_text("handmade hazard boots (pair)", "handmade hazard boots (pair)"),
    description = ccb.content.text("Custom boots of treated leather sealed with polymer coating.  Tough and acid-proof with steel toes for extra safety."),
    mass = "1330 g",
    volume = "2500 ml",
    survival_price = "60 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather_treated", "rubber", "vinyl", "hc_steel" },
    symbol = "[",
    looks_like = "boots_combat",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 12,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_heel_r",
                    "foot_heel_l",
                },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 3.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                encumbrance = 22,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 3.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                    { id = "hc_steel", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 1.0 },
                    { id = "rubber", coverage = 100, thickness = 5.0 },
                },
                encumbrance = 0,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_xlsurvivor",
    copy_from = "boots_survivor",
    name = ccb.content.plural_text("handmade hazard boots (pair)", "handmade hazard boots (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.4, volume = 1.4 } },
}

ccb.content.define_item {
    id = "boots_xssurvivor",
    copy_from = "boots_survivor",
    name = ccb.content.plural_text("handmade hazard boots (pair)", "handmade hazard boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_survivor_hoof",
    category = "armor",
    name = ccb.content.plural_text("handmade hazard hoof boots (pair)", "handmade hazard hoof boots (pair)"),
    description = ccb.content.text("Custom boots of treated leather sealed with polymer coating, specially tailored for mutant hoof-feet.  Tough and acid-proof with steel toes to give them some extra kick."),
    mass = "1330 g",
    volume = "2500 ml",
    survival_price = "0 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather_treated", "rubber", "vinyl", "hc_steel" },
    symbol = "[",
    looks_like = "boots_survivor",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OVERSIZE", "MUTATED_ANATOMY_ONLY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 12,
        portions = {
            {
                covers = { "hoof_l", "hoof_r" },
                subparts = { "hoof_wall_l", "hoof_wall_r" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 3.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                encumbrance = 22,
                coverage = 100,
            },
            {
                covers = { "hoof_l", "hoof_r" },
                subparts = { "hoof_fetlock_l", "hoof_fetlock_r" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 3.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                    { id = "hc_steel", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 100,
            },
            {
                covers = { "hoof_l", "hoof_r" },
                subparts = { "hoof_sole_l", "hoof_sole_r" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 1.0 },
                    { id = "rubber", coverage = 100, thickness = 5.0 },
                },
                encumbrance = 0,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "boots_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur hazard boots (pair)", "handmade faux fur hazard boots (pair)"),
    description = ccb.content.text("Custom boots of treated leather, sealed with polymer coating and lined with faux fur.  Warm and acid-proof with steel toes for protection."),
    mass = "1760 g",
    volume = "3500 ml",
    survival_price = "60 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather_treated", "vinyl", "faux_fur", "hc_steel" },
    symbol = "[",
    looks_like = "boots_fur",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 70,
        thickness = 4,
        environmental_protection = 12,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_heel_r",
                    "foot_heel_l",
                },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 2.0 },
                    { id = "faux_fur", coverage = 100, thickness = 2.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                encumbrance = 26,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 2.0 },
                    { id = "faux_fur", coverage = 100, thickness = 2.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                    { id = "hc_steel", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 0.5 },
                    { id = "faux_fur", coverage = 100, thickness = 0.5 },
                    { id = "rubber", coverage = 100, thickness = 5.0 },
                },
                encumbrance = 0,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_wsurvivor_nofur",
    copy_from = "boots_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur hazard boots (pair)", "handmade faux fur hazard boots (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_wsurvivor_nofur",
    copy_from = "boots_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur hazard boots (pair)", "handmade faux fur hazard boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "boots_wsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade winterized hazard boots (pair)", "handmade winterized hazard boots (pair)"),
    description = ccb.content.text("Custom boots of treated leather, sealed with polymer coating and lined with fur.  Warm and acid-proof with steel toes for protection."),
    mass = "1760 g",
    volume = "3500 ml",
    survival_price = "60 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "leather_treated", "vinyl", "fur", "hc_steel" },
    symbol = "[",
    looks_like = "boots_fur",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 70,
        thickness = 4,
        environmental_protection = 12,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_ankle_r",
                    "foot_ankle_l",
                    "foot_arch_r",
                    "foot_arch_l",
                    "foot_heel_r",
                    "foot_heel_l",
                },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 2.0 },
                    { id = "fur", coverage = 100, thickness = 2.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                encumbrance = 26,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 2.0 },
                    { id = "fur", coverage = 100, thickness = 2.0 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                    { id = "hc_steel", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 0,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather_treated", coverage = 100, thickness = 0.5 },
                    { id = "fur", coverage = 100, thickness = 0.5 },
                    { id = "rubber", coverage = 100, thickness = 5.0 },
                },
                encumbrance = 0,
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_boots_wsurvivor",
    name = ccb.content.plural_text("handmade winterized hazard boots (pair)", "handmade winterized hazard boots (pair)"),
    copy_from = "boots_wsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.3, volume = 1.3 } },
}

ccb.content.define_item {
    id = "xs_boots_wsurvivor",
    copy_from = "boots_wsurvivor",
    name = ccb.content.plural_text("handmade winterized hazard boots (pair)", "handmade winterized hazard boots (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
