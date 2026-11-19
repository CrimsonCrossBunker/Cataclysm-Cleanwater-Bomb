local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_ESCAPE",
    line = {
        choices = {
            ccb.content.text("&As you move to stand, you see the shade stir.  A buzzing sensation, neither sight nor sound, fills your senses, then passes.  Was it grabbing you?  Just reaching out to touch you?  You don't know, but you roll out of the way and stand up."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
