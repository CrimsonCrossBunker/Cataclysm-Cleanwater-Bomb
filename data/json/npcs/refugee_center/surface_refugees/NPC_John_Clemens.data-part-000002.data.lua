local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1",
    line = ccb.content.gendered_line("*turns to look at you, lifting an enormous cowboy hat off his eyes.  He appears to be in the process of growing out a set of bushy muttonchops and a handlebar mustache.  Bright blue eyes peer out from his wrinkled face.  \"Howdy, pardner.  They call me Clemens.  John Clemens.  I'm an ol' cowhand.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_John_Clemens", "yes"),
                actions.set_first_topic("TALK_REFUGEE_John_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, John."),
            next_topic = "TALK_REFUGEE_John_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi John, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
