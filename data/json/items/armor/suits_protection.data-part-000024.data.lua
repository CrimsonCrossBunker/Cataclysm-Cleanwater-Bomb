local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad_chainmail",
    copy_from = "qt_chainmail_jumpsuit",
    name = ccb.content.plural_text("nomad chainmail", "suits of nomad chainmail"),
    mass = "17200 g",
    volume = "7000 ml",
    description = ccb.content.text("A full body multilayered chainmail outfit.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 16,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 14,
            },
            {
                materials = {
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 14,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_chainmail_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_chainmail_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}
