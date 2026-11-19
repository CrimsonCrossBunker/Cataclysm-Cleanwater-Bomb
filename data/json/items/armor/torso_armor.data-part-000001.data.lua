local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_vest",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("base chainmail vest"),
    description = ccb.content.text("A customized mild steel chainmail vest.  It's a sleeveless piece of chainmail with small straps designed to better distribute the weight."),
    mass = "6894 g",
    volume = "1 L",
    length = "10 cm",
    price = "100 USD",
    survival_price = "20 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "vest_leather",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "9350 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    armor = {
        warmth = 0,
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 50,
                encumbrance = 0,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "gastropod_foot" },
                coverage = 50,
                encumbrance = 0,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                encumbrance = 0,
                coverage = 50,
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 50,
                encumbrance = 0,
            },
        },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "xl_chainmail_vest",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail vest"),
    copy_from = "base_chainmail_vest",
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "10500 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_vest",
    abstract = true,
    copy_from = "base_chainmail_vest",
    name = ccb.content.text_without_extraction("chainmail vest"),
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "7000 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_TORSO" },
        },
    },
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
    armor = {},
}
