local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BARKEEP_TAP",
    line = ccb.content.text("Just the best spirits the whole of New England has to offer.  Well the best we've managed to loot so far at least.\n\n <ANCILLA_barkeep_suggestion>"),
    replies = {
        {
            text = ccb.content.text("Just some water."),
            false_text = ccb.content.text("[$2] Just some water."),
            text_when = predicates.handler("dlg_p_dda_fc580c0c78bf"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_fc580c0c78bf") },
            success = { next_topic = "TALK_DONE", actions = { actions.handler("dlg_a_dda_1dfd46df0f2b") } },
            failure = { next_topic = "TALK_DONE", actions = { actions.handler("dlg_a_dda_d3d52e8fe965") } },
        },
        {
            text = ccb.content.text("[$3] I'll take a beer."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_4269fb161103") },
        },
        {
            text = ccb.content.text("[$3] Get me a cup of red wine."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9b2df95177fe") },
        },
        {
            text = ccb.content.text("[$3] I'll take a shot of rum."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_9c107a61ce55") },
        },
        {
            text = ccb.content.text("[$3] I'll take a shot of whiskey."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_80d2569046d0") },
        },
        {
            text = ccb.content.text("On second thought, don't bother."),
            next_topic = "TALK_ANCILLA_BARKEEP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD",
    line = ccb.content.text("Oh yes of course, think this should be all, well that's all there is anyhow."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_1b4ead6a5a99"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3cea5fb343d4") } },
    },
}
