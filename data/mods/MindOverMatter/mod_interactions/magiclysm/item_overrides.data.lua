local ccb = require("ccb")

ccb.content.define_item {
    id = "thought_shield_item",
    name = ccb.content.plural_text("thought shields", "thought shields"),
    copy_from = "thought_shield_item",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_thought_shield_item_0" } },
}

ccb.content.define_item {
    id = "thought_shield_plus_item",
    name = ccb.content.plural_text("thought suit", "thought suit"),
    copy_from = "thought_shield_plus_item",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_thought_shield_plus_item_0" } },
}
