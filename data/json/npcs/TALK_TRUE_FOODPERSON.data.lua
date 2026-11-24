local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TRUE_FOODPERSON",
    line = {
        when = predicates.wears("speaker", "foodperson_mask"),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } }),
                yes = ccb.content.text("Greetings friend, it's nice to see you."),
                no = ccb.content.gendered_line("So you're back… explain yourself!", { "speaker" }),
            },
            no = ccb.content.text("What sorcery is this?"),
        },
        no = {
            when = predicates.wears("speaker", "foodkid_badge"),
            yes = ccb.content.text("Welcome home Foodkid!"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_npc_foodperson_impressed" } }),
                yes = ccb.content.text("Greetings friend, it's nice to see you."),
                no = {
                    when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }),
                    yes = ccb.content.text("Still here?  Take your time, it's rough out there."),
                    no = ccb.content.text("Greeting citizen, what brings you to the FoodLair?"),
                },
            },
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_foodperson_foodperson_has_talked", "yes"),
            },
        },
    },
    replies = {
        {
            when = predicates.any({ predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } }), predicates.negate(predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") })) }), predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } }), predicates.any({ predicates.has_trait("speaker", "PROF_FOODP"), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }) }) }),
            text = ccb.content.text("Hey.  Let's chat for a second."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_has_talked" } })), predicates.all({ predicates.negate(predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") })), predicates.negate(predicates.wears("speaker", "foodkid_badge")) }) }),
            text = ccb.content.text("Greetings… Foodperson?"),
            next_topic = "TALK_FOODPERSON_INTRODUCTION",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }) }),
            text = ccb.content.text("I am you but from an alternate reality."),
            trial = {
                kind = "lie",
                difficulty = 10,
                modifiers = { { score = "TRUST", scale = 1 }, { score = "VALUE", scale = 1 } },
            },
            success = { next_topic = "TALK_FOODPERSON_MULTIVERSE", opinion = { trust = 2, value = 2 } },
            failure = { next_topic = "TALK_FOODPERSON_ONLYONE", opinion = { trust = -5, value = -5 } },
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.has_trait("speaker", "PROF_FOODP") }),
            text = ccb.content.text("I am Foodperson, who are YOU?"),
            next_topic = "TALK_FOODPERSON_TWO",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.has_trait("speaker", "PROF_FOODP") }),
            text = ccb.content.text("There is only one real Foodperson!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        {
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_foodperson_foodperson_meeting_solved" } })), predicates.any({ predicates.wears("speaker", "foodperson_mask"), predicates.wears("speaker", "foodperson_mask_on") }), predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")) }),
            text = ccb.content.text("I am the REAL Foodperson!"),
            next_topic = "TALK_FOODPERSON_ONLYONE",
        },
        {
            text = ccb.content.text("So, you are a REAL FOODPERSON, right?  You know my <name_g> over there?  You know that you ruined his legacy?"),
            when = predicates.has_mission("MISSION_pizzaiolo_2"),
            next_topic = "TALK_TRUE_FOODPERSON_pizzaiolo",
        },
        {
            text = ccb.content.text("Nevermind me, I'm just going to leave."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_INTRODUCTION",
    line = ccb.content.gendered_line("Indeed it is I!  The one and only FOODPERSON!", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Wow!  Such an honor to meet you in person!"),
            next_topic = "TALK_FOODPERSON_MAIN",
            opinion = { trust = 1, value = 1 },
        },
        {
            text = ccb.content.text("Are you joking?  Foodperson is not real, it's a restaurant mascot!"),
            opinion = { trust = -1, value = -1 },
            next_topic = "TALK_FOODPERSON_DOUBTED",
        },
        {
            text = ccb.content.text("The great Foodperson in the flesh!  Such an honor to finally meet you in person!"),
            trial = {
                kind = "lie",
                difficulty = 60,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 2 } },
            },
            success = { next_topic = "TALK_FOODPERSON_MAIN", opinion = { trust = 2, value = 2 } },
            failure = { next_topic = "TALK_FOODPERSON_VEXED", opinion = { trust = -5, value = -5 } },
        },
        {
            text = ccb.content.text("Ah… well, nice to meet you Foodperson."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_VEXED",
    line = ccb.content.text("Do not mock me, for my strength is quite real!  Get out of here now!"),
    replies = {
        { text = ccb.content.text("Sheesh, ok, calm down, I'm leaving!"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Forgive me, I didn't mean to disrespect you."),
            next_topic = "TALK_FOODPERSON_MAIN",
        },
        {
            text = ccb.content.text("Oh yeah?  Show me what you can do!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_DOUBTED",
    line = ccb.content.text("A common mistake, but I can assure you that I'm very real!"),
    replies = {
        { text = ccb.content.text("Sure, whatever."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Ok… I believe you."), next_topic = "TALK_FOODPERSON_MAIN" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_TEAMUP",
    line = ccb.content.text("It's crazy out there, it's going to be a tough journey but I'm with you!"),
    replies = {
        {
            text = ccb.content.text("Let's go, we have a world to save!"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
            opinion = { trust = 20, value = 20 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_ONLYONE",
    line = ccb.content.text("There can be only one!"),
    replies = {
        {
            text = ccb.content.text("I AM THE ONE!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
        },
        {
            when = predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")),
            text = ccb.content.text("Wow, calm down, it's just a prank bro."),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
        },
        {
            when = predicates.has_trait("speaker", "PROF_FOODP"),
            text = ccb.content.text("WAIT!  There might be another way!"),
            next_topic = "TALK_NONE",
        },
        {
            when = predicates.has_trait("speaker", "PROF_FOODP"),
            text = ccb.content.text("I don't want to fight you.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRUE_FOODPERSON_pizzaiolo",
    line = ccb.content.text("Umm, I'm not sure I'm following you…"),
    replies = {
        {
            text = ccb.content.text("You know what, <name_b>, I don't want to talk to you anymore.  <kill_npc> <name_b>!"),
            next_topic = "TALK_DONE",
            native_actions = { "insult_combat" },
        },
    },
}
