local ccb = require("ccb")

ccb.content.define_item {
    id = "iso_old_sword",
    copy_from = "mc_longsword",
    name = ccb.content.plural_text("ancient sword", "ancient swords"),
    description = ccb.content.text("A longsword worn down by countless battles.  It was once finely engraved."),
    flags = { "UNBREAKABLE_MELEE", "CONDUCTIVE", "SHEATH_SWORD" },
    tool = {},
}

ccb.content.define_item {
    id = "iso_old_armor",
    copy_from = "armor_lc_plate",
    name = ccb.content.plural_text("envoy's armor", "envoy's armors"),
    description = ccb.content.text("A suit of armor worn down by an endless journey.  Only its sturdiest parts remain now."),
    materials = { "qt_steel", "qt_steel_chain", "leather", "wool" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 0.55 },
                    { id = "wool", coverage = 100, thickness = 2.8 },
                    { id = "leather", coverage = 5, thickness = 1.5 },
                },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                layers = { "NORMAL", "OUTER" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = {
                    { id = "qt_steel", coverage = 95, thickness = 2.8 },
                    { id = "wool", coverage = 100, thickness = 2.8 },
                    { id = "leather", coverage = 5, thickness = 1.5 },
                },
                covers = { "torso" },
                coverage = 100,
                vitals_coverage = 60,
                layers = { "NORMAL", "OUTER" },
                encumbrance = 10,
            },
        },
    },
}
