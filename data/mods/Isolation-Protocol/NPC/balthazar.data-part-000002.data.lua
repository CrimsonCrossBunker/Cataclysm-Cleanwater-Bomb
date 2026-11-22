local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_CONFIRM",
    line = ccb.content.text("ALLIANCE CONFIRMED.  INITIATING COOPERATIVE PROTOCOLS.  STANDBY FOR CAUSAL INTEGRATION."),
    replies = {
        {
            text = ccb.content.text("Let me take the lead."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_isolation_protocol_40e0dc93f391"), actions.replace_mutation("speaker", "iso_trait_balthazar_uplink"), actions.add_effect("speaker", "sleep", { turns = 600 }), actions.handler("w16b_a_isolation_protocol_2f298c4cf0ab") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_DENY_CONFIRM",
    line = ccb.content.text("INVALID RESPONSE TO AUTHENTIC PROPOSAL.  INITIATING COOPERATIVE PROTOCOLS.  STANDBY FOR CAUSAL INTEGRATION."),
    replies = {
        {
            text = ccb.content.text("Fine, be that way."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_isolation_protocol_40e0dc93f391"), actions.replace_mutation("speaker", "iso_trait_balthazar_uplink"), actions.add_effect("speaker", "sleep", { turns = 900 }), actions.add_effect("speaker", "blind_no_msg", { turns = 900 }), actions.handler("w16b_a_isolation_protocol_2f298c4cf0ab") },
        },
    },
}
