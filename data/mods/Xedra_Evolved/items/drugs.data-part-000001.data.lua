local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_treatment",
    name = ccb.content.plural_text("questionable blood treatment", "questionable blood treatment"),
    description = ccb.content.text("This homemade blood treatment purports to reduce the cravings brought on by vampirism and if applied often and early to even reverse some stages of the disease.  But vampires surely can't be real, can they?"),
    mass = "1 g",
    volume = "12ml",
    price = "50 USD",
    phase = "liquid",
    survival_price = "20 USD",
    materials = { "hflesh" },
    stack_size = 4,
    symbol = "!",
    color = "magenta",
    flags = { "NPC_SAFE", "TRADER_AVOID" },
    comestible = {
        kind = "MED",
        servings = 4,
        vitamins = { { id = "meat_allergen", amount = 1 } },
        on_consume = "drink_blood_treatment",
    },
}
