local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_DEPUTY_BADGE",
    name = ccb.content.text("Find Deputy Badge"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "badge_deputy",
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("I hope you will find use from what you got out of the deposit box but I also have another job for you that might lead you to an opportunity to deal out justice for those who cannot.  First things first, we can't just look like ruffians.  Find us a deputy badge, easy enough?"),
        accepted = ccb.content.text("I'd check the police station."),
        rejected = ccb.content.text("We're also official… just hang in there and I'll show you what we can really do."),
        advice = ccb.content.text("They shouldn't be that hard to find… should they?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great work, Deputy.  We're in business."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the criminals if it hasn't already."),
    },
}
