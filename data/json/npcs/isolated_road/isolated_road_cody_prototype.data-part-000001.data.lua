local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_FEELING_IT",
    line = {
        choices = {
            ccb.content.text("Yeah!  I feel a lot better now that Jay and I are talking again, and we've been putting some serious work into this stuff.  If you wanted to help source parts and do some testing, we could definitely get some prototypes made."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alright."),
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_can_prototype", "yes"),
            },
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}
