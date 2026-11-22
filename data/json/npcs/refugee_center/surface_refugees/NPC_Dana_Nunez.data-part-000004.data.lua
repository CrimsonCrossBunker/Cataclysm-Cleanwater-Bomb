local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Dana_Background_baking", "TALK_TACOMA_Dana_Baking", "TALK_REFUGEE_Dana_Background_baking2_nobarter", "TALK_REFUGEE_Dana_Background_baking2_yesbarter" },
    replies = {
        {
            text = ccb.content.text("[8 flour] That sounds like a great deal, here's some flour for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "flour", 8), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("flour", 8), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[2 merch] I got two merch for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "FMCNote", 2), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("FMCNote", 2), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[6 flour] Thanks for cutting me a deal, here's the six cups of flour."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "flour", 6), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("flour", 6), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[1 merch] All right, one merch as agreed."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "FMCNote", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            actions = { actions.transfer_items("FMCNote"), actions.handler("dlg_a_dda_070edb08b9e3") },
        },
        {
            text = ccb.content.text("[8 flour] That sounds like a great deal, here's some flour for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "flour", 8), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("flour", 8), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[2 merch] I got two merch for you."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.has_inventory("speaker", "FMCNote", 2), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("FMCNote", 2), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[6 flour] Thanks for cutting me a deal, here's the six cups of flour."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "flour", 6), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("flour", 6), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
        {
            text = ccb.content.text("[1 merch] All right, one merch as agreed."),
            next_topic = "TALK_REFUGEE_Dana_Background_baking2",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.has_effect("interlocutor", "dana_barter_success"), predicates.has_inventory("speaker", "FMCNote", 1), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            actions = { actions.transfer_items("FMCNote"), actions.handler("dlg_a_dda_e61dd25a5265") },
        },
    },
}
