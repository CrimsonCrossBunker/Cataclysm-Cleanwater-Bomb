local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_scan" },
    line = {
        choices = {
            ccb.content.text_without_extraction("<telepathy_generic>"),
            ccb.content.text_without_extraction("<telepathy_follower>"),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_FRIEND" } },
}
