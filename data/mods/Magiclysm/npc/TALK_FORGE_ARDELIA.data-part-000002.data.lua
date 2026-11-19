local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_LIBRARIAN",
    line = ccb.content.text("I keep Valzain's books.  There are many floors of bookshelves among his pocket dimensions, with more magic than a mortal mind like yours could comprehend.  These happen to be the ones I think it most likely he'll read soon.  I can sell some that we have extra copies of."),
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD_LIBRARIAN",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_LIBRARIAN_DOING",
        },
        {
            text = ccb.content.text("Do you have any more books in the back?"),
            next_topic = "TALK_FORGE_LIBRARIAN_ASK_INTERVAL",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LIBRARIAN_DOING",
    line = ccb.content.text("I organize the books, I sell extra books, back when we still lent books I would hunt down those with late books to return.  I have done this for aeons past and I will continue to do this for aeons to come."),
    replies = {
        {
            text = ccb.content.text("Let's talk business then."),
            next_topic = "TALK_FORGE_LORD_LIBRARIAN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LIBRARIAN_ASK_INTERVAL",
    line = ccb.content.text("It shouldn't take Valzain too long to read what he desires from what I have out.  Check back on <restock_time_point> and I should have some new books set out."),
    replies = { { text = ccb.content.text("Safe readings."), next_topic = "TALK_FORGE_LORD_LIBRARIAN" } },
}
