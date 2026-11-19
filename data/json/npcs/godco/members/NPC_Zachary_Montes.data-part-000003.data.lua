local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Story0",
    line = ccb.content.gendered_line("That ain't the point here, chum.  Don'tcha get it?  This was MY territory, but they took it away from me.  Now they think of us as nothin' but a <freaking> nuisance.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Zachary_Background",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Background",
    line = ccb.content.text("Who I was is gone, dead… died when I put down the monsters wearing the face of my friends.  Ever since then, I've felt nothing but disgust for myself.  Let's not fuckin' reminisce."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Godco",
    line = ccb.content.text("They are nice people, lettin' us stay here 'n all.  I got friends here, and while we may not be members we belong here.  We'll fight together if they ever try to kick us out."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Feeling",
    line = ccb.content.text("It ain't so bad.  I got shelter, heat, and people to defend me if any <zombie> shuffles its way in here.  If I want to eat then I'll be doin' construction work all day."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Result_rewardRation",
    line = ccb.content.text("Food is just the thing a starving man needs.  Thanks for the help, <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary_Result_rewardIcon",
    line = ccb.content.gendered_line("Ha ha ha!  Think before you speak, chum.  Eight icons for an honest day's work, I say the system's broken!", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Sorry to hear that.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("No rest for the weary…"), next_topic = "TALK_DONE" },
    },
}
