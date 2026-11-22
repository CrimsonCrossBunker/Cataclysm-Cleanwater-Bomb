local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Who are you, exactly?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_WHO",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Wanna buy something, maybe sell off what you don't need?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Could I buy one of your pets?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_BUY_PETS",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
