local ccb = require("ccb")

ccb.content.define_item {
    id = "raw_tainted_fur",
    name = ccb.content.plural_text("tainted pelt", "tainted pelt"),
    copy_from = "raw_fur",
    description = ccb.content.text("A carefully folded raw pelt harvested from an unnatural creature.  The smell of rot is overwhelming, with bits of flesh cling to the mangy, sickly patches of fur still present on the pelt.  This can't be used for anything useful."),
    price = "0 cent",
    comestible = { shelf_life = "6 hours" },
    use_actions = { "POISON" },
}
