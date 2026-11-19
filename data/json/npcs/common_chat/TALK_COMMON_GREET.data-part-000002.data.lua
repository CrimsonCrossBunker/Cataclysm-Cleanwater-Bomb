local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY", "TALK_STRANGER_SCARED", "TALK_STRANGER_WARY",
        "TALK_MISSION_DESCRIBE_URGENT",
    },
    replies = {
        {
            text = ccb.content.text("Drop your weapon!"),
            when = predicates.all({ predicates.actor_state("interlocutor", "has_weapon"), predicates.negate(predicates.actor_state("interlocutor", "friendly")) }),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                native_actions = { "drop_weapon" },
                opinion = { trust = 4, fear = -3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Get out of here or I'll kill you."),
            when = predicates.negate(predicates.actor_state("interlocutor", "friendly")),
            trial = { kind = "intimidate", difficulty = 20 },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}
