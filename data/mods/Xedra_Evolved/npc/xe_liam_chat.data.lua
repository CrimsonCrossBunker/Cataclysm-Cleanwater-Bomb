local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT",
    line = {
        choices = {
            ccb.content.text("Before things ended did you see any of the interviews with some of the remaining Wampanoag?  They kept saying things about other races coming back to this planet.  That's crazy, right?"),
            ccb.content.text("A few nights after I got here, I saw lights in the woods off in the distance.  I don't know why, but I ran back into the house turned off all the lights and closed the blinds.  It was just so eerie!"),
        },
    },
    on_enter = {
        {
            actions = {
                "morale_chat_activity",
                actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("We're always gonna be friends, right?  Even with the apocalypse… changing us?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Friends4ever",
        },
        {
            text = ccb.content.text("What do you miss most about the internet?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Internet",
        },
        {
            text = ccb.content.text("Now that we've got no responsibilities, is there anything you'd like to see or do?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Goals",
        },
        {
            text = ccb.content.text("What do you think the rest of the world is like these days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_World",
        },
        {
            text = ccb.content.text("Do you miss any food from the old days?"),
            next_topic = "TALK_FRIEND_Liam_CHAT_Food",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_CHAT_World",
    line = {
        choices = {
            ccb.content.text("There could be anything out there.  Remember towards the end before the apocalypse?  I remember tons of weird stuff I heard on the radio.  Like, I heard out past Bunyan there were strange trees and species showing up in the deep woods, stuff no one had ever seen before.  The Border Patrol was going in about 'species previously thought extinct' or something like that.  Didn't make sense to me.  Why the heck was the *Border Patrol* talking about *closing off forests*?  Weird stuff.  I guess that means I don't have a clue what's out there now."),
            ccb.content.text("I still can't decide if our leaders thought Canada was a threat or what?  Why else did they militarize the border patrol up here just as bad it had been on the southern border for decades?"),
            ccb.content.text("I remember talking to a friend coming back from Vegas a few years back and he mentioned Border Patrol had those big armored Bear Cub vehicles with a roadblock going into one of the canyons outside of Vegas.  Hundreds of miles from any border.  Weird stuff man, I wonder if it's all connected?"),
        },
    },
    replies = { { text = ccb.content.text("[Continue chatting.]"), next_topic = "TALK_DONE" } },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_DRACO_FAE",
    line = ccb.content.text("What does this story remind me of?  Is it, Rip van Winkle?  Didn't he join some party and come home a dozen years later?"),
    replies = {
        {
            text = ccb.content.text("Maybe we should avoid drinking anything there?"),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BRING_BOANN_JABBERWOCK_HEART",
    line = ccb.content.text("Is Lewis Carrol hiding behind a bush over there?  Because if not, this sounds insane and insanely dangerous.  But no one else has even given us a hint about a way off this world of the dead.  Can we really pass this by?"),
    replies = {
        {
            text = ccb.content.text("It's you and me buddy, to infinity and beyond!"),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
