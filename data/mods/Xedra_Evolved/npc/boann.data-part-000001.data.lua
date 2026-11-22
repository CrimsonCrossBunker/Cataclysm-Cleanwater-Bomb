local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_INTRO",
    line = {
        choices = {
            {
            when = predicates.has_trait("speaker", "FAE_ENMITY"),
            yes = ccb.content.text("Begone, slayer.  I will have no dealings with you."),
            no = {
                when = predicates.has_trait("speaker", "CHANGELING_MAGIC"),
                yes = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("Greetings, kinsman."),
                    no = ccb.content.text("Greetings, kinswoman."),
                },
                no = {
                    when = predicates.has_any_trait("speaker", { "ARVORE", "HOMULLUS", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" }),
                    yes = ccb.content.text("Greetings, elder cousin."),
                    no = {
                        when = predicates.has_any_trait("speaker", { "VAMPIRE", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4", "BLOOD_DRINKER", "LILIN_TRAITS" }),
                        yes = ccb.content.text("Greetings, nightwalker."),
                        no = {
                            when = predicates.has_trait("speaker", "WEREWOLF_HYBRID_FORM"),
                            yes = ccb.content.text("Greetings, child of the moon."),
                            no = ccb.content.text("Greetings, mortal."),
                        },
                    },
                },
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Greetings."),
            next_topic = "TALK_BOANN_1",
            when = predicates.negate(predicates.has_trait("speaker", "FAE_ENMITY")),
        },
        {
            text = ccb.content.text("I-"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "FAE_ENMITY"),
            actions = { actions.handler("dlg_a_xedra_evolved_39d3de69d719") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_1",
    line = ccb.content.text("I came here with my court when the Hedge between our worlds thinned and the border marches expanded.  They came for conquest and I came here for coexistence."),
    replies = {
        {
            text = ccb.content.text("So you're a good faerie?"),
            next_topic = "TALK_BOANN_2",
        },
        {
            text = ccb.content.text("How can I join your court?"),
            next_topic = "TALK_BOANN_JOIN",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("Is there anything I can do for you?"),
            next_topic = "TALK_QUEST_LIST",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("I've completed all your quests and am ready to join your court."),
            next_topic = "TALK_JOIN_COURT_SUCCESS",
            when = predicates.handler("dlg_p_xedra_evolved_04093a51dc35"),
            actions = { actions.add_effect("speaker", "march_baron", { permanent = true }) },
        },
        {
            text = ccb.content.text("I am ready to leave this world for yours."),
            next_topic = "TALK_OUTWORLD_CONFIRM",
            when = predicates.has_effect("speaker", "march_baron"),
        },
        {
            text = ccb.content.text("I'd like some advice about the Jabberwock."),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
            when = predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"),
        },
        {
            text = ccb.content.text("I'd like some advice about the march lords."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
            when = predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about that dog."),
            next_topic = "TALK_KILL_DOGTHING_ADVICE",
            when = predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the Mi-Go guards."),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
            when = predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the armored centipede."),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
            when = predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the automaton."),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
            when = predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the triffid heart."),
            next_topic = "TALK_GET_TRIFFID_HEART_ADVICE",
            when = predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the titan stag beetle."),
            next_topic = "TALK_KILL_TITAN_BEETLE_ADVICE",
            when = predicates.has_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the shadow and its piece."),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
            when = predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'd like some advice about the star-crowned hound."),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
            when = predicates.has_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"),
        },
        {
            text = ccb.content.text("I'm back and I killed the Jabberwock.  [Give her the heart]"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_COMPLETED",
            when = predicates.all({ predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"), predicates.has_item("speaker", "jabberwock_heart") }),
            actions = { actions.handler("dlg_a_xedra_evolved_ed11e2ea946f"), actions.purchase_pet("mon_melian_mantis_mount", { count = 1, name = ccb.content.text("Bladepetal") }), actions.handler("dlg_a_xedra_evolved_cf12c508fcee"), actions.set_actor_value("speaker", "completed_boann_bring_jabberwock_heart", "yes"), actions.finish_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART", { success = true }) },
        },
        {
            text = ccb.content.text("I'm back and I killed the March Lords."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_lords_for_boann" } }),
            actions = { actions.replace_mutation("speaker", "CALL_DAFFODIL"), actions.handler("dlg_a_xedra_evolved_4ab7cfd6e16e"), actions.clear_actor_value("speaker", "killed_lords_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_two_lords", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed that dog-like thing."),
            next_topic = "TALK_KILL_DOGTHING_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_dogthing_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_d9b5051470de"), actions.clear_actor_value("speaker", "killed_dogthing_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_dogthing", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the Mi-Go guards."),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_five_mi_go_guards_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_574ffce3087f"), actions.clear_actor_value("speaker", "killed_five_mi_go_guards_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_five_mi_go_guards", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the armored centipede."),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_armored_centipede_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_f5eac8797fc4"), actions.clear_actor_value("speaker", "killed_armored_centipede_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_armored_centipede", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the automaton."),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_automaton_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_95172cc51252"), actions.clear_actor_value("speaker", "killed_automaton_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_dreamforged_automaton", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the triffid heart.  [Give her the heart chunk]"),
            next_topic = "TALK_GET_TRIFFID_HEART_COMPLETED",
            when = predicates.all({ predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"), predicates.has_item("speaker", "triffid_heart_chunk") }),
            actions = { actions.handler("dlg_a_xedra_evolved_6d0172cf5651"), actions.set_actor_value("speaker", "completed_boann_bring_triffid_heart", "yes"), actions.finish_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN", { success = true }) },
        },
        {
            text = ccb.content.text("I'm back and I killed the titan stag beetle."),
            next_topic = "TALK_KILL_TITAN_BEETLE_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_titan_beetle_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_6d66d884babf"), actions.clear_actor_value("speaker", "killed_titan_beetle_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_titan_beetle", "yes") },
        },
        {
            text = ccb.content.text("I'm back and I killed the Shadow.  [Give her the piece of shadow]"),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_COMPLETED",
            when = predicates.all({ predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"), predicates.has_item("speaker", "shadow_singularity_piece") }),
            actions = { actions.handler("dlg_a_xedra_evolved_f5ff0d9bcf33"), actions.set_actor_value("speaker", "completed_boann_bring_shadow_piece", "yes"), actions.finish_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN", { success = true }) },
        },
        {
            text = ccb.content.text("I'm back and I killed the star-crowned hound."),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_COMPLETED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "killed_star_crown_hound_for_boann" } }),
            actions = { actions.handler("dlg_a_xedra_evolved_c9a3c948bbd8"), actions.clear_actor_value("speaker", "killed_star_crown_hound_for_boann"), actions.set_actor_value("speaker", "completed_boann_kill_star_crown_hound", "yes") },
        },
        {
            text = ccb.content.text("I'd better get going."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_2",
    line = ccb.content.text("Some of my kind might find that word pejorative, but it's what you've called us for so very long.  It had been quite a while since we were last able to come in numbers to this world, until the last few years."),
    replies = {
        {
            text = ccb.content.text("Why were you able to return?"),
            next_topic = "TALK_BOANN_3",
        },
        {
            text = ccb.content.text("How can I join your court?"),
            next_topic = "TALK_BOANN_JOIN",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("Well those of us who aren't faeries have other places to be now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_3",
    line = ccb.content.text("The same thing that is causing the portal storms made travel between our worlds easier again.  We have to engage in fairly strenuous decontamination procedures on our way back but we've had those in place for aeons."),
    replies = {
        {
            text = ccb.content.text("Decontamination?  You can leave here and not worry about the risen dead?"),
            next_topic = "TALK_BOANN_4",
        },
        {
            text = ccb.content.text("How can I join your court?  I want to leave here when you do!"),
            next_topic = "TALK_BOANN_JOIN",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("I'm going to head on now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_4",
    line = ccb.content.text("If we die here, we will rise just like you, we are within the belly of the beast, so to speak here.  But yes when we go elsewhere we don't bring this with us, that would be rude."),
    replies = {
        {
            text = ccb.content.text("Please take me away with you."),
            next_topic = "TALK_BOANN_JOIN",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("I haven't decided if I believe you or not but I'll see you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BOANN_JOIN",
    line = ccb.content.text("You cannot simply walk through our gates and claim a place among our ranks.  First, you must prove your worth.  A series of trials awaits you, each more perilous than the last.  Return to me with trophies of triumph and relics of renown, the hard-won proof of your deeds, and then shall your deeds proclaim your worth."),
    replies = {
        {
            text = ccb.content.text("Do you have a quest for me now?"),
            next_topic = "TALK_QUEST_LIST",
            when = predicates.handler("dlg_p_xedra_evolved_7ca7adc11f7e"),
        },
        {
            text = ccb.content.text("I'm going to head on now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_QUEST_LIST",
    line = {
        when = predicates.handler("dlg_p_xedra_evolved_4df51e8438f5"),
        yes = ccb.content.text("I have no further quests for you.  Once you've completed them all, you'll become part of my court and be allowed to move offworld when you will wish so."),
        no = {
            when = predicates.handler("dlg_p_xedra_evolved_1e8a51a49649"),
            yes = ccb.content.text("(Boann hands you a list) Here is a list of the quests to complete to become part of my court.  They are quite perilous, but their rewards are worth it."),
            no = {
                when = predicates.handler("dlg_p_xedra_evolved_fa6979ea7ba7"),
                yes = ccb.content.text("I have no new quests for now.  Once you've completed them, you'll become one of my knights and able to accomplish the quests that will make you a member of my court."),
                no = ccb.content.text("(Boann hands you a list) Here is a list of the quests to complete to become one of my knights.  Take your time, they can be accomplished at your prerogative."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("And when I'll be a knight you'll bring me out of here?"),
            next_topic = "TALK_QUEST_KNIGHT_OUTWORLD",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "told_about_knight_not_coming" } })),
        },
        {
            text = ccb.content.text("[Bring me the heart of a Jabberwock]"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_bring_jabberwock_heart" } })) }),
        },
        {
            text = ccb.content.text("[Find and kill two March Lords]"),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_kill_two_lords" } })) }),
        },
        {
            text = ccb.content.text("[Kill the suspicious dog]"),
            next_topic = "TALK_KILL_DOGTHING_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_kill_dogthing" } })) }),
        },
        {
            text = ccb.content.text("[Kill five Mi-Go guards]"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_kill_five_mi_go_guards" } })) }),
        },
        {
            text = ccb.content.text("[Kill an armored centipede]"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_kill_armored_centipede" } })) }),
        },
        {
            text = ccb.content.text("[Kill the remains of a dreamforged automaton]"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "completed_boann_kill_dreamforged_automaton" } })) }),
        },
        {
            text = ccb.content.text("[Bring me back a chunk of a triffid heart]"),
            next_topic = "TALK_GET_TRIFFID_HEART_OFFER",
            when = predicates.handler("dlg_p_xedra_evolved_dfe207bd8294"),
        },
        {
            text = ccb.content.text("[Kill a titan stag beetle]"),
            next_topic = "TALK_KILL_TITAN_BEETLE_OFFER",
            when = predicates.handler("dlg_p_xedra_evolved_b71db82a456b"),
        },
        {
            text = ccb.content.text("[Bring me back a piece of the darkest shadow]"),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_OFFER",
            when = predicates.handler("dlg_p_xedra_evolved_1f936a76f1ea"),
        },
        {
            text = ccb.content.text("[Kill a star-crowned hound]"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_OFFER",
            when = predicates.handler("dlg_p_xedra_evolved_637cfb78c98b"),
        },
        {
            text = ccb.content.text("I'm going to head on now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_QUEST_KNIGHT_OUTWORLD",
    line = ccb.content.text("You won't be a member of my court yet.  After another few quests, you will, and you along with all those that follow you will be brought out of this world whenever you wish so."),
    replies = {
        {
            text = ccb.content.text("Can I see the quest list again?"),
            next_topic = "TALK_QUEST_LIST",
            actions = { actions.set_actor_value("speaker", "told_about_knight_not_coming", "yes") },
        },
        {
            text = ccb.content.text("I'm going to head on now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "told_about_knight_not_coming", "yes") },
        },
    },
}
