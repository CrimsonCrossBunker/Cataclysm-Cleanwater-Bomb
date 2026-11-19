local ccb = require("ccb")

ccb.content.define_item {
    id = "raw_tainted_leather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("tainted hide", "tainted hide"),
    survival_price = "10 cent",
    description = ccb.content.text("A carefully folded raw skin harvested from an unnatural creature.  The smell of rot is overwhelming, and it has an ghastly unnatural feeling with a wide variety of cuts, divots, and malformed lumps covering the sickly green-gray skin.  This can't be used for anything useful."),
    price = "0 cent",
    comestible = { shelf_life = "6 hours" },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "raw_tainted_leather_scraps",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("tainted skin scraps", "tainted skin scraps"),
    mass = "1 g",
    volume = "5 ml",
    survival_price = "0 cent",
    description = ccb.content.text("Shredded scraps of raw skin from an unnatural creature.  It can't have much use."),
    price = "0 cent",
    comestible = { shelf_life = "3 hours", calories = 3 },
    use_actions = { "POISON" },
}
