local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_1",
    line = ccb.content.text("*looks up at you with a gaunt face.  His loose clothes and sharp cheekbones suggest he recently lost a lot of weight.  \"Hi.  Hi there.\"  He scratches at a patchy beard of gray stubble.  \"I'm Garry, Garry Villeneuve.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Garry_Villeneuve", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Garry_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Garry."),
            next_topic = "TALK_REFUGEE_Garry_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Garry, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
