local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_MUSIC2",
    line = ccb.content.text("&You perform on your musical instrument with everything you have, giving a strong performance.  Luliya sways and begins to play her instrument and sing along.  The music and her voice are beautiful, she sounds like she has had some formal musical training."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "general_music_u_jammed_luliya", "yes"), actions.handler("dlg_a_dda_b37aabecb038") } },
    },
    replies = {
        {
            text = ccb.content.text("Fun, thank you for playing with me, Luliya."),
            next_topic = "TALK_LULIYA",
        },
        {
            text = ccb.content.text("Fun, thank you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
