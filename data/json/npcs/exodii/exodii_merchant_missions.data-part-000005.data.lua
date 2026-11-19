local ccb = require("ccb")

-- A jut is a long, thin pole.  The warehouse is made of concrete and rusty iron, and atop it there's a glistening pole.  The pole is broken, turned off.  I got a tool for you to turn it back on.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_clarify",
    line = ccb.content.text("A jut be a long, thin post, kennit.  The store-cabin be made o' con-crete an' rusty iron, and atop it be a glintin' post.  The post be broken, I'd razz.  Turnt off.  Rubik's got a tool for you to pop, make it turnt on."),
    replies = {
        {
            text = ccb.content.text("OK, got it.  A metal and concrete building with some kind of metal pole on top that you want me to fix"),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_intro1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
