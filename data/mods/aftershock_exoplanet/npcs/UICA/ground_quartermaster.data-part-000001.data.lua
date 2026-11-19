local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER" },
    line = ccb.content.text("&You find the Quartermaster lazily reclined against a stack of intermodal crates.  <npc_name> barely acknowledges your presence, their eyes never leaving their PDA as they address you.\n\"Need something salvor?\""),
    replies = {
        {
            text = ccb.content.text("Show me what you have."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_can_trade" } }),
        },
        {
            text = ccb.content.text("Can I buy supplies here?"),
            next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_can_trade" } })), predicates.negate(predicates.has_effect("interlocutor", "afs_tried_to_bribe")) }),
        },
        {
            text = ccb.content.text("Can I buy supplies here?"),
            next_topic = "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_RECENTLY_FAILED",
            when = predicates.has_effect("interlocutor", "afs_tried_to_bribe"),
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
