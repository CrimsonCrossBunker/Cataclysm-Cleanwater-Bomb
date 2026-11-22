local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_no",
    line = ccb.content.text("Not today.  Too mighty an ask, and we can't spare the steelies.  But, I'll give ye a lump'a'ice.  Keep up work'n'trade, n' mayhaps somethin' changes one'a these days."),
    replies = {
        {
            text = ccb.content.text("I'm just really eager to shed this fleshy prison.  You sure there's nothing we can do?"),
            next_topic = "TALK_EXODII_MERCHANT_Cyberframe_trust_no_weirdo",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "decisions_blobpsychosis_u_too_eager_cyborg_body" } })),
            actions = { actions.set_actor_value("speaker", "decisions_blobpsychosis_u_too_eager_cyborg_body", "yes"), actions.handler("dlg_a_dda_d62a3b691c5f"), actions.adjust_faction_trust(-2) },
        },
        {
            text = ccb.content.text("I guess I'll ask again another time.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I guess I'll ask again another time.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
