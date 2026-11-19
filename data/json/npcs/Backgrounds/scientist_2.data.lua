local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_SCIENTIST_2_STORY1",
    line = ccb.content.gendered_line("I've got a memory blank for about three days before and after <the_cataclysm> actually.  I worked at a lab - nothing to do with any of this; physics stuff.  I think I was working there when things happened.  My first clear memory is running through the underbrush a few miles from town.  I was bandaged up, I had a messenger bag loaded with gear, and I'd taken a hard hit to the side of my head.  I have no idea what happened to me, but clearly I had already been on the run for a bit.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Do you think there's some way your knowledge could help us understand all this?"),
            next_topic = "BGSS_SCIENTIST_2_SCIENCEHELP",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- TK, this survivor can be given some rare lab notes and offer some insights into portals.  Nothing too special.
-- TKTK, eventually this survivor might be able to be given a passive job to do something interesting with a portal gun or similar.
-- TKTKTK, waaay down the road building a survivor lab in the basecamp may be an option.  This survivor would want to set up a computer and a micro particle accelerator and could have a related quest.
ccb.content.define_dialogue_topic {
    id = "BGSS_SCIENTIST_2_SCIENCEHELP",
    line = ccb.content.text("I mean, if you find anything related to all this that falls under the theoretical physics banner, I could probably help you decipher it and maybe explain it a bit.  To do more, like construct functioning models and such, I'd need a safe lab of my own, with quite a lot of fancy gear, and a reliable power grid.  I think that's a long way down the road."),
    replies = {
        {
            text = ccb.content.text("Cool.  What did you say before that?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
