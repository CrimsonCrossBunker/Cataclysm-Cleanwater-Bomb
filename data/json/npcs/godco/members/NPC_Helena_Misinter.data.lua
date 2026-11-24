local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Helena_2", "TALK_GODCO_Helena_Story", "TALK_GODCO_Helena_Uncle", "TALK_GODCO_Helena_Mood", "TALK_GODCO_Helena_Community" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Helena_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Helena_Mood",
        },
        {
            text = ccb.content.text("Could you tell me about the community?"),
            next_topic = "TALK_GODCO_Helena_Community",
        },
        {
            text = ccb.content.text("Can I help you with anything?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } }),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Helena_Join",
            when = predicates.handler("dlg_p_dda_e12a216748aa"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("Get away from here, sinner, we don't want your kind here.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("What brings you here <name_b>?  You know we don't want anything to do with you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Blessings to you."),
                        ccb.content.text("Bless you, <u_name>."),
                    },
                },
                no = ccb.content.text("Stranger, what brings you to our holy home?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_GODCO_Helena_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_helena" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_helena", "yes") },
        },
        {
            text = ccb.content.text("Good to see you again."),
            next_topic = "TALK_GODCO_Helena_2",
            when = predicates.handler("dlg_p_dda_e67b4a947328"),
        },
        {
            text = ccb.content.text("Why might that be?"),
            next_topic = "TALK_GODCO_Helena_Angry",
            when = predicates.handler("dlg_p_dda_3b94acd27179"),
        },
        {
            text = ccb.content.text("I can't talk right now."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_449f69e62f09"),
        },
        {
            text = ccb.content.text("Fine then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_40d168d78a5b"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Firstmeet",
    line = ccb.content.text("I'm Helena, the caretaker of this flock.  Who might you be, wanderer?"),
    replies = {
        {
            text = ccb.content.text("I'm just passing through."),
            next_topic = "TALK_GODCO_Helena_Wanderer",
        },
        {
            text = ccb.content.text("I'm not doing much wandering, I'm staying here."),
            next_topic = "TALK_GODCO_Gemma_Firstmeet",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        },
        {
            text = ccb.content.text("I'm just passing through.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Wanderer",
    line = ccb.content.text("Just like all the sinners, roaming through Hell."),
    replies = {
        {
            text = ccb.content.text("It certainly seems like it."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("See ya later, crazy lady."),
            opinion = { value = -1, anger = 1 },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Joinee",
    line = ccb.content.gendered_line("I'm glad you could make it here.  May the Lord have mercy on you.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Thank you, I hope he shares that sentiment."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        { text = ccb.content.text("Thank you.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_2",
    line = ccb.content.text("What do you need?"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("Corrie and I have finished that solar cart."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_Negotiate",
        },
        {
            text = ccb.content.text("Olwen's finished the radio transmitter she was working on."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.has_mission("MISSION_GODCO_HELENA_VISIT_MERCHANTS")), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_godco_has_radio" } }) }),
            next_topic = "TALK_GODCO_Helena_Contact_FreeMerch",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Story",
    line = ccb.content.text("I am a prophet, like my uncle before me.  He saw <the_cataclysm>, the righteous judgment of God and set about preparing an ark to save us.  He passed before his visions could be fulfilled, and now I carry his righteous banner."),
    replies = {
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Helena_Uncle",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Uncle",
    line = ccb.content.text("He had many visions, and he had many secrets.  I don't know all of them, but there was one he was highly vocal about, regarding <the_cataclysm>, that according to him \"The spawn of Satan shall descend upon the Earth, and all will be consumed in death and destruction\".  He never said much else about it, and always had a mortified face whenever someone brought it up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Mood",
    line = ccb.content.text("Thanks to my uncle's forethought, we've been blessed by God.  We have plenty of food for ourselves, safety from the hordes of Hell, and the continued protection of the Lord our God."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Community",
    line = ccb.content.text("They denied us, they labeled us as a doomsday cult, threw sticks and stones at us, and yet, we were standing resiliently.  Why?  Because we knew God was on our side."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Join",
    line = ccb.content.text("We are all under God's protection here.  Our community, like all moral civilizations, has a set of rules.  Obey the Decalogue, have respect for your neighbors and we'll get along just fine.  Go see Gemma or Julian for a bed, if one's available.  We do have limited space on our Ark, though."),
    replies = {
        {
            text = ccb.content.text("Okay, I'll see about that later."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("What is the Decalogue?"),
            next_topic = "TALK_GODCO_Helena_Decalouge",
        },
        {
            text = ccb.content.text("Okay, I'll see about that.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Decalouge",
    line = ccb.content.text("Its also called the Ten Commandments, if you've heard it by that.  A long time ago, Moses lead the Israelites out of slavery in Egypt, towards the Promised Land.  They broke their Covenant with God, and were cursed to wander the desert for forty years, as opposed to the nineteen days it would normally take.  On the way there, Moses went atop Mount Sinai to speak with God.  He saw a burning bush, and heard the voice of the Lord; who engraved the Decalogue on two tablets of stone."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GODCO_Helena_Decalouge2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Decalouge2",
    line = ccb.content.text("&Helena flips through her Bible before stopping.  \"They read: 'I am the Lord your God, who brought you out of Egypt, out of the land of slavery.  You shall have no other gods before me.  You shall not make for yourself a carved image, or any likeness of anything that is in heaven above, or that is in the earth beneath, or that is in the water under the earth.  You shall not take the name of the Lord your God in vain.  Remember the Sabbath day, and keep it holy.  Honor your father and your mother.  You shall not murder.  You shall not commit adultery.  You shall not steal.  You shall not bear false witness against your neighbor.  You shall not covet your neighbors house.\"  They're written in Exodus 20:1-17, for future reference."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_GODCO_Helena_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Negotiate",
    line = ccb.content.text("I like what you and Corrie's put together.  I did promise payment for a proof-of-concept, what'll it be?"),
    replies = {
        {
            text = ccb.content.text("I'll have some icons."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_machineIcon",
        },
        {
            text = ccb.content.text("I want Corrie to have some extra rations."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_machineFood",
        },
        { text = ccb.content.text("Let's negotiate some other time."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_machineIcon",
    line = ccb.content.text("Here's your money.  Don't spend it all in one place."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_DONE",
            actions = { actions.clear_actor_value("speaker", "mission_completed_godco_corrie_machine"), actions.set_actor_value("speaker", "mission_reward_godco_machine_reward", "icon"), actions.set_actor_value("speaker", "mission_reward_unclaimed_machine_reward", "yes"), actions.handler("dlg_a_dda_5b6141887928") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_machineFood",
    line = ccb.content.text("A generous soul, are we?  That's not what I was expecting, but I'll see to it."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            actions = {
                actions.clear_actor_value("speaker", "mission_completed_godco_corrie_machine"),
                actions.set_actor_value("speaker", "mission_reward_godco_machine_reward", "ration"),
                actions.set_actor_value("speaker", "mission_reward_unclaimed_machine_reward", "yes"),
            },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Contact_FreeMerch",
    line = ccb.content.text("Yes, I was just informed of that.  I also heard that she found a large group of people living out in an old evacuation center, who consider themselves merchants.  That would be a good place to resume our spread of the Truth, perhaps we could find others who were faithful before <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text("I presume you want me to pay a visit?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
            next_topic = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
        },
        {
            text = ccb.content.text("Oh, I've met them before!"),
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } }) }),
            next_topic = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
        },
        { text = ccb.content.text("Let's change the subject."), next_topic = "TALK_GODCO_Helena_2" },
        { text = ccb.content.text("Good luck with that."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
    line = ccb.content.text("Yes, you seem like a good fit for the job.  I'll pay you a small sum for getting some information about them."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll go and see what's up."),
            next_topic = "TALK_DONE",
            actions = { actions.offer_mission("MISSION_GODCO_HELENA_VISIT_MERCHANTS") },
        },
        {
            text = ccb.content.text("Let's change the subject."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Tell_FreeMerch",
    line = ccb.content.text("Really?  I'd pay a small sum for information about them."),
    replies = {
        {
            text = ccb.content.text("Well, they're…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_1af3223913ba") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Angry",
    line = ccb.content.text("You've been nothing but a leech and a stain on us, we don't want you here anymore nor your \"services\" you might provide.  Now get out."),
    replies = { { text = ccb.content.text("Fine then."), next_topic = "TALK_DONE" } },
}
