local ccb = require("ccb")

ccb.content.define_item {
    id = "leather_journal",
    copy_from = "leather_journal",
    name = ccb.content.plural_text("leather journal", "leather journals"),
    looks_like = "book_nonf_soft_psych_cggamers",
    inheritance = { add = { flags = { "TRADER_AVOID", "CALORIES_INTAKE" } } },
    tool = {},
    use_actions = { "CALORIES_INTAKE_TRACKER" },
}
