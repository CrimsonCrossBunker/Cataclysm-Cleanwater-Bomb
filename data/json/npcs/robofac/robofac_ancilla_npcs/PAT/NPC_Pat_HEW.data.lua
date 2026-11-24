local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("&Your HUD flicks on and a low-resolution version of Pat's computer desktop becomes visible.  \"I've flagged a bunch of places you've been, eh?  Take a look.\""),
        no = ccb.content.text("&Pat starts to scroll through photos and spreadsheets on their personal device, inviting you over to look with them.  \"I've flagged a bunch of places you've been, eh?  Take a look.\""),
    },
    replies = {
        {
            text = ccb.content.text("[Photos of the LIXA facility] What about that place?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_LIXA",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_lixa" } }),
        },
        {
            text = ccb.content.text("[Photos of the strange temple] No doubt that place has some strange shit in it, right?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRANGE_TEMPLE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_strange_temple" } }),
        },
        {
            text = ccb.content.text("[Photos of the castle] What about that castle?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_EXODII",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_exodii" } }),
        },
        {
            text = ccb.content.text("[Photos of the farmstead] That farm was odd, to say the least.  Maybe there?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VITRIFIED",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_vitrified" } }),
        },
        {
            text = ccb.content.text("[Photos of the mine entrance] Looks like you flagged that mine."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_AMIGARA",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_amigara" } }),
        },
        {
            text = ccb.content.text("[Photos of the alien highlands] Well, that's a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_HIGHLANDS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_highlands" } }),
        },
        {
            text = ccb.content.text("[Photos of the physics laboratory] That freaky lab?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PHYSICS_LAB",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_physics_lab" } }),
        },
        {
            text = ccb.content.text("[Photos of dead monster corpse] I guess if anything is gonna work, it'd be that dead creature?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MONSTER_CORPSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_monster_corpse" } }),
        },
        {
            text = ccb.content.text("[Photos of the glowing church] That place was full of something unreal.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RURAL_CHURCH",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_rural_church" } }),
        },
        {
            text = ccb.content.text("[Photos of the fenced-off forest] What was that place called again?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MORGANTOWN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_morgantown" } }),
        },
        {
            text = ccb.content.text("[Distorted images of the boarded up cabin] Ah, that place.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB_HINT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_cabin_reverb_hint" } }),
        },
        {
            text = ccb.content.text("[An audio recording] Ah, that place near the radio tower.  What do you think?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIO_TOWER_REVERBERATION_MP3",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_radio_tower_reverberation_mp3" } }),
        },
        {
            text = ccb.content.text("[Photos of the repeating alien cabins] That's a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_cabin_reverb" } }),
        },
        {
            text = ccb.content.text("[Photos of the repeating alien radio towers] That's gotta be a no brainer."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIOSPHERE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_radiosphere" } }),
        },
        {
            text = ccb.content.text("[Photos of the glowing strings] That place was odd, to say the least."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRING_DIMENSION",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_string_dimension" } }),
        },
        {
            text = ccb.content.text("[Photos of the spiral rock formations] How about that 'mine?'"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SPIRAL_MINE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_spiral_mine" } }),
        },
        {
            text = ccb.content.text("[Distorted images of the spider's lair] Well, I guess that might've been a good place."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VOID_SPIDER_LAIR",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_spider_dimension" } }),
        },
        {
            text = ccb.content.text("[Twisted images of the otherworldly, shifting tunnels] Ah, that place.  Duh."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PORTAL_STORM_DUNGEON",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_portal_storm_dungeon" } }),
        },
        {
            text = ccb.content.text("[Snapshots of the scarlet storm] That storm?"),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SCARLET_STORM",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_saw_scarlet_storm" } }),
        },
        {
            text = ccb.content.text("Hmm.  Well, I guess we'll just see what I can find."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_LIXA",
    line = ccb.content.text("I don't trust anything about that place, but yeah, you're right, that'd be a good place to try.  Try scannin' from the surface."),
    replies = {
        {
            text = ccb.content.text("I'll be careful."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRANGE_TEMPLE",
    line = ccb.content.text("Never saw anything like that place before.  Set the HEW station up right next to the pedestal, yeah?  Don't want you goin' in and gettin' freakin' yoinked."),
    replies = {
        {
            text = ccb.content.text("Thanks, good idea."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_EXODII",
    line = ccb.content.text("Those fahkin' robots give me the heebies.  But yeah, I guess that makes sense.  I'd do it out of sight if I were you - don't think they'd appreciate it."),
    replies = {
        {
            text = ccb.content.text("Thanks, that's good advice."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VITRIFIED",
    line = ccb.content.text("Oh hell yeah.  Just don't go inside, yeah?  I'd scan from the road - the HEW can reach it from theah."),
    replies = {
        {
            text = ccb.content.text("Good idea."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_AMIGARA",
    line = ccb.content.text("All sorts wrong with that place.  I'd set up the HEW and scan in the pahking lot."),
    replies = {
        {
            text = ccb.content.text("Good idea."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_HIGHLANDS",
    line = ccb.content.text("Well, yeah, but how the fahk'a you gonna get back theah?  I remembah when it happened.  Last thing I saw was that shot of you walkin' through water like an idiot, and bam, gone."),
    replies = {
        {
            text = ccb.content.text("Guess I'll give it a try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PHYSICS_LAB",
    line = ccb.content.text("Got a LOT of radio interference there.  Worth a try.  Try from the surface nearby, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MONSTER_CORPSE",
    line = ccb.content.text("Even if we had a thousand options, that's where I'd try first.  Right theah, near the 'entrance.'  I bet the air is full of all kinds of strange shit.  Just don't go all freakin' Noah on me and go inside, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RURAL_CHURCH",
    line = ccb.content.text("Yup, that'd do it.  Just do it from the road over heah, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks, good idea."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_MORGANTOWN",
    line = ccb.content.text("Well hell yeah that place is fahkin' haunted!  My uncle camped there once a few years ago and tells me all about the ghosts he saw.  If ghosts ain't strange what is?  Actually, don' answer that."),
    replies = {
        {
            text = ccb.content.text("Ghosts.  Right."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIO_TOWER_REVERBERATION_MP3",
    line = ccb.content.text("That creepy music place?  Yeah.  Do that.  Just take earplugs."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB_HINT",
    line = ccb.content.text("We did pick up interference there.  Worth a try."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_CABIN_REVERB",
    line = ccb.content.text("Well, no shit Sherlock.  If you wanna go hang around that cabin roof again and wait for a portal storm, be my guest."),
    replies = {
        {
            text = ccb.content.text("Guess I'll give it a try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_RADIOSPHERE",
    line = ccb.content.text("Those pictures were some of the most insane shit I ever saw.  No idea how you plan on gettin' back theah, though."),
    replies = {
        {
            text = ccb.content.text("Guess I'll give it a try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_STRING_DIMENSION",
    line = ccb.content.text("The data I pulled on that was wicked pissah - some of the coldest temps I've ever seen.  Definitely get some interestin' HEW scans theah.  If I were you I'd track down a woobie - a linah for the modulah defense system, yeah?  Keep ya' warm."),
    replies = {
        {
            text = ccb.content.text("Guess I'll give it a try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SPIRAL_MINE",
    line = ccb.content.text("I'd say that theah was an elaborate prank, if it weren't for the fahkin' wicked crazy shit inside.  Yeah.  Scan it from the pahking lot, will ya'?"),
    replies = {
        {
            text = ccb.content.text("Guess I'll give it a try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_VOID_SPIDER_LAIR",
    line = ccb.content.text("Well, yeah, I'd fahkin' say so.  You don' plan to go back theah, though, right?  That fahkin' spidah, man.  I don' like spidahs."),
    replies = {
        {
            text = ccb.content.text("I guess if I'm ever back there, I could try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_PORTAL_STORM_DUNGEON",
    line = ccb.content.text("Ah, that' fahkin' place ya' got ripped inta' during the portal storm.  I'd fahkin' say so.  Real mind fahk.  Think the ground'll even hold the station?  I dunno.  Seems fahkin' nuts to try, but that's on you."),
    replies = {
        {
            text = ccb.content.text("I guess if I can find my way back, I could try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4_SCARLET_STORM",
    line = ccb.content.text("Nothin' fahkin' natural about that, so  I'd fahkin' say so.  Good idea."),
    replies = {
        {
            text = ccb.content.text("I guess if I can find it again, I could try."),
            next_topic = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_4",
        },
    },
}
