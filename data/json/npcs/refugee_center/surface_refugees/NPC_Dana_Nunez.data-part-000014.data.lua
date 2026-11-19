local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Recruit",
    line = ccb.content.text("Pablo's a little quicker on the trigger than I am.  We're trying to have a baby, did you know that?  It's a bit crazy in this world, but I won't change those plans.  Tell you what: if your camp has access to a doctor and some medical facilities, in case I actually can get pregnant again, I would consider getting out of here and signing up."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_dana_pregnancy", "knows") } } },
    replies = {
        {
            text = ccb.content.text("I'll look into that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
