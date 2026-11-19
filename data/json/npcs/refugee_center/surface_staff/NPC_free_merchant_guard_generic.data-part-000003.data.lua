local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_Boris_Mission_1",
    line = {
        choices = {
            ccb.content.text("Talk to one of the bosses about that.  You'd have to pay me to go back there though, that's gonna be a hell of a job."),
            ccb.content.text("I don't have a lot of free time for that sort of thing.  Maybe talk to the shopkeep, they know more about scheduling and stuff."),
            ccb.content.text("Nah."),
            ccb.content.text("I'd rather stand around looking threatening than scrub gore out of the tiles."),
            ccb.content.text("Not unless you pay me.  Try the shopkeep, they can sell our services just like anything else."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_DONE" } },
}
