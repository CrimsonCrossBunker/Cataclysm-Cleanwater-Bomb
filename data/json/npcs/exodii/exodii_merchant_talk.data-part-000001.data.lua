local ccb = require("ccb")

-- We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New",
    line = ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface",
    line = ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
    replies = {
        {
            text = ccb.content.text("This is gonna sound strange, and I'm not an \"Exodii\", but I think I may be a bit like you.  [Tell Rubik about your experience with AltarOS]"),
            next_topic = "TALK_EXODII_MERCHANT_New_NL_Interface2",
        },
    },
}

-- Now that's a story.  Sometimes, we find places we call "labyrinths."  Stairs down to other worlds.  We keep track of them.  And, one is nearby, spotted by a novice Exodii, themselves.  That'd be the one you were trapped in, I believe.  So, I guess we're related, by circumstance, at least.  You're welcome here, and I'll remember and tell your story.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface2",
    line = ccb.content.text("&The towering cyborg listens intently, bowing its entire torso now and again, in a sort of understanding nod.  Unseen speakers emit a whistle, like a human impressed, tinged with only the faintest amount of static.  \"S'a tale, no doubt.  At times, we happen by places this'n might call \"labyrinths.\"   Apples an' pears down to otherlands, in their own right.  The Exodii keeps the reckonin'.  An there's one \"nearby\", so t'speak, spotted by a green Exodii 'emself.  That's the one, this'n takes it.  So we've got accord.  We're kin by circumstance has it, aye?  Yer welcome here, n' this'n will remember n' yark the tale.\""),
    replies = {
        {
            text = ccb.content.text("Now, with that out of the way…"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
    },
}
