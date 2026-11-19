local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_ROOF",
    line = ccb.content.text("I was up pretty high on that hill, so I saw quite a bit.  The men with spears set up blockades, and there was quite a lightshow going on out there when I started up.  I think it was mostly fires, I didn't hear much shouting.  I saw a few people try to run the barricade and get stabbed to pieces.  There were swarms of <zombies>, traveling in packs towards sounds and noises.  I watched them rip a few people to shreds, screaming and trying to get away.  You know.  The usual stuff.  I was pretty numb by that point."),
    replies = {
        { text = ccb.content.text("How did you get down?"), next_topic = "BGSS_HOSPITAL_2_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
