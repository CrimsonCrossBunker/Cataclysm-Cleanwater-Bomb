local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE",
    line = ccb.content.text("As we discussed during acceptance of the contract, we were aware of hazardous ground conditions, but we were unable to deduce further information other than what was available through long-range sensing.  If you would like to provide a description of the hazards present, we are willing to document them."),
    replies = {
        {
            text = ccb.content.text("[Detail the conditions at the research facility.  This will advance time by ten minutes.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_Explainer",
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b") },
        },
        {
            text = ccb.content.text("[Let them know how much of a trainwreck THIS one was.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut",
        },
        {
            text = ccb.content.text("…Just forget it.  Let's never speak of this again."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_Explainer",
    line = ccb.content.text("&Over the course of several minutes, you calmly detail the events at the facility: the unexpected zombie presence underground, the anomalous nature of the experiment floor, and the encounter with the warped and hostile research staff trapped in the corridor.  Throughout, the voice interjects with questions, the sounds of typing filling the pauses.\n\n\"We appreciate your thorough report,\" the voice finally responds.  \"Your handling of the circumstances was commendable considering the anomalous and unpredictable nature of the facility.  If you seek further contract work, rest assured, we'll take into account the potential for anomalous circumstances in future assignments and relay them accordingly.\""),
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
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut",
    line = ccb.content.text("&The intercom waits patiently."),
    replies = {
        {
            text = ccb.content.text("Hoo boy, where do I even begin with this one?  Let's start with the fact that your intel was about as useful as a screen door on a submarine!  \"Sparsely-populated,\" my ass!  How did you lot miss the goddamn zombie mosh pit down the open elevator shaft!?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_1",
    line = ccb.content.text("We're sorry but-"),
    replies = {
        {
            text = ccb.content.text("Oh, ho ho ho ho ho no friend you do not get to talk right now.  When I FINALLY got down to the experiment floor, you know what I found?  The entire corridor was turned into a two-dimensional image!  What were they even DOING that turned an entire section of the building INTO A HAUNTED VIDEO GAME PORTAL PAINTING!?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_2",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_5",
        },
    },
}

-- I realize I'm assuming the player has encountered congealed light by accidentally breaking open the terrain features, but eh.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_2",
    line = ccb.content.text("What do you mean by-"),
    replies = {
        {
            text = ccb.content.text("I SAID SHUT UP!  It teleported me to an infinitely looping corridor!  INFINITELY!  LOOPING!  CORRIDOR!  I mean, fuck, you ever see one of those Escher paintings?  It's like that, only you don't just see the surface of what you're looking at, you see EV-ER-Y-THING, and friend let me tell you getting a first-hand look at the inside of my digestive system was *not* pretty.  Oh, and did I mention the light?  Yeah, when some of the laser tubes got broken, they spat out light THAT HURT!  A LOT!"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_3",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_3",
    line = ccb.content.text("Please slow down-"),
    replies = {
        {
            text = ccb.content.text("You know why they got broken?  I was fighting the insane remnants of the research staff!  They were climbing the walls, spitting light!  And then there was the corridor itself somehow!  I fought the goddamn building!  I've had nightmares that made more sense than fighting that thing!"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
    line = ccb.content.text("&The voice on the other side of the intercom is silent with disbelief."),
    replies = {
        {
            text = ccb.content.text("[Wait.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_5",
    line = ccb.content.text("Uh… Yeah, sorry.  I'll, um… I'll make a note to try and see if we can't get any better information for your future contracts."),
    replies = { { text = ccb.content.text("Good."), next_topic = "TALK_DONE" } },
}
