local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Olwen_2", "TALK_GODCO_Olwen_Mood", "TALK_GODCO_Olwen_Story", "TALK_GODCO_Olwen_Skills" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Olwen_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Olwen_Mood",
        },
        {
            text = ccb.content.text("How's your family?"),
            next_topic = "TALK_GODCO_Olwen_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("How is your love life going in here?"),
            next_topic = "TALK_GODCO_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("I heard you were handy with computers."),
            next_topic = "TALK_GODCO_Olwen_Skills",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What in the world are you still doing around here, come back to screw me over?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_olwen" } }),
            yes = {
                choices = {
                    ccb.content.text("Hey, <name_g>."),
                    ccb.content.text("Good to see you again."),
                    ccb.content.text("What can I do for you?"),
                    ccb.content.text("You don't look too shabby, <u_name>."),
                },
            },
            no = ccb.content.text("I definitely haven't met you yet.  Nice to meet you, I'm Olwen."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just a traveler."),
            next_topic = "TALK_GODCO_Olwen_Firstmeet",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_olwen" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_olwen", "yes") },
        },
        {
            text = ccb.content.text("Hi, Olwen.  What's up?"),
            next_topic = "TALK_GODCO_Olwen_2",
            when = predicates.handler("dlg_p_dda_8c6148cf7b57"),
        },
        {
            text = ccb.content.text("Hey, Olwen.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("What's with the attitude?"),
            next_topic = "TALK_GODCO_Olwen_Angry",
            when = predicates.handler("dlg_p_dda_1811b3ed1781"),
        },
        {
            text = ccb.content.text("No, I'll be on my way."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Firstmeet",
    line = ccb.content.text("You look somewhat interesting.  So, what's your story?"),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            next_topic = "TALK_GODCO_Olwen_Traveler",
        },
        {
            text = ccb.content.text("I'm seeking asylum here."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            next_topic = "TALK_GODCO_Olwen_Joinee",
        },
        {
            text = ccb.content.text("I'm just a curious traveler."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            next_topic = "TALK_GODCO_Olwen_Mutant_Traveler",
        },
        {
            text = ccb.content.text("I'd rather not say.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Traveler",
    line = ccb.content.text("Not many travelers come through here these days.  There's not much left to wander too, besides a horde of <zombies>."),
    replies = {
        {
            text = ccb.content.text("Any old port in a storm, I guess."),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Mutant_Traveler",
    line = ccb.content.text("Not many travelers come through here these days.  There's not much left to wander too, besides a horde of <zombies>.  The people here won't be too friendly with you either, so that sucks."),
    replies = {
        { text = ccb.content.text("Sure does."), next_topic = "TALK_GODCO_Olwen_2" },
        {
            text = ccb.content.text("Why would that be?"),
            next_topic = "TALK_GODCO_Olwen_You_Mutant",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Joinee",
    line = ccb.content.text("I suppose a lot of us are these days, with all the nasty things wandering around.  I hope you like it here, might not be the most comfortable, but it'll do for me."),
    replies = {
        {
            text = ccb.content.text("Any old port in a storm, I guess."),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_2",
    line = ccb.content.text("What's up?"),
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_training_olwen_can_teach" } }),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Mood",
    line = ccb.content.text("They're alright, I suppose.  Helena's an asshole as usual, we're low on supplies, and all scared to go twenty feet outside the gate."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Story",
    line = ccb.content.text("Not much too it, really.  I came here on that bus with everyone else when <the_cataclysm> happened to stroll by.  I've been servicing everyone's electronics since then."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about your past?"),
            next_topic = "TALK_GODCO_Olwen_Background",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Background",
    line = ccb.content.text("Why not?  Oversharing is kind of my thing anyway.  Got any more interview questions?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Family",
    line = ccb.content.text("My dad's having a hard time letting go of the past.  Got any more interview questions?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love0",
    line = ccb.content.text("Well…  Things were going pretty well between Julian and I before <the_cataclysm>, but after everything that happened…  Ugh, I'm getting depressed just thinking about it.  Let's just talk about something else."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love1",
    line = ccb.content.text("Pretty well actually!  Julian just asked me to marry him!  With wedding rings and everything!  I must be the happiest woman still alive!"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Love2",
    line = ccb.content.text("I'm on cloud nine!  I just came back from trying on my wedding dress!  Julian is so charming thinking of everything, I don't know how to repay him, I'm really over the moon with the wedding."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Skills",
    line = ccb.content.text("Yeah, I got a master's in computer science from the University of Rhode Island.  Everyone around here comes to me when they want to keep their computers running.  Corrie works more with the hardware portion of these things; I'd recommend visiting her."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "general_training_olwen_can_teach", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("Could you teach me anything?"), next_topic = "TALK_TRAIN" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_You_Mutant",
    line = ccb.content.text("Well, this is a really xenophobic bunch, and regard some of your, changes, as a curse brought on by God.  I'm cool with you though, not like some of these other <name_b>.  There are a few who wouldn't mind you, though."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        { text = ccb.content.text("In that case, I'd better get going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Angry",
    line = ccb.content.text("You've been quite the <name_b> as of late, and I'm sick of it.  Now go away."),
    replies = { { text = ccb.content.text("Alright, I'll leave."), next_topic = "TALK_DONE" } },
}
