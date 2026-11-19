local ccb = require("ccb")

ccb.content.define_item {
    id = "gown_gossamer_boann_unique",
    name = ccb.content.plural_text("aegis gown", "aegis gowns"),
    copy_from = "gown_gossamer",
    looks_like = "gown_gossamer",
    inheritance = { add = { flags = { "RELIC_PINK" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_gown_gossamer_boann_unique_0" } },
}
