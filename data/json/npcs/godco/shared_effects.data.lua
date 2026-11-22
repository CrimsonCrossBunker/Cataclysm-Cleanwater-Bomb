local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_chef", "TALK_GODCO_guard_food", "TALK_GODCO_Arturo_1", "TALK_GODCO_Theresa_1", "TALK_GODCO_chloe", "TALK_GODCO_Corrie_1", "TALK_GODCO_Darryl_1", "TALK_GODCO_Greenwood_1", "TALK_GODCO_Felicity_1", "TALK_GODCO_Gemma_1", "TALK_GODCO_Helena_1", "TALK_GODCO_Jane_1", "TALK_GODCO_Jeremiah_1", "TALK_GODCO_Julian_1", "TALK_GODCO_Katherine_1", "TALK_GODCO_Kostas_1", "TALK_GODCO_Maria", "TALK_GODCO_Olwen_1", "TALK_GODCO_Russell_1", "TALK_GODCO_Sonia", "TALK_GODCO_Tom_1", "TALK_GODCO_Zachary" },
    on_enter = {
        { when = predicates.negate(predicates.has_effect("interlocutor", "npc_value_interaction_timer_short")), actions = { actions.add_effect("interlocutor", "npc_value_interaction_timer_short", { turns = 108000 }), actions.handler("dlg_a_dda_e1af90ce9574") } },
    },
    replies = {
        {
            text = ccb.content.text("This is a fake response to prevent errors.  Please don't give the player the variable below."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "this_is_fake_shared_godco_value_display" } }),
        },
    },
}
