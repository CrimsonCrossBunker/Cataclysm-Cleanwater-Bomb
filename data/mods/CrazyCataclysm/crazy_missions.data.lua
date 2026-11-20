local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_CITY_COP_MOMENTO",
    name = ccb.content.text("Break into armory to retrieve valued possession"),
    copy_from = "MISSION_GET_CITY_COP_MOMENTO",
    goal = "MGOAL_FIND_ITEM",
    difficulty = 10,
    value = 1000000,
    dialogue = {
        describe = ccb.content.text("I need you to get my riches from the armory safe."),
        offer = ccb.content.text("I left my most valued possession in the armory.  I don't have the code, can you get in?"),
        accepted = ccb.content.text("Thanks, it's great to see someone willing to help out."),
        rejected = ccb.content.text("Well, I'll find someone else to do it for me, real shame with all those guns locked up too…"),
        advice = ccb.content.text("You look like a resourceful sort, maybe you can hack it or something."),
        inquire = ccb.content.text("Got it?  Should've been in my gun safe."),
        success = ccb.content.text("Thanks!  I'll be sure to put in a good word for you around town."),
        success_lie = ccb.content.text("OK, then hand it over."),
        failure = ccb.content.text("Filthy right-clicker."),
    },
}
