local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different",
    line = ccb.content.text("*nods deeply.  \"We are, for where we once were in chaos, now we are at peace.  In time, this shall bring wisdom, but we must ponder on these great changes.\""),
    replies = {
        {
            text = ccb.content.text("Were you like this, uh, before?  Did you use to have a doctor or anything?"),
            next_topic = "TALK_DINODAVE_Different2",
        },
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different2",
    line = ccb.content.text("We were… I… we can scarcely remember those times.\"  Dave looks pained.  \"No, we had no doctor.  We didn't need one.  We had a job and… and… we don't like to talk about this."),
    replies = {
        {
            text = ccb.content.text("Come on, Dave.  We're friends.  I won't use this against you or anything."),
            next_topic = "TALK_DINODAVE_Different3",
        },
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different3",
    line = ccb.content.text("*winces.  \"It is true.  You have earned some truth, but we… we find it hard to give.  We had a job, an education.  Prestige.  It is all very faint now.\"  He touches a stainless steel ring on his pinky finger, looking lost in thought.  \"We don't know why that man left, and this one remains.  Perhaps that is some wisdom that will come with time, or perhaps it is a door best left closed.\""),
    replies = {
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}
