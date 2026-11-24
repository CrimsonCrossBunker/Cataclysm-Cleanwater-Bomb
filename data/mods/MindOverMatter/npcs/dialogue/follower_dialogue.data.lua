local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_scan" },
    line = {
        choices = {
            ccb.content.text_without_extraction("<telepathy_generic>"),
            ccb.content.text_without_extraction("<telepathy_follower>"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_ILLNESS" },
    line = {
        choices = {
            ccb.content.text("And?"),
            ccb.content.text("Yeah, it is what it is."),
            ccb.content.text("Those storms at the end of world…  I was fine before them."),
            ccb.content.text("You noticed, did you?"),
            ccb.content.text("Yeah, I've had it for years at this point.  Not much I can do about it now, though."),
            ccb.content.text("Really wish I had gotten some more treatment before, you know."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure your illness for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_VITAKINETIC_HEALING",
    line = { when = predicates.handler("dlg_p_mindovermatter_83ff787adb53"), yes = ccb.content.text("We'll talk about that after you're done operating that vehicle."), no = { when = predicates.handler("dlg_p_mindovermatter_ad31ba7ddf09"), yes = ccb.content.text("I don't want to talk about that while I'm operating a vehicle!"), no = {
                when = predicates.handler("dlg_p_mindovermatter_c12d8bd39fb6"),
                yes = ccb.content.text("I'm too thirsty, give me something to drink."),
                no = {
                    when = predicates.handler("dlg_p_mindovermatter_170fbd5b08e8"),
                    yes = ccb.content.text("I'm too hungry, give me something to eat."),
                    no = {
                        when = predicates.handler("dlg_p_mindovermatter_f11538b5053e"),
                        yes = ccb.content.text("I'm too tired, let me rest first."),
                        no = {
                            when = predicates.has_effect("interlocutor", "asked_to_vitakinetic_heal"),
                            yes = ccb.content.text("I already told you no.  Let it go."),
                            no = ccb.content.text("I have some reason to refuse healing."),
                        },
                    },
                },
            } } },
    replies = {
        {
            text = ccb.content.text("Ah, okay."),
            next_topic = "TALK_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_LUNGS" },
    line = {
        choices = {
            ccb.content.text("* coughs.  \"Yeah, I'm not feeling so great"),
            ccb.content.text("No.  No I don't."),
            ccb.content.text("Yeah, I think I'm coming down with something."),
            ccb.content.text("Ugh, yeah.  If only I could call in sick, you know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure it for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_VITAKINETIC_CURE_DISEASE_EYES" },
    line = {
        choices = {
            ccb.content.text("They just itch like crazy at all time lately."),
            ccb.content.text("Yeah, I guess.  Must have got something in them."),
            ccb.content.text("Yeah, I think I'm coming down with something."),
            ccb.content.text("Ugh, yeah.  If only I could call in sick, you know?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I can cure it for you."),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_mindovermatter_60ee61334138") },
            success = { next_topic = "TALK_DENY_VITAKINETIC_HEALING" },
            failure = { next_topic = "TALK_PERSUADE_VITAKINETIC_HEALING" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERSUADE_VITAKINETIC_HEALING",
    line = ccb.content.text("You're going to what?  How are you going to do that?"),
    replies = {
        {
            text = ccb.content.text("You've seen what I can do, right?  Let me try.  (Note: By doing this you will absorb <npc_name>'s disease into yourself.)"),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_ACCEPT_VITAKINETIC_HEALING" },
            failure = {
                next_topic = "TALK_DENY_VITAKINETIC_HEALING_NON_PERSUADE",
                actions = {
                    actions.add_effect("interlocutor", "asked_to_vitakinetic_heal", { turns = 86400 }),
                },
            },
        },
        { text = ccb.content.text("Never mind then."), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("Forget it, let's get going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_VITAKINETIC_HEALING_NON_PERSUADE",
    line = ccb.content.text("I don't think so.  I know there are zombies out there and the world is all fucked up, but I'd rather keep that fucked-up-ness as far away from me as possible.  No offense."),
    replies = { { text = ccb.content.text("Alright, if you insist."), next_topic = "TALK_DONE" } },
}

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
