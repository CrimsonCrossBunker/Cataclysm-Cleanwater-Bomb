local ccb = require("ccb")

ccb.content.define_item {
    id = "naginata",
    copy_from = "naginata",
    name = ccb.content.plural_text("naginata", "naginata"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "pike",
    copy_from = "pike",
    name = ccb.content.plural_text("pike", "pikes", "weapon"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "q_staff",
    copy_from = "q_staff",
    name = ccb.content.plural_text("quarterstaff", "quarterstaves"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
