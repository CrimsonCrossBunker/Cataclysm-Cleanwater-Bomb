local ccb = require("ccb")

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
