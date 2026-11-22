local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
    line = ccb.content.text("Well, I used to be a roofer, but I had a bad fall and wrecked my back around '06.  Tried to get into other kinds of carpentry but I just don't have the head for it.  My wife managed to support both of us with the extra bit I made from odd jobs, but she had a stroke in 2016 and left me on my own the last few years slowly draining my savings dry while I work whatever junk jobs I can handle.  Couple days before <the_cataclysm> I got the notice that the bank was going to foreclose on my crappy little trailer."),
    replies = {
        {
            text = ccb.content.text("You have any kids?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE2",
        },
        {
            text = ccb.content.text("Would you like to travel with me?  Someone good with a trade could be helpful, and it's got to be better than wasting away here."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp.  It's a damn sight better than those place, and there are regular meals.  Someone with your trades experience would be welcome, even if you can't do the big jobs anymore."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
            when = predicates.handler("dlg_p_dda_451497940a38"),
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
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE2",
    line = ccb.content.text("Yeah, we had two.  My daughter died of an OD right at the start of that fentanyl stuff.  It did a real number on my son - they were twins you see - and he cut ties to me and my wife.  Wasn't even there for her funeral.  I can't blame him, it messed us all up pretty fierce.  As far as I'm concerned he's still out there with my grandkids, hiding away somewhere safe.  These days, no news is good news."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("Would you like to travel with me?  Someone good with a trade could be helpful, and it's got to be better than wasting away here."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp.  It's a damn sight better than those place, and there are regular meals.  Someone with your trades experience would be welcome, even if you can't do the big jobs anymore."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
            when = predicates.handler("dlg_p_dda_451497940a38"),
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
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
