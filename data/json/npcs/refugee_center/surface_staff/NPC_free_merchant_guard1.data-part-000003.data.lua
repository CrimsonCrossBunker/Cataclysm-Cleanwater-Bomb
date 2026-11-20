local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_EVAC_SMOKER_GET_CIGARETTES",
    name = ccb.content.text("Smokes, let's go."),
    description = ccb.content.text("Make a friend at the refugee center by handing over around five packs - 100 cigarettes."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 800,
    item = "cig",
    item_count = 100,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Come on man, I just need a smoke."),
        offer = ccb.content.text("With all that's been going on, it's been more and more difficult to find a smoke.  My stash has been running low for a while now.  Think you could help me out here?  A few packs is all I need."),
        accepted = ccb.content.text("Thanks, it's great to see someone willing to help a guy out."),
        rejected = ccb.content.text("Well, I'll find someone else to do it for me."),
        advice = ccb.content.text("Plenty of smokers in towns.  Gotta be some left over cigs in some of them houses."),
        inquire = ccb.content.text("Got the smokes?"),
        success = ccb.content.text("Thanks!  I'll be sure to put in a good word for you around the center."),
        success_lie = ccb.content.text("OK, then hand it over."),
        failure = ccb.content.text("Shit happens."),
    },
}
