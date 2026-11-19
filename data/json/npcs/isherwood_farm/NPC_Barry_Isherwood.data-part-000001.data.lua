local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_BARRY_RESCUE",
    line = ccb.content.text("*crouches on the bottom of his cell, shivering, then looks up as you approach.  He blinks a few times, then stands up.  He's totally nude, and his tanned body is covered in tiny, precise-looking scars of varying ages.  \"I can't believe my eyes.  Please get me outta here…\""),
    replies = {
        {
            text = ccb.content.text("Are you Barry Isherwood?"),
            next_topic = "TALK_ISHERWOOD_BARRY_ID",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
        },
        {
            text = ccb.content.text("I'll get you out of here, just stay calm.  <lets_go>"),
            next_topic = "TALK_ISHERWOOD_BARRY_Escaping",
            when = predicates.negate(predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1")),
        },
        {
            text = ccb.content.text("I'm Luke Skywalker, I'm here to rescue you."),
            actions = { actions.set_actor_value("speaker", "too_short_to_be_a_stormtrooper", "unclear") },
            next_topic = "TALK_ISHERWOOD_BARRY_BADJOKE",
        },
        {
            text = ccb.content.text("You just hold tight here for a second."),
            next_topic = "TALK_DONE",
        },
    },
}
