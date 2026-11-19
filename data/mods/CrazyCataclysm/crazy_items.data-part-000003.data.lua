local ccb = require("ccb")

ccb.content.define_item {
    id = "flu_shot_fun",
    copy_from = "flu_shot",
    name = ccb.content.text("flu shot"),
    comestible = {
        kind = "MED",
        vitamins = { { id = "mutagen", amount = 2000 }, { id = "mutagen_batrachian", amount = 2300 } },
    },
    inheritance = { add = { flags = { "NUTRIENT_OVERRIDE" } }, remove = { flags = { "NO_INGEST" } } },
}
