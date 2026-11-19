local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } }),
        yes = {
            choices = {
                ccb.content.text("Good to see you again, how can I help you?"),
                ccb.content.gendered_line("They say I turned a man into a cedar tree once.  That's a terrible thing to say.", { "interlocutor" }),
                ccb.content.gendered_line("You like maple syrup?  That was me.  Not the syrup, that was the trees, but I figured out how to make it much harder to concentrate it, used to be way too easy.  Pretty nice right?", { "interlocutor" }),
                ccb.content.gendered_line("Did I tell you the one about the beavers?  Used to be way too big.  Like giant beavers, it was a mess.  I fixed that.  Of course there seem to be a bunch of new giant things out here now.  I'll have to think about that.", { "interlocutor" }),
                ccb.content.text("You know storms?  Used to be more.  Took me a lot of work, but there aren't as many now.  That was me, I did that.  Fewer storms, pretty good.  There's a big eagle, it's a long story really.  I'm good with rope though."),
            },
        },
        no = ccb.content.text("It's decided then.  I will be Glooscap.  Who will you be?"),
    },
    replies = {
        {
            text = ccb.content.text("Glooscap?  That's a funny name.  Is it foreign?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } })),
            next_topic = "TALK_GLOOSCAP_WHERE",
        },
        {
            text = ccb.content.text("[INT 11]  Like the Wabanaki myth?"),
            next_topic = "TALK_GLOOSCAP_MYTH",
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 11), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_accused_malsumis" } })) }),
        },
        {
            text = ccb.content.text("So.  You're dressed like a hunter.  Are you a hunter?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_befriended_glooscap" } })) }),
            next_topic = "TALK_GLOOSCAP_HUNTER",
        },
        {
            text = ccb.content.text("Have you had any luck out there?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_befriended_glooscap" } }),
            native_actions = { "start_trade" },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("Whatever, I don't have time for whatever this is.  Try not to get your face eaten I guess."),
            next_topic = "TALK_DONE",
        },
    },
}
