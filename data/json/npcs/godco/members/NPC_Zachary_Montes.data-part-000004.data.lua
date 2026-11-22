local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Nightmare",
    line = ccb.content.gendered_line("Ain't you heard it?  It's been screeching out in the forest during the night for a while now, keeps me up sometimes.  I'm too scared to go out and see what that thing is.  If you'd kill it, I'd be in your debt forever.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do."),
            next_topic = "TALK_NONE",
            actions = { actions.offer_mission("MISSION_GODCO_ZACHARY_KILL_NIGHTMARE") },
        },
        {
            text = ccb.content.text("I'm sorry to hear that <name_g>, but I don't feel like facing it either."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
        yes = ccb.content.gendered_line("After what you did for me, I'll follow you to the ends of the Earth!  No one around here's stood up for me like that, I owe ya one.", { "speaker" }),
        no = ccb.content.text("No chance!  Its not you, its the world out there I'm worried about.  All those <freaking> monsters really give me the creeps, and as far as I know this church is the last bastion of humanity in the <the_cataclysm>."),
    },
    replies = {
        {
            text = ccb.content.text("That's understandable."),
            next_topic = "TALK_GODCO_Zachary_Intro_2",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } })),
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_meeting_zachary_willing_to_follow" } }),
            actions = { "follow", actions.handler("dlg_a_dda_22a5bb9a10f5") },
        },
    },
}
