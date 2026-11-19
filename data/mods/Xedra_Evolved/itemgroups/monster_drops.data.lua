local ccb = require("ccb")

ccb.content.define_harvest {
    id = "triffid_heart",
    message = "<triffid_harvest>",
    drops = {
        { output = "stick_fiber", category = "bone", mass_ratio = 0.5 },
        { output = "triffid_heart_chunk", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.3 },
    },
}
