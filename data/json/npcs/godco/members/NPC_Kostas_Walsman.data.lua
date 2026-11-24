local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Kostas_2", "TALK_GODCO_Kostas_Story", "TALK_GODCO_Kostas_Mood", "TALK_GODCO_Kostas_Task", "TALK_GODCO_Kostas_Herbalism" },
    replies = {
        {
            text = ccb.content.text("I have the pine needles you asked me for."),
            next_topic = "TALK_GODCO_Kostas_Tea_2",
            when = predicates.all({ predicates.any_equal({ "in-progress", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } }), predicates.has_inventory("speaker", "pine_bough", 12) }),
            actions = { actions.set_actor_value("interlocutor", "knowledge_completed_godco_kostas_tea", "yes"), actions.handler("dlg_a_dda_517739bde778") },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Kostas_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Kostas_Mood",
        },
        {
            text = ccb.content.text("What do you do around here?"),
            next_topic = "TALK_GODCO_Kostas_Task",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_2",
            actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("A sin against God, did you know that's what you are?  Get away from me."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("&Kostas looks up at you and scorns.  \"I'm rather busy right now with an important project, go away please.\""),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("<u_name>, how can I help you?"),
                    },
                },
                no = ccb.content.gendered_line("You must be new here, nice to meet you.  They call me Kostas, I'm the local herbalist.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Kostas."),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_kostas", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.handler("dlg_p_dda_8b79c1f17396"),
        },
        {
            text = ccb.content.text("I heard Jeremiah wanted to learn a few things from you."),
            next_topic = "TALK_GODCO_Kostas_Jeremiah",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "failed_persuade")), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_kostas" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_convince_kostas" } }) }),
        },
        {
            text = ccb.content.text("Hi, Kostas.  Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_2",
            when = predicates.handler("dlg_p_dda_5fe76c7704cf"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Hey, I think we've got some time to chat, don't you?"),
            next_topic = "TALK_GODCO_Kostas_Angry",
            when = predicates.handler("dlg_p_dda_447ecf8e75e4"),
        },
        {
            text = ccb.content.text("Hi, Kostas.  Care to trade?"),
            next_topic = "TALK_GODCO_Kostas_Angry",
            when = predicates.handler("dlg_p_dda_ca7e572fd51b"),
        },
        {
            text = ccb.content.text("Hey Kostas, find something interesting lately?"),
            next_topic = "TALK_GODCO_Kostas_Interval",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("Hey, Kostas.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What the hell are you talking about?"),
            next_topic = "TALK_GODCO_Kostas_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Alright then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Interval",
    line = {
        choices = {
            ccb.content.text("I'm afraid I haven't gone out there for a while, maybe come back after <restock_time_point>.  These are all I have, care to take a look?"),
            ccb.content.text("Sorry these are all I have.  However I'll be back from my next run after <restock_time_point>.  Care to take a look in the meanwhile?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alright, I'll take a look."),
            native_actions = { "start_trade" },
            next_topic = "TALK_GODCO_Kostas_1",
        },
        {
            text = ccb.content.text("Alright, thanks for informing me.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_2",
    line = ccb.content.text("What can I do for you, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Are there any jobs I could do?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Story",
    line = ccb.content.text("My story?  I'm afraid it's not as gripping as the other tales around here.  My father was an herbalist, my grandfather was an herbalist and - as ancestral pressure would have it - I also became an herbalist.  I studied from the best teachers and, through the years, a generation's knowledge passed on to me.  I've spent a good portion of my life warning others of the fakery that is plastic medicine and helping them rediscover the forgotten beauty that lies in our surroundings.  I joined the New England Church Community to express my gratitude towards the benevolence of nature.  This is where it brought me."),
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
    id = "TALK_GODCO_Kostas_Mood",
    line = ccb.content.text("It's been quiet and peaceful.  Nature is recovering, and so are we.  There's something bittersweet about <the_cataclysm>, isn't there?  Our species was on the path of destruction, but Mother Nature spared us.  A sign of mercy for a creature that did not deserve it."),
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
    id = "TALK_GODCO_Kostas_Task",
    line = ccb.content.text("You must be new to herbalism, no?  In short, I scavenge the land for herbs to supply our humble community with medicine.  And that's just one part of my job.  Say, are you interested in buying campsite gear?  I came across an abandoned camp while foraging.  One can only wonder what happened to its poor inhabitants…"),
    replies = {
        {
            text = ccb.content.text("Care to share your knowledge about herbalism?"),
            next_topic = "TALK_GODCO_Kostas_Herbalism",
        },
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
    id = "TALK_GODCO_Kostas_Herbalism",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } }),
        yes = {
            choices = {
                ccb.content.text("Nature can provide.  You can live off the land if you learn how."),
                ccb.content.text("Foraging is about recognizing the abundance that is around us all the time, not seeking out rare species."),
                ccb.content.text("You'll need a good book to confidently identify edible and poisonous wild foods.  I'd recommend the book 'Autobiography of a Mountain Man' for detailed descriptions."),
                ccb.content.text("Never eat any wild food without first being sure of its identity.  It only takes one mistake."),
                ccb.content.text("The huge diversity of wild plants and fungi can be very daunting to the novice forager.  Don't be too ambitious.  Try to enjoy the learning process without getting frustrated or taking risks around uncertain identifications."),
            },
        },
        no = ccb.content.text("I can tell you this: pine needles make the best tea.  Perhaps I'll make you one someday."),
    },
    replies = {
        {
            text = ccb.content.text("Can I try your pine needle tea?"),
            next_topic = "TALK_GODCO_Kostas_Tea",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "knowledge_completed_godco_kostas_tea" } })),
            actions = {
                actions.set_actor_value("interlocutor", "knowledge_completed_godco_kostas_tea", "in-progress"),
            },
        },
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
    id = "TALK_GODCO_Kostas_Tea",
    line = ccb.content.text("Sure.  Bring me a dozen pine boughs and I'll boil you some."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll be back soon."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Tea_2",
    line = ccb.content.text("This recipe is a gemstone of my family heritage.  Lucky for us that the most common evergreen tree in the U.S. is non-toxic.  Start by rinsing the needles, and separating any woody parts from them.  Then, cut the pine needles in half.  Add one bough's worth of chopped needles to a cup or mug and fill it with boiling water.  Let the needles steep for ten minutes, until they turn brownish and sink down to the bottom.  As a final step, you can strain the needles, but then you'd be wasting precious calories.  A drink like this is perfect for mid-winter colds."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thank you.  See you around, Kostas."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah",
    line = ccb.content.text("Yeah, yeah…  I don't think he'd be a good fit for an herbalist.  He has a bad habit of wandering off someplace, could get him killed one of these days."),
    replies = {
        {
            text = ccb.content.text("Jeremiah's a bright kid.  I'll just tell him to not wander as a stipulation."),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = {
                    { score = "trust", scale = 2 },
                    { score = "value", scale = 2 },
                    { score = "anger", scale = -1 },
                },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
                opinion = { trust = 0, fear = 0 },
            },
        },
        {
            text = ccb.content.text("I know him pretty well, I'm sure he'll learn as he goes along."),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = { { score = "value", scale = 3 }, { score = "anger", scale = -2 } },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
                opinion = { trust = 0, fear = 0 },
            },
        },
        {
            text = ccb.content.text("If you don't take him under your wings, I'll rip them off for you.  Capiche?"),
            trial = {
                kind = "intimidate",
                difficulty = -5,
                modifiers = {
                    { score = "fear", scale = 2 },
                    { score = "trust", scale = -2 },
                    { score = "value", scale = -2 },
                    { score = "anger", scale = -1 },
                },
            },
            success = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_Persuade",
                opinion = { trust = -5, value = -5, anger = 5, fear = 10 },
            },
            failure = {
                next_topic = "TALK_GODCO_Kostas_Jeremiah_FailPersuade_Violent",
                opinion = { trust = -10, value = -10, anger = 10 },
            },
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thank you.  See you around, Kostas."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_Persuade",
    line = ccb.content.gendered_line("Alright, you've convinced me.  I'll take Jeremiah on and show him the ropes.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Kostas."),
            actions = {
                actions.set_actor_value("speaker", "general_mission_kostas_teach_jeremiah", "yes"),
                actions.clear_actor_value("speaker", "general_mission_convince_kostas"),
            },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
    line = ccb.content.text("No, I'm still certain about this.  Jeremiah just isn't a good fit."),
    replies = {
        {
            text = ccb.content.text("Alright.  See you around, Kostas."),
            actions = { actions.add_effect("interlocutor", "failed_persuade", { turns = 86400 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_FailPersuade_Violent",
    line = ccb.content.text("You think you're so tough <name_b>?  I'm not taking Jeremiah on, certainly not when his representitive is so barbaric.  I don't know how he got such a violent individual like yourself to do this, but I hope he can find someone else in the future."),
    replies = {
        {
            text = ccb.content.text("Fuck you then, you judgmental <name_b>."),
            actions = { actions.add_effect("interlocutor", "failed_persuade", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_You_Mutant",
    line = ccb.content.text("I'm talking about you and your filthy, unnatural appearance.  I don't like your kind, and neither does anyone else.  Go repent before the Lord for your many sins, if he'll even listen to you."),
    replies = { { text = ccb.content.text("Fuck you, I'm blowing this joint."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Angry",
    line = ccb.content.text("&Kostas becomes visibly angry now, glaring at you.  \"Feeling pushy today, are we?  If you want to hear it plain, we're not on good terms at the moment and I would appreciate it if you didn't bother me for a while.  Understand?\""),
    replies = { { text = ccb.content.text("Okay, see you later."), next_topic = "TALK_DONE" } },
}
