local ccb = require("ccb")

ccb.content.define_item {
    id = "cooked_elderberries",
    copy_from = "elderberries",
    name = ccb.content.plural_text("cooked elderberries", "cooked elderberries"),
    description = ccb.content.text("A serving of elderberries, cooked just enough to remove the toxins."),
    display_type = "BY_WEIGHT",
    flags = {},
    comestible = { kind = "FOOD" },
    use_actions = {},
}
