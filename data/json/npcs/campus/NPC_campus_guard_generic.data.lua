local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUARD_CAMP_BACKGROUND",
    line = {
        choices = {
            ccb.content.text("Everybody left has to take a turn.  I guess it's fair but not everyone is really suited for beating up zombies or whatever."),
            ccb.content.gendered_line("I'm not even supposed to be here today, I just lost a bet and had to take this shift.", { "interlocutor" }),
            ccb.content.gendered_line("I should be resting right now, this is my third straight shift.  Too many people sick or hurt right now.", { "interlocutor" }),
            ccb.content.text("I live for this stuff.  I'm not really big on books, so this is probably what I'm best at here."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
