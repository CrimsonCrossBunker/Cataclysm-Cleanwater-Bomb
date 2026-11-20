local ccb = require("ccb")

ccb.content.define_item {
    id = "longsword",
    copy_from = "mc_longsword",
    name = ccb.content.plural_text("longsword", "longswords"),
    description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard compared to smaller swords."),
    replace_materials = { mc_steel = "steel" },
    tool = {},
}
