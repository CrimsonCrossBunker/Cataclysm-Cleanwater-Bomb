local ccb = require("ccb")

ccb.content.define_item {
    id = "kitchen_gun",
    copy_from = "m9",
    name = ccb.content.plural_text("Kitchen Gun™", "Kitchen Guns™"),
    description = ccb.content.text("Say goodbye to daily stains and dirty surfaces with new Kitchen Gun!  Just aim at the dust, blood, or splinters, and then shoot it a bunch of times to clean it.  Blast the filth away with Kitchen Gun™!"),
    gun = { effects = { "CLEAN_DUST", "CLEAN_SPLINTERS", "CLEAN_BLOOD" } },
}
