local ccb = require("ccb")

-- 'light' related, partially 'speed'
ccb.content.define_item {
    id = "glowing_mushroom",
    name = ccb.content.plural_text("glowing mushroom caps", "glowing mushroom caps"),
    description = ccb.content.text("Slim stripes cut from a bioluminescent mushroom, still surrounded by a faint glowing aura."),
    survival_price = "9 USD 70 cent",
    symbol = "o",
    color = "light_cyan",
    mass = "70 g",
    volume = "200 ml",
    looks_like = "mushroom",
    comestible = {
        kind = "FOOD",
        calories = 86,
        vitamins = { { id = "redcells", amount = 25 }, { id = "vitC", amount = 6 } },
    },
    use_actions = { { kind = "cast_spell", spell = "glowing_mushroom_spell", no_fail = true, level = 0 } },
}

-- 'healing' related
ccb.content.define_item {
    id = "horn_moss_capsule",
    name = ccb.content.plural_text("horn moss capsules", "horn moss capsules"),
    description = ccb.content.text("Pure white moss capsules, shaped like a goat's horn.  The fine spores contained within are a powerful magical reagent, and can be consumed to recover small amounts of health."),
    survival_price = "12 USD 50 cent",
    symbol = "o",
    color = "white",
    mass = "35 g",
    volume = "50 ml",
    looks_like = "mushroom",
    comestible = {
        kind = "FOOD",
        calories = 65,
        vitamins = { { id = "iron", amount = 7 }, { id = "vitC", amount = 5 } },
    },
    use_actions = { { kind = "cast_spell", spell = "flask_regeneration_effect", no_fail = true, level = 0 } },
}
