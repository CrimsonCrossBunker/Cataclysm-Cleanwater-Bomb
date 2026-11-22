local ccb = require("ccb")

ccb.content.define_item {
    id = "water_mycus",
    copy_from = "water",
    name = ccb.content.plural_text("fungal water", "fungal water"),
    description = "Water, the stuff of life.  Specifically, fungal life.  This water is cloudy, transformed into a fungal sea.  You probably should not drink this.",
    comestible = {
        quench = 30,
        parasites = 5,
        contamination = {
            { disease = "fungal_contamination", probability = 100 },
        },
    },
}
