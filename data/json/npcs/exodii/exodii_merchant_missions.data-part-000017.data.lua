local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete",
    line = ccb.content.text("&Rubik chuckles and nods, leaning against the counter.  \"Aye, ye did us'n a fine turn.  What say ye for reward?\"  Rubik reaches into the desk in front of them and pulls out a tiny, green-glowing CRT, scrolling rapidly down a list you cannot understand, they click on an option, and some complex robot schematics come on screen.\n\n\"How'd ye like ta'be cut inta' this sort'o crowded space?\"  Rubik taps their metal torso.  \"This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\"\n\n\"Think on it, decide on a last.\""),
    replies = {
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe] A robotic body I'll need to keep constantly powered?  Why not?  I'm ready."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
            actions = { actions.adjust_faction_trust(5), actions.handler("dlg_a_dda_4b6b808ad998") },
            opinion = { trust = 7, value = 5 },
        },
        {
            text = ccb.content.text("[$2500 in store credit] How about store credit instead?"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_ab5ed3715805"), "start_trade" },
            opinion = { trust = 4, value = 3 },
        },
        {
            text = ccb.content.text("I don't need anything.  Just keep in mind that I'm always on your side, yeah?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete_partial",
    line = ccb.content.text("Aye, they did indeed.  And aye, ye clearly tried.  That's the way'o'things.  Have a look about, tell me what ye like."),
    replies = {
        {
            text = ccb.content.text("[$1000 in store credit] How about store credit instead?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(-4), actions.handler("dlg_a_dda_ff7fed64ffd0"), "start_trade" },
        },
        {
            text = ccb.content.text("I don't need anything.  Just keep in mind that I'm always on your side, yeah?"),
            next_topic = "TALK_DONE",
            actions = { actions.adjust_faction_trust(4) },
            opinion = { trust = 7, value = 5 },
        },
    },
}
