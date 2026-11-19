local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_FM_BACKGROUND",
    line = {
        choices = {
            ccb.content.text("Nothing too fancy.  We have a rota of anyone able bodied that can handle themselves."),
            ccb.content.text("None of your business really, is it."),
            ccb.content.gendered_line("I've seen my share of zombies, I'm one of the ones that's ready to take em on.  Nothing more.", { "interlocutor" }),
            ccb.content.text("Gotta earn my keep."),
            ccb.content.text("It's honest work, and now and then I get to take a zombie down."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
