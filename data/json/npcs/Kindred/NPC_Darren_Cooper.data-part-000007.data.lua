local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_WORK",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.gendered_line("You're Kindred, and yet you question the power the bones hold, the Song itself?  This hypocrisy is why I set off on my own.  Stop wasting my time and get out of my way.", { "speaker" }),
        no = ccb.content.text("I know it's hard to comprehend when you can't hear the song.  The bones hold power, you just don't hear it yet.  But you will, eventually."),
    },
    replies = {
        {
            text = ccb.content.text("I meant no offense.  I'm sure you have your reasons."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("What about the woman you mentioned - Brigitte - what happened to her?"),
            next_topic = "TALK_COOPERS_SIDE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
        {
            text = ccb.content.text("Brigitte was right.  I can't reason with you.  You have to be stopped."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("You're rambling.  I can't let you keep hurting people.  This ends now."),
            next_topic = "TALK_COOPER_FIGHT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_knows_cooper_kill" } }) }),
        },
        {
            text = ccb.content.text("This is a waste of time.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}
