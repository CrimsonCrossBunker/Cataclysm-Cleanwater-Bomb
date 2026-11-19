local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    line = ccb.content.text("That theah was one of the first jobs they had me do.  I'm not keen to do it again.  I say see if you can find one of these storms, and stay as close to the edge as ya' can, and once that thing beeps, get outta'theah."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_1",
    line = ccb.content.text("That theah station's a BEAUT.  Real easy to set up.  We used to load 'em in trucks, so I suggest ya' throw it in the back of somethin', drive into one of those storms theah, set it up, start the recordin' routine, and get the fahk outta' there.  Go back in a day or two and pick it up."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_2",
    line = ccb.content.text("We used to contract a few'a those for weather data.  Lemme see those coordinates.\"  Pat takes out his personal device and skims his offline map data.  After a minute, he looks puzzled and turns back to you.  \"The fahk they sending you?  It isn't nowhere I evah heard of.  But look, these places are deathtraps anyhow - little metal coffins in the lake.  I don't envy you."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_3",
    line = ccb.content.text("Yeah, I was watchin' when you hauled that device in heah to the intercom.  Looks a lot like the standahd station, but all those strange devices?  I don't have any idea about them theah.  Same advice I'd give for even a nahrmal recordin': drop that thing off, set it up, and get the fahk outta dodge.  Go back the next day when the storm is ovah."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE",
    line = ccb.content.text("More important, I know the crew they sent as the advanced team.  Be careful with them.  Real careful, hear me?  They sold be some bunk electronics, and overcharged me for it.  Don't trust'em."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_2",
    line = ccb.content.text("That's no highway, so whatever is going on there is no doubt cramped.  If it's zombies we're talking about, I suggest you take somethin' that makes a lot of noise.  Or a freakin' machine gun."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    line = ccb.content.text("Lemme check my maps.\" Pat looks at their personal device for a while before shaking their head.  \"Whatevah that is, isn't on the public maps I have downloaded.  Take your transpondah and proceed with caution, yeah?  I'll chime in when you get theah."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_3",
    line = ccb.content.text("Look, you didn't heah this from me, but I don't think you're the first person they've sent theah.  Whatevah it is, I'd bet a pack of smokes it's dangerous as all hell.  Take your transpondah and stay in touch."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
