local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "pseudo_magazine",
    category = "spare_parts",
    name = ccb.content.text_without_extraction("pseudo magazine"),
    description = ccb.content.text_without_extraction("Pseudo magazine for use in dirty vehicle hacks."),
    flags = { "PSEUDO", "ZERO_WEIGHT", "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "DEBUG_ONLY" },
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            watertight = true,
            rigid = true,
            ammunition = { battery = 1000000, propane = 1000000 },
        },
    },
    symbol = "@",
    color = "red",
    magazine = { ammunition = { "battery" }, capacity = 1000000 },
}
