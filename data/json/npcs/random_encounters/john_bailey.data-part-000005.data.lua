local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RC_John_Bailey_Teach",
    line = {
        when = predicates.handler("dlg_p_dda_fd9e247d105f"),
        yes = ccb.content.text("I'd be happy to.  I can't spare a lot of free time, but for a little trade, I'll tell you about whatever I can help with."),
        no = ccb.content.text("Sorry, but that's all I have time for at the moment.  Darius is waiting outside."),
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "John_Bailey_teach", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Sure, let's talk trade."),
            next_topic = "TALK_TRAIN",
            when = predicates.handler("dlg_p_dda_fd9e247d105f"),
            actions = { actions.handler("dlg_a_dda_2558df1b1d33") },
        },
        {
            text = ccb.content.text("I'll bear that in mind.  What did you say you were doing here?"),
            next_topic = "TALK_RC_John_Bailey_2",
        },
        {
            text = ccb.content.text("Thanks, I'll think about it.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I might take you up on that, but for now I've gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}
