local ccb = require("ccb")

ccb.content.define_item {
    id = "scimitar",
    copy_from = "mc_scimitar",
    looks_like = "katana",
    name = ccb.content.plural_text("shamshir", "shamshirs"),
    description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries.  Designed for slashing, and quite deadly against unarmored targets."),
    replace_materials = { mc_steel = "steel", leather = "wood" },
    tool = {},
}
