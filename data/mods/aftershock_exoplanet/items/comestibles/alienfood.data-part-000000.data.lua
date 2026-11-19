local ccb = require("ccb")

ccb.content.define_item {
    id = "yum_lichen",
    name = ccb.content.plural_text("clump of lichen", "clumps of lichen"),
    mass = "120 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A clump of moist squishy lichen.  You get the impression that it might not be the safest thing to eat considering how it makes your hand tingle."),
    price = "6 cent",
    volume = "26 ml",
    flags = { "RAW" },
    comestible = {
        kind = "FOOD",
        calories = 400,
        healthy = -20,
        quench = 15,
        fun = -8,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 12 },
            { id = "vitC", amount = 56 },
            { id = "mutant_toxin", amount = 25 },
        },
        pet_food = { "ALIEN_LICHEN" },
    },
    use_actions = { "BLECH", "PETFOOD" },
}
