local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_NOWAY",
    line = ccb.content.text("Haha, yeah, I can see why you'd think that.  I don't mean it's a good apocalypse.  I just mean that at least now I know what I'm doing every day.  I'd still kill a hundred giant bugs for a warm bed and some time alone with… sorry.  Let's change the subject."),
    replies = {
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_TRIFFIDS",
    line = ccb.content.text("Yeah, have you seen them yet?  They're these shitty walking flowers with a big <freaking> stinger in the middle.  They travel in packs.  They hate the giant insects except bees for whatever reason, and we were using them for cover to clear a horde of them.  Unfortunately, turns out the plants are better trackers than the bugs.  They almost seemed intelligent… I barely made it out, only because they were, uh, distracted."),
    replies = {
        {
            text = ccb.content.text("I'm sorry you lost someone."),
            next_topic = "BGSS_LOST_PARTNER_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
