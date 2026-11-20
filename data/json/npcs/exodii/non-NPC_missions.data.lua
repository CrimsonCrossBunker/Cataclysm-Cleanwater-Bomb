local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_exodii_signpost",
    name = ccb.content.text("Follow the directions on the pictographic sign"),
    description = ccb.content.text("I found a weird pictographic sign that seemed to point towards someone willing to trade."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { terrain = "exodii_base_x0y3z0", special = "exodii_base", reveal_radius = 5 } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I found a weird pictographic sign that seemed to point towards someone willing to trade."),
        offer = ccb.content.text("This is a sign with a series of simple line-art pictograms showing what appears to be a basic trade transaction.  A pair of hands offers a piece of some kind of junk, and another pair of hands offers a small pouch in return."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
