local ccb = require("ccb")

ccb.content.define_item {
    id = "wakizashi",
    copy_from = "mc_wakizashi",
    name = ccb.content.plural_text("wakizashi", "wakizashi"),
    description = ccb.content.text("A comparatively-common Japanese short sword.  Smaller and lighter than a katana, but still effective in combat."),
    replace_materials = { mc_steel = "steel" },
    tool = {},
}
