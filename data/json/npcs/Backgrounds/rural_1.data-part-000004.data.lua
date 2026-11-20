local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_rural_1_FARM",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("You were told to check out a farm that might be infested with zombies."),
    goal = "MGOAL_GO_TO",
    difficulty = 3,
    value = 0,
    start = {
        target = { special = "Farm Mutable", terrain = "farm_3", reveal_radius = 3 },
        handler = "mark_mission_BGSS_rural_1_started_quest",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Any luck finding the farm?"),
        success = ccb.content.text("I don't know how I can ever make it up to you!  I barely made it out of this place alive.  I wasn't sure I'd ever see it again, to be honest."),
        success_lie = ccb.content.text("Great!"),
        failure = ccb.content.text("I guess I don't blame you.  I knew it wouldn't be easy."),
    },
}
