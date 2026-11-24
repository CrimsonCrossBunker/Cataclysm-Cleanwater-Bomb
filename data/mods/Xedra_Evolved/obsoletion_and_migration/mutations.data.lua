local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WIND_BLOWS_WILLOW_BENDS",
    name = ccb.content.text("The Wind Blows, the Willow Bends"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability, you gain the ability to enhance your dodge capabilities."),
}

ccb.content.define_trait_migration {
    id = "NO_TRACE_YET_I_WISH_active",
    remove = true,
}
