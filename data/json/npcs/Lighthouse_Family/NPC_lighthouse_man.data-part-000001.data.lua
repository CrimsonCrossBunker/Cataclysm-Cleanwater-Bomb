local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_lighthouse_man_1", "TALK_lighthouse_man_Background", "TALK_lighthouse_man_hay", "TALK_lighthouse_man_survivors_yes", "TALK_lighthouse_man_survivors_no" },
    line = ccb.content.text("<greet>"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("<BGSS_intro_question>"),
            next_topic = "TALK_lighthouse_man_Background",
        },
        {
            text = ccb.content.text("How are you doing?"),
            next_topic = "TALK_lighthouse_man_hay",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_help_helped_lighthouse_man" } }),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_lighthouse_man_1",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_help_helped_lighthouse_man" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Has anyone come recently?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "global_safe_space_lighthouse_fixed" } }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_372a8aa8260c") },
            success = { next_topic = "TALK_lighthouse_man_survivors_yes", actions = { actions.handler("dlg_a_dda_81e6145c1e01"), actions.update_map("lighthouse_man_survivor", "lighthouse_ground") } },
            failure = { next_topic = "TALK_lighthouse_man_survivors_no" },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_Background",
    line = ccb.content.text("I'm just a simple man from a simple family.  Before <the_cataclysm> I had a fishing boat, and I went to sea on it, to catch fish and other marine life.  This is how my grandfather lived, my father lived, and I began to live like that.  I had a large family, 7 children, but not many survived, only my wife and daughter remained…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_hay",
    line = ccb.content.text("You know, pretty good.  It is cozy here, there is a lot of space, and most importantly, it's safe.  We even started considering this place as our new home.  By the way, while I was fishing, a bottle with a piece of paper came to the shore of our island.  Here, take a look.\", he gave you a piece of paper, something was written on it: '0030045-0030045-35321700', with something similar to lightning scribbled nearby.  \"I wonder what it could mean…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_yes",
    line = ccb.content.text("Good news, <name_g>.  One survivor sailed to us recently."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_no",
    line = ccb.content.text("Nobody came, <name_g>.  I'm beginning to doubt that anyone else has survived besides us…"),
}
