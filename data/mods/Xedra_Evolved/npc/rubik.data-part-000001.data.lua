local ccb = require("ccb")

-- We brought out the armored forces early on this journey.  Specifically since this world hosts not just the undead but people who hunted us in other worlds.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_JOTUNN",
    line = ccb.content.text("Four-by-twos woke afore the dawn this green and blue.  Us un's prefer to duck and dive but this mudball's filth kicked it off afore our landing."),
    replies = {
        {
            text = ccb.content.text("Wait you are at war with someone here?."),
            next_topic = "TALK_EXODII_MERCHANT_War",
        },
    },
}

-- If you know nothing of it more the better for you.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_War",
    line = ccb.content.text("If you knah no'hin ov i' mawe 'he be''er faw you.."),
    replies = {
        {
            text = ccb.content.text("Wow you're accent got really thick there."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}

-- The police here travel to different dimensions and hunt Exodii and others.  They act like they don't need to worry about the dead rising.  They got their just desserts in the Cataclysm and we'll kill anymore we find.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_XEDRA",
    line = ccb.content.text("Ye scuffers 'ere dolly walk through the mirror and butcher hook us and ours.  Nevermind the enemy, do these pork loins as if'n the enemy'd nevermind them.  Oy, they got their rust shirt and more comin'."),
    replies = {
        {
            text = ccb.content.text("Oh well yeah, damn the man then I guess."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}
