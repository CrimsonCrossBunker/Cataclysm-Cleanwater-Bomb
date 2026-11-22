local ccb = require("ccb")

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
