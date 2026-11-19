local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_nomad_heavyplate",
    copy_from = "armor_lc_heavyplate",
    name = ccb.content.plural_text("nomad heavy plate armor", "nomad heavy plate armors"),
    description = ccb.content.text("A full body multilayered heavy suit of plate armor with a 6 mm thick chest piece.  The medium steel has been quenched, tempered and affixed over a full-body layered suit of weight-distributing straps.  The armor has an integrated breathable Lycra jumpsuit and the torso has a spall liner of aramid panels.  Electronics run below the surface and circulate cool air to the skin, drawing power from your internal CBM reservoir."),
    materials = { "qt_steel", "qt_steel_chain", "lycra", "kevlar" },
    inheritance = { add = { flags = { "NORMAL", "MUNDANE", "USES_BIONIC_POWER" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 4.8 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 2.0 },
                    { id = "kevlar", coverage = 100, thickness = 2.0 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 27,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 1.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 1.05 },
                    { id = "qt_steel_chain", coverage = 100, thickness = 1.2 },
                    { id = "lycra", coverage = 100, thickness = 4.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 20,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_armor_nomad_heavyplate_0", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the climate control on."),
            target = "armor_nomad_heavyplate_on",
            need_charges_message = ccb.content.text("Your internal reservoir is empty."),
        },
    },
}
