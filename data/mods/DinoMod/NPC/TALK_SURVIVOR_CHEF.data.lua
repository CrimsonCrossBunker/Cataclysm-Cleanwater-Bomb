local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_NC_SURVIVOR_CHEF_DINOSAURS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NC_SURVIVOR_CHEF_DINOSAURS",
    line = ccb.content.text("That's a lot of meat to break down.  You're going to want to get together a real butcher setup, hooks and all, rig up a way to keep the meat cold or even better frozen, and figure out some way to make it last longer.  Could do jerky, maybe get a canning operation going.  The main thing is to work fast before it goes bad.  Hey, I know a pretty good cook who could help with that.  No, she's dead.  I'm here though."),
    replies = { { text = ccb.content.text("I'm getting hungry."), next_topic = "TALK_NC_SURVIVOR_CHEF" } },
}
