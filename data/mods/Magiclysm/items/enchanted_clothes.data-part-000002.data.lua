local ccb = require("ccb")

ccb.content.define_item {
    id = "coat_lab_plus_one",
    copy_from = "coat_lab",
    name = ccb.content.plural_text("enchanted lab coat", "enchanted lab coat"),
    looks_like = "coat_lab",
    description = ccb.content.text("A long white coat with several large pockets, with a pentagram on the lapel and a few orichalcum threads sewn into the seams.  Perfect for the stylish-but-effective academic mage."),
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_coat_lab_plus_one_0" } },
}

ccb.content.define_item {
    id = "coat_lab_plus_two",
    copy_from = "coat_lab",
    name = ccb.content.plural_text("enspelled lab coat", "enspelled lab coat"),
    looks_like = "coat_lab",
    description = ccb.content.text("A long white coat with several large pockets, with a pentagram on the lapel and orichalcum and mithril threads sewn into the seams.  A director of thaumaturgical research would have worn this or something like this before the Cataclysm."),
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_coat_lab_plus_two_0" } },
}
