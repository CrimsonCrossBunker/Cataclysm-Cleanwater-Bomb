local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_Explainer",
    line = ccb.content.text("&Over the course of several minutes, you explain what happened at the ruins: the zombie presence and gigantic tendrils on the surface, and the biological infestation completely taking over the basement, as well as the hostile threats encountered therein.  The voice periodically interjects with questions or statements; the whole time, you hear the sounds of typing on a keyboard.\n\n\"We would like to extend our thanks for your detailed report.  It is clear to us that the threat level present at the manufacturer was far higher than we had originally anticipated, and your performance in the situation was exemplary.  Should you desire further contract work, we will bear these facts in mind, and ensure that the threat prognoses of your future assignments are adequately assessed.\""),
    replies = {
        {
            text = ccb.content.text("It's fine.  At least now we know for the future."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Yeah, yeah.  You're welcome."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Let's never do that again."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut",
    line = ccb.content.text("&The intercom waits patiently."),
    replies = {
        {
            text = ccb.content.text("Description, huh?  Where to begin?  Let's start with the giant mob of zombies that was infesting the building.  Oh, and there were also horrors full of toxic gas that exploded when I got near them or killed one, so I was constantly choking on fumes the whole time."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_1",
    line = ccb.content.text("That makes-"),
    replies = {
        {
            text = ccb.content.text("Oh, but that's not all!  They were coming from a pair of giant fucking tentacles coming out of the ground like a monster movie that were constantly roaring and shaking the whole building, and toxic exploding spiders kept crawling off and shooting poison darts at me until I got away or stopped the tentacles themselves, which wasn't easy because the entire building had come down around them."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_2",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_2",
    line = ccb.content.text("What do you mean by-"),
    replies = {
        {
            text = ccb.content.text("Then it took me half an hour to find the way down, because there were holes in the floor everywhere, and when I finally did, I was in the insides of a goddamn flesh pit with flooding up to my ankles, and to complement the innards hanging from the ceiling that I couldn't see through the gas that would throw me ten feet and make me start drowning, there were dozens of people fused together in lumps everywhere, and did I mention the poison gas?  Because they were full of it too, and so everything reeked and it felt like being in a giant fucking intestine full of people."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_3",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_3",
    line = ccb.content.text("Please slow down-"),
    replies = {
        {
            text = ccb.content.text("And after ALL THAT, I find your manufacturing lab on the other end of this thing straight out of a fever dream nightmare, and after ALL THAT, I find your photonics, and then I have to get ALL THE WAY out of the ENTIRE ZOMBIE-INFESTED TOWN so I could bring you your stupid fucking template.  Are you happy now?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
    line = ccb.content.text("&The voice on the other side of the intercom is silent with disbelief."),
    replies = {
        {
            text = ccb.content.text("[Wait.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
    line = ccb.content.text("…Uh.  We are- thank you for finding the photonics.  We will, ah, make sure that the threat conditions of your future contracts are adequately assessed.  Um.  Thank you."),
    replies = { { text = ccb.content.text("Good."), next_topic = "TALK_DONE" } },
}
