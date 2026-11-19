local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY1",
    line = {
        choices = {
            {
                when = predicates.actor_state("interlocutor", "female"),
                yes = ccb.content.text("I lived alone, on the old family property way out of town.  My husband passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing him so young.  I'd been shut in for a while anyway.  When the news started talking about Chinese bio weapons and sleeper agents, and showing the rioting in Boston and such, I curled up with my canned soup and changed the channel."),
                no = ccb.content.text("I lived alone, on the old family property way out of town.  My wife passed away a bit over a month before this started… cancer.  If anything good has come out of all this, it's that I finally see a positive to losing her so young.  I'd been shut in for a while anyway.  When the news started talking about Chinese bio weapons and sleeper agents, and showing the rioting in Boston and such, I curled up with my canned soup and changed the channel."),
            },
        },
    },
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_RURAL_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
