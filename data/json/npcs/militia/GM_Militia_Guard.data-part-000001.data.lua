local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_Guard1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_LODGEMAIN" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("I'm busy on watch duty.  Talk to the Boss upstairs."),
    },
    replies = {
        {
            text = ccb.content.text("What are you doing?"),
            next_topic = "TALK_MILITIA_GUARD1_Introduction",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_MILITIA_GUARD1_BYE",
        },
    },
}
