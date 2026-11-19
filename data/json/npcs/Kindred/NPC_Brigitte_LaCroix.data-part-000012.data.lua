local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED_SEER",
    line = ccb.content.text("I understand your reluctance.  Feel free to return when you see the way."),
    replies = {
        {
            text = ccb.content.text("Maybe some other time.  Changing the topic…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Alright, but I have to go now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_CYCLE",
    line = ccb.content.text("It's not just walking horrors and monsters that have changed with the Cataclysm.  It started a… cycle, of sorts.  Everything repeats.  We can only see it in others, but it happens to us, even you and I.  How many times have you fallen?  Your flesh rent from your body, devoured.  Or perhaps it was the quiet whimper of succumbing to the elements.  But your bones rose again.  Different flesh, different name, sometimes even different knowledge, but the bones, the same.  We are all trapped in the same cycle.  We just keep forgetting.  That's why we need to amass the Song.  That's why it has to end, even if it means the destruction, not restoration."),
    replies = {
        { text = ccb.content.text("That's… certainly something."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("That's insane."), next_topic = "TALK_BONE_SEER_INSULT" },
        { text = ccb.content.text("Right… I think I'll go now."), next_topic = "TALK_DONE" },
    },
}
