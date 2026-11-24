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

ccb.content.define_dialogue_topic {
    id = "BOSS_Brigitte_LaCroix_Story2",
    line = ccb.content.text("*shows you on your map where to find it.  \"This looks right to me.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "directions_Brigitte_LaCroix",
    name = ccb.content.text("Check out that graveyard"),
    description = ccb.content.text("Maybe that goth is still alive."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "cemetery_religious", terrain = "cemetery_4square_11", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_Brigitte_LaCroix",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Maybe that goth is still alive."),
        offer = ccb.content.text("Maybe that goth is still alive."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
