local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_STORY1",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("My husband made it out with me, but got eaten by one of those <freaking> plant monsters a few days before I met you.  This hasn't been a great year for me."),
                no = ccb.content.text("My wife made it out with me, but got eaten by one of those <freaking> plant monsters a few days before I met you.  This hasn't been a great year for me."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm sorry to hear it."),
            next_topic = "BGSS_LOST_PARTNER_1_STORY2",
        },
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_STORY2",
    line = ccb.content.gendered_line("That's how it goes, you know?  These are the end times.  I don't really want to talk about it more than that.  And honestly, I never really felt like I belonged, in the old world.  In a weird way, I actually feel like I have a purpose now.  Do you ever get that?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("No, that's messed up."),
            next_topic = "BGSS_LOST_PARTNER_1_NOWAY",
        },
        {
            text = ccb.content.text("Yeah, I get that.  Sometimes I feel like my existence began shortly after the Cataclysm."),
            next_topic = "BGSS_LOST_PARTNER_1_YEAH",
        },
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_YEAH",
    line = ccb.content.text("I guess those of us who made it this far have to have made it for a reason, or something.  I don't mean like a religious reason, just… we're survivors."),
    replies = {
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_NOWAY",
    line = ccb.content.text("Haha, yeah, I can see why you'd think that.  I don't mean it's a good apocalypse.  I just mean that at least now I know what I'm doing every day.  I'd still kill a hundred zombies for an internet connection and a night watching crappy movies with… sorry.  Let's change the subject."),
    replies = {
        {
            text = ccb.content.text("Tell me about those plant monsters."),
            next_topic = "BGSS_LOST_PARTNER_1_TRIFFIDS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- In a future version this NPC might give you directions to a triffid grove.
ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_1_TRIFFIDS",
    line = ccb.content.gendered_line("Yeah, have you seen them yet?  They're these shitty walking flowers with a big <freaking> stinger in the middle.  They travel in packs.  They hate the zombies, and we were using them for cover to clear a horde of the dead.  Unfortunately, turns out the plants are better trackers than the <zombies>.  They almost seemed intelligent… I barely made it out, only because they were, uh, distracted.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I'm sorry you lost someone."),
            next_topic = "BGSS_LOST_PARTNER_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
