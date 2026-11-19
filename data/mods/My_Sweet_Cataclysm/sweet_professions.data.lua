local ccb = require("ccb")

ccb.content.define_profession {
    id = "sugar_kin",
    name = { male = "Sugar Boy", female = "Sugar Girl" },
    description = "You're a human shaped candy brought to life under unknown circumstances.  You have your whole life ahead of you and it's gonna be sweet!",
    points = 5,
    traits = { "SUGAR" },
    pets = { { monster = "mon_necco", count = 1 } },
    items = { both = { entries = { { item = "sugarkin_flyer", custom_flags = { "auto_wield" } } } } },
    flags = { "SCEN_ONLY" },
}
