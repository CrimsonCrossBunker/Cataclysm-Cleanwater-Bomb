local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "base_chainmail_arms",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("base chainmail sleeves", "base chainmail sleeves"),
    description = ccb.content.text("Customized chainmail arm protection.  Both sleeves have straps to connect them with each other.  They don't cover the hands, making them less cumbersome and allowing them to be worn with gloves."),
    mass = "2812 g",
    volume = "750 ml",
    length = "9 cm",
    price = "75 USD",
    survival_price = "25 USD",
    symbol = "[",
    looks_like = "armguard_metal",
    materials = { "steel" },
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            ablative = true,
            capacity = "2200 ml",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 1500,
            description = ccb.content.text("You can wear some armor over chainmail without penalty."),
            allowed_flags = { "ABLATIVE_CHAINMAIL_ARMS" },
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
            allowed_flags = { "ABLATIVE_CHAINMAIL_ELBOWS" },
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
}
