local ccb = require("ccb")

ccb.content.define_item {
    id = "zweihander",
    copy_from = "mc_zweihander",
    name = ccb.content.plural_text("zweihänder", "zweihänders"),
    description = ccb.content.text("A huge two-handed sword from Germany.  It packs a real wallop."),
    replace_materials = { mc_steel = "steel" },
    tool = {},
}
