local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad_advanced_on",
    copy_from = "armor_nomad_advanced",
    name = ccb.content.plural_text("advanced nomad jumpsuit (on)", "advanced nomad jumpsuits (on)"),
    description = ccb.content.text("A reinforced but airy jumpsuit designed to survive the long-term wear and tear of exploring the apocalyptic wasteland.  Rather than advanced polymer fabrics which may not be available in many worlds, it is made of breathable twill fabric with leather reinforcements ensuring it can be produced easily regardless of technology level.  Its clever construction adds additional core support, helping you to carry more equipment.  The internal cooling tubes are active and humming."),
    revert_to = "armor_nomad_advanced",
    flags = { "VARSIZE", "POCKETS", "STURDY", "USES_BIONIC_POWER", "MUNDANE", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "100 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The hum of the suit's climate control fades."),
            target = "armor_nomad_advanced",
        },
    },
}

ccb.content.define_item {
    id = "armor_nomad_light",
    name = ccb.content.plural_text("light nomad jumpsuit", "light nomad jumpsuits"),
    description = ccb.content.text("A light, airy jumpsuit designed to survive the long-term wear and tear of exploring the apocalyptic wasteland.  Rather than advanced polymer fabrics which may not be available in many worlds, it is made of breathable twill fabric with leather reinforcements ensuring it can be produced easily regardless of technology level.  Its clever construction adds additional core support, helping you to carry more equipment."),
    copy_from = "armor_nomad",
    survival_price = "12 USD 50 cent",
    materials = { "denim", "leather" },
    color = "light_gray",
    inheritance = { scale = { mass = 0.6, volume = 0.75, warmth = 0.75 } },
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 0.5 },
                    { id = "leather", coverage = 30, thickness = 1.5 },
                },
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                vitals_coverage = 30,
                coverage = 100,
                encumbrance = { 2, 2 },
                breathability = "AVERAGE",
            },
        },
        environmental_protection = 1,
        thickness = 0.5,
    },
    use_actions = {},
}
