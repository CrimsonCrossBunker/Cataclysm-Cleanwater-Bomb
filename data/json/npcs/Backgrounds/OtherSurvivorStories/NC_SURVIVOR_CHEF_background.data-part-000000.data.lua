local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BOSS_NC_SURVIVOR_CHEF_Story1",
    line = ccb.content.gendered_line("I found a cell phone a while ago and it started ringing.  I picked it up and just listened.  It was this cook, and they just kept talking on and on about some restaurant and all the good food there and asking to be rescued.  Maybe they were just dialing random numbers?  I don't know.  But they might still be out there, and I wouldn't mind a good meal.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Let's see how to get there and go check on them."),
            next_topic = "BOSS_NC_SURVIVOR_CHEF_Story2",
            when = predicates.handler("dlg_p_dda_0af60ccedec1"),
            actions = { actions.assign_mission("directions_chef") },
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
