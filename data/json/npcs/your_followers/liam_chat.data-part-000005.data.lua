local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Jenny_CrushAccuse",
    line = ccb.content.text("*stares at you wide-eyed for a beat, then breaks into a shy grin.  \"Aw man, busted.  You *know* I dig those distracted nerdy chicks who don't react to my presence in any way.  It's all good though, you know?  Don't tell her.  I barely know her and it's not like she's in a place to be dating some stranger.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "u_liam_jenny_feelings", "crushing_hard") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Your secret's safe with me.  <done_conversation_section>"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        {
            text = ccb.content.text("Your secret's safe with me.  <lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}
