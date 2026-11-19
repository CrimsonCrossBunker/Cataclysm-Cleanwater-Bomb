local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_RURAL_1_STORY3",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_rural_1_started_quest" } }),
        yes = ccb.content.text("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people I cared about a bit.  I started to worry about them.  I headed out, but everything seemed different to me.  Didn't get far before I bumped into a giant fly buzzing, and that's when I started to put it all together.  Never did see my friends again.  My place was trashed anyway, so I wandered on.  And now I'm here with you."),
        no = ccb.content.text("That was the first thing to really shake me out of it.  I didn't really have any very close friends, but there were people I cared about a bit.  I started to worry about them.  I headed out, but everything seemed different to me.  Didn't get far before I bumped into a giant fly buzzing, and that's when I started to put it all together.  Never did see my friends again.  My place was trashed anyway, so I've just been wandering since."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
