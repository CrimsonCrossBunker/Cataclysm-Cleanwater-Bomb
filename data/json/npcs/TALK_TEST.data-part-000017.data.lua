local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode)."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_always = true,
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS3",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should always see this response and be able to select it."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_570f78b53fd8"),
            show_always = true,
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_ALWAYS2",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode) because"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_always = true,
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_CONDITION",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should see this response but not be able to select it (except in debug mode) because"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_when = predicates.handler("dlg_p_dda_570f78b53fd8"),
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SHOW_CONDITION2",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You should not see this response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            show_reason = "zero isn't greater than one.",
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_RANDOM",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("You will see this response half of the time."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_92305705c4d3"),
        },
        {
            text = ccb.content.text("All done"),
            next_topic = "TALK_DONE",
        },
    },
}
