local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("What can you tell me about Xedra?"),
            next_topic = "TALK_EXODII_MERCHANT_XEDRA",
        },
        {
            text = ccb.content.text("What can you tell me about these faeries?"),
            next_topic = "TALK_EXODII_MERCHANT_FAE",
        },
        {
            text = ccb.content.text("[DEDUCTION 2] So does that mean the stories I heard about vampires are true as well?"),
            next_topic = "TALK_EXODII_MERCHANT_VAMPIRE",
            when = predicates.handler("dlg_p_xedra_evolved_89df39a2ceaa"),
        },
        {
            text = ccb.content.text("I saw some much larger and more heavily armed and armored cyborgs ."),
            next_topic = "TALK_EXODII_MERCHANT_JOTUNN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_exodii_seen_jotunn" } }),
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_VAMPIRE",
    line = ccb.content.text("Claret drinking brown bread, an' a crew of Renny's, on this mudball.  Us un's can't tell if they're part of the enemy or parasites exposed when the enemy rises.  Not on every mudball but definitely moar than enough to be a right pain."),
    replies = {
        {
            text = ccb.content.text("Well that's certainly disturbing."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("[DEDUCTION 4 or INT 14 ] Would you have any specialized weapons to use against them?"),
            next_topic = "TALK_EXODII_MERCHANT_VAMPIRE_GEAR",
            when = predicates.handler("dlg_p_xedra_evolved_b3eba08a0db3"),
            actions = { actions.set_actor_value("speaker", "rubik_vampire_weapons", "banger_and_smash") },
        },
    },
}

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
