local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Medieval",
    line = ccb.content.text(
        --~ It's a bit of a surprise, isn't it?  Before we came here, we were in a place about 600 years earlier in time, or so.  We landed in the middle of a war that turned wrong when the dead started joining back in.  Truth be told, not a very unusual situation.  The Enemy makes us fight.  By and by, we came in, and by then the killing fields were ready for us to harvest their bronze.  It's not Avalonian steel, but it's a good strong metal for stopping a nibbling mouth, so we kept some of their armor and weapons to trade.
        "That be a right welcher, eh?  Afore us'n were to this land, the preface were on a half-score century by the reckonin'.  Landed us in amidst of a war'd turned wrong, for an' as the dead had come back in.  By the butcher's block, not much an unusual case, really.  The Enemy makes us fight.  By an' by, we came in, an' by then the killin' fields were plump and ready to harvest the bronze.  'Tain't no steel-of-the-lake, but 'tis a good dross metal for holdin' off a nibblin' mouth, so we kept a few o' their vestments an' stickers for to trade."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "u_talk_exodii_about_medieval_stock", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("You seem to have a bunch of blueprints.  Can you tell me more about those?"),
            next_topic = "TALK_EXODII_MERCHANT_Stock_Nomad",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
