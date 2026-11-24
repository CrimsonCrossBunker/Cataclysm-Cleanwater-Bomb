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

ccb.content.define_item {
    id = "compositebow",
    copy_from = "compositebow",
    name = ccb.content.plural_text("composite bow (heavy)", "composite bows (heavy)"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "reflexbow",
    copy_from = "reflexbow",
    name = ccb.content.plural_text("composite bow (light)", "composite bows (light)"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

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

ccb.content.define_item {
    id = "longbow",
    copy_from = "longbow",
    name = ccb.content.text("longbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "greatbow_meteor",
    copy_from = "greatbow_meteor",
    name = ccb.content.text("blackwood greatbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

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

ccb.content.define_item {
    id = "shortbow",
    copy_from = "shortbow",
    name = ccb.content.text("short bow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "spear_knife",
    copy_from = "spear_knife",
    name = ccb.content.plural_text("simple knife spear", "simple knife spears"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "spear_spike",
    copy_from = "spear_spike",
    name = ccb.content.plural_text("spike on a stick", "spikes on sticks"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item { id = "stick", copy_from = "stick", inheritance = { add = { flags = { "WOODEN_WEAPON" } } } }

ccb.content.define_item {
    id = "selfbow",
    copy_from = "selfbow",
    name = ccb.content.text("survival bow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "crossbow",
    copy_from = "crossbow",
    name = ccb.content.text("wood crossbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "club_wooden",
    copy_from = "club_wooden",
    name = ccb.content.plural_text("wooden club", "wooden clubs"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "woodgreatbow",
    copy_from = "woodgreatbow",
    name = ccb.content.text("wooden greatbow"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
    gun = {},
}

ccb.content.define_item {
    id = "pike_wood",
    copy_from = "pike_wood",
    name = ccb.content.plural_text("wooden pike", "wooden pikes", "weapon"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}
