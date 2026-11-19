local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_Liam_SOCIAL" },
    line = ccb.content.text("Any time, what's on your mind?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on a job we're doing."),
            next_topic = "TALK_Liam_Opinions",
        },
        {
            text = ccb.content.text("[Raise your hand for a high-five.]"),
            next_topic = "TALK_Liam_HighFive",
        },
        {
            text = ccb.content.text("Can I ask you a bit about yourself?"),
            next_topic = "BGSS_Liam1",
        },
        {
            text = ccb.content.text("You picked up a lot of useful skills over the years, hey."),
            next_topic = "BGSS_Liam_Expertise",
        },
        {
            text = ccb.content.text("I just wanted to chat, you know.  To relax."),
            next_topic = "TALK_FRIEND_Liam_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("The way you said something earlier made me realize… you have a crush on Jenny Forcette, don't you."),
            next_topic = "TALK_Liam_Jenny_CrushAccuse",
            when = predicates.all({ predicates.any_equal({ "crush_suspected", { scope = "speaker", key = "u_liam_jenny_feelings" } }), predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })) }),
        },
        {
            text = ccb.content.text("You keep looking at my ears?"),
            next_topic = "TALK_LIAM_CHANGELING",
            when = predicates.has_trait("speaker", "CHANGELING_EARS"),
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LIAM_CHANGELING",
    line = ccb.content.text("Yeah, of course I'm looking at your ears, I'm pretty sure you never had pointy ears before now?  It doesn't change anything about our friendship but really did you hide this from me all these years?"),
    replies = {
        {
            text = ccb.content.text("I don't know where it came from but during the Cataclysm it was like the veil was lifted from my eyes and I suddenly realized I'd never been from here.  But I don't really know where I'm from just yet."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.all({ predicates.has_trait("speaker", "UNKNOWING_CHANGELING_NOBLE"), predicates.negate(predicates.has_trait("speaker", "THRESH_FAIR_FOLK_NOBLE")) }),
        },
        {
            text = ccb.content.text("I never really felt like I belonged but now I know the truth, I am one of the aristocracy of the Fae and I must find my way back home to our courts!"),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "THRESH_FAIR_FOLK_NOBLE"),
        },
        {
            text = ccb.content.text("I don't know where it came from but during the Cataclysm it was like the veil was lifted from my eyes and I suddenly realized I'd never been from here.  But I don't really know where I'm from just yet."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "FAIR_FOLK_COMMONER_SELECTOR"),
        },
        {
            text = ccb.content.text("I'm descended from the house fae that help good people with their chores and protect their homes!  I never knew until after the Cataclysm."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_COMMONER_BROWNIE"),
        },
        {
            text = ccb.content.text("I'm an animal aspected prankster fae!  Doesn't this make so much sense from our childhood?  I never knew before but it feels so true!"),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_COMMONER_POOKA"),
        },
        {
            text = ccb.content.text("It's so weird ever since the Cataclysm I've been having these dreams of swimming and when I see myself in the water I'm not a person but a seal.  I think I'm some kind of seal faerie."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_COMMONER_SELKIE"),
        },
        {
            text = ccb.content.text("During the Cataclysm a boulder spoke to me and told me that I was descended from the folk of stone and mountains.  Afterwards I noticed my ears had changed."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.has_trait("speaker", "UNKNOWING_CHANGELING_COMMONER_TROW"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions",
    line = ccb.content.text("My opinion?  Sure, my friend, hit me up, what's eating you?"),
    replies = {
        {
            text = ccb.content.text("Check this out, I found an address of some kind of central refugee management facility.  Should we check it out?  Maybe they'll have answers?"),
            next_topic = "TALK_Liam_Opinions_MISSION_DRACO_FAE",
            when = predicates.has_mission("MISSION_DRACO_FAE"),
        },
        {
            text = ccb.content.text("You thinking what I'm thinking about this mystery dropoff for Smokes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BRING_BOANN_JABBERWOCK_HEART",
            when = predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"),
        },
    },
}
