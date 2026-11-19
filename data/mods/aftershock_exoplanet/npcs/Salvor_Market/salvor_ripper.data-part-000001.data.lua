local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_INTRO_UNSKILLED",
    line = ccb.content.text("Huh?  You barely look like you know your way around a computer, let alone know what I do here.  Why don't you go bother someone else?"),
    replies = {
        {
            text = ccb.content.text("Yeah, I was hoping to start learning here."),
            trial = { kind = "persuade", difficulty = 50 },
            success = { next_topic = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("[LIE] I know a thing or two."),
            trial = { kind = "lie", difficulty = 50 },
            success = { next_topic = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("[$400] My money spends just as well as anyone's."),
            trial = { kind = "persuade", difficulty = 90 },
            success = { next_topic = "TALK_SALVOR_RIPPER_BRIBE_SUCCESS" },
            failure = { next_topic = "TALK_SALVOR_RIPPER_FAIL" },
        },
        {
            text = ccb.content.text("Maybe I should…"),
            actions = { actions.set_first_topic("TALK_SALVOR_RIPPER_IGNORE") },
            next_topic = "TALK_DONE",
        },
    },
}
