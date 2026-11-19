local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_VAMPIRE" },
    line = ccb.content.text("I can do it, if you truly want it.  I've seen that those who willingly become vampires are more likely to fully walk the path so I won't attempt to force you."),
    replies = {
        {
            text = ccb.content.text("I am sure.  Grant me vampirism."),
            actions = { actions.add_effect("speaker", "vampire_virus", { permanent = true, intensity = 1 }) },
            next_topic = "TALK_VAMPIRE_MENTOR_NEWVAMPIRE",
        },
        { text = ccb.content.text("Maybe later, but not now."), next_topic = "TALK_DONE" },
    },
}
