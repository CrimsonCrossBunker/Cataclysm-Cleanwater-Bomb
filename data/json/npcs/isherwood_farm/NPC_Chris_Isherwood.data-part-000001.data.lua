local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS",
    line = {
        joined = {
            ccb.content.text("*is a young man, perhaps in his early twenties or late teens.  He eyes you up and down.  \""),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("I see that badge.  You need to leave our land, my relatives have no fondness for Marshals.\""),
                no = {
                    when = predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_chris_marshal_badge" } }),
                    yes = ccb.content.gendered_line("I see you took the badge off.  Fine, then, but you'd better not let anyone here know you've got ties to the Marshals.\"", { "speaker" }),
                    no = ccb.content.text("Hi, what's up?\""),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CHRIS",
            actions = { actions.set_actor_value("speaker", "isherwood_chris_marshal_badge", "seen") },
            opinion = { trust = -5, value = -5 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}
