local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- A generic guard for the campus faction.
ccb.content.define_npc {
    id = "great_library_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_CAMPUS_GUARD",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_CAMP_GUARD",
    faction = "the_great_library",
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_GUARD",
    line = {
        choices = {
            ccb.content.text("I'm not in charge here, you're looking for someone else…"),
            ccb.content.text("Stay alert, there's trouble in these woods."),
            ccb.content.text("Just on lookout, move along."),
            ccb.content.text("Don't distract me.  I'm on watch."),
            {
                when = predicates.conversation_state("daylight"),
                yes = { choices = { ccb.content.text("Hello.  Welcome to the library.") } },
                no = { choices = { ccb.content.text("Good evening.  Welcome to the library.") } },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How did you get stuck with guard duty?"),
            next_topic = "TALK_GUARD_CAMP_BACKGROUND",
        },
        { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" },
    },
}

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
