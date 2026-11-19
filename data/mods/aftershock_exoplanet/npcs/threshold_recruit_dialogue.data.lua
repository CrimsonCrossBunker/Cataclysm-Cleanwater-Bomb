local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Sets a base level response if you share the same threshold with an uplift or other specific type of post thresh mutant.  Higher base chance for herd type animals.
ccb.content.define_dialogue_topic {
    id = { "TALK_SUGGEST_FOLLOW" },
    replies = {
        {
            text = ccb.content.text("[MASTODON 75%] Come, join the herd before you're left behind."),
            when = predicates.all({ predicates.has_trait("speaker", "THRESH_MASTODON"), predicates.has_trait("interlocutor", "THRESH_MASTODON") }),
            next_topic = "TALK_AGREE_FOLLOW",
            native_actions = { "follow" },
            opinion = { value = -1 },
        },
        {
            text = ccb.content.text("[MI-GO 50%] Let's see just how much we can improve ourselves."),
            when = predicates.all({ predicates.has_trait("speaker", "THRESH_YUGGOTH"), predicates.has_trait("interlocutor", "THRESH_YUGGOTH") }),
            next_topic = "TALK_AGREE_FOLLOW",
            native_actions = { "follow" },
            opinion = { value = -1 },
        },
    },
}
