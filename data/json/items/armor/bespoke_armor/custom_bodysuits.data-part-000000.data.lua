local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad",
    name = ccb.content.plural_text("nomad jumpsuit", "nomad jumpsuits"),
    description = ccb.content.text("A reinforced but airy jumpsuit designed to survive the long-term wear and tear of exploring the apocalyptic wasteland.  Rather than advanced polymer fabrics which may not be available in many worlds, it is made of breathable twill fabric with leather reinforcements ensuring it can be produced easily regardless of technology level.  Its clever construction adds additional core support, helping you to carry more equipment."),
    mass = "3600 g",
    volume = "3500 ml",
    survival_price = "17 USD 50 cent",
    materials = { "denim", "leather" },
    symbol = "[",
    looks_like = "touring_suit",
    color = "light_red",
    flags = { "VARSIZE", "POCKETS", "STURDY", "MUNDANE" },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 50, thickness = 1.5 },
                },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                vitals_coverage = 40,
                coverage = 100,
                encumbrance = { 6, 6 },
                breathability = "AVERAGE",
            },
        },
        environmental_protection = 2,
        warmth = 10,
        thickness = 2,
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_0" } },
}

ccb.content.define_item {
    id = "armor_nomad_advanced",
    name = ccb.content.plural_text("advanced nomad jumpsuit", "advanced nomad jumpsuits"),
    description = ccb.content.text("A reinforced but airy jumpsuit designed to survive the long-term wear and tear of exploring the apocalyptic wasteland.  Rather than advanced polymer fabrics which may not be available in many worlds, it is made of breathable twill fabric with leather reinforcements ensuring it can be produced easily regardless of technology level.  Its clever construction adds additional core support, helping you to carry more equipment.  A set of cooling tubes run throughout the clothing as well."),
    mass = "4000 g",
    volume = "3500 ml",
    price = "350 USD",
    survival_price = "17 USD 50 cent",
    materials = { "denim", "leather" },
    symbol = "[",
    looks_like = "touring_suit",
    color = "light_red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
        {
            kind = "CONTAINER",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            moves = 80,
            max_item_length = "15 cm",
            description = ccb.content.text("Pants pocket."),
        },
    },
    flags = { "VARSIZE", "POCKETS", "STURDY", "USES_BIONIC_POWER", "MUNDANE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 1.0 },
                    { id = "leather", coverage = 50, thickness = 1.5 },
                },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                vitals_coverage = 40,
                coverage = 100,
                encumbrance = { 6, 6 },
                breathability = "AVERAGE",
            },
        },
        environmental_protection = 2,
        warmth = 10,
        thickness = 4,
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_advanced_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_advanced_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}
