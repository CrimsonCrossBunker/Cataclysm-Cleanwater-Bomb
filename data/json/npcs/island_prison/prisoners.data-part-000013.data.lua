local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_PRISONER_LEADER_GET_ID_CARD",
    name = ccb.content.text("Get The Thing from the chief's office"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "id_military",
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Here's the job…"),
        offer = ccb.content.text("My snitch whispered in my ear that the thing I need is located in the chief's safe in his office.  You need to crack it open and bring the contents to me.  Don't try to use anything you find in there!  Just bring all the stuff to me, and I'll help you.  Deal?"),
        accepted = ccb.content.text("Great!  Don't forget that I need all stuff from the safe, try not to lose a thing."),
        rejected = ccb.content.text("Fine, I'll get the thing in any case, sooner or later."),
        advice = ccb.content.text("The chief's office is on the other side of the prison.  I think the road there is full of <zombies>, so you better find a weapon.  Also you probably will need some tools to crack the safe open."),
        inquire = ccb.content.text("Did you get the stuff already?"),
        success = ccb.content.text("At last!  Give me a few moments to check if it isn't damaged.  Here, take this for your troubles."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("You're useless.  I should've killed you when I met you."),
    },
    generic_rewards = false,
    start = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_accepted_prisoner_leader_mission", "yes"),
        },
    },
    finish = {
        item_rewards = { { item = "can_beans", container = "can_medium" } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_prisoner_leader_mission", "yes"),
            ccb.content.dialogue_actions.clear_actor_value("speaker", "mission_accepted_prisoner_leader_mission"),
        },
    },
}
