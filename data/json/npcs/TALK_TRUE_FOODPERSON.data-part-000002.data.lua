local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_MAIN",
    line = ccb.content.text("Anyway, do you need something?"),
    replies = {
        {
            text = ccb.content.text("Are you interested in some trading?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_trade" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_trade" } })), predicates.negate(predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) })) }),
            trial = {
                kind = "persuade",
                difficulty = 50,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_FOODPERSON_TRADE" },
            failure = { next_topic = "TALK_FOODPERSON_NOTRADE" },
        },
        {
            text = ccb.content.text("Let's trade?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_trade" } })), predicates.any({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_trade" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodperson_impressed" } }), predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) }) }) }),
            actions = { "start_trade" },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm looking for a place to stay."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_shelter" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_shelter" } })), predicates.negate(predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) })) }),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_FOODPERSON_SHELTER" },
            failure = { next_topic = "TALK_FOODPERSON_NOSHELTER" },
        },
        {
            text = ccb.content.text("I want to get stronger.  Please teach me."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_training" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_training" } })), predicates.negate(predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) })) }),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_FOODPERSON_TRAINING" },
            failure = { next_topic = "TALK_FOODPERSON_NOTRAINING" },
        },
        {
            text = ccb.content.text("Please share your knowledge."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_training" } })), predicates.any({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_training" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodperson_impressed" } }), predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) }) }) }),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("I'm building up a team, people with special abilities."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_failed_team" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_success_team" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodperson_impressed" } })), predicates.negate(predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) })) }),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = {
                next_topic = "TALK_FOODPERSON_SIDEKICK",
                actions = {
                    actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_success_team_team", "yes"),
                },
            },
            failure = { next_topic = "TALK_FOODPERSON_SOLO" },
        },
        {
            text = ccb.content.text("Can you tell me again about this sidekick offer?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_sidekick_offer" } }), predicates.negate(predicates.assigned_missions(1, 1)) }),
            next_topic = "TALK_FOODPERSON_SIDEKICK",
        },
        {
            text = ccb.content.text("Alright, I thought about this, what do you say about we team up?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodpersons_sharing" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) }),
            next_topic = "TALK_FOODPERSON_TEAMUP",
        },
        { text = ccb.content.text("I'm good, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_NOTRADE",
    line = ccb.content.text("I already have everything I need here in the FoodLair!"),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_failed_trade", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_TRADE",
    line = ccb.content.text("Alright let's see what you've got."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_success_trade", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE", actions = { "start_trade" } } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_NOTRAINING",
    line = ccb.content.gendered_line("You're not ready for this.", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_failed_training", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("But I am worthy!"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_TRAINING",
    line = ccb.content.text("I can teach you a few tricks."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_success_training", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_TRAIN" },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_NOSHELTER",
    line = ccb.content.text("This is no place for a civilian.  You should go to the refugee center."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_failed_shelter", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Damn!"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_SHELTER",
    line = ccb.content.text("Well… You seem like a decent sort, I might have an offer for you."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_success_shelter", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("I'm listening."), next_topic = "TALK_FOODPERSON_SIDEKICK" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_SOLO",
    line = ccb.content.text("Sorry but I work alone."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_failed_team", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("We could really use your help!"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_SIDEKICK",
    line = ccb.content.gendered_line("What about: you prove your worth and join me as my sidekick?", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_sidekick_offer", "yes"),
            },
        },
    },
    replies = {
        {
            when = predicates.negate(predicates.assigned_missions(1, 1)),
            text = ccb.content.text("That sounds great!"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            when = predicates.negate(predicates.assigned_missions(1, 1)),
            text = ccb.content.text("Ok…"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            when = predicates.negate(predicates.assigned_missions(1, 1)),
            text = ccb.content.text("I need to think about it."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            when = predicates.negate(predicates.assigned_missions(1, 1)),
            text = ccb.content.text("Huh… no thanks."),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.assigned_missions(1, 1),
            text = ccb.content.text("There's other things I'd like to discuss."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            when = predicates.assigned_missions(1, 1),
            text = ccb.content.text("Alright bye."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_TWO",
    line = ccb.content.text("The way you talk, the way you move… You're… You're me?  But how?"),
    replies = {
        {
            text = ccb.content.text("I… I don't know.  It probably has something to do with <the_cataclysm>!  What do you say we team up to find out?"),
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_meeting_solved", "yes"),
            },
            next_topic = "TALK_FOODPERSON_TEAMUP",
        },
        {
            text = ccb.content.text("It might have something to do with <the_cataclysm>, mind if I stay here while we try to figure this out?"),
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_meeting_solved", "yes"),
            },
            next_topic = "TALK_FOODPERSON_SHARING",
        },
        {
            text = ccb.content.text("This can't be true, you're trying to trick me!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        { text = ccb.content.text("I need time to think."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_MULTIVERSE",
    line = ccb.content.text("Wha… but.  But… how?"),
    replies = {
        {
            text = ccb.content.text("No time to explain, the world is at an end and we must join forces to save it!"),
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_meeting_solved", "yes"),
            },
            next_topic = "TALK_FOODPERSON_TEAMUP",
        },
        {
            text = ccb.content.text("The Cataclysm weakened the space-time continuum, I accidentally fell through a tear in reality and ended up here.  I will need access to your resources to keep fighting."),
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_meeting_solved", "yes"),
            },
            next_topic = "TALK_FOODPERSON_SHARING",
        },
        {
            text = ccb.content.text("I am the ultimate Foodperson, I travel the multiverse consuming powers from all the Foodpersons.  And now I've come for you!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        {
            text = ccb.content.text("Can't tell you now.  In due time all will be revealed."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_SHARING",
    line = ccb.content.text("Of course, whatever you need… Foodperson."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_foodpersons_sharing", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thank you Foodperson!  It's good to know I have a friend here."),
            next_topic = "TALK_FOODPERSON_MAIN",
            opinion = { trust = 10, value = 10 },
        },
    },
}
