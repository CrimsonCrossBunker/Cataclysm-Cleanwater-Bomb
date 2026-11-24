local ccb = require("ccb")

-- there will be some thoughts about how this alchemy stuff works. the relation are pretty stretchy, because I don't want to make bazillion of plants for each purpose, so don't mind if 'light' related plant will occur in 'darkness' flask effect
-- same as barnacle weed, 'duration' and 'sustaining', but not so long and more powerful, for effective and non standard effects like night vision
ccb.content.define_item {
    id = "platonic_flower",
    name = ccb.content.text("philosopher's flower"),
    color = "pink",
    flags = { "NO_AUTO_CONSUME", "NONCONDUCTIVE" },
    symbol = "%",
    description = ccb.content.text("A fractal corolla winds inward in mathematical harmony, reflecting beauty in its ideal form."),
    survival_price = "6 USD",
    materials = { "veggy" },
    volume = "50 ml",
    mass = "50 g",
    comestible = {
        kind = "FOOD",
        calories = 100,
        fun = 2,
        vitamins = { { id = "vitC", amount = 5 }, { id = "iron", amount = 5 }, { id = "calcium", amount = 5 } },
    },
}

-- exotic, rare component for high level potions
ccb.content.define_item {
    id = "moonflowers",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("moonflowers", "moonflowers"),
    mass = "120 g",
    color = "cyan",
    symbol = "o",
    description = ccb.content.text("A handful of moonflowers glitter like tiny stars and faintly smell of morning dew.  Properly harvested, they will never wilt or wither."),
    survival_price = "20 USD",
    volume = "250 ml",
    comestible = {
        kind = "FOOD",
        calories = 156,
        vitamins = {
            { id = "iron", amount = 5 },
            { id = "vitC", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
}

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

-- another high level component, 'mana' related
ccb.content.define_item {
    id = "golden_reed_stalk",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("golden reed stalks", "golden reed stalks"),
    color = "yellow",
    symbol = "%",
    looks_like = "wheat",
    description = ccb.content.text("Stalks cut from a golden reed.  They have a strong, spiced aroma."),
    survival_price = "7 USD 80 cent",
    comestible = {
        calories = 63,
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 12 },
            { id = "vitC", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
}

-- 'duration' and 'sustaining'
ccb.content.define_item {
    id = "wood_barnacle",
    copy_from = "platonic_flower",
    name = ccb.content.text("wood barnacle"),
    symbol = "o",
    color = "brown",
    looks_like = "egg",
    description = ccb.content.text("Heavy wooden shells surrounding a diminutive white fruit."),
    survival_price = "10 USD",
    comestible = {
        calories = 64,
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "vitC", amount = 5 },
            { id = "redcells", amount = 3 },
        },
    },
}

-- 'range', 'area', 'aoe'
ccb.content.define_item {
    id = "dragon_nail",
    copy_from = "platonic_flower",
    name = ccb.content.text("dragonail"),
    color = "brown",
    symbol = "o",
    looks_like = "egg",
    description = ccb.content.text("Knife sharp thorns from a dragonail bush.  Eating them raw would be a dangerous challenge."),
    survival_price = "8 USD 90 cent",
    comestible = {
        calories = 85,
        kind = "FOOD",
        vitamins = { { id = "iron", amount = 7 }, { id = "vitC", amount = 4 }, { id = "calcium", amount = 1 } },
    },
}

-- breaks magic enchantments (whatever that means), used to make magic armor, maybe 'breaks' related (like increasing the damage/armor penetration abilities)
ccb.content.define_item {
    id = "moly_tuber",
    copy_from = "platonic_flower",
    name = ccb.content.text("moly tuber"),
    color = "blue",
    symbol = "%",
    description = ccb.content.text("The black root of a moly plant, extracted from the ground through great effort.  Rumored to grant protection to those who consume it."),
    survival_price = "3 USD",
    comestible = {
        calories = 67,
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = 13 }, { id = "iron", amount = 7 } },
    },
}

-- stat bonuses
ccb.content.define_item {
    id = "fern_flower",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("fern flower", "fern flowers"),
    color = "blue",
    symbol = "%",
    description = ccb.content.text("A small flower cut from a fern, it has a faint honeyed aroma.  Believed to bring good luck to whoever finds it."),
    survival_price = "12 USD",
    comestible = {
        calories = 33,
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = 8 }, { id = "vitC", amount = 4 }, { id = "iron", amount = 2 } },
    },
    use_actions = { { kind = "cast_spell", spell = "flower_fern_spell", no_fail = true, level = 0 } },
}

-- low and middle level spell component, same as mana crystals, weak 'mana' related
ccb.content.define_item {
    id = "funnelcap_chunk",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("funnelcap chunk", "funnelcap chunks"),
    color = "blue",
    symbol = "%",
    description = ccb.content.text("Large chunks of funnelcap meat, still leaking fine amounts of clear sap."),
    survival_price = "60 cent",
    comestible = {
        calories = 4,
        kind = "FOOD",
        vitamins = {
            { id = "vitC", amount = 5 },
            { id = "iron", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "funnelcap_spell", no_fail = true, level = 0 } },
}

-- 'teleportation' related
ccb.content.define_item {
    id = "sojourners_flower",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("sojourner's flower", "sojourner's flowers"),
    color = "red",
    symbol = "o",
    description = ccb.content.text("A red puffball flower cut from a sojourner's palm.  When wind wafts between its petals, you can hear the sounds of faraway places."),
    survival_price = "14 USD",
    volume = "10 ml",
    mass = "10 g",
    comestible = {
        calories = 10,
        kind = "FOOD",
        vitamins = {
            { id = "iron", amount = 5 },
            { id = "vitC", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "sojourners_palm_spell", no_fail = true, level = 0 } },
}

-- alchemy bases material, maybe its possible to make a moonshine using it
ccb.content.define_item {
    id = "whiskflower",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("whiskflower", "whiskflowers"),
    color = "red",
    symbol = "o",
    description = ccb.content.text("A pink whisk shaped flower with a powerful alcoholic smell."),
    survival_price = "1 USD 10 cent",
    volume = "10 ml",
    mass = "10 g",
    comestible = {
        calories = 11,
        kind = "FOOD",
        vitamins = {
            { id = "iron", amount = 5 },
            { id = "vitC", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "whiskflower_spell", no_fail = true, level = 0 } },
}
