local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_SUCCESS",
    replies = {
        {
            text = ccb.content.text("Glad to help.  I need no payment."),
            next_topic = "TALK_NONE",
            when = predicates.conversation_state("mission_offers_generic_rewards"),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("How about some items as payment?"),
            next_topic = "TALK_MISSION_REWARD",
            when = predicates.all({ predicates.conversation_state("mission_offers_generic_rewards"), predicates.negate(predicates.actor_state("interlocutor", "friendly")) }),
            native_actions = { "mission_reward" },
        },
        {
            text = ccb.content.text("Maybe you can teach me something as payment?"),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.conversation_state("mission_offers_generic_rewards"), predicates.any({ predicates.actor_state("interlocutor", "offers_skill_training"), predicates.actor_state("interlocutor", "offers_style_training") }) }),
        },
        {
            text = ccb.content.text("Glad to help.  I need no payment.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.conversation_state("mission_offers_generic_rewards"),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("Glad to help."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.conversation_state("mission_offers_generic_rewards")),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("Glad to help.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.conversation_state("mission_offers_generic_rewards")),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
    },
}
