local ccb = require("ccb")

-- The faeries announced themselves in Rubik's world near what we know as Wales.  Exodii mostly avoid them referencing several myths about bad luck and that for because they've traded their flesh for metal the fae aren't really interested in them anyway.  Not quite as bad as the undead but more tricksome.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_FAE",
    line = ccb.content.text("The Good Folk of Aberystwyth?  Us 'ave no truck with them, the milk is spoilt, the flesh is hoofshod, the henge holds no peel.  Ye'd ken best not their seductions.  A trifle better than the enemy."),
    replies = {
        {
            text = ccb.content.text("I'll keep your warnings in mind."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Wont_Talk_To_Fair_Folk",
    line = ccb.content.text("&No matter what you do or say, the towering mass of metal will not acknowledge you."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

-- Vampires have infested your world?  We're gonna talk to the supercomputer and bring out some of our anti-vampire designs and will get back to you soon.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_VAMPIRE_GEAR",
    line = ccb.content.text("If this green and brown, has the claret drinkers us un'll be truckin' with ole Great Grey and bringin' out the good and plenty.  Only one way to throw a smash and banger for the tick dead."),
    replies = {
        {
            text = ccb.content.text("I'll keep your warnings in mind."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}
