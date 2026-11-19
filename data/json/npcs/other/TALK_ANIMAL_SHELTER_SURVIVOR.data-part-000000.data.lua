local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text_without_extraction("<greet>"),
        no = ccb.content.text("Finally, someone who isn't part of those <zombies>."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, today's your lucky day.  Hand over your stuff, or you'll be one yourself."),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("Hey, nice to meet you."),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text_without_extraction("<greet>"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
