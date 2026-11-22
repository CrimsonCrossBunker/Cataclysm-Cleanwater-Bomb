local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_SawMarshal",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("*glares at your marshal badge.  \"I said, keep *walking*, G-man.\""),
        no = ccb.content.text("*spits on the ground, glancing at where your marshal badge would have been, and shaking his head.  \"Nice try.  You can take off the badge, but I know what you are, I'm not some country rube.  Get out.\""),
    },
    replies = {
        {
            text = ccb.content.text("<color_green>[Social 3]</color> I swear, I'm not here to cause trouble.  I just volunteer with those guys to help travelers, things like that.  I don't speak for them."),
            next_topic = "TALK_ISHERWOOD_EDDIE_MarshalOff_Convince",
            when = predicates.handler("dlg_p_dda_35ada2d8d64b"),
        },
        {
            text = ccb.content.text("<color_yellow>[Social <3]</color> I took it off man, what more do you want from me?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_MarshalOff_GoAway",
            when = predicates.handler("dlg_p_dda_76314c46821c"),
        },
        {
            text = ccb.content.text("Fine, I'm gone."),
            next_topic = "TALK_DONE",
        },
    },
}
