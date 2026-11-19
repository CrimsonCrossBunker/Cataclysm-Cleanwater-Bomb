local ccb = require("ccb")

ccb.content.define_item {
    id = "regional_avocado",
    copy_from = "apple",
    name = ccb.content.text("avocado"),
    description = ccb.content.text("A dark-skinned fruit with soft green flesh and a large pit."),
    looks_like = "apple",
    mass = "200 g",
    volume = "225 ml",
    color = "green",
    comestible = {
        shelf_life = "5 days",
        calories = 240,
        quench = 1,
        vitamins = {
            { id = "vitC", amount = "15000 μg" },
            { id = "iron", amount = "830 μg" },
            { id = "calcium", amount = "18000 μg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
