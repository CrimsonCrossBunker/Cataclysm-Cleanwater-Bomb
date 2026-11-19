local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GUNTRADER" },
    line = ccb.content.text("&You find the clerk leaning before an almost impressive collection of weaponry, most of it neatly displayed in racks or hanging from the curved prefab ceiling.  <mypronoun> barely acknowledges your approach, it doesn't seem like customer service is a priority here."),
    replies = {
        {
            text = ccb.content.text("You sell guns here right?"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
