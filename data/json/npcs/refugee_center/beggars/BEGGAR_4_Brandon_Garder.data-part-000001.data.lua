local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_TALK2",
    line = ccb.content.text("You name it!  Asthma, diabetes, arthritis.  Diabetes hasn't been so bad since I stopped, y'know, eating regularly.  Well, I assume it hasn't.  Not like I can check that ol' whatchamacallit, the blood test the docs used to bug me about every couple months."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_SICKLY",
    line = ccb.content.text("They got enough mouths to feed that can pull their own weight.  I got a lot of weight and I'm too weak to pull it, so I'm out here."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
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
    id = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
    line = ccb.content.text("Came with a small group quite a while ago.  The others were young and fit, they got in.  They were some of the last ones to get in actually.  I didn't make the cutoff."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
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
    id = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
    line = ccb.content.text("This is a mercy.  I get shelter, light, and heat, and those guards will help us if any zombies show up.  It ain't so bad.  If I was out on my own I'd have none of this and still have to look for food… in other words, I'd be dead as a doornail.  Or I guess undead."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
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
