local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy2",
    line = {
        when = predicates.has_effect("interlocutor", "hunt_godco_russell"),
        yes = ccb.content.text("Look, I'm just a regular God-fearing fella like you.  You gotta have something to keep your mind off stuff.  You'd get mad otherwise.  My passion happens to be collecting trophies.  I appreciate your help, by the way."),
        no = ccb.content.text("Look, I'm just a regular God-fearing fella like you.  You gotta have something to keep your mind off stuff.  You'd get mad otherwise.  My passion happens to be collecting trophies."),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Your life, your escape mechanism…"), next_topic = "TALK_DONE" },
    },
}
