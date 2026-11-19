local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_SOLDIER_2_STORY1",
    line = ccb.content.gendered_line("I was in the army.  Just a new recruit.  I wasn't even done basic training, they actually called me out of boot camp to serve once the shit hit the fan.  I barely knew which end of the gun the bullets came out of, and they jammed me into a truck and drove me to Newport to 'assist in the evacuation efforts'.  Our orders barely made sense, our officers were as confused as we were.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened in Newport?"),
            next_topic = "BGSS_SOLDIER_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SOLDIER_2_STORY2",
    line = ccb.content.gendered_line("We never even made it to Newport.  The truck got stomped by something gigantic.  I didn't even see it, just saw this huge black-and-green spiny leg jam through the ceiling, through the el-tee.  Heard the tires grinding, felt the truck lift up.  We were kicked off the leg like dog shit off a sneaker.  I don't know how I survived.  The thing rolled over, killed most of us right there.  I musta blacked out for a bit.  Came to, and while I was getting myself out, the others started getting back up.  Long story short, I lived, they didn't, and I ran.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
