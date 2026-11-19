local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1",
    line = {
        joined = {
            ccb.content.text("*is an uncharacteristically well-groomed young man, his hair trim and slicked back.  In this stark setting, he looks like a cartoon character on a live-action set piece.  \""),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("Oh my, it's good to see such a strong and handsome fellow around here"),
                no = ccb.content.text("Oh my, you're a beautiful lady, so nice to see you"),
            },
            ccb.content.text(".\"  He slides his hand through his hair and smiles, his eyes half-lidded.  \"They call me Alonso.\""),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Alonso_Lautrec", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Alonso_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Alonso."),
            next_topic = "TALK_REFUGEE_Alonso_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Alonso, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
