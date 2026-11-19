local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- This is used for the all_nutrient_starve_test.
ccb.content.define_item {
    id = "debug_nutrition",
    copy_from = "can_spam",
    name = ccb.content.text_without_extraction("holy SPAM of debugging", "holy SPAM of debugging"),
    description = ccb.content.text_without_extraction("A mysterious lump of SPAM that contains just enough calories and vitamins to feed you for a day.  For debug use only."),
    comestible = {
        calories = 2150,
        vitamins = {
            { id = "vitC", amount = 100 },
            { id = "calcium", amount = 100 },
            { id = "iron", amount = 100 },
        },
    },
}
