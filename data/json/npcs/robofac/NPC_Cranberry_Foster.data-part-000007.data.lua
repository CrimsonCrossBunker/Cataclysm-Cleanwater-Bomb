local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_HWP_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_merc_promised_u" } }),
        yes = ccb.content.text("As promised earlier, I'll let the Hub know that you're worth manufacturing some proper gear for.  Let 'em know that I sent you next time you talk with them and I'm sure they'll help you."),
        no = ccb.content.text("I do owe you one.  Tell you what: I'll let the Hub know that you're worth manufacturing some proper gear for.  Let 'em know that I sent you next time you talk with them and I'm sure they'll help you."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_hub_rnd_u_can_research_rifle", "yes") },
        },
    },
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_1_MAIN" } },
}
