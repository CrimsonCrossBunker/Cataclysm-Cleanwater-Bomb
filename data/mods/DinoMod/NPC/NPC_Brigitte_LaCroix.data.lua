local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER",
    replies = {
        {
            text = ccb.content.text("What can you tell me about the dinosaurs?"),
            next_topic = "TALK_BONE_SEER_DINOSAURS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_DINOSAURS",
    line = ccb.content.text("Their song is older than ours, but also different.  We have much to learn from their old bones.  I knew a man once who sang not of bones but of meat.  If you find him, you will know the face of Bo.  He has listened hardest to them, but I do not know if he hears."),
    replies = {
        {
            text = ccb.content.text("That explains everything, thank you."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}
