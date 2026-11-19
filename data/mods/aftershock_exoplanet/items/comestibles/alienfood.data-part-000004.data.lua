local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_bone",
    category = "spare_parts",
    name = ccb.content.plural_text("alien bone", "alien bones"),
    mass = "225 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Obviously bones.  Could be used to make some stuff, like needles."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "bone" },
    volume = "250 ml",
    subtype_order = { "milling", "comestible" },
    milling = { result = "meal_bone", recipe = "meal_bone_mill_1_4" },
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 96 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}
