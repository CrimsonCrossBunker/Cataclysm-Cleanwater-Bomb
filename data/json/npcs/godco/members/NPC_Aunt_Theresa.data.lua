local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Theresa_2", "TALK_GODCO_Theresa_Mood", "TALK_GODCO_Theresa_Story", "TALK_GODCO_Theresa_Help", "TALK_GODCO_Theresa_Husband", "TALK_GODCO_Theresa_Community", "TALK_GODCO_Theresa_Vision", "TALK_GODCO_Theresa_Firstmeet" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Theresa_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's it like living here?"),
            next_topic = "TALK_GODCO_Theresa_Mood",
        },
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_GODCO_Theresa_Help",
        },
        {
            text = ccb.content.text("How've things been since <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Theresa_Cataclysm",
            when = predicates.handler("dlg_p_dda_d637ce500b4a"),
        },
        {
            text = ccb.content.text("Do you knit at all?  I noticed you have sewing needles."),
            next_topic = "TALK_GODCO_Theresa_Knit",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("I have no interest in dealing with you, unnatural abomination.  Keep away from me."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("What are you doing around here?  I don't want to talk to you."),
            no = {
                when = predicates.handler("dlg_p_dda_f98058ef3692"),
                yes = ccb.content.text("&Theresa looks up from her knitting, with a sparkle in her eyes.  \"Come on in, <granny_name_g>.  I'm glad to see you again, have a seat.\""),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_theresa" } }),
                    yes = ccb.content.text("Praise the Lord.  It's good to see you're still around, <granny_name_g>."),
                    no = ccb.content.text("Welcome, <granny_name_g>.  I don't think I recognize you, I'm Theresa."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Theresa.  I'm <u_name>."),
            next_topic = "TALK_GODCO_Theresa_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_theresa" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_theresa", "yes") },
        },
        {
            text = ccb.content.text("Hello, Theresa.  How are you doing?"),
            next_topic = "TALK_GODCO_Theresa_2",
            when = predicates.handler("dlg_p_dda_651c5ad5121f"),
        },
        {
            text = ccb.content.text("Hello, Theresa.  How are you doing?"),
            next_topic = "TALK_GODCO_Theresa_Anger",
            when = predicates.handler("dlg_p_dda_470036d03c11"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("What's the insults for?"),
            next_topic = "TALK_GODCO_Theresa_You_Mutant",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
        {
            text = ccb.content.text("Fuck you then, I'm leaving."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_af294cdc5175"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Firstmeet",
    line = ccb.content.text("It is nice to meet you as well.  I reckon you got some questions about our group."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_2",
    line = {
        choices = {
            ccb.content.text("Just fine.  Nice of you to ask.  How's it going, <granny_name_g>?"),
            ccb.content.text("I'm doing as well as can be expected.  How's everything, <granny_name_g>?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm here about the scarf."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_56f3a4b9bb1e"),
            actions = { actions.handler("dlg_a_dda_4e9bbce8c9e2") },
        },
        {
            text = ccb.content.text("I'm here about the blanket."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_9dec920460e6"),
            actions = { actions.handler("dlg_a_dda_a026e5b0762a") },
        },
        {
            text = ccb.content.text("I'm here about the quilt."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_5f469fab0828"),
            actions = { actions.handler("dlg_a_dda_cae2469c91fb") },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Mood",
    line = ccb.content.text("We're doing better than most, to put it mildly.  There's a reason for that, as for everything.  Say, have I told you about my husband?  I'm sorry if I already have, my memory's not what it used to be."),
    replies = {
        {
            text = ccb.content.text("Tell me about your husband."),
            next_topic = "TALK_GODCO_Theresa_Husband",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Husband",
    line = ccb.content.text("He was an exceptional man.  Ever since he was a child it was clear that there was something special about him.  My husband had a way with people, and with God too.  But, after all he was as human as you and I.  He was corrupted by addiction.  One day, God appeared to him in a vision that turned his life around, he had other plans for him.  From then on he didn't take his life for granted.  He used his talent and newfound inspiration to better the people around him."),
    replies = {
        {
            text = ccb.content.text("So, he founded the community?"),
            next_topic = "TALK_GODCO_Theresa_Community",
        },
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Theresa_Vision",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Community",
    line = ccb.content.text("That's right.  He wanted something to return for the guidance he received when he was at the lowest point of his life.  He created a charity group which, over the years, became what's now known as the New England Church Community.  He lead them for many decades, until his death a few years before his prophecy was fulfilled.  Now, our niece Helena leads the community."),
    replies = {
        {
            text = ccb.content.text("Tell me about his visions."),
            next_topic = "TALK_GODCO_Theresa_Vision",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Vision",
    line = ccb.content.text("He was a man of many secrets.  It would've been too personal to share, I'm afraid.  On the other hand, there was a prophecy he was quite vocal about.  In a way, he predicted <the_cataclysm> long before the first warning signs appeared.  Thanks to him, we had the foresight to prepare.  Oh what a great man he was…"),
    replies = {
        {
            text = ccb.content.text("So, he founded the community?"),
            next_topic = "TALK_GODCO_Theresa_Community",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Story",
    line = ccb.content.text("Oh you don't have the time for that, do you now?  It's a long, long tale, thank goodness.  I'm grateful, for I was blessed with a full life."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Help",
    line = ccb.content.text("That's very sweet of you <granny_name_g>, but there's nothing I could possibly want from this mortal world.  My life is now complete, I believe."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit",
    line = ccb.content.text("Yes, I knit and sew in my spare time.  Its' helped keep my hands in good shape over the years."),
    replies = {
        {
            text = ccb.content.text("Could you make something for me?"),
            next_topic = "TALK_GODCO_Theresa_Knit_Something",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Something",
    line = ccb.content.text("I suppose I could, in exchange for a few icons.  A scarf is five, a blanket ten, a quilt thirty."),
    replies = {
        {
            text = ccb.content.text("I'll have a scarf."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 5),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_scarf", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 5) },
        },
        {
            text = ccb.content.text("I'll have a blanket."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 10),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_blanket", "yes"), actions.handler("dlg_a_dda_bc30246b108a"), actions.transfer_items("icon", 10) },
        },
        {
            text = ccb.content.text("I'll have a quilt."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 30),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_quilt", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 30) },
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Theresa_Knit_Time",
        },
        {
            text = ccb.content.text("I've changed my mind.  How're you feeling?"),
            next_topic = "TALK_GODCO_Theresa_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Time",
    line = ccb.content.text("I can knit a scarf ready by tomorrow, a blanket in two days, and a quilt in a week."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_GODCO_Theresa_Knit_Something" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Done",
    line = ccb.content.text("I hope you like it <granny_name_g>.  If you want anything else, just come back."),
    replies = {
        {
            text = ccb.content.text("Thank you, Theresa.  I'll put it to good use."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Cataclysm",
    line = ccb.content.text("I've grown tired, <granny_name_g>.  I haven't left here since we came, and things outside are getting worse each day.  All my old aches and pains have come back too; I can't see too good, and my muscles are always sore.  I don't like where my niece is going either; she's ever more fanatical, and taking my dear husband's prophecy to the extreme.  I'm content with my life, though.  I've lived long and prospered by the grace of the Lord."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_You_Mutant",
    line = ccb.content.text("You clearly have the mark of a sinner.  I've seen your kind out and about after the Flood, killing and maiming like wild animals.  None of you are any good, not even to God, and you're of no good to me either.  Run on back to your sinful ways, now.  God has judged you already."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Anger",
    line = ccb.content.text("You've done me poorly enough times now, I won't have any more of it.  Get out of here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
