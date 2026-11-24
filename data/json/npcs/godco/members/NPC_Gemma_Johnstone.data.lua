local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Gemma_Firstmeet", "TALK_GODCO_Gemma_2", "TALK_GODCO_Gemma_Story", "TALK_GODCO_Gemma_Leader", "TALK_GODCO_Gemma_Mood", "TALK_GODCO_Gemma_Ref", "TALK_GODCO_Gemma_Leave", "TALK_GODCO_Gemma_Joinee" },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Gemma_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Gemma_Mood",
        },
        {
            text = ccb.content.text("What does a dorm leader do exactly?"),
            next_topic = "TALK_GODCO_Gemma_Leader",
        },
        {
            text = ccb.content.text("Can I help you with anything?"),
            next_topic = "TALK_GODCO_Gemma_Help",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } }),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Gemma_Join",
            when = predicates.handler("dlg_p_dda_b0d2ab06f9d5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("The Lord isn't with you, and that's obvious.  Get out of my sight, sinner.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("I'm rather busy at the moment, I don't have the time to talk right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Good to see you're still around, <granny_name_g>."),
                        ccb.content.text("Hey <u_name>.  How can I help you?"),
                    },
                },
                no = ccb.content.text("Great to see a new face.  I'm Gemma.  Will you be staying here with us?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Gemma.  I'm just passing through."),
            next_topic = "TALK_GODCO_Gemma_Leave",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Gemma.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Gemma_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("I'm already staying here.  Nice to meet you."),
            next_topic = "TALK_GODCO_Gemma_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_gemma" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_gemma", "yes") },
        },
        {
            text = ccb.content.text("Hi, Gemma.  How're you doing?"),
            next_topic = "TALK_GODCO_Gemma_Mood",
            when = predicates.handler("dlg_p_dda_812ec78644bd"),
        },
        {
            text = ccb.content.text("Hello, Gemma.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Are you sure?  I've got all the time in the world."),
            next_topic = "TALK_GODCO_Gemma_Angry",
            when = predicates.handler("dlg_p_dda_b25b2ee6efa9"),
        },
        {
            text = ccb.content.text("What's the harsh reception about?"),
            next_topic = "TALK_GODCO_Gemma_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fine then, screw you."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Firstmeet",
    line = ccb.content.gendered_line("It's nice to meet you too, survivor.  It's a tragedy what's become of the New England Church Community, perhaps it'll flourish again someday.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Leave",
    line = ccb.content.text("I heard what it's like out there.  You must be weary from exploring this unforgiving wasteland.  I'm sorry that you're leaving us this soon."),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Join",
    line = ccb.content.text("We are all under God's protection here.  Our community, like all moral civilizations, has a set of rules.  Obey the Decalogue, have respect for your neighbors and we'll get along just fine, okay?"),
    replies = {
        { text = ccb.content.text("Got it."), next_topic = "TALK_GODCO_Gemma_Joinee" },
        {
            text = ccb.content.text("What is the Decalogue?"),
            next_topic = "TALK_GODCO_Gemma_Decalouge",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Decalouge",
    line = ccb.content.text("Its also called the Ten Commandments, if you've heard it by that.  A long time ago, Moses lead the Israelites out of slavery in Egypt, towards the Promised Land.  They broke their Covenant with God, and were cursed to wander the desert for forty years, as opposed to the nineteen days it would normally take.  On the way there, Moses went atop Mount Sinai to speak with God.  He saw a burning bush, and heard the voice of the Lord; who engraved the Decalogue on two tablets of stone."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GODCO_Gemma_Decalouge2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Decalouge2",
    line = ccb.content.text("&Gemma is in deep, silent thought for a moment, before clearing her throat.  \"They read: 'I am the Lord your God, who brought you out of Egypt, out of the land of slavery.  You shall have no other gods before me.  You shall not make for yourself a carved image, or any likeness of anything that is in heaven above, or that is in the earth beneath, or that is in the water under the earth.  You shall not take the name of the Lord your God in vain.  Remember the Sabbath day, and keep it holy.  Honor your father and your mother.  You shall not murder.  You shall not commit adultery.  You shall not steal.  You shall not bear false witness against your neighbor.  You shall not covet your neighbors house.\"  They're written in Exodus 20:1-17, for future reference."),
    replies = { { text = ccb.content.text("Got it."), next_topic = "TALK_GODCO_Gemma_Joinee" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Joinee",
    line = ccb.content.text("You are most welcome here.  In the good old days we would've held a ceremony for you.  Oh well, times have changed.  Accept this blanket, you may choose either bed by the window.  If you're hungry, you can go see Simon for a meal, up to one per day."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a026e5b0762a"), actions.set_actor_value("speaker", "general_meeting_godco_joinee", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Gemma."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Story",
    line = ccb.content.text("My story?  It's been told a thousand times."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Leader",
    line = ccb.content.text("I always have things on the go: tidying, organizing, cleaning, but I don't complain.  I never complain."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Gemma_Help",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("There sure is.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Mood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } }),
        yes = ccb.content.text("I'm feeling great!  Even if the world's over, I always have myself and God above."),
        no = ccb.content.text("I'm feeling alright, just working away."),
    },
    replies = {
        {
            text = ccb.content.text("I'm happy to hear that, Gemma.  I'd best be going."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } }),
        },
        {
            text = ccb.content.text("I'll see you around."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_gemma_got_supplements" } })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Help",
    line = ccb.content.text("My flowers look a bit dehydrated, I'd appreciate it if you watered them for me.  These indoor plants are the most calming reminders of life before <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I meant \"Are there any jobs you know of?\""),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_You_Mutant",
    line = ccb.content.text("You certainly have the marks of one.  I don't understand how you can go walking around looking like an abomination, cursed by God, and think everything's alright.  I'm not interested in learning, either, so be gone with you."),
    replies = { { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Angry",
    line = ccb.content.text("If you really want to know the truth, I;m quite upset with how you've been acting as of late, and I don't want to talk to you.  Now please, leave me be."),
    replies = { { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}
