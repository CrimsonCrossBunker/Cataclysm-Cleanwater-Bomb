local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PROFESSOR_1_STORY1",
    line = ccb.content.gendered_line("I'm actually a chemistry professor at Harvard.  I'd been on sabbatical for the last six months.  I can't imagine the university was a good place to be, given what I've heard about Boston… I'm not sure anyone made it out.  I was out at my cabin near Chatham, ostensibly working on the finishing touches for a paper, but mostly just sipping whisky and thanking my lucky stars for tenure.  Those were good days.  Then came <the_cataclysm>, the military convoys, the <zombies>.  My cabin was crushed by a fearsome beast, just collateral damage after it got blasted off Orleans by a tank.  I was already busy running frantically by then.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Do you think there's some way your knowledge could help us understand all this?"),
            next_topic = "BGSS_PROFESSOR_1_SCIENCEHELP",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- TK, down the road: if it becomes interesting to give stone or soil samples to this guy he might produce interesting data.
-- TKTK, waaay down the road building a survivor lab in the basecamp may be an option.  This survivor might be able to study strange rocks and metals, eg.  from a fungal spire, or (if they're ever in game) from other dimensions.
ccb.content.define_dialogue_topic {
    id = "BGSS_PROFESSOR_1_SCIENCEHELP",
    line = ccb.content.text("Hard to say.  I'm not really an organic chemist, I did geological chemistry.  I'm at a loss to how that relates, but if you come across something where my knowledge would help I'll gladly offer it."),
    replies = {
        {
            text = ccb.content.text("Cool.  What did you say before that?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
