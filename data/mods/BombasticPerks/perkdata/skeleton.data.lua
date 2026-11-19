local ccb = require("ccb")

ccb.content.define_item {
    id = "skeleton_plate",
    copy_from = "armor_lc_plate",
    name = ccb.content.plural_text("skeletal plate", "skeletal plates"),
    description = ccb.content.text("A full body multilayered suit of skeletal plate armor."),
    replace_materials = { lc_steel = "bone", lc_steel_chain = "flesh" },
    inheritance = {
        add = { flags = { "INTEGRATED", "UNBREAKABLE", "NO_SALVAGE" } },
        scale = { encumbrance = 0.3 },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}
