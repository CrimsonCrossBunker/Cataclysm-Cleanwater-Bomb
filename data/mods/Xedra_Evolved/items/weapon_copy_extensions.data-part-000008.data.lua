local ccb = require("ccb")

ccb.content.define_item {
    id = "club_wooden",
    copy_from = "club_wooden",
    name = ccb.content.plural_text("wooden club", "wooden clubs"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
