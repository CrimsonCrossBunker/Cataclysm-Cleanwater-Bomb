local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_legs",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("base chainmail leggings", "base chainmail leggings"),
    description = ccb.content.text("Customized chainmail leggings.  Their straps keep everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    mass = "4212 g",
    volume = "1500 ml",
    length = "11 cm",
    price = "75 USD",
    survival_price = "20 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3300 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "900 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("chainmail leggings", "chainmail leggings"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("chainmail leggings", "chainmail leggings"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_legs",
    name = ccb.content.text_without_extraction("base chainmail half-leggings", "base chainmail half-leggings"),
    description = ccb.content.text("Customized partial chainmail leggings only covering the front and sides of the legs.  The zigzagging lace at the back keeps everything in place, and the lack of toes and heels allows them to work perfectly well with footwear."),
    mass = "3159 g",
    volume = "1125 ml",
    length = "10 cm",
    price = "56 USD 25 cent",
    survival_price = "15 USD",
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                coverage = 75,
                encumbrance = 11,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_half_legs",
    name = ccb.content.text_without_extraction("chainmail half-leggings", "chainmail half-leggings"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "3800 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "1050 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_half_legs",
    abstract = true,
    copy_from = "base_chainmail_half_legs",
    name = ccb.content.text_without_extraction("chainmail half-leggings", "chainmail half-leggings"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_LEGS" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "700 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1000,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_KNEES" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}
