local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PAT_ADVICE_MISSION_ROBOFAC_INTERCOM_IVAS",
    line = ccb.content.text("Anduril?  Holy shit, real assholes those guys.  Defense contractah thinks they could get away with naming their weapons manufacturin' after the fahkin' sword of the West - Tolkien - Aragon, yeah?  Read a lot about'em online before it all.  If it's the headset I'm thinkin' of, you mind bringin' it by heah to me before giving it to our employers?  They may'a been assholes but maybe after the end'a the world we can do somethin' fahkin' cool with their tech."),
    replies = {
        {
            text = ccb.content.text("Thanks a lot.  If I find the headset, I'll think about bringing it by to you."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_REACH_REFUGEE_CENTER",
    line = ccb.content.text("Show me on the map.  Yeah, I rememberah them buildin' that place.  Like you I didn't beeline for that shit when it all happened.  Can't imagine anyone nice is runnin' it, but I guess that's true everywhere these days."),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_FREE_MERCHANTS_EVAC_1",
    line = ccb.content.text("Take a gun.  After the shit you've done for our employahs here, this should be cake, eh?"),
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
