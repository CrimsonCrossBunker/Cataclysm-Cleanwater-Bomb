local ccb = require("ccb")

-- Based on security vests like https://www.masadagear.com/p/masada_armour_%E2%80%8Bun_bullet_proof_vest
-- encumbrance handled above
ccb.content.define_item {
    id = "level_3_vest",
    category = "armor",
    name = ccb.content.text("hard armor vest"),
    looks_like = "ballistic_vest_esapi",
    variants = {
        {
            id = "fema_armor_vest",
            name = ccb.content.text("humanitarian ballistic vest"),
            description = ccb.content.text("Bright blue in color, this slim armor vest was used by volunteers and officials from humanitarian groups during the first days of the Cataclysm before order broke down completely.  \"FEMA\" is written on the front lapel and across the back."),
            color = "blue",
        },
        {
            id = "police_armor_vest",
            name = ccb.content.text("police ballistic vest"),
            description = ccb.content.text("This charcoal-colored body armor was once a common sight on police officers, and it provides adequate protection against small-caliber firearms in addition to featuring pouches to hold armor inserts.  \"POLICE\" is written on the front lapel and across the back."),
        },
        {
            id = "national_guard_armor_vest",
            name = ccb.content.text("National Guard ballistic vest"),
            description = ccb.content.text("Styled in urban camo, this ballistic vest was issued to soldiers, and as things got worse, to volunteers as well.  It was designed to stand out after the chaos of the riots; \"US ARMY\" is emblazoned on the front lapel next to a patch of the United States flag, and \"NATIONAL GUARD\" is written across the back."),
        },
    },
    variant_kind = "generic",
    description = ccb.content.text("Armored panels give this vest solid defense against small caliber firearms, and front and back pockets for hard armor panels give protection from higher calibers."),
    mass = "2650 g",
    volume = "6 L",
    price = "700 USD",
    survival_price = "5 USD",
    symbol = "[",
    materials = { "nylon", "kevlar_layered" },
    color = "light_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2000 ml",
            mass_limit = "5 kg",
            max_item_length = "33 cm",
            moves = 800,
            description = ccb.content.text("Pocket for a large armor plate."),
            allowed_flags = { "ABLATIVE_LARGE" },
        },
    },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 4,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_upper" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 95, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
        },
    },
}
