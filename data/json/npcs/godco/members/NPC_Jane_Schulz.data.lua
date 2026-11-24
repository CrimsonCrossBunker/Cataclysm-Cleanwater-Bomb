local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jane_2", "TALK_GODCO_Jane_Mood", "TALK_GODCO_Jane_Story", "TALK_GODCO_Jane_Firstmeet", "TALK_GODCO_Jane_Kostas_Personal" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Jane_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Jane_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Jane_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Need any help?"),
            next_topic = "TALK_GODCO_Jane_Help",
        },
        {
            text = ccb.content.text("Could you provide any medical services?"),
            next_topic = "TALK_GODCO_Jane_Heal_You",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jane_Help", "TALK_GODCO_Jane_Arturo", "TALK_GODCO_Jane_Medicine", "TALK_GODCO_Jane_Kostas" },
    replies = {
        {
            text = ccb.content.text("I might have some medicine for the community.  Anything you're missing?"),
            next_topic = "TALK_GODCO_Jane_Medicine",
        },
        {
            text = ccb.content.text("Are you taking care of Arturo?"),
            next_topic = "TALK_GODCO_Jane_Arturo",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Jane_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Jane_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Jane_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you want to come with me?"),
            next_topic = "TALK_GODCO_Jane_Follow",
        },
        {
            text = ccb.content.text("Could you provide any medical services?"),
            next_topic = "TALK_GODCO_Jane_Heal_You",
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
    id = "TALK_GODCO_Jane_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Jane glances at you, scowls, and ignores your presence."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_jane" } }),
            yes = {
                choices = {
                    ccb.content.text("How can I help you?"),
                    ccb.content.text("<u_name>, what can I do for you?"),
                },
            },
            no = ccb.content.text("Oh, I don't think we've met before.  My name's Jane, I'm the local doctor."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Jane."),
            next_topic = "TALK_GODCO_Jane_Firstmeet",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_jane" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_jane", "yes") },
        },
        {
            text = ccb.content.text("Hi, Jane.  Got a minute?"),
            next_topic = "TALK_GODCO_Jane_2",
            when = predicates.handler("dlg_p_dda_07592b4ecdd4"),
        },
        {
            text = ccb.content.text("Hi, Jane.  Got a minute?"),
            next_topic = "TALK_GODCO_Jane_Angry",
            when = predicates.handler("dlg_p_dda_4f8893d03f0a"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Firstmeet",
    line = ccb.content.gendered_line("Always nice to meet a fellow outsider.  How can I help you?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_2",
    line = ccb.content.text("Sure, I don't see why not.  I've gotta keep my mind off stuff anyway."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Mood",
    line = ccb.content.text("I'm doing somewhat well, thanks to my occupation.  The other joinees, well, they're barely scraping by.  It's been tense, and I'm not seeing it change for the better."),
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
    id = "TALK_GODCO_Jane_Story",
    line = ccb.content.text("I was a physician, one of the more unfortunate people who didn't call in sick during the riots.  I remember it all so clearly, the cuts, bruises, deep bites, then those oily black eyes, caustic yellow blood, spastic fungal growths… it was terrible gnarly.  Then things descended into all-new levels of fucked up, and some of my coworkers were preparing to just get the hell out.  I followed them."),
    replies = {
        { text = ccb.content.text("Were you evaced'?"), next_topic = "TALK_GODCO_Jane_Story1" },
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
    id = "TALK_GODCO_Jane_Story1",
    line = ccb.content.text("No, not by the government."),
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
    id = "TALK_GODCO_Jane_Community",
    line = ccb.content.text("No, not really.  I came here after I was split from my friends by a horde of <zombies>.  They let me in after I gave away some food I found.  The church distrusts my profession; I get by helping Kostas."),
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
    id = "TALK_GODCO_Jane_Help",
    line = ccb.content.text("I really don't, actually.  Even my help is thankless here.  Bandaging cuts, setting bones, disinfecting wounds; who needs all that when they can pray anything away?"),
    replies = {
        {
            text = ccb.content.text("Do you have any work available?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Would you like to buy any supplies?"),
            next_topic = "TALK_GODCO_Jane_Medical_Buy",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Arturo",
    line = ccb.content.text("I do what I can, but he's mostly beyond my skillset.  Coke's a <freaking> <name_b>, really messes a person up.  Arturo was on it for several years before he tried to get help, now he has auditory hallucinations; hears voices from nowhere.  Traumatic experiences have a harsher effect on recovering addicts, but <the_cataclysm> is worse than anything we've gone through before."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Medicine",
    line = ccb.content.text("Thorazine would go us a long way, but Arturo's having trouble getting it.  They think he's the key and that my help would obstruct him.  Regardless, there's just so much anti-medical sentiment here that I've given up on prescribing anything."),
    replies = {
        {
            text = ccb.content.text("Would you like to buy any supplies?"),
            next_topic = "TALK_GODCO_Jane_Medical_Buy",
        },
        {
            text = ccb.content.text("What about Kostas?  The Church seems to trust him."),
            next_topic = "TALK_GODCO_Jane_Kostas",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Kostas",
    line = ccb.content.text("He's an alright physician, but the Church massively overrates him.  They think his 'natural medicine' can cure anything, like he's a magic medicine man.  God created everything, so what on Earth isn't natural?!"),
    replies = {
        {
            text = ccb.content.text("How do you feel about him personally?"),
            next_topic = "TALK_GODCO_Jane_Kostas_Personal",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Kostas_Personal",
    line = ccb.content.text("Personally, I like him.  We've worked together for a few cases, but most people refuse to let me work; they only want to see him."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Heal_You",
    line = ccb.content.text("Sure, I've got some supplies on hand, just give me a minute and you'll be right as rain.  It'll cost three icons."),
    replies = {
        {
            text = ccb.content.text("I can pay for quality work.  Here it is."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 3),
            actions = { actions.transfer_items("icon", 3), "give_aid" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jane_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Follow",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } }),
        yes = ccb.content.text("I'm up for it, Arturo's got enough medicine for two-and-half months.  It's thankless work around here, so let's blow this joint."),
        no = ccb.content.text("I'd like to leave, but I've got to take care of Arturo.  He's always low or nearly out of antipsychotics, so I do what I can."),
    },
    replies = {
        {
            text = ccb.content.text("Alright.  Wanna chat?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } })),
            next_topic = "TALK_GODCO_Jane_2",
        },
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_meeting_jane_willing_to_follow" } }),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Medical_Buy",
    line = ccb.content.text("I could always use more bandages, disinfectant, and the like.  What do you have?"),
    repeat_replies = {
        {
            items = {
                "adhesive_bandages", "antibiotics", "arm_splint", "leg_splint", "bandages",
                "disinfectant", "medical_gauze",
            },
            reply = { text = ccb.content.text("I have <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't have anything right now.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Jane_2",
        },
        {
            text = ccb.content.text("I don't have anything right now.  I'll come back with something later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_Angry",
    line = ccb.content.text("Fuck off <name_b>.  I've had it with your tormenting antics, I don't want anything to do with you right now."),
    replies = { { text = ccb.content.text("Fine then, have it your way."), next_topic = "TALK_DONE" } },
}
