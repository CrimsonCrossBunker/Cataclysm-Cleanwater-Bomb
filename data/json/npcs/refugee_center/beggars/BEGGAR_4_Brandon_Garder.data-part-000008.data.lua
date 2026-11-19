local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUIT2",
    line = ccb.content.gendered_line("Well… I'll be honest, I didn't even think Dave could be sorted out, and you've gone and called my bluff!  It's a darn fine thing you've done for that poor soul.  Listen, I wasn't… entirely serious about wanting to come with you, but if you can convince the others to go, then I guess I'll come along.", { "speaker" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_recruit_brendan_recruited", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
