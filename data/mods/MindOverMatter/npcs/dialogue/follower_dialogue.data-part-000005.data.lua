local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ACCEPT_VITAKINETIC_HEALING",
    line = {
        choices = {
            ccb.content.text("Alright, it can't be worse than what I'm already going through."),
            ccb.content.text("Sure, I'll try anything at this point."),
            ccb.content.text("Okay.  The medicine's going to run out someday and then I'll really be fucked.  If this works…"),
            ccb.content.text("Yeah, I feel awful.  What have I got to lose?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s cold*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "pre_common_cold") }),
            actions = { actions.remove_effects("interlocutor", { "pre_common_cold" }), actions.add_effect("speaker", "pre_common_cold", { turns = 129600 }), actions.handler("w16b_a_mindovermatter_67b18abdffda") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s cold*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "common_cold") }),
            actions = { actions.remove_effects("interlocutor", { "common_cold" }), actions.handler("w16b_a_mindovermatter_6fe944b01ee5") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s flu*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "pre_flu") }),
            actions = { actions.remove_effects("interlocutor", { "pre_flu" }), actions.add_effect("speaker", "pre_flu", { turns = 129600 }), actions.handler("w16b_a_mindovermatter_85040b4f9c01") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s flu*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "flu") }),
            actions = { actions.remove_effects("interlocutor", { "flu" }), actions.handler("w16b_a_mindovermatter_b912f8015243") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s pinkeye*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "pre_conjunctivitis_viral") }),
            actions = { actions.remove_effects("interlocutor", { "pre_conjunctivitis_viral" }), actions.add_effect("speaker", "pre_conjunctivitis_viral", { turns = 259200 }), actions.handler("w16b_a_mindovermatter_8876dd159962") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s pinkeye*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "conjunctivitis_viral") }),
            actions = { actions.remove_effects("interlocutor", { "conjunctivitis_viral" }), actions.handler("w16b_a_mindovermatter_32444df216a1") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s pinkeye*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "pre_conjunctivitis_bacterial") }),
            actions = { actions.remove_effects("interlocutor", { "pre_conjunctivitis_bacterial" }), actions.add_effect("speaker", "pre_conjunctivitis_bacterial", { turns = 259200 }), actions.handler("w16b_a_mindovermatter_7cb8bd1885a3") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s pinkeye*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_effect("interlocutor", "conjunctivitis_bacterial") }),
            actions = { actions.remove_effects("interlocutor", { "conjunctivitis_bacterial" }), actions.handler("w16b_a_mindovermatter_5ac08d4c365b") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s asthma*"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_mindovermatter_7086f7c2b4e2"),
            actions = { actions.handler("w16b_a_mindovermatter_c4df3154f023"), actions.replace_mutation("speaker", "ASTHMA"), actions.handler("w16b_a_mindovermatter_7b974b64afc3") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s asthma*"),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_mindovermatter_6bde1105733e"),
            actions = { actions.handler("w16b_a_mindovermatter_c4df3154f023"), actions.add_effect("speaker", "effect_asthma_disease_absorbed", { turns = 5184000 }), actions.handler("w16b_a_mindovermatter_029b3ef37529") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s chemical imbalance*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "CHEMIMBALANCE"), predicates.negate(predicates.has_trait("speaker", "CHEMIMBALANCE")) }),
            actions = { actions.handler("w16b_a_mindovermatter_53487ace6c42"), actions.replace_mutation("speaker", "CHEMIMBALANCE"), actions.handler("w16b_a_mindovermatter_c478c0beddda") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s kaluptic psychosis*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "SCHIZOPHRENIC"), predicates.negate(predicates.has_trait("speaker", "SCHIZOPHRENIC")) }),
            actions = { actions.handler("w16b_a_mindovermatter_6b444f460865"), actions.replace_mutation("speaker", "SCHIZOPHRENIC"), actions.handler("w16b_a_mindovermatter_8206fef07cc7") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s muscle jitters*"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "JITTERY"),
            actions = { actions.handler("w16b_a_mindovermatter_5bde1764fcc2"), actions.replace_mutation("speaker", "JITTERY"), actions.handler("w16b_a_mindovermatter_b6aedcb3a17f") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s mood swings*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "MOODSWINGS"), predicates.negate(predicates.has_trait("speaker", "MOODSWINGS")) }),
            actions = { actions.handler("w16b_a_mindovermatter_2d5db4f256aa"), actions.replace_mutation("speaker", "MOODSWINGS"), actions.handler("w16b_a_mindovermatter_16d922d70635") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s weakening sickness*"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "ROT1"),
            actions = { actions.handler("w16b_a_mindovermatter_60e8badef7d0"), actions.replace_mutation("speaker", "ROT1"), actions.handler("w16b_a_mindovermatter_3c9e32e96773") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s narcolepsy*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "NARCOLEPTIC"), predicates.negate(predicates.has_trait("speaker", "NARCOLEPTIC")) }),
            actions = { actions.handler("w16b_a_mindovermatter_777646196153"), actions.replace_mutation("speaker", "NARCOLEPTIC"), actions.handler("w16b_a_mindovermatter_1f7d7211739d") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s seasonal allergies*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "SEASONAL_ALLERGIES"), predicates.negate(predicates.has_trait("speaker", "SEASONAL_ALLERGIES")) }),
            actions = { actions.handler("w16b_a_mindovermatter_c8f3b6789ab0"), actions.replace_mutation("speaker", "SEASONAL_ALLERGIES"), actions.handler("w16b_a_mindovermatter_c2325deeaaf1") },
        },
        {
            text = ccb.content.text("Hold still.  *Remove <npc_name>'s seasonal affective disorder*"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("interlocutor", "SEASONAL_AFFECTIVE"), predicates.negate(predicates.has_trait("speaker", "SEASONAL_AFFECTIVE")) }),
            actions = { actions.handler("w16b_a_mindovermatter_12c6ef369316"), actions.replace_mutation("speaker", "SEASONAL_AFFECTIVE"), actions.handler("w16b_a_mindovermatter_16d922d70635") },
        },
        {
            text = ccb.content.text("Actually, maybe now's not the best time."),
            next_topic = "TALK_DONE",
        },
    },
}
