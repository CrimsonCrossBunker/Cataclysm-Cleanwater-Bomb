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

ccb.content.define_item {
    id = "moons_tears_estoc",
    copy_from = "ch_estoc",
    name = ccb.content.plural_text("moon's tears estoc", "moon's tears estoc"),
    description = "A thin thrusting sword, a sort of predecessor to the rapier, forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp.",
    looks_like = "ch_estoc",
    replace_materials = { ch_steel = "moon_tears", kevlar = "leather" },
    inheritance = {
        scale = {
            mass = 0.56,
            melee_damage = { stab = 1.2 },
        },
    },
}
