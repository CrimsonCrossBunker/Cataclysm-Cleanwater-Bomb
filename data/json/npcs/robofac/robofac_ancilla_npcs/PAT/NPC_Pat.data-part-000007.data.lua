local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_NO",
    line = ccb.content.text("Pair'a advanced AR glasses, 2 two-way radios, and 2 tablet PCs.  Or, ya' cough up 10 HGC, and I'll scrounge up the pahts myself.  Cool?"),
    replies = { { text = ccb.content.text("Cool."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_NO",
    line = ccb.content.text("No prob.  Just cough up 2 HGC, and I'll scrounge up the pahts myself.  Cool?"),
    replies = { { text = ccb.content.text("Cool."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_YES",
    line = ccb.content.text("&Pat whips out their soldering iron and starts to clear their desk.  \"Wicked.  Come back tomorrah.\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you tomorrow."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_YES",
    line = ccb.content.text("&Pat whips out their soldering iron and starts to clear their desk.  \"Wicked.  Come back tomorrah.\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you tomorrow."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_AR_GLASSES_DONE",
    line = ccb.content.text("&Pat picks up a new pair of modified AR glasses, wipes the lenses, and hands them over to you.  \"Careful with this set, yeah?\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you later."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_REMAKE_EARPIECE_DONE",
    line = ccb.content.text("&Pat whistles sharply and tosses the earpiece in the air.  You catch it.  Pat chuckles.  \"Don' lose that one, got it?\""),
    replies = { { text = ccb.content.text("Thanks, Pat.  See you later."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1",
    line = ccb.content.text("Actually, yeah, I been thinkin' about this a lot.  I'm probably bettah suited stayin' heah, an' you're bettah out in the field.  I'm wonderin' if maybe we team up.  Partners.  Whaddaya think?"),
    replies = {
        {
            text = ccb.content.text("Sure, I like it.  What do you have in mind?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2",
        },
        {
            text = ccb.content.text("Let me think about this.  We'll talk again later, maybe.  See you later, Pat."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I work alone.  I gotta go."), next_topic = "TALK_DONE" },
    },
}
