local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_tainted_human",
    copy_from = "meat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted human meat", "of tainted human meat chunks"),
    description = ccb.content.text("A piece of rotted meat that has been harvested from something human, or at the very least something once human, as if cannibalism wasn't abhorrent enough."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}
