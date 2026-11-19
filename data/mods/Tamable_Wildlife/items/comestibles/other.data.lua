local ccb = require("ccb")

ccb.content.define_item {
    id = "sweet_goop",
    name = ccb.content.plural_text("sweet goop", "sweet goop"),
    looks_like = "birdfood",
    description = ccb.content.text("A bunch of sweet stuff with a wet, goopy consistency.  Normal bugs would die for this, just hope the mutants will like it as well."),
    mass = "60 g",
    volume = "250 ml",
    price = "20 cent",
    survival_price = "25 cent",
    materials = { "junk" },
    symbol = ";",
    color = "brown",
    flags = { "INEDIBLE", "NUTRIENT_OVERRIDE" },
    comestible = {
        kind = "FOOD",
        calories = 400,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 7 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 5,
        freezing_point = -274,
        pet_food = { "BUGFOOD" },
    },
    use_actions = { "PETFOOD" },
}
