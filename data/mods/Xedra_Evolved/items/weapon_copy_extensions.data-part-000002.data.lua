local ccb = require("ccb")

ccb.content.define_item {
    id = "cudgel",
    copy_from = "cudgel",
    name = ccb.content.plural_text("cudgel", "cudgels"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "spear_wood",
    copy_from = "spear_wood",
    name = ccb.content.plural_text("fire-hardened wooden spear", "fire-hardened wooden spears"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "spear_homemade_halfpike",
    copy_from = "spear_homemade_halfpike",
    name = ccb.content.plural_text("homemade halfpike", "homemade halfpikes"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "i_staff",
    copy_from = "i_staff",
    name = ccb.content.plural_text("ironshod quarterstaff", "ironshod quarterstaves"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
