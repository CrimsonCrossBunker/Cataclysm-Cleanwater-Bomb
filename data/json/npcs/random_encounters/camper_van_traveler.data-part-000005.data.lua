local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_isherwood_traveler",
    name = ccb.content.text("Check out that farm"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Isherwood Farm Mutable", terrain = "farm_isherwood_1", reveal_radius = 5 },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}

ccb.content.define_mission {
    id = "directions_cabin",
    name = ccb.content.text("Check out that cabin"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { terrain = "chemical_lab_ocu", special = "Occupied Chem Lab", reveal_radius = 5 } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}

ccb.content.define_mission {
    id = "directions_cowboy",
    name = ccb.content.text("Check out that desolate barn"),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { terrain = "desolatebarn", special = "desolate barn", reveal_radius = 5 } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Sweet."),
        success_lie = ccb.content.text("Sweet."),
        failure = ccb.content.text("That's unfortunate."),
    },
}
