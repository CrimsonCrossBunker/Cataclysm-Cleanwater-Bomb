local ccb = require("ccb")

ccb.content.define_item {
    id = "tainted_marrow_human",
    copy_from = "tainted_marrow",
    category = "other",
    name = ccb.content.plural_text("portion of tainted human bone marrow", "of tainted human bone marrow portions"),
    description = ccb.content.text("A wet, green chunk of spongy goop extracted from a rotten human bone.  You could eat it, but it will poison you."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}
