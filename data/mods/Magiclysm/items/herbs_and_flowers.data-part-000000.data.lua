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
