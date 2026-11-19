local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_danger_sense" },
    line = ccb.content.text("&You open your senses to any dangers.  You have a faint sense of foreboding, but that's it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_sense_hostility" },
    line = ccb.content.text("&A quick check reveals nothing out of the ordinary.  To <npc_name>, you're just another face in the crowd."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GUARD_GENERIC_REFUGEE_scan" },
    line = {
        choices = {
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_refugee_guard>"),
            ccb.content.text_without_extraction("<telepathy_generic>"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}
