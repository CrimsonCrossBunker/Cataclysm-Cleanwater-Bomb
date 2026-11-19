local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_mutant_tainted",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("chunk of tainted mutant meat", "of tainted mutant meat chunks"),
    color = "magenta",
    snippet_category = "tainted_mutant_meat_desc",
    looks_like = "meat",
    price = "0 cent",
    survival_price = "5 cent",
    flags = { "TRADER_AVOID", "BAD_TASTE", "RAW" },
    comestible = {
        cooks_like = "meat_mutant_tainted_cooked",
        cooked_item = "meat_mutant_tainted_cooked",
        cooking_energy = "300 kJ",
        shelf_life = "4 hours",
        fun = -15,
        smoking_result = "meat_mutant_tainted_smoked",
    },
    use_actions = { "POISON" },
}
