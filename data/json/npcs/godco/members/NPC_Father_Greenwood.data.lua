local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Greenwood_1", "TALK_GODCO_Greenwood_2", "TALK_GODCO_Greenwood_Firstmeet" },
    replies = {
        {
            text = ccb.content.text("I'm seeking forgiveness, Father.  I've made mistakes in my life that I can never take back."),
            actions = {
                "morale_chat_activity",
                actions.add_effect("speaker", "godco_confessed", { turns = 86400 }),
            },
            when = predicates.all({ predicates.negate(predicates.has_effect("speaker", "godco_confessed")), predicates.negate(predicates.has_flag("speaker", "PSYCHOPATH")) }),
            next_topic = "TALK_GODCO_Greenwood_Confessed",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_1",
    line = {
        when = predicates.handler("dlg_p_dda_085a734e2c49"),
        yes = ccb.content.text("What brings you back here?  Come to exploit me again?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
            yes = ccb.content.text("The Lord be with you…  You don't seem all too well, I pray for you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } }),
                yes = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = {
                        choices = {
                            ccb.content.text("The Lord be with you, brother."),
                            ccb.content.text("Good to see you're still around, <u_name>."),
                        },
                    },
                    no = {
                        choices = {
                            ccb.content.text("The Lord be with you, sister."),
                            ccb.content.text("Good to see you're still around, <u_name>."),
                        },
                    },
                },
                no = {
                    when = predicates.actor_state("speaker", "male"),
                    yes = ccb.content.text("The Lord be with you, brother.  You seem new, nice to meet you.  Welcome, and welcome aboard!"),
                    no = ccb.content.text("The Lord be with you, sister.  You seem new, nice to meet you.  Welcome, and welcome aboard!"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Reverend."),
            next_topic = "TALK_GODCO_Greenwood_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("Good to see you again, Reverend.  I wanted to talk."),
            next_topic = "TALK_GODCO_Greenwood_2",
            when = predicates.handler("dlg_p_dda_5646b391242e"),
        },
        {
            text = ccb.content.text("I'm looking for work.  Can I do anything for your congregation?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_9632f2278fb1"),
        },
        {
            text = ccb.content.text("Nice meeting you, Reverend.  I'd best get going though."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9632f2278fb1"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("What's wrong with me, if you could say?"),
            next_topic = "TALK_GODCO_Greenwood_You_Mutant",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_greenwood" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_greenwood", "yes") },
        },
        {
            text = ccb.content.text("What are you talking about?"),
            next_topic = "TALK_GODCO_Greenwood_Angry",
            when = predicates.handler("dlg_p_dda_085a734e2c49"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Firstmeet",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        { text = ccb.content.text("Where am I?"), next_topic = "TALK_GODCO_Greenwood_Where" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_2",
    line = {
        when = predicates.actor_state("speaker", "male"),
        yes = ccb.content.text("How may I help you, brother?"),
        no = ccb.content.text("How may I help you, sister?"),
    },
    replies = {
        {
            text = ccb.content.text("Where am I again?"),
            next_topic = "TALK_GODCO_Greenwood_Where",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Greenwood_Past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me a bit about this church?"),
            next_topic = "TALK_GODCO_Greenwood_NECC",
        },
        {
            text = ccb.content.text("I'm looking for work.  Can I do anything for your congregation?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Confessed",
    line = {
        when = predicates.actor_state("speaker", "male"),
        yes = ccb.content.text("We all have, brother, we all have."),
        no = ccb.content.text("We all have, sister, we all have."),
    },
    replies = { { text = ccb.content.text("Thanks for your time, Reverend."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Where",
    line = ccb.content.text("This is the New England Community Church, the congregation of it.  Praise the Lord that we made it through!"),
    replies = {
        {
            text = ccb.content.text("What are you doing out here?"),
            next_topic = "TALK_GODCO_Greenwood_Compound",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Compound",
    line = ccb.content.text("We all came out here when <the_cataclysm> rocked the world.  It's an old retreat Helena bought in the hopes of renovating it, good thing we did."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Past",
    line = ccb.content.text("I had a pretty comfortable life growing up.  My parents were florists, owned a shop along the main street of town.  They were always so cheery, as if nothing bad could phase them.  When I was about fifteen, I dreamt that the Lord spoke to me; as if urging me to go and spread his Gospel, so I did.  I took odd jobs at several churches for a while, before I went to seminary.  I went between three different churches, before I found this one.  I've been here since."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_NECC",
    line = ccb.content.text("The full name is the New England Community Church.  Helena's father started it about twenty years ago.  The flock may be small, but we've always helped each other when times were tough; we're like a family now."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        {
            text = ccb.content.text("What do you think about Helena?"),
            next_topic = "TALK_GODCO_Greenwood_Helena",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Helena",
    line = ccb.content.text("&Greenwood looks over his their shoulder, briefly glancing around before speaking in a low whisper.  \"Don't tell anyone I said this, but I don't like Helena at all.  Her father was a real nut, he'd rave on and on about an apocalypse he'd prepared for.  He always thought that his church would be the ark to weather the storm, that God would destroy the world by unleashing the armies of Hell; and he wasn't talking about the Second Coming of Christ.  Helena's just as fanatical as he was, and it reflects in her inadequate leadership.  To be honest, I'm highly concerned for some of the people here; they're obsessively zealous with Helena, and harbor a xenophobic hatred of everything.  As in Matthew 15:14, 'They are blind guides.  And if one blind person guides another, they will both fall into a pit'.\""),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_You_Mutant",
    line = ccb.content.text("Well, it's your appearance.  You're… how do I say, significantly different than what most people are used to.  With the sudden appearance of strange phenomenon following the Rapture, some have taken your changes as a mark of demonic corruption, and won't be very kind to you either.  Be wary of this."),
    replies = {
        {
            text = ccb.content.text("Alright.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        {
            text = ccb.content.text("Thanks for the info, I'd best be going then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Angry",
    line = ccb.content.text("I've already given you a second chance, and yet you kept right on abusing me.  I can't stand it any longer, and I want nothing to do with you.  I hope that God will show you the light soon enough."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
