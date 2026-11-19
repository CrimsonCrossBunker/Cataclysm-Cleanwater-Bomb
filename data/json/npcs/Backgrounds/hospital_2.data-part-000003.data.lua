local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_ROOF",
    line = ccb.content.gendered_line("My hospital was the tallest building in town, so I saw quite a bit.  The military set up blockades on the roads coming in and out of the town, and there was quite a lightshow going on out there when I started up.  I think it was mostly automated turrets and robots, I didn't hear much shouting.  I saw a few cars and trucks try to run the barricade and get blown to high hell.  There were swarms of <zombies> in the streets, traveling in packs towards sounds and noises.  I watched them rip a few running cars to shreds, including the people inside who were trying to get away.  You know.  The usual stuff.  I was pretty numb by that point.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("How did you get down?"), next_topic = "BGSS_HOSPITAL_2_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_CABINSUCCESS",
    line = ccb.content.text("I suppose it couldn't hurt now.  I doubt anyone's still there anyway."),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_CABINFAILURE",
    line = ccb.content.text("Yeah, fat chance I'm giving up that kind of personal information to someone I barely know.  What are you trying to pull?"),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_NONE" } },
}
