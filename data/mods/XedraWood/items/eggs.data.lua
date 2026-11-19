local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_claw_runner",
    looks_like = "egg_dino_small",
    name = ccb.content.text("dragon-bird egg"),
    color = "green",
    symbol = "o",
    description = ccb.content.text("Pale, round egg laid by a dragon-bird."),
    price = "125 cent",
    materials = { "egg" },
    volume = "1700 ml",
    mass = "57 g",
    flags = { "FREEZERBURN" },
    comestible = {
        fun = -6,
        shelf_life = "16 days",
        kind = "FOOD",
        quench = 4,
        healthy = 1,
        calories = 80,
        rot_spawn = { monster = "mon_claw_runner_hatchling", chance = 80 },
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_claw_hunter",
    looks_like = "egg_dino_theropod",
    name = ccb.content.text("claw hunter egg"),
    mass = "2 kg",
    color = "green",
    symbol = "O",
    description = ccb.content.text("Pale, football-shaped egg laid by a dragon-bird."),
    price = "125 cent",
    materials = { "egg" },
    volume = "1700 ml",
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "32 days",
        kind = "FOOD",
        quench = 4,
        healthy = 1,
        calories = 2600,
        fun = -6,
        rot_spawn = { monster = "mon_claw_hunter_hatchling", chance = 60 },
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}
