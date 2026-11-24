local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jeremiah_2", "TALK_GODCO_Jeremiah_Mood", "TALK_GODCO_Jeremiah_Story", "TALK_GODCO_Jeremiah_Parents", "TALK_GODCO_Jeremiah_Dnd" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Jeremiah_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's your take on the situation here?"),
            next_topic = "TALK_GODCO_Jeremiah_Mood",
        },
        {
            text = ccb.content.text("What are your parents like?"),
            next_topic = "TALK_GODCO_Jeremiah_Parents",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are your plans after <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Jeremiah_Plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Were could I find work around here?"),
            next_topic = "TALK_GODCO_Jeremiah_Work",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What are you doing around here <name_b>?  Get lost."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } }),
            yes = {
                choices = {
                    ccb.content.text("Hey, look who's back."),
                    ccb.content.text("Hey again."),
                    ccb.content.text("Hey again <u_name>."),
                    ccb.content.text("Oh, hey, it's you again."),
                },
            },
            no = ccb.content.text("Oh, uh… you look new.  Didn't think we'd see new people here.  Hey."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just a traveler, kid.  I won't be staying here for long."),
            next_topic = "TALK_GODCO_Jeremiah_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } })), predicates.negate(predicates.has_effect("speaker", "godco_joinee")) }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_godco_jeremiah", "yes") },
        },
        {
            text = ccb.content.text("I'm not exactly new here, kid."),
            next_topic = "TALK_GODCO_Jeremiah_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_godco_jeremiah" } })), predicates.has_effect("speaker", "godco_joinee") }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_godco_jeremiah", "yes") },
        },
        {
            text = ccb.content.text("Hey, Jerry.  What's up?"),
            next_topic = "TALK_GODCO_Jeremiah_2",
            when = predicates.handler("dlg_p_dda_6a5418e02494"),
        },
        {
            text = ccb.content.text("What's with the attitude?"),
            next_topic = "TALK_GODCO_Jeremiah_Angry",
            when = predicates.handler("dlg_p_dda_6c9f3c8e5e82"),
        },
        {
            text = ccb.content.text("Hey, kid.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Firstmeet",
    line = ccb.content.text("I have a name, you know.  It's Jeremiah, but people just call me Jerry."),
    replies = {
        {
            text = ccb.content.text("Sorry, Jerry.  What's up?"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("Sorry, Jeremiah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_2",
    line = ccb.content.text("I thought asking about each other's emotions went out of style after <the_cataclysm>.  Uhm, okay then.  I'm fine, I guess."),
    replies = {
        {
            text = ccb.content.text("I noticed you're holding a D&D handbook.  Do you play much?"),
            next_topic = "TALK_GODCO_Jeremiah_Dnd",
        },
        {
            text = ccb.content.text("I've convinced Kostas to take you on."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_kostas_teach_jeremiah" } }),
            next_topic = "TALK_GODCO_Jeremiah_Kostas_Convinced",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Mood",
    line = ccb.content.text("My take?  You already know how things are.  People are dead, my friends are dead, so yeah.  At least there's no school, the adults just love reminding me that.  You know what?  I kinda miss school."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Story",
    line = ccb.content.text("I was in high school, like anyone else my age.  Then out of nowhere, my mom pulled me out of school to \"save me\".  I got packed into a bus with my parents and their old-timey friends.  We've been stuck here ever since.  Actually, it's not all that bad.  I'm studying to be a herbalist like Kostas, which is cool I guess."),
    replies = {
        {
            text = ccb.content.text("Tell me about your parents."),
            next_topic = "TALK_GODCO_Jeremiah_Parents",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Dnd",
    line = ccb.content.text("Yeah, I play.  I ran a campaign for a while with some of my friends, we'd play after school.  I don't know where they are now, though.  Do you wanna play some?"),
    replies = {
        {
            text = ccb.content.text("Sure, I'm up for it."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_7cc77414dbc2") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("No thanks.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Parents",
    line = ccb.content.text("&Jeremiah leans his head towards your ear, speaking in a low whisper.  \"To be honest with you, I don't like my mom at all.  She's like a <freaking> helicopter, always telling me what to do, where to go, who I can be with.  She never thinks of me as an individual, only some idea of who she thinks I am.  My dad's alright, he's the chef around here.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Plans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_mission_jeremiah_apprentice" } }),
        yes = ccb.content.text("I don't know, exactly.  I think I'll stay here and do what I can for the community."),
        no = ccb.content.text("I'd like to study herbology with Kostas, it seems like a useful skill these days.  I do feel bad for Jane though, she's a skilled doctor and nobody here cares, they all just think any illness can be prayed away."),
    },
    replies = {
        {
            text = ccb.content.text("When do you plan on starting that apprenticeship?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_convince_kostas" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_mission_kostas_teach_jeremiah" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_mission_jeremiah_apprentice" } })) }),
            next_topic = "TALK_GODCO_Jeremiah_Apprenticeship",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Apprenticeship",
    line = ccb.content.text("Well…  Kostas is a bit unsure about teaching me, for some reason.  If you could change his mind, I'd pay you some \"icons\", what we've started using for money around here."),
    replies = {
        {
            text = ccb.content.text("No thanks.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("I'll see what I can do for you."),
            actions = { actions.set_actor_value("speaker", "general_mission_convince_kostas", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Kostas_Convinced",
    line = ccb.content.text("That's great!  Thanks <name_g>, here's the money."),
    replies = {
        {
            text = ccb.content.text("You're welcome."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5e691b19a919"), actions.clear_actor_value("speaker", "general_mission_kostas_teach_jeremiah"), actions.set_actor_value("interlocutor", "general_mission_jeremiah_apprentice", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Work",
    line = ccb.content.text("Darryl should have something for you to do if you like gardening, Jane could use some medical supplies, too.  If you like to be bossed around, Helena probably has a few things that need doing.  I'd just ask around, really."),
    replies = {
        { text = ccb.content.text("Is there anything you need?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Angry",
    line = ccb.content.text("You know very well what I'm upset about.  Now do like I said earlier and get lost."),
    replies = { { text = ccb.content.text("Fine, whatever."), next_topic = "TALK_DONE" } },
}
