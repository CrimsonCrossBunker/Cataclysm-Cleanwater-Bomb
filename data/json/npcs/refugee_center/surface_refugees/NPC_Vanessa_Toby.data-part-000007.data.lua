local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Haircut",
    line = ccb.content.text("Sure, I can give you a haircut.  It'll be six merch for a haircut, or three for a shave, okay?"),
    replies = {
        {
            text = ccb.content.text("[6 merch] Please give me a haircut."),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.has_inventory("speaker", "FMCNote", 6),
            actions = { actions.transfer_items("FMCNote", 6), "buy_haircut", actions.add_effect("interlocutor", "vanessa_haircut_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("[3 merch] Please give me a shave."),
            next_topic = "TALK_CUT_YOUR_BEARD",
            when = predicates.has_inventory("speaker", "FMCNote", 3),
            actions = { actions.transfer_items("FMCNote", 3), "buy_shave", actions.add_effect("interlocutor", "vanessa_shave_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("Actually, you owe me a free haircut, remember?"),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_services_owed_haircut_1" } }),
            actions = { actions.set_actor_value("interlocutor", "mission_services_owed_haircut_1", "no"), actions.add_effect("interlocutor", "vanessa_haircut_in_progress", { turns = 100 }) },
        },
        {
            text = ccb.content.text("Could you fix it to where I can grow my hair out, please?"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "natural_hair_growth")),
            actions = { actions.replace_mutation("speaker", "natural_hair_growth") },
        },
        {
            text = ccb.content.text("I'd like it if my hair didn't grow out anymore.  Can you help me with that?"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "natural_hair_growth"),
            actions = { actions.handler("dlg_a_dda_d8cf71f883be") },
        },
        {
            text = ccb.content.text("Could you fix it to where I can grow my facial hair out, please?"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "natural_beard_growth")),
            actions = { actions.replace_mutation("speaker", "natural_beard_growth") },
        },
        {
            text = ccb.content.text("I'd like it if my facial hair didn't grow out anymore.  Can you help me with that?"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "natural_beard_growth"),
            actions = { actions.handler("dlg_a_dda_c4a0ea5c8862") },
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's a bit rich for my blood.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
