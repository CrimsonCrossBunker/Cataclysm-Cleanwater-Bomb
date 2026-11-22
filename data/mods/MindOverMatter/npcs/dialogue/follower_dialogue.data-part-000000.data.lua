local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    replies = {
        {
            text = ccb.content.text("[Telepathy] *Read <npc_name>'s mind*"),
            next_topic = "TALK_FRIEND_FOLLOWER_scan",
            when = predicates.handler("dlg_p_mindovermatter_8333d7767a16"),
        },
        {
            text = ccb.content.text("[Vitakinesis] I noticed that you're really sick."),
            next_topic = "TALK_FRIEND_VITAKINETIC_CURE_ILLNESS",
            when = predicates.all({ predicates.any({ predicates.has_trait("interlocutor", "ASTHMA"), predicates.has_trait("interlocutor", "CHEMIMBALANCE"), predicates.has_trait("interlocutor", "SCHIZOPHRENIC"), predicates.has_trait("interlocutor", "JITTERY"), predicates.has_trait("interlocutor", "MOODSWINGS"), predicates.has_trait("interlocutor", "ROT1"), predicates.has_trait("interlocutor", "NARCOLEPTIC"), predicates.has_trait("interlocutor", "SEASONAL_ALLERGIES"), predicates.has_trait("interlocutor", "SEASONAL_AFFECTIVE") }), predicates.has_trait("speaker", "VITAKINETIC") }),
        },
        {
            text = ccb.content.text("[Vitakinesis] You don't look so good."),
            next_topic = "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_LUNGS",
            when = predicates.all({ predicates.any({ predicates.has_effect("interlocutor", "pre_common_cold"), predicates.has_effect("interlocutor", "common_cold"), predicates.has_effect("interlocutor", "pre_flu"), predicates.has_effect("interlocutor", "flu") }), predicates.has_trait("speaker", "VITAKINETIC") }),
        },
        {
            text = ccb.content.text("[Vitakinesis] Is there something wrong with your eyes?"),
            next_topic = "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_EYES",
            when = predicates.all({ predicates.any({ predicates.has_effect("interlocutor", "pre_conjunctivitis_viral"), predicates.has_effect("interlocutor", "conjunctivitis_viral"), predicates.has_effect("interlocutor", "pre_conjunctivitis_bacterial"), predicates.has_effect("interlocutor", "conjunctivitis_bacterial") }), predicates.has_trait("speaker", "VITAKINETIC") }),
        },
    },
}
