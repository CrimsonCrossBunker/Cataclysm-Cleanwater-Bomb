local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "boann",
    unique_name = ccb.content.text("Lady Boann"),
    class = "xe_fae_noblewoman_boann",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_BOANN_INTRO",
    missions_offered = "MISSION_BRING_BOANN_JABBERWOCK_HEART",
    gender = "female",
}

ccb.content.define_npc_class {
    id = "xe_fae_noblewoman_boann",
    name = ccb.content.text("fae noblewoman"),
    job_description = ccb.content.text("I'm in charge of the faeries of my court."),
    common = false,
    traits = {
        { trait = "hair_super_princess", variant = "blond" },
        { trait = "natural_hair_color_blond" },
        { trait = "SKIN_DARK" },
        { trait = "FAERIECREATURE" },
        { trait = "THRESH_FAIR_FOLK_NOBLE" },
        { trait = "IRON_ALLERGY" },
        { trait = "CHANGELING_MAGIC" },
        { trait = "DISIMMUNE" },
        { trait = "BEAUTIFUL2" },
        { trait = "PARACLESIAN_FAE_SIGHT_2" },
        { trait = "PARACLESIAN_INT_PER_2" },
        { trait = "PARACLESIAN_STR_DEX_2" },
        { trait = "PARACLESIAN_MAKE_GOSSAMER" },
        { trait = "CHANGELING_NOBLE_MOVEMENT_BUFFS" },
        { trait = "CHANGELING_NOBLE_BURNING_WEAPON" },
        { trait = "BOANN_RETALIATION" },
    },
    dexterity = { rng = { 4, 10 } },
    intelligence = { rng = { 2, 5 } },
    worn = "NC_BOANN_WORN_GEAR",
    carry = "EMPTY_GROUP",
    weapon = "NC_BOANN_WEAPON",
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "melee", bonus = { rng = { 1, 5 } } },
        { skill = "firstaid", bonus = { rng = { 1, 4 } } },
        { skill = "cooking", bonus = { rng = { 6, 8 } } },
    },
}

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

ccb.content.define_dialogue_topic {
    id = { "TALK_BRING_BOANN_JABBERWOCK_HEART_OFFER" },
    line = ccb.content.text("Prove to me that you have the heart of a knight.  Bring me the putrid heart of a Jabberwock."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the Jabberwock?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART")),
            actions = { actions.assign_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
    line = ccb.content.text("You will need incredible melee skills to handle this or an impressive gun.  Otherwise it does not have hidden tricks or notable intelligence so it'll be a straightforward fight."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the Jabberwock?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART")),
            actions = { actions.assign_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_BRING_BOANN_JABBERWOCK_HEART_COMPLETED" },
    line = ccb.content.text("I'm pleased to grant you a Melian mount of your own."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TWO_MARCH_LORDS_OFFER" },
    line = ccb.content.text("Prove your allegiance to me.  Kill two March Lords so all will see your defense of this world."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
    line = ccb.content.text("They are fearsome opponents and have warriors at their command but lack long-range attacks.  You can find them in the border patrol offices or during one of their rare hunts amidst the mists."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TWO_MARCH_LORDS_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TWO_MARCH_LORDS_COMPLETED" },
    line = ccb.content.text("I'm pleased to grant you the right to call upon daffodil warriors.  They bloom into a life of combat."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DOGTHING_OFFER" },
    line = ccb.content.text("A dog-like being has been found nearby.  Whatever it is, it's not a dog.  Kill it, and I will teach you how to see beyond barriers."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the dog?"),
            next_topic = "TALK_KILL_DOGTHING_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DOGTHING_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DOGTHING_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DOGTHING_ADVICE",
    line = ccb.content.text("Do not be deceived by its looks.  It is not a regular dog.  Be very careful as we do not know what it can do."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the dog?"),
            next_topic = "TALK_KILL_DOGTHING_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DOGTHING_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DOGTHING_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DOGTHING_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DOGTHING_COMPLETED" },
    line = ccb.content.text("I will now grant you the knowledge to see beyond all walls, written on this parchment."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_FIVE_MI_GO_GUARDS_OFFER" },
    line = ccb.content.text("A knight must be able to face harsh conditions.  Kill five Mi-Go guards and you'll receive an object able to refuel your magical energy."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the guards?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
    line = ccb.content.text("Something to protect yourself from the fumes and heat is a must.  They are smart enough to feel fear, so if they're injured enough they'll stop attacking and try to flee."),
    replies = {
        {
            text = ccb.content.text("I'll do it. Where's the guards?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_FIVE_MI_GO_GUARDS_COMPLETED" },
    line = ccb.content.text("Here is the object.  As promised, using it will recharge your mana."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_ARMORED_CENTIPEDE_OFFER" },
    line = ccb.content.text("A knight must know how to triumph despite their foe's armor.  Kill an armored centipede and I'll grant you an insignia, so you might be recognized as one of my knights."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the centipede?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
    line = ccb.content.text("Study the weak spots of weaker centipedes, it'll give you an advantage.  Its armor isn't as effective against blunt and piercing weapon than it is against slashing weapons and bullets."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the centipede?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_ARMORED_CENTIPEDE_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_ARMORED_CENTIPEDE_COMPLETED" },
    line = ccb.content.text("I'm honored to grant you this insignia."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DREAMFORGED_AUTOMATON_OFFER" },
    line = ccb.content.text("A rampaging automaton has been spotted.  Destroy it, and you'll be granted a great weapon."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the automaton?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
    line = ccb.content.text("My scouts mentioned that it relies on electricity to attack.  Find a way to shield yourself against that, and it'll be much easier to kill.  They also mentioned how damaged the automaton's exposed insides are, so I wouldn't attempt to use weapons that only damage the insides if I were you."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the automaton?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DREAMFORGED_AUTOMATON_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DREAMFORGED_AUTOMATON_COMPLETED" },
    line = ccb.content.text("I'm pleased to grant you this frostrimed estoc."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_TRIFFID_HEART_OFFER" },
    line = ccb.content.text("I want you to brave the harshest environments.  Bring me a chunk of a triffid heart and I'll grant you a powerful set of armor."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the triffids?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_TRIFFID_HEART_ADVICE",
    line = ccb.content.text("Tear gas is deadly to them.  In addition, they don't get along with anything that isn't a triffid."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the triffids?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_TRIFFID_HEART_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_TRIFFID_HEART_COMPLETED" },
    line = ccb.content.text("I'm pleased to grant you a set of armor appropriate for a knight."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TITAN_BEETLE_OFFER" },
    line = ccb.content.text("A knight must be able to triumph over all beasts.  Kill a titan stag beetle and you'll receive a magical musical instrument."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the beetle?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TITAN_BEETLE_ADVICE",
    line = ccb.content.text("Mundane weapons won't do much so try to find something that bypasses its armor.  It's also very slow so keeping your distance is easy.  Learning the weak points of smaller beetles and using high-power ammunitions can work too but expect its shell to block most shots."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the beetle?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TITAN_BEETLE_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TITAN_BEETLE_COMPLETED" },
    line = ccb.content.text("I give you Väinämöinen's Kantele.  Take care of it, it's very precious."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_SHADOW_SINGULARITY_PIECE_OFFER" },
    line = ccb.content.text("There is a shadow that haunts the night.  Bring me proof that you killed it and I'll grant you the right to bear my banner."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
    line = ccb.content.text("To encounter it, stand alone or accompanied by at most two allies in a field or a forest at night.  It might take multiple nights for it to show itself so prepare something to do while you wait.  Light massively weaken it so ensure the battlefield is well lit.  Separate it from its minions, as it can create more than you'll manage to kill and heal its wounds over time.  It is also particularly resilient against bullets so engage in melee if you manage to get close enough."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_SHADOW_SINGULARITY_PIECE_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_SHADOW_SINGULARITY_PIECE_COMPLETED" },
    line = ccb.content.text("I am honored to give you this banner.  Wear it with pride, as you more than earned that right."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_STAR_CROWN_HOUND_OFFER" },
    line = ccb.content.text("Knight, I ask you to kill a star-crowned hound.  This will be a difficult challenge but I trust that you will prevail against this mighty foe.  Kill it and a necklace that will amplify your magical abilities will be yours."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the hound?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
    line = ccb.content.text("It is strong but slow, so disengaging is possible.  It will summon hounds, but they quickly fade away so they aren't that much of an issue compared to it.  Stand away from corners in walls as it can teleport to them.  It has no armor against fire, electricity and blunt weapons but it quickly heals all its wounds so continuous heavy damage is the key to kill it.  If you cannot manage to injure it, do not hesitate to withdraw and try another way to kill it."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the hound?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_STAR_CROWN_HOUND_COMPLETED" },
    line = ccb.content.text("I give you this necklace as a gift for your services.  May it serve you well."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_JOIN_COURT_SUCCESS" },
    line = ccb.content.text("You are now officially a member of my court and can leave this place for the summer lands.  You will be assigned a territory to guard in my name in the Marches and troops to help you hold it.  But only when you leave here and there is no return from there to here so anyone you wish to take must come with you when you leave."),
    replies = {
        {
            text = ccb.content.text("Thank you my liege.  I will let you know when I am ready to make the journey."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I wish to leave now.  (This will end the game)"),
            next_topic = "TALK_OUTWORLD_CONFIRM",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_OUTWORLD_CONFIRM" },
    line = ccb.content.text("Are you certain?  Leaving this world is a one-way trip.  There is still a very long time before it becomes urgent to do so and many things to gain from staying here a little longer."),
    replies = {
        {
            text = ccb.content.text("I changed my mind.  I'll stay for now."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I am sure.  Bring me out of here.  (This will end the game)"),
            next_topic = "TALK_LEAVE_THIS_WORLD",
        },
        {
            text = ccb.content.text("I am sure.  Bring me and my followers out of here.  (This will end the game)"),
            next_topic = "TALK_LEAVE_THIS_WORLD",
            when = predicates.handler("dlg_p_xedra_evolved_b52f0aa23941"),
            actions = { actions.set_actor_value("speaker", "u_has_followers", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_THIS_WORLD",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_has_followers" } }),
        yes = ccb.content.text("(Boann leads you and your followers to a hidden ritual circle) This is the exit point.  After the ritual, you will all go through the decontamination process before you are allowed to claim your own barony, as fit for a member of my court.  Your followers will then claim a small part of it for their homes."),
        no = ccb.content.text("(Boann leads you to a hidden ritual circle) This is the exit point.  After the ritual, you'll go through the decontamination process before being allowed to claim your own barony, as fit for a member of my court."),
    },
    replies = {
        {
            text = ccb.content.text("A whole new world, filled with possibilities.  A place where the Cataclysm isn't.  What you do now is another story."),
            next_topic = "TALK_DONE",
            actions = { "u_die", actions.add_effect("speaker", "a_winner_is_u", { permanent = true }) },
        },
    },
}
