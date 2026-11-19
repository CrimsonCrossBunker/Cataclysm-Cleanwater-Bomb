local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_SOLDIER_1_STORY1",
    line = ccb.content.gendered_line("Listen, I don't want to get too into it.  I was in the reserves, OK?  I didn't sign on for some glory loaded shit about protecting my nation, I wanted to get some exercise, make some friends, and it looks good on my resume.  I never thought I'd get called to active duty to fight <freaking> zombies.  Maybe I'm a deserter, or a chickenshit, but I can tell you one other thing I am that the other grunts ain't: alive.  You can figure the rest out.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Fair enough, thanks.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
