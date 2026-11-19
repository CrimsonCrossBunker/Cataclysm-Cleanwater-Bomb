local ccb = require("ccb")

ccb.content.define_item {
    id = "boann_unique_weapon_sword",
    copy_from = "moons_tears_estoc",
    looks_like = "ch_estoc",
    name = ccb.content.plural_text("Sidereal Eclipse", "Sidereal Eclipse"),
    description = ccb.content.text("Shimmering like a beam of moonlight, this sword seems to minutely shift its position when not looked at directly.  It exerts a slight pull on your hand when you hold it, moving your body to the proper position."),
    inheritance = { add = { flags = { "RELIC_PINK" } } },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_boann_unique_weapon_sword_0" } },
}
