local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MUG_TELEKINESIS_USED",
    line = {
        when = predicates.actor_state("interlocutor", "male"),
        yes = {
            choices = {
                ccb.content.text("*'s weapon flies out of his hands.\n\n\"<freaking> <name_b>!  You some kind of witch?\""),
                ccb.content.text("*'s weapon flies out of his hands and he lets out a startled yelp."),
            },
        },
        no = {
            choices = {
                ccb.content.text("*'s weapon flies out of her hands.\n\n\"<freaking> <name_b>!  You some kind of witch?\""),
                ccb.content.text("*'s weapon flies out of her hands and she lets out a startled yelp."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Get out of here before I do worse."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_DONE", native_actions = { "flee" } },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
    },
}
