local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Complete",
    line = ccb.content.text("Gimme spek, 'n  fetch 'em 'ere."),
    replies = {
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yank_out_all_bionics_from_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_fa45b3adc710") },
        },
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "repair_and_rescue_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_441dbf0d2d0d") },
        },
        {
            text = ccb.content.text("Of course, it is time for us to talk."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "reverse_cybernization_prototype", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_ba9865e060b2") },
        },
        {
            text = ccb.content.text("Let's see what I get."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "pull_out_from_rotten_cyborg", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_32d0bdeebb48") },
        },
        {
            text = ccb.content.text("It is time to put this body to rest."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "dress_up_rotten_cyborg", { scope = "speaker", key = "dialogue_exodii_cybor_rescue_ongoing_current_type" } }),
            actions = { actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "no"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "none"), actions.handler("dlg_a_dda_c0c90eb7d35f") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}
