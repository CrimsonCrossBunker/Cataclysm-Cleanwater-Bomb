local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1",
    line = ccb.content.gendered_line("*seems impossibly young at first glance, her dark face nervous when she sees you looking her way.  On closer inspection as you approach, you see that she is likely in her early teens, but the contrast to the weary faces around makes her age stand out.  \"Oh, uh… hi.  You look new.  I'm Aleesha.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Aleesha_Seward", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Aleesha_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, kid.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Aleesha, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
