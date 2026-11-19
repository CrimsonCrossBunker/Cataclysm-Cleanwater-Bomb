local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_WHO",
    line = ccb.content.gendered_line("I worked here before <the_cataclysm> dumped everything in the <freaking> bin.  I took care of all the animals here, and when the <zombies> started roaming the streets, I gathered every pet or stray I could.  I still take care of them, just gotta worry about the <zombies> now on top of disease, cleanliness, etc.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("That's quite noble of you, but how do you take care of so many animals?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_PETS",
        },
        {
            text = ccb.content.text("Wanna buy something, maybe sell off what you don't need?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_PETS",
    line = ccb.content.text("To be honest with you, it's been pretty difficult.  I sneak out at night or whenever there's an opening to grab whatever I need and come back before something notices me.  I've been held up for quite a while whenever a horde decides to pass by.  Good thing we had some spare bookcases lying around, or I'd be a goner by now."),
    replies = {
        {
            text = ccb.content.text("Interesting."),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text("Wanna buy something, maybe sell off what you don't need?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
