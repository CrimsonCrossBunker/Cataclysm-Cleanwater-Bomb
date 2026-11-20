local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_FARM_HOUSE",
    name = ccb.content.text("Reach Farm House"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "farm_2",
    dialogue = {
        describe = ccb.content.text("I just need a place to start over…"),
        offer = ccb.content.text("I've accepted that everyone I used to know is dead… one way or another.  I really wish I could have done something to save my brother but he was one of the first to go.  I'd like to start over, just rebuild at one of the farms in the countryside.  Can you help me secure one?"),
        accepted = ccb.content.text("Thank you, let's find a remote one so we don't have to worry about many zombies."),
        rejected = ccb.content.text("Please, I just don't know what to do otherwise."),
        advice = ccb.content.text("Traveling the backroads would be a good way to search for one."),
        inquire = ccb.content.text("Shall we keep looking for a farm house?"),
        success = ccb.content.text("Well, my adventuring days are over.  I can't thank you enough.  Trying to make this place self sustaining will take some work but the future is looking brighter.  At least it ought to be safe for now.  You'll always be welcome here."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I guess it was just a pipe dream."),
    },
}

ccb.content.define_mission {
    id = "MISSION_REACH_FEMA_CAMP",
    name = ccb.content.text("Reach FEMA Camp"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { native_actions = { "follow_only" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_REACH_FARM_HOUSE",
    destination = "fema",
    dialogue = {
        describe = ccb.content.text("Maybe they escaped to one of the camps…"),
        offer = ccb.content.text("I can't thank you enough for bringing me the patient records but I do have another request.  You seem to know your way around… could you take me to one of the FEMA camps?  I know some were overrun but I don't want to believe all of them could have fallen."),
        accepted = ccb.content.text("Thank you, just bring me to the camp… I just want to see."),
        rejected = ccb.content.text("Please, I don't know what else to do."),
        advice = ccb.content.text("We should go at night, if it is overrun then we can quickly make our escape."),
        inquire = ccb.content.text("Any leads on where a camp might be?"),
        success = ccb.content.text("I guess this wasn't as bright an idea as I thought."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I bet some of them are still out there…"),
    },
}
