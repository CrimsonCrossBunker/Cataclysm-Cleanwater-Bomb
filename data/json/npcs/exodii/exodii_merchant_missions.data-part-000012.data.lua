local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Do you remember that bunker you found for us?  Well, turns out they're not so friendly.  We found out one of their people is running some sort of workshop, and we think that an explorer we lost is being held inside.  They're Exodii like me - lots of metal, not easy to miss.  I think they're being tortured, at the least.  If you, a mercenary, can recover them, we'd pay handsomely.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_intro",
    line = ccb.content.text("Ye mind that bunker ye ferreted fer us'n?  Turns they be no kindly folk.  Us'n learned one o'their scavs keep'n a second hall, an' we reckon an escolt we lost be held fast inside.  One kin t'me - Exodii - much metal, deep red shell, hard t'miss.  Torture'n the like - bad if tassed this'n.  If ye can fetch 'em back pop-n-work-like, us'll pay ye right handsome."),
    replies = {
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_explain",
        },
        {
            text = ccb.content.text("What if the worst has happened, and they're dead?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_advice_dead",
        },
        {
            text = ccb.content.text("So one of those scientists from the bunker abducted one of your people?  An exodii with a red frame?  You want me to find them?  I'll do it."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm gonna need to think on this one.  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- I don't want them to know we are involved.  We've seen people like this in other otherlands, and we know it's dangerous to let them know too much about us.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_explain",
    line = ccb.content.text("Ol' Rubik don't want'n 'em kennin' us'n be involved.  Folk o' this kind we've spied in otherlands, an' we ken it be perilous t'let 'em learn o'er much about us'n."),
    replies = {
        {
            text = ccb.content.text("Right, so you don't want them to know that you're involved.  I'll see if I can find this exodii with a red frame."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}

-- If that's the case, just bring back proof.  We know them well, so any part of their frame will do.  It's a deep red color.  Hard to miss.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_advice_dead",
    line = ccb.content.text("If that be the case, fetch back the proof ya' can.  Any piece'o'their frame will do, but I'd prefer all of it.  Deep red color.  Hard t'miss."),
    replies = {
        {
            text = ccb.content.text("If they're dead, just bring back a piece of their red frame as proof.  Let's hope they're alive.  I'll see if I can find this exodii."),
            actions = { actions.assign_mission("EXODII_MISSION_CHOP_SHOP") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
