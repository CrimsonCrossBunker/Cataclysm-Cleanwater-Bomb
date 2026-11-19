local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy3",
    line = ccb.content.text("I may be more skilled or better equipped but you, my friend, have something I don't: experience.  A good hunter never leaves his hunting ground.  I sure ain't gonna leave it!  Now you <name_g>, you know what it's REALLY like out there!"),
    replies = {
        {
            text = ccb.content.text("I hate to break it to you, but I came here because I don't want to see the world."),
            next_topic = "TALK_GODCO_Russell_Joinee",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm humbled by your words.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
