local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DOING",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_FORGE_LORD" } }),
        yes = ccb.content.text("Once I was lost in the throes of love, now I've built an empire of material goods.  I've found these two things are equally as powerful, and dangerous."),
        no = ccb.content.text("Well here and now I am the law, and the law here is that people purchase my goods, they take them out into the world and they die; or they return to buy more of my goods.  Either way, I write poetry about them."),
    },
    replies = {
        {
            text = ccb.content.text("Good day, sir."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_FORGE_LORD", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_FORGE_LORD" } })),
            next_topic = "TALK_FORGE_LORD",
        },
    },
}
