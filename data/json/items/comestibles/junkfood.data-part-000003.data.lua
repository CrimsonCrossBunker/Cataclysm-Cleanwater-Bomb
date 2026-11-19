local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "debug_calories",
    name = ccb.content.text_without_extraction("unholy debug angel cake"),
    copy_from = "jihelucake",
    description = ccb.content.text_without_extraction("This unholy confection of delight does not lie, it packs a heavenly amount of calories in each sinful bite.  For debug use only."),
    comestible = { shelf_life = "4 days", calories = 10000, fun = 20 },
}
