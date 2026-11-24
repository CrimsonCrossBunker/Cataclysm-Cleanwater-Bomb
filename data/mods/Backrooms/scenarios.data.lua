local ccb = require("ccb")

ccb.content.define_scenario {
    id = "backroom_dweller",
    name = "Backrooms",
    points = 0,
    description = "What is this place?  You can't seem to find your way back out.",
    locations = { "sloc_backrooms" },
    start_name = "The Backrooms",
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "backroom_dweller_starternpc",
    name = "Backrooms (NPC EDITION)",
    points = 0,
    description = "What is this place?  You can't seem to find your way back out.  But hey, at least you aren't alone.  Will you cannibalize them as a last resort?  Maybe get them to surgically implant bionics into you?  Just keep them around for company?  Maybe you two will protect each other?  The possibilities have just widened, my friend, for you are no longer one.  You are two, and that's better than what it used to be like.",
    locations = { "sloc_backrooms" },
    start_name = "The Backrooms",
}

ccb.content.define_start_location {
    id = "sloc_backrooms",
    name = ccb.content.text("The Backrooms"),
    targets = { "backfloorchamber" },
}
