local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Tacoma",
    line = {
        when = predicates.any_equal({ "phase_1", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }),
        yes = ccb.content.gendered_line("Have you heard anything back from the ranch about jobs yet?", { "speaker" }),
        no = ccb.content.text("Huh.  I've made a few friends here, but not so much as I'd stick around here with no future prospects, hoping someone downstairs dies to make room for me.  It does sound nice, if they're looking for more workers."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "recruit_general_Nunez_Tacoma", "phase_1") },
        },
    },
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
