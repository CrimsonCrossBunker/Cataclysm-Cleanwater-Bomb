local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BARRY",
    line = ccb.content.text("Some of their cows were killed before we realized what was happening, Barry and Carlos went into the forest to find the predator but it was like nothing they'd ever seen.  Carlos may be willing to tell you more."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TOPICS",
            actions = { actions.set_actor_value("speaker", "u_learned_barry_missing", "yes") },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "u_learned_barry_missing", "yes") },
        },
    },
}
