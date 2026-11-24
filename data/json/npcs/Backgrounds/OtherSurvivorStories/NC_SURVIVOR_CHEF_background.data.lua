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

ccb.content.define_dialogue_topic {
    id = "BOSS_NC_SURVIVOR_CHEF_Story2",
    line = ccb.content.text("*shows you on your map where to find it.  \"This looks right to me.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "directions_chef",
    name = ccb.content.text("Check out that restaurant"),
    description = ccb.content.text("Maybe that chef is still alive."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { terrain = "s_restaurant", special = "restraunt", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_chef",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Maybe that chef is still alive."),
        offer = ccb.content.text("Maybe that chef is still alive."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
