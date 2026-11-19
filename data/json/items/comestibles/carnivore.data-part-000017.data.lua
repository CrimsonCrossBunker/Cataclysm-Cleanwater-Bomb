local ccb = require("ccb")

-- Not for use in any recipes except mutagenics.
ccb.content.define_item {
    id = "fat_tainted_human",
    copy_from = "fat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted human fat", "of tainted human fat chunks"),
    description = ccb.content.text("A watery yellow glob of fat from some zombified human.  Something is… wrong with it.  It doesn't seem like normal fat."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}
