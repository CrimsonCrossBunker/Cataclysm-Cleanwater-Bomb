local ccb = require("ccb")

ccb.content.define_harvest {
    id = "elder_thing",
    message = ccb.content.text("You crack open the hard chitin of the outer barrel to get at the alien flesh beneath."),
    drops = {
        { output = "veggy_tainted", category = "flesh", mass_ratio = 0.32 },
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.32 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}
