local ccb = require("ccb")

ccb.content.define_item {
    id = "dimensional_anchor",
    copy_from = "dimensional_anchor",
    category = "clothing",
    name = ccb.content.plural_text("5-point anchor", "5-point anchors"),
    inheritance = { add = { flags = { "MUNDANE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_dimensional_anchor_0" } },
}

ccb.content.define_item {
    id = "dimensional_anchor_on",
    copy_from = "dimensional_anchor_on",
    category = "clothing",
    name = ccb.content.plural_text("5-point anchor (on)", "5-point anchors (on)"),
    inheritance = { add = { flags = { "MUNDANE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_dimensional_anchor_on_0" } },
}

ccb.content.define_item {
    id = "robofac_armor_anchor",
    copy_from = "robofac_armor_anchor",
    inheritance = { add = { flags = { "MUNDANE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_robofac_armor_anchor_0" } },
}

ccb.content.define_item {
    id = "robofac_armor_anchor_on",
    copy_from = "robofac_armor_anchor_on",
    inheritance = { add = { flags = { "MUNDANE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_robofac_armor_anchor_on_0" } },
}
