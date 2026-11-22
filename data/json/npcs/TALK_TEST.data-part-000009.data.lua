local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_VARS_TIME",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_add_var time test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_39c984351a3f"),
            actions = { actions.handler("dlg_a_dda_0800348406d2") },
        },
        {
            text = ccb.content.text("This is an npc_add_var time test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_39c984351a3f"),
            actions = { actions.handler("dlg_a_dda_251811359f38") },
        },
        {
            text = ccb.content.text("This is a u_compare_var time test response for > 3_days."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_2cf14bc9b169"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_BIONICS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a u_has_bionics bio_ads test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_47d2b82345f3"),
        },
        {
            text = ccb.content.text("Failure!  This is an npc_has_bionics bio_ads test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_02144db8685d"),
        },
        {
            text = ccb.content.text("This is an npc_has_bionics ANY response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_40cd89da0fd5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SIMPLE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a80805708528") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SIMPLE_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_6b4f20e24d78"), actions = { actions.handler("dlg_a_dda_6f2ec01fa962") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SENTINEL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { once = "spend500", actions = { actions.handler("dlg_a_dda_aa997daca7f5") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_SENTINEL_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend500", actions = { actions.handler("dlg_a_dda_235092572aa0") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_592da6fe3d02") } },
        { actions = { actions.handler("dlg_a_dda_86691d1371f8") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_4d28545eb132"), actions = { actions.handler("dlg_a_dda_d43155ec8917") } },
        { when = predicates.handler("dlg_p_dda_da708d01c100"), actions = { actions.handler("dlg_a_dda_df5564bf69d7") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { once = "spend250", actions = { actions.handler("dlg_a_dda_be9ba3691f85") } },
        { actions = { actions.handler("dlg_a_dda_05ace2c4f108") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL_CONDITIONAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend250", actions = { actions.handler("dlg_a_dda_398033f945ab") } },
        { when = predicates.handler("dlg_p_dda_da708d01c100"), once = "spend500", actions = { actions.handler("dlg_a_dda_e027d7a1d297") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_MAPGEN",
    line = {
        choices = {
            ccb.content.text("This is an example of mapgen_update effect variations"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Please test some simple remote mapgen"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_61bf0c87d3ec") },
        },
        {
            text = ccb.content.text("Please test mapgen_update multiples"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_d0e782f9bda5") },
        },
        {
            text = ccb.content.text("Please test mapgen_update linked"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_a474cd6dbb19") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SIMPLE_SKILLS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a driving test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6403ff9d30c2"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NEGATED_SKILLS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a low driving test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d0df4f6aff30"),
        },
    },
}
