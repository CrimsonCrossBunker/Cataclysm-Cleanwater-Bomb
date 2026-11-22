local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_started_quest" } }),
        yes = ccb.content.text("The shelter's in your hands, at this point."),
        no = ccb.content.gendered_line("I never made it there and can't imagine I ever will.  Every time I've tried I've been headed off by the <zombies>.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("Could you tell me that story again?"),
            next_topic = "BGSS_PREPPER_1_STORY1",
        },
        {
            text = ccb.content.text("I could go check out that shelter for you if you like.  Bring back any supplies you left behind?"),
            when = predicates.handler("w16b_p_dda_72804463a175"),
            trial = { kind = "persuade", difficulty = 10, modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 }, { score = "ANGER", scale = -6 } } },
            success = { next_topic = "BGSS_PREPPER_1_SHELTERSUCCESS", actions = { actions.handler("w16b_a_dda_7f8ee2dc5183") } },
            failure = { next_topic = "BGSS_PREPPER_1_SHELTERFAILURE", actions = { actions.handler("w16b_a_dda_4bccdb13b4fc"), actions.set_actor_value("speaker", "general_BGSS_prepper_1_asked_about_quest", "yes") }, opinion = { trust = -2 } },
        },
        {
            text = ccb.content.text("I know this might seem weird but… your shelter wasn't on the way out of town, was it?  A hole in the ground, surrounded by trees?  Full of supplies with a sign out front that says 'I'm gonna shoot you'?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE1",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_found_computer" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_asked_about_shelter" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_finished_quest" } })) }),
            actions = { actions.set_actor_value("speaker", "mission_BGSS_prepper_1_asked_about_shelter", "yes") },
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
