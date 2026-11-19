local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_2",
    line = ccb.content.text("I guess I can spare a few minutes.  What is it?"),
    replies = {
        { text = ccb.content.text("Can I buy anything?"), next_topic = "TALK_GODCO_Darryl_Trade" },
        {
            text = ccb.content.text("How are the chickens?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_trade_darryl_built_coop" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_darryl" } }) }),
            next_topic = "TALK_GODCO_Darryl_Trade_Eggs",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_Darryl_Wife",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
