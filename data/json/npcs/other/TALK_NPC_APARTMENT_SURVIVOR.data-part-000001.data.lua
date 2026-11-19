local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_APARTMENT_SURVIVOR_CALM",
    line = ccb.content.gendered_line("Oh, you're not one of the <zombies>.  Come on in, just don't cause any trouble.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Alright, let's chat."),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
