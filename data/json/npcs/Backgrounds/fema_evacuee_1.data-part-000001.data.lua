local ccb = require("ccb")

-- TK: In a future version this character will give you directions to the FEMA camp.
ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_ESCAPE1",
    line = ccb.content.gendered_line("That place was chaos.  I only stayed a few hours.  They had a big backhoe running, digging a huge pit in a cordoned section they wouldn't let us near.  Well, I managed to sneak over that way, and saw them dumping load after load of the dead in the pit, pouring dirt back over them even as they revived and tried to climb out.  Even with all the shit I've seen since, it haunts me.  I knew then I had to get out.  Luckily for me, we were attacked the next morning by some giant horror, a kind I haven't really seen since then.  While the guards were busy with that, I grabbed some supplies I'd stocked up over the night and I fucked right out of there.  A few others tried to get the fuck out with me, but as far as I know I was the only lucky one.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Tell me more about that FEMA camp."),
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
