local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text_without_extraction("<greet>"),
        no = ccb.content.text("Finally, someone who isn't part of those <zombies>."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Yeah, today's your lucky day.  Hand over your stuff, or you'll be one yourself."),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("Hey, nice to meet you."),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text_without_extraction("<greet>"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Who are you, exactly?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_WHO",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Wanna buy something, maybe sell off what you don't need?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Could I buy one of your pets?"),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_BUY_PETS",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_BUY_PETS",
    line = ccb.content.text("I hate to see them go, but I think you'd be able to take better care of one than I can right now.  I can sell you a cat or dog of your choosing, for $25 and $50, respectively."),
    replies = {
        {
            text = ccb.content.text("I've changed my mind, let's talk about something else."),
            next_topic = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text("I'll have a dog."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "sold_pet")),
            actions = { actions.purchase_pet("mon_dog", { cost = 5000, pacified = true }), actions.add_effect("interlocutor", "sold_pet", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("I'll have a cat."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "sold_pet")),
            actions = { actions.purchase_pet("mon_cat", { cost = 2500, pacified = true }), actions.add_effect("interlocutor", "sold_pet", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
