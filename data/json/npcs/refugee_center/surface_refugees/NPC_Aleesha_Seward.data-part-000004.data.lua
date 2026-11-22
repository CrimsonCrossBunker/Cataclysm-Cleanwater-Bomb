local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_1_firstmeet",
    line = {
        when = predicates.handler("dlg_p_dda_1e3f5a885a23"),
        yes = {
            when = predicates.handler("dlg_p_dda_2abaf18a0216"),
            yes = ccb.content.text("I'm not a kid, okay?  I'm sixteen."),
            no = ccb.content.text("I'm not a kid, okay?  I'm fifteen."),
        },
        no = ccb.content.text("I'm not a kid, okay?  I'm fourteen."),
    },
    replies = {
        {
            text = ccb.content.text("Sorry, I didn't mean anything by it.  What's up?"),
            next_topic = "TALK_REFUGEE_Aleesha_2",
        },
        {
            text = ccb.content.text("Sorry, I didn't mean anything by it.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Aleesha_2",
    line = {
        when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        yes = ccb.content.text("We're just standing around here waiting, like a bunch of idiots.  We're supposedly waiting to go downstairs to the shelter, but it's been over a month.  I don't think it's happening.  I don't know what we're doing here.  I've read all the books, and there's zombies outside so we're stuck in here.  We can hear them at night."),
        no = ccb.content.text("I don't know what's up.  I'm not sure what we're even doing here.  They say we're supposed to wait until we can be moved to the shelter downstairs, but we've been here days and there's no word on how long we'll be waiting.  It's all so stupid, and nobody can tell me anything.\"  She glances at the shuttered windows.  \"Jenny figures they're never going to let us go down there, so I guess we're going to sort it out up here, one way or another.  It's not fair, but 'fair' doesn't mean much in my life anymore."),
    },
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
