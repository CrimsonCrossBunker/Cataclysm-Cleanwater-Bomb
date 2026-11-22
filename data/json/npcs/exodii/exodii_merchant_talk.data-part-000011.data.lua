local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Prototype_Cyborg_Rescue",
    line = ccb.content.text("Fer this 'un, I can yank out their bits 'n give 'em to ya, or I can jus' take out the busted pieces so they can still use th' rest o' stuff in 'em. Elsewise, why don't ya jest give 'im to me?  I reckon I can turn 'im into a right useful worker."),
    replies = {
        {
            text = ccb.content.text("[$300] Take everything from him and if there is something useful, put it aside for me."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_a88b1d9a27dc"),
            actions = { actions.handler("dlg_a_dda_2172f5c1c7c0"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "yank_out_all_bionics_from_prototype") },
        },
        {
            text = ccb.content.text("[200$] Just remove broken bits so they can control themselves."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_e1b6dba94f89"),
            actions = { actions.handler("dlg_a_dda_04c92d015381"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "repair_and_rescue_prototype") },
        },
        {
            text = ccb.content.text("[95$] Pull everything out, you can keep what works.  Just bring my buddy back."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_bf2e523c29cd"),
            actions = { actions.handler("dlg_a_dda_f11832a75b0b"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "reverse_cybernization_prototype") },
        },
        {
            text = ccb.content.text("They are all yours.  [Adds 200$]"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            actions = { actions.handler("dlg_a_dda_fbd68f46e57c") },
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Broken_Cyborg_Rescue",
    line = ccb.content.text("This 'unwon't be twitching', too much grey lost to dead.  But ye can salvage bits from 'em or born 'em for a walker, or just cut out the rot 'n grey link so ya can miss 'em proper."),
    replies = {
        {
            text = ccb.content.text("[200$] Pull out CBM if he can't use it, I can."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_e1b6dba94f89"),
            actions = { actions.handler("dlg_a_dda_53c8e22fd393"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "pull_out_from_rotten_cyborg") },
        },
        {
            text = ccb.content.text("[25$] Pull everything out, you can keep what works.  He deserves a burial."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
            when = predicates.handler("dlg_p_dda_3e621d135700"),
            actions = { actions.handler("dlg_a_dda_d71efea66826"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing", "yes"), actions.handler("dlg_a_dda_822f4d122b5f"), actions.set_actor_value("speaker", "dialogue_exodii_cybor_rescue_ongoing_current_type", "dress_up_rotten_cyborg") },
        },
        {
            text = ccb.content.text("They are all yours.  [Adds 150$]"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "bot_prototype_cyborg", 1),
            actions = { actions.handler("dlg_a_dda_99d373d5ee50") },
        },
        {
            text = ccb.content.text("Actually, forget it's not my problem."),
            next_topic = "TALK_DONE",
        },
    },
}
