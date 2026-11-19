local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_1_STORY1",
    line = ccb.content.text("I was just sittin' around in the pen.  They took me in the night before, for a bullshit technicality.  Assholes.  I was stuck tied up to a tree when the guys with the pistols all started yelling about an emergency, geared up, and left me there with just this dumb horse for a guard.  I was stuck there for two god-damn days, with no food and only a little water.  Then this big-ass spider showed and started trying to eat the horse.  I didn't know what the fuck to think, but in the fighting they smashed down my tree, and I managed to slip away."),
    replies = {
        {
            text = ccb.content.text("Lucky you.  How did you get away?"),
            next_topic = "BGSS_CRIMINAL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_1_STORY2",
    line = ccb.content.text("It was just <freaking> chaos out there, man.  But I'm used to chaos.  You don't live as long as I've lived and not know how to keep away from a fight you can't win.  Biggest worry wasn't the zombies and the monsters, honestly.  It was that something even worse was coming."),
    replies = {
        { text = ccb.content.text("How did you keep safe?"), next_topic = "BGSS_CRIMINAL_1_STORY3" },
        {
            text = ccb.content.text("What were you in for in the first place?"),
            next_topic = "BGSS_CRIMINAL_1_PAROLE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_1_STORY3",
    line = ccb.content.text("Kept outta their line of sight, is a big part of it.  Don't let those <freaking> flyin' eyeballs get you, you know?  I kept my head down until I got past the worst of it, but then one of the <freaking> flying eyeballs saw me and I had to book it.  I wound up on the edge of a river layin' low under a hollow tree for a few hours, then slipped away in the night."),
    replies = {
        {
            text = ccb.content.text("What were you in for in the first place?"),
            next_topic = "BGSS_CRIMINAL_1_PAROLE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_1_PAROLE",
    line = ccb.content.text("Bullshit, that's what.  The assholes busted me on possession, wasn't even my fuckin' stash.  I don't do weed, man, that shit's nasty, I was just carryin' it for my buddy Johnny.  Y'know, this might be a <freaking> hellhole now, but if I've seen the last power-trippin' asshole pistol man, it might all be worth it."),
    replies = {
        { text = ccb.content.text("What were you saying before?"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
