local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_mutant_tainted_cooked",
    copy_from = "meat_mutant_tainted",
    name = ccb.content.plural_text("cooked tainted mutant meat", "cooked tainted mutant meat"),
    snippet_category = "cooked_tainted_mutant_meat_desc",
    looks_like = "meat_cooked",
    comestible = { parasites = 0 },
    inheritance = {
        add = { flags = { "EATEN_HOT" } },
        remove = { flags = { "RAW" } },
        scale = { survival_price = 1.5, fun = 0.7 },
    },
}

ccb.content.define_item {
    id = "meat_mutant_tainted_smoked",
    copy_from = "meat_mutant_tainted_cooked",
    name = ccb.content.plural_text("smoked tainted mutant meat", "smoked tainted mutant meat"),
    description = ccb.content.text("Rotten mutant meat that has been heavily smoked for preservation."),
    comestible = { shelf_life = "42 days", quench = -1 },
    inheritance = { add = { flags = { "EATEN_HOT", "SMOKED" } }, scale = { survival_price = 1.8, fun = 0.7 } },
}
