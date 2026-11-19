local ccb = require("ccb")

ccb.content.define_item {
    id = "purity_crackers",
    name = ccb.content.plural_text("purity crackers", "purity crackers"),
    description = ccb.content.text("An incredibly hard cracker.  Squeezing it in your hand it feels as though your teeth might break before the cracker does.  The packaging on the side shows a tall being feeding these crackers to a horned and four legged creature."),
    mass = "200 g",
    volume = "250 ml",
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "fae_blood", "veggy" },
    symbol = ";",
    color = "yellow",
    flags = { "INEDIBLE" },
    comestible = {
        kind = "FOOD",
        pet_food = { "UNICORNFOOD" },
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
    use_actions = { "PETFOOD" },
}
