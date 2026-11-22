local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "elevator_controls_call_success",
    line = ccb.content.text("&You hear the elevator arrive."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

-- TODO: Make this have actual consequences
ccb.content.define_dialogue_topic {
    id = "elevator_controls_call_fail",
    line = ccb.content.text("&You fail to make the elevator move."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "elevator_controls_start",
    line = ccb.content.text("&This computer controls the elevator platform."),
    replies = {
        {
            text = ccb.content.text("Attempt to call the elevator."),
            when = predicates.handler("w16b_p_hunvre_371437fadc86"),
            trial = { kind = "skill_check", difficulty = 6, skill = "computer" },
            success = { next_topic = "elevator_controls_call_success", actions = { actions.handler("w16b_a_hunvre_3d9f07542792") } },
            failure = { next_topic = "elevator_controls_call_fail" },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}
