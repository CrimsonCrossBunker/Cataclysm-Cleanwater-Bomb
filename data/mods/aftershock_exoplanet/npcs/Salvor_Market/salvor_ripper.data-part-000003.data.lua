local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_IGNORE",
    line = ccb.content.text("&The ripper is ignoring you.  They continue to tap away at their wrist computer, occasionally glancing up to make sure you're still there, but otherwise not acknowledging your presence."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("[Ancient Mercurial ID codes] I've found something you want.  Lets have a real talk."),
            next_topic = "TALK_SALVOR_MERCURIAL_IDENTS",
            when = predicates.has_item("speaker", "ruin_data_mercurial_id"),
        },
    },
}
