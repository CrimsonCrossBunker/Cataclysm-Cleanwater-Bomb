local ccb = require("ccb")

ccb.content.define_item {
    id = "pike_wood",
    copy_from = "pike_wood",
    name = ccb.content.plural_text("wooden pike", "wooden pikes", "weapon"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
