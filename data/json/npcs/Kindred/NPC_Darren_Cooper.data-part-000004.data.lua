local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_NECESSARY",
    line = ccb.content.text("People will die in this world overrun with monsters.  There is no avoiding it.  But I can give those deaths meaning, allow them to help the world after death, more than they could in life.  It brings me no pleasure, but… yes, some must give their life for the greater good.  It's the only way.  Wish there was an alternative, but it must be done.  I only take people from this world to save it.  Make no mistake though, the only people that I… kill are those who would not survive anyway."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper_kill", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Why do you kill people?"),
            next_topic = "TALK_COOPER_GOAL",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } })),
        },
        {
            text = ccb.content.text("Are you going to kill me?"),
            next_topic = "TALK_COOPER_KILL_PLAYER",
        },
        { text = ccb.content.text("You're a monster."), next_topic = "TALK_COOPER_MONSTER" },
        {
            text = ccb.content.text("You're just a murderer with a shoddy excuse.  I can't let you keep doing this."),
            next_topic = "TALK_COOPER_FIGHT",
        },
        {
            text = ccb.content.text("You have a point.  The ends justify the means."),
            next_topic = "TALK_COOPER_AGREE",
        },
        {
            text = ccb.content.text("Do you have any proof that this will work?"),
            next_topic = "TALK_COOPER_WORK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_cooper_goal_k" } }),
        },
    },
}
