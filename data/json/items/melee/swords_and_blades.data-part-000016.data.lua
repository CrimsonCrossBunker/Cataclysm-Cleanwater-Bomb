local ccb = require("ccb")

ccb.content.define_item {
    id = "katana",
    copy_from = "mc_katana",
    name = ccb.content.plural_text("katana", "katana"),
    description = ccb.content.text("A rare sword from Japan.  Deadly against unarmored targets, and still very effective against armor."),
    replace_materials = { mc_steel = "steel" },
    tool = {},
}
