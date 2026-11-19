local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_WHY_HERE" },
    line = ccb.content.text("It wasn't my choice, obviously.  That fucking bastard back in Alpha Centauri had me transferred to this frozen hell.  Pulled strings with the staff in command.  I signed on to help put Earth back where it belongs: on top.  Not freeze my arse off fixing barely held-together scrap in the middle of fucking nowhere.  Mercurial doesn't even give a shit about this place.  I don't know why the UICA even bothers to station us here.  If you ask me this planet should have stayed abandoned."),
    replies = {
        {
            text = ccb.content.text("Who's the bastard?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_BKGR_BASTARD",
        },
        {
            text = ccb.content.text("What makes you think Mercurial doesn't care?"),
            next_topic = "TALK_UICA_VEHICLE_MERCHANT_MERCURIAL",
        },
        { text = ccb.content.text("Sorry I asked."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_BKGR_BASTARD" },
    line = ccb.content.text("My former superior officer, the prick.  Always hovering my shoulder like a damn drone.  I won't miss that uptight control freak.  We fought a lot and didn't see things eye to eye.  But this?  I never imagined the fucker would stoop this low.  Hell of a disciplinary action, I'll tell you that much."),
    replies = { { text = ccb.content.text("I'm sorry to hear that."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_VEHICLE_MERCHANT_MERCURIAL" },
    line = ccb.content.text("The last thing they did was set up their little clinic on the station, and they haven't done jack since.  No communications, no re-colonization efforts, no survey teams.  They hardly even seem to care about going down planetside.  Not like I blame them.  The colony didn't work out before so, why bother?  This place is clearly not worth the effort."),
    replies = {
        {
            text = ccb.content.text("I guess there are some rocks even Corpos won't touch."),
            next_topic = "TALK_DONE",
        },
    },
}
