local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Sonia_Tunes", "TALK_GODCO_Sonia_Instrument", "TALK_GODCO_Sonia_Chloe", "TALK_GODCO_Sonia_Band", "TALK_GODCO_Sonia_Feeling", "TALK_GODCO_Sonia_Greet", "TALK_GODCO_Sonia_Godco" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Sonia_Chloe",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Sonia_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Sonia_Godco",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Now that your guitar is fixed, could you play something for me?"),
            next_topic = "TALK_GODCO_Sonia_Play_For_U",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_sonia_guitar_fixed" } }), predicates.has_item("interlocutor", "acoustic_guitar") }),
        },
        {
            text = ccb.content.text("That's a nice guitar you have."),
            next_topic = "TALK_GODCO_Sonia_Instrument",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Sonia glances at you harshly, then turns away.  \"Come back later, I'm busy right now.\""),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_sonia" } }),
            yes = {
                choices = {
                    ccb.content.gendered_line("Well now, good to see you again, friend.", { "speaker" }),
                    ccb.content.text("Nice of you to come around <u_name>."),
                },
            },
            no = ccb.content.text("Good to see people like you in the world.  I'm Sonia, Sonia Greene.  I entertain the people."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Sonia?  Nice to meet you, I'm <u_name>.  How are things here?"),
            next_topic = "TALK_GODCO_Sonia_Feeling",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_sonia" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_sonia", "yes") },
        },
        {
            text = ccb.content.text("Hey Sonia.  What's up?"),
            next_topic = "TALK_GODCO_Sonia_Tunes",
            when = predicates.handler("dlg_p_dda_1885ec9fcf06"),
        },
        {
            text = ccb.content.text("Hey Sonia.  What's up?"),
            next_topic = "TALK_GODCO_Sonia_Angry",
            when = predicates.handler("dlg_p_dda_50d7905c11f8"),
        },
        {
            text = ccb.content.text("Hey Sonia.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("Alright, see you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Tunes",
    line = {
        choices = {
            {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_sonia_guitar_fixed" } }),
                yes = ccb.content.text("Just playing some good ol' tunes.  There's so much negativity around here, someone's gotta cheer people up, ya know?"),
                no = ccb.content.text("Nothin' much, just sitting around and biding my time, getting any work I can.  I might play something to cheer everyone up, if my guitar wasn't busted."),
            },
        },
    },
    replies = {
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
    id = "TALK_GODCO_Sonia_Instrument",
    line = ccb.content.text("You're damn right.  I like its scars, makes it look like it has a history, you know?  We've been through a lot.  Those pesky <zombies> forced me to harm my sweet, sweet guitar, but I retaliated and bashed their heads in!  I lost a part of me that day, but the guitar's alright.  Just a bit rusted from all that blood and gore, that's all."),
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
    id = "TALK_GODCO_Sonia_Chloe",
    line = ccb.content.text("Now that's a wild story.  I owe my life to this kid Chloe, really.  I'll let her tell the tale."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Sonia_Band",
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
    id = "TALK_GODCO_Sonia_Band",
    line = ccb.content.text("I was in an underground band - Taurists was our name - before all this.  Performing gigs at local venues and jamming with my friends; that's all my life was about.  Now, I'm a badass soloist with a war-torn guitar, a singer of the old-world preserving the wonders of music and the Taurist legacy for generations to come.  That's also a synonym for not having all that much going on in my life."),
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
    id = "TALK_GODCO_Sonia_Feeling",
    line = ccb.content.text("Oh, just fine.  A bit malnourished and all, but I can't really complain if that's the worst of it, right?  My guitar makes our twisted little world a bit more tolerable, though.  Takes my mind off stuff and muffles the screams of the boogeyman, you know?"),
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
    id = "TALK_GODCO_Sonia_Godco",
    line = ccb.content.text("Fairly?  There's no such thing as fairness in the world.  The NECC wouldn't give a damn if I starved to death on this very bench.  At least I have friends here, ones that appreciate what I do.  I make music and that's all I have left, it means everything to me."),
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
    id = "TALK_GODCO_Sonia_Play_For_U",
    line = ccb.content.text("Sure, I can play you a tune or two that I know.  It will cost you a little something, just one icon.  The artist doesn't want to starve, if you know what I mean."),
    replies = {
        {
            text = ccb.content.text("Alright, let's hear it."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "icon"),
            actions = { actions.transfer_items("icon"), actions.handler("dlg_a_dda_fa9ebfeb6877") },
            opinion = { trust = 1, value = 1 },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia_Angry",
    line = ccb.content.text("&Sonia doesn't say anything back, ignoring you."),
    replies = { { text = ccb.content.text("[Walk away.]"), next_topic = "TALK_DONE" } },
}
