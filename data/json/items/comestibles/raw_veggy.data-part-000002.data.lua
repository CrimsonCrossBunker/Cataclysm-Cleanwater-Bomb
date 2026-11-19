local ccb = require("ccb")

-- Who in their right mind would eat an entire garlic bulb raw?
ccb.content.define_item {
    id = "garlic",
    name = ccb.content.text("garlic bulb"),
    mass = "18 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A pungent garlic bulb.  Popular as a seasoning for its strong flavor.  Can be disassembled into cloves."),
    price = "12 cent",
    survival_price = "48 cent",
    materials = { "garlic" },
    volume = "45 ml",
    flags = { "RAW", "PLANTABLE_SEED" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -18,
        calories = 24,
        fun = -18,
        vitamins = {
            { id = "vitC", amount = "5400 μg" },
            { id = "iron", amount = "600 μg" },
            { id = "calcium", amount = "32400 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
