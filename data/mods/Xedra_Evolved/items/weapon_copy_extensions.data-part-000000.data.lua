local ccb = require("ccb")

ccb.content.define_item {
    id = "art_club",
    copy_from = "art_club",
    name = ccb.content.plural_text("ancient club", "ancient clubs"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "art_staff",
    copy_from = "art_staff",
    name = ccb.content.plural_text("ancient staff", "ancient staffs"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "art_spear",
    copy_from = "art_spear",
    name = ccb.content.plural_text("ancient spear", "ancient spears"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "bo",
    copy_from = "bo",
    name = ccb.content.plural_text("bō", "bō"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
