local ccb = require("ccb")

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
