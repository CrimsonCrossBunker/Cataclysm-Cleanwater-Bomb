local ccb = require("ccb")

ccb.content.define_item {
    id = "tainted_innards",
    copy_from = "offal",
    name = ccb.content.plural_text("tainted innards", "tainted innards"),
    description = ccb.content.text("An unidentifiable selection of rotted innards that barely hold their form.  It is revolting and certainly no longer healthy to eat."),
    display_type = "BY_WEIGHT",
    snippet_category = "tainted_innards_desc",
    survival_price = "0 cent",
    comestible = { shelf_life = "4 hours", fun = -25 },
    use_actions = { "POISON" },
}
