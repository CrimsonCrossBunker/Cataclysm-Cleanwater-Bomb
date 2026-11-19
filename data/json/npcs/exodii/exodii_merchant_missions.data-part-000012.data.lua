local ccb = require("ccb")

-- Indeed, they failed.  That's how it goes, sometimes.  Maybe it's for the best.  Time will tell.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_4_complete_failed",
    line = ccb.content.text("Aye, failed they did.  That's the way'o'things.  Mayhaps for the best.  Time'll tell."),
    replies = { { text = ccb.content.text("Later, Rubik."), next_topic = "TALK_DONE" } },
}

-- All dead.  That's a shame.  Could I interest you in a mercenary contract to get me some more information on this place?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer1",
    line = ccb.content.text("All dead, eh?  A sorry shame.  Ahh, but, might I tempt ye with a pop-n-work's bond t'fetch us'n more ken?"),
    replies = {
        {
            text = ccb.content.text("You want to pay me to go back?  Sure, tell me more."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- If you can find your way back to that place, look all over for some sort of terminal or computer.  You may or may not find one with a plug for this contraption.  If you plug it in, and it works, and the Exodii there aren't too diverged from us, it should download lots of important data we can use.  Do this for me, and I'll reward you handsomely.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer2",
    line = ccb.content.text("If ye wend back that way, escolt fer some manner o' terminal, computer, the like.  Ye mayhap upon one wi' a jack fer this contraption.\"  Rubik pulls out a small, scrap metal device that looks like an otherworldly USB drive.  \"If ye set it in, an' it takes, an' the node strayed not o'er far from us'n, it should draw down a trove o' vital reckonin' we can make use of.  Do this fer me, an' us'll pay ye right handsome."),
    replies = {
        {
            text = ccb.content.text("So you want me to take that device, plug it into a computer there, download the data, and return it to you?  Sure, I can do that."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Accepted",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
