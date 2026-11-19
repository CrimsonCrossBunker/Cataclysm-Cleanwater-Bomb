local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = {
            choices = {
                ccb.content.text("The government doesn't subsidize your purchases here anymore."),
                ccb.content.text("Do you have any tales of adventure I could write down?"),
                ccb.content.text("In case you were wondering, we no longer respect any pre-existing weapon laws."),
            },
        },
        no = {
            choices = {
                ccb.content.text("Welcome to the Forge of Wonders."),
                ccb.content.text("Here to trade, I hope?"),
                ccb.content.text("Bring me tales and we can trade."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_LORD_DOING",
        },
        {
            text = ccb.content.text("I have some stories for you."),
            next_topic = "TALK_FORGE_LORD_BOOKS_DELIVER",
        },
        {
            text = ccb.content.text("Anything interesting being worked on?"),
            next_topic = "TALK_FORGE_LORD_ASK_INTERVAL",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}
