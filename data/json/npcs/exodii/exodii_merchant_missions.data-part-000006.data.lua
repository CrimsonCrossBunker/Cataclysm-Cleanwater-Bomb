local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro2",
    line = ccb.content.text(
        --~ No, my friend, no!  Don't make contact, understand?  This is a covert op.  If you see that it's safe you can go in closer and look around, but for goodness' sake, don't talk to anyone and don't linger.
        "No, me fruit gum, no!  Make no contact, y'ken?  This be covert.  If ye kennit be safe, traipse along an' for a kennabout, but upon the chimes, speak none and tarry little."),
    replies = {
        {
            text = ccb.content.text("I get the impression this is important, but I don't know what you mean."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro2_translate",
        },
        {
            text = ccb.content.text("This sounds insanely dangerous.  They could just shoot me on sight."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro3",
        },
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro2_translate",
    line = ccb.content.text("*pauses for a moment, and lets out a slow sigh, speaking hesitantly as they catch themselves in idioms.  \"Make no contact.  We ken… we think the abroad o'… the outside o' the bunker be safe an'… be safe to explore, for one such as ye, who harks as from this'n land.  A wander in and escolt… a look around we ken as no… no risk.  If ye think ye been spotted, wave along and make no mention of ol' Rubik and the Exodii.  Not afore we be razzed some more o' this rattlin'… this bunker.\""),
    replies = {
        {
            text = ccb.content.text("How can you know that it's safe?  What if I'm shot on sight?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro3",
        },
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro3",
    line = ccb.content.text(
        --~ Our scouts have seen people who look like you wandering in the area safely.  If the scavengers can make it in and out, you should be fine.
        "Them as we've escolted seems a fair kin, an' we've eyed a scav or two wanderin' the premise unscathed.  If'n the scavs o' the dust can make it in an' out, so should ye be."),
    replies = {
        {
            text = ccb.content.text("So you want me to go there, see what's inside the walls, look around a little, and then let you know if I see anything, but if someone tries to talk to me, not mention you or your people?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_understood",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_understood",
    line = ccb.content.text("Aye, ye kennit well."),
    replies = {
        {
            text = ccb.content.text("This is insane.  I can't tell if you're leading me into a trap or not.  What's in it for me?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_pay_skeptic",
        },
        {
            text = ccb.content.text("Sure.  Don't know what good it'll do you, but I might be willing.  What are you paying?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_pay_nice",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
