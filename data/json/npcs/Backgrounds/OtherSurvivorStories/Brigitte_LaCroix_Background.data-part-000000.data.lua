local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BOSS_Brigitte_LaCroix_Story1",
    line = ccb.content.text("You know those goth kids that used to hang out in malls?  I got out of a bad situation with one.  I did okay but they got bit and we did a viking funeral, very nice.  Before the end, they told me about this other goth kid that was hanging out in graveyards and rocking out to metal or something.  That's the last place I would go, but some people are just broken in the head, you know?"),
    replies = {
        {
            text = ccb.content.text("Let's see how to get there and go check on them."),
            next_topic = "BOSS_Brigitte_LaCroix_Story2",
            when = predicates.handler("dlg_p_dda_bfd92f9f6491"),
            actions = { actions.assign_mission("directions_Brigitte_LaCroix") },
            switch = true,
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
