local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_BUY_PETS",
    line = ccb.content.text("I hate to see them go, but I think you'd be able to take better care of one than I can right now.  I can sell you a cat or dog of your choosing, for $25 and $50, respectively."),
    replies = {
        {
            text = ccb.content.text("I've changed my mind, let's talk about something else."),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text("I'll have a dog."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "sold_pet")),
            actions = { actions.purchase_pet("mon_dog", { cost = 5000, pacified = true }), actions.add_effect("interlocutor", "sold_pet", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("I'll have a cat."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "sold_pet")),
            actions = { actions.purchase_pet("mon_cat", { cost = 2500, pacified = true }), actions.add_effect("interlocutor", "sold_pet", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
