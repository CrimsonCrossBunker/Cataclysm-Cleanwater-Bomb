local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb_Luke",
    line = ccb.content.text("Well, I trust you on this.  If you need a good hand with chemistry, go see Luke about it.  He knows a lot, you'd be surprised.  \" He pauses for a moment, and thinks as if trying to recall something.  \"Luke should be over in the old outbuilding near the dairy, that's on the other end of the property."),
    replies = {
        {
            text = ccb.content.text("That sounds great, I'll go talk to him about it.  Let's talk about something else first, though."),
            actions = { actions.set_actor_value("speaker", "chris_planned_for_bomb", "yes") },
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("That sounds great, I'll go talk to him about it."),
            actions = { actions.set_actor_value("speaker", "chris_planned_for_bomb", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}
