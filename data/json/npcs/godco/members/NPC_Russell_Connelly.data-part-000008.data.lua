local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trade",
    line = ccb.content.text("We're all desperately holding on to our stockpiles, but I can find something for you.  I have some spare hides and pelts, if you're interested in buying."),
    replies = {
        {
            text = ccb.content.text("Since I helped you out with your trophies, can I get a discount?"),
            next_topic = "TALK_GODCO_Russell_Trade2",
            when = predicates.all({ predicates.has_effect("interlocutor", "hunt_godco_russell"), predicates.negate(predicates.has_effect("interlocutor", "trade_godco_russell")) }),
        },
        {
            text = ccb.content.text("Let's make a deal."),
            native_actions = { "start_trade" },
            next_topic = "TALK_GODCO_Russell_2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
