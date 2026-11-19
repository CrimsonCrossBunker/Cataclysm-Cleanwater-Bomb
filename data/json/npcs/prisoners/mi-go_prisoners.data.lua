local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MI-GO_PRISONER1",
    line = {
        choices = {
            ccb.content.text("My god, you've got to get me out of here.  The things… the things they've done… please help."),
            ccb.content.text("Aren't you a little short to be a stormtrooper?"),
            ccb.content.text("Please, help me."),
            ccb.content.text("Can you get me out of this hell hole?"),
            ccb.content.text("Who are you?  Are you real?"),
            ccb.content.text("Can you please save me?  I have to get out of here."),
            ccb.content.text("Hallelujah, rescue!"),
            ccb.content.text("I can't believe my eyes.  Thank you, thank you!"),
            ccb.content.text("You're… you're actually real!"),
            ccb.content.gendered_line("How are you here?  Are you one of them, somehow?  What's going on?", { "speaker" }),
        },
    },
    replies = {
        {
            text = ccb.content.text("Come with me, if you want to live."),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
            opinion = { trust = 4, value = 4, fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("I've no use for weaklings.  Run.  Now."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
        },
    },
}
