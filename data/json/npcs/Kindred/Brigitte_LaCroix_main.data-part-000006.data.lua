local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG3_FRIEND",
    line = ccb.content.text("Only when you crush the bones of a body does it cease to rise.  Only if you examine the bones can you see what was, the story of the bones.  Whatever causes this change is alive, writhing within us all; an inevitable part of this new world.  It holds the power of change.  When we hold the bones, we hold the power.  Thus the strength.  Together… they form a beautiful song."),
    replies = {
        {
            text = ccb.content.text("What do we actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("Does anyone else share this belief?"),
            next_topic = "TALK_BONE_SEER_OTHERS_FRIEND",
        },
    },
}
