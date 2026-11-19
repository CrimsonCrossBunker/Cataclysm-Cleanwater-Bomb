local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_BONE_SEER",
    line = ccb.content.text("Listen…  Can't you hear the song here?"),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_BONE_SEER",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_BONE_SEER" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_BONE_SEER_Abilities",
    line = ccb.content.text("I hear the song of the bones.  You can hear it too.  We listen to them, and learn from their stories.  I can also break them just the same."),
}
