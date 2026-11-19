local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Work2",
    line = ccb.content.text("We could put together a little clean up group, but everyone here has terrible memories of that place.  I could not ask anyone here to go back and see the leftovers of people we knew.  Still, it's a big job.  Who here might be able to do it?"),
    replies = {
        {
            text = ccb.content.text("I'm sure there's someone.  Would you like me to ask around?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
