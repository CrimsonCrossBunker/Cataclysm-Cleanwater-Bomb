local ccb = require("ccb")

ccb.content.define_item {
    id = "frost_bone_human",
    category = "spare_parts",
    name = ccb.content.plural_text("frostbitten human bone", "frostbitten human bones"),
    mass = "225 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A stretched bumpy piece of bone, unpleasant to hold."),
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
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}
