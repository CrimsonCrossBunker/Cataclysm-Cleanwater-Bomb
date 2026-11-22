local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoneTrade",
    line = {
        choices = {
            ccb.content.text("Good an' fine, then."),
            ccb.content.text("Have it as ye'll see."),
            ccb.content.text("For a card an' a wink, eh?"),
        },
    },
    on_enter = {
        { when = predicates.handler("dlg_p_dda_da66e2d84e95"), actions = { actions.handler("dlg_a_dda_88ab5cdd0752"), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("How come that dude is selling medieval gear in addition to all those guns?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Medieval",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_weaponmaster" } }),
        },
        {
            text = ccb.content.text("You seem to have a bunch of blueprints.  Can you tell me more about those?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad",
        },
        {
            text = ccb.content.text("Have you anything more back there?"),
            next_topic = "TALK_EXODII_MERCHANT_AskedRestock",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
