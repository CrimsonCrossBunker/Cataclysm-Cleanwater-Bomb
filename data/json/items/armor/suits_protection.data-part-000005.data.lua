local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_sjumpsuit",
    abstract = true,
    copy_from = "base_chainmail_hauberk",
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
    description = ccb.content.text("A fully customized chainmail outfit, covering torso and arms.  Combine with a aketon or other padded layer for optimal protection."),
    mass = "10669 g",
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
                covers = { "torso", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
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
    id = "xl_chainmail_sjumpsuit",
    abstract = true,
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
    copy_from = "base_chainmail_sjumpsuit",
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
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
    armor = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "xs_chainmail_sjumpsuit",
    abstract = true,
    copy_from = "base_chainmail_sjumpsuit",
    name = ccb.content.text_without_extraction("chainmail sleeveless jumpsuit"),
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
