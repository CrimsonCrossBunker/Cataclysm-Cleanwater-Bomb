local ccb = require("ccb")

ccb.content.define_item {
    id = "druid_naturearrows1",
    copy_from = "arrow_heavy_fire_hardened_fletched",
    name = ccb.content.text("nature's arrow"),
    looks_like = "arrow_heavy_fire_hardened_fletched",
    description = ccb.content.text("A magically conjured arrow made of twisted wood."),
    ammunition = { damage = { type = "stab", penetration = 3 }, count = 1, recovery_chance = 87 },
}

ccb.content.define_item {
    id = "arrow_druid",
    copy_from = "arrow_heavy_fire_hardened_fletched",
    name = ccb.content.text("twisted wooden arrow"),
    looks_like = "arrow_heavy_fire_hardened_fletched",
    description = ccb.content.text("A arrow that looks more like it was grown than carved.  Despite that, it flies straight and true.  It explodes into a mass of entangling vegetation when it hits its target."),
    ammunition = {
        damage = { type = "stab", penetration = 2 },
        count = 1,
        recovery_chance = 83,
        effects = { "TANGLE" },
    },
}
