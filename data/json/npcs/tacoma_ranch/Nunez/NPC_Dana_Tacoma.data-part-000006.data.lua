local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_Trailer3",
    line = ccb.content.text("*sighs and nods.  \"Making do with what I've got, but yeah.  I can only crank out a couple loaves a day, and can't do anything fun.  Pablo has been talking about setting me up a separate kitchen to really get going, but we've got so much critical work to do, and fresh bread is a luxury, even if it's great for morale.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "knowledge_tacoma_bakery", "knows") } } },
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("Any luck with the pregnancy?"),
            next_topic = "TALK_TACOMA_Dana_Pregnancy",
            when = predicates.any_equal({ "knows", { scope = "speaker", key = "knowledge_dana_pregnancy" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TACOMA_Dana_TrailerPropane",
    line = ccb.content.text("You bet we will.  We've been collecting tanks and have enough for a while, but I'm burning through it faster than the scavengers can bring in more.  Pablo is working out some plans with the others to get me a real wood fired kitchen soon, and that'll also boost my capacity.  Maybe he could give you some scavenging work if you ask."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "knowledge_propane_scavenging", "knows") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Seems like a tiny kitchen for a bakery."),
            next_topic = "TALK_TACOMA_Dana_Trailer3",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
