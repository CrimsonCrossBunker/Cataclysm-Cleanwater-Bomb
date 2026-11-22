local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_RADIO",
    line = {
        joined = {
            { when = predicates.conversation_state("radio"), yes = ccb.content.text("Are you making a joke?  We're using two-way radios to talk right now.\n  Whatever, I'll go over it again in case you forgot.\n") },
            ccb.content.text("If you have a two-way radio and I have a two-way radio, you can use the faction interface (keybind '#') key to contact me.  I'll respond as long as I'm not too far away and the signal isn't blocked by the ground.  We can converse normally via a radio, but obviously we can't trade items and I can't train you.\n  You can tell me to come to you or go to any of your faction camps, or if I'm at a faction camp, you can tell me to perform actions at the camp."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Sorry, I don't know what I was thinking.  Tell me about you coming here."),
            false_text = ccb.content.text("Tell me about you coming here."),
            text_when = predicates.conversation_state("radio"),
            next_topic = "TALK_ALLY_TUTORIAL_MOVEMENT",
        },
    },
}
