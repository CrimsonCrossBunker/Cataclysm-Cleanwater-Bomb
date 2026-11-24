local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "xe_vampire_mentor",
    suffix = ccb.content.text("vampire"),
    class = "NC_NPC_XE_VAMPIRE_MENTOR",
    attitude = 0,
    mission = "SHELTER",
    chat = "TALK_VAMPIRE_MENTOR",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_NPC_XE_VAMPIRE_MENTOR",
    name = ccb.content.text("Vampire Mentor"),
    job_description = ccb.content.text("An ancient vampire, willing to assist those who want to further their curse."),
    common = false,
    sells_belongings = false,
    skills = {
        { skill = "speech", bonus = { rng = { 3, 6 } } },
        { skill = "chemistry", bonus = { rng = { 2, 3 } } },
        { skill = "gun", bonus = { rng = { 2, 3 } } },
        { skill = "pistol", bonus = { rng = { 2, 3 } } },
        { skill = "rifle", bonus = { rng = { 2, 3 } } },
        { skill = "swimming", bonus = { rng = { 2, 3 } } },
        { skill = "firstaid", bonus = { rng = { 2, 3 } } },
        { skill = "cooking", bonus = { rng = { 2, 3 } } },
    },
    intelligence = { rng = { 2, 4 } },
    perception = { rng = { 2, 4 } },
    strength = { rng = { 2, 4 } },
    dexterity = { rng = { 2, 4 } },
    weapon = "EMPTY_GROUP",
    traits = {
        { group = "Appearance_demographics" },
        { group = "BG_survival_story_UNIVERSAL" },
        { group = "NPC_Vampire_Mentor_starting_traits" },
        { group = "trait_group_complete_vampire" },
        { trait = "MENTOR_PEACE", weight = 100 },
        { trait = "PSYCHOPATH", weight = 100 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_MENTOR",
    line = {
        when = predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }),
        yes = ccb.content.text("Sorry I must go.  Bye!"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_mentor" } }),
            yes = {
                choices = {
                    ccb.content.text("Welcome back."),
                    ccb.content.text("Hello again."),
                },
            },
            no = ccb.content.text("Welcome.  What do you seek here?  Fortune?  Safety?  A friend?  A mentor?  What brought you here?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I want to talk."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I want a mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I want to kill vampires."),
            next_topic = "TALK_VAMPIRE_MENTOR_KILLING",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("I've done it.  I am now a true vampire."),
            next_topic = "TALK_VAMPIRE_MENTOR_TRUEVAMP",
            when = predicates.all({ predicates.has_trait("speaker", "VAMPIRE4"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "told_about_trueness" } })), predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) }),
            actions = { actions.set_actor_value("speaker", "told_about_trueness", "yes") },
        },
        {
            text = ccb.content.text("Before, you said there was more that I needed to learn?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH",
            when = predicates.handler("dlg_p_xedra_evolved_35cc231b3499"),
        },
        {
            text = ccb.content.text("I've lost the book you gave me.  Do you have another?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BOOK_NEED_NEW",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "received_mentor_book" } }), predicates.negate(predicates.has_item("speaker", "vampire_mentor_book")), predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) }),
        },
        {
            text = ccb.content.text("I have brought back the components you need for the ritual."),
            next_topic = "TALK_VAMPIRE_MENTOR_MAKE_TIER_5",
            when = predicates.all({ predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"), predicates.has_item("speaker", "stormwrought_blood_charged"), predicates.has_inventory("speaker", "concentrated_underhill_essence", 400), predicates.has_item("speaker", "dream_drainer_heart"), predicates.has_item("speaker", "moonstruck_pearl"), predicates.has_item("speaker", "abyssal_hunger_shard") }),
            actions = { actions.transfer_items("stormwrought_blood_charged"), actions.transfer_items("concentrated_underhill_essence", 400), actions.transfer_items("dream_drainer_heart"), actions.transfer_items("moonstruck_pearl"), actions.transfer_items("abyssal_hunger_shard") },
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }),
            actions = { actions.handler("dlg_a_xedra_evolved_aa606712f66b") },
        },
        {
            text = ccb.content.text("Do you want to chat for a bit?"),
            next_topic = "TALK_MENTOR_NO_CHAT",
            when = predicates.all({ predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })), predicates.has_trait("interlocutor", "PSYCHOPATH") }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("Do you want to chat for a bit?"),
            next_topic = "TALK_MENTOR_CHAT",
            when = predicates.all({ predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })), predicates.negate(predicates.has_trait("interlocutor", "PSYCHOPATH")) }),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_mentor", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_TALK" },
    line = ccb.content.text("What do you wish to discuss?"),
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_VAMPIRE_MENTOR_SELF" },
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_VAMPIRE_MENTOR_PLACE" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("What did you meant by \"mentor\"?"),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_MENTORING" },
    line = {
        when = predicates.has_effect("speaker", "vampire_virus"),
        yes = ccb.content.text("I can help you become a stronger vampire, if it is what you wish."),
        no = ccb.content.text("I can share with you the gift of vampirism, if it is what you wish."),
    },
    replies = {
        {
            text = ccb.content.text("I want to become a stronger vampire."),
            when = predicates.all({ predicates.has_effect("speaker", "vampire_virus"), predicates.negate(predicates.has_trait("speaker", "VAMPIRE4")) }),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_STRONGER",
        },
        {
            text = ccb.content.text("I want to become a stronger vampire."),
            when = predicates.all({ predicates.has_trait("speaker", "VAMPIRE4"), predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")), predicates.negate(predicates.has_trait("speaker", "BLOOD_DRINKER")) }),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER",
        },
        {
            text = ccb.content.text("I want to become a vampire."),
            when = predicates.negate(predicates.has_effect("speaker", "vampire_virus")),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_VAMPIRE",
        },
        {
            text = ccb.content.text("You already made me as strong as a vampire can be.  See you."),
            when = predicates.has_trait("speaker", "BLOOD_DRINKER"),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Maybe later.  Bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_KILLING" },
    line = ccb.content.text("There are many vampires in this place.  Feel free to kill the others, I am not affiliated with them."),
    replies = {
        {
            text = ccb.content.text("I'm here to kill all vampires, no exceptions.  Prepare to die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_53c17c81e090") },
        },
        {
            text = ccb.content.text("You seem more reasonable than the rest.  Would you like to be cured of your curse?"),
            next_topic = "TALK_VAMPIRE_MENTOR_CURE",
        },
        {
            text = ccb.content.text("It can wait.  Can we talk?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("It can wait.  Can we discuss what you meant by \"mentor\"?"),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SELF" },
    line = ccb.content.text("I am an old vampire, wishing to see more embrace and develop that gift."),
    replies = {
        { text = ccb.content.text("I want to talk."), next_topic = "TALK_VAMPIRE_MENTOR_TALK" },
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_VAMPIRE_MENTOR_PLACE" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_PLACE" },
    line = ccb.content.text("It's a safe place for the blood-drinkers.  Here, it's only them, their servants and their food.  And also those who wish to become blood-drinkers themselves."),
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_VAMPIRE_MENTOR_SELF" },
        { text = ccb.content.text("I want to talk."), next_topic = "TALK_VAMPIRE_MENTOR_TALK" },
        {
            text = ccb.content.text("Can I do something for you?"),
            next_topic = "TALK_VAMPIRE_MENTOR_ASSISTANCE",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_TRUEVAMP" },
    line = ccb.content.text("I am overjoyed that a new person decided to take their place as a new ruler of the night!  Soon, you'll be ready for the final step, the one that will allow you to fully walk the path!"),
    replies = {
        {
            text = ccb.content.text("I want to talk."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("Before, you said there was more that I needed to learn?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH",
            when = predicates.handler("dlg_p_xedra_evolved_69ebfe42166c"),
        },
        {
            text = ccb.content.text("Can you help me walk that path?"),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER",
        },
        {
            text = ccb.content.text("I just wanted to share the news.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH" },
    line = ccb.content.text("Yes.  The gifts of the blood are somewhat random, as are its curses.  But now that you have come into your true power, there are ways to expand your talents and to modify your weaknesses.  It will require a great deal of blood and time, but I can show you the way."),
    replies = {
        {
            text = ccb.content.text("Yes.  I want more power."),
            next_topic = "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH_LEARNED",
            actions = { actions.handler("dlg_a_xedra_evolved_644c819c1395") },
        },
        {
            text = ccb.content.text("Maybe later, but not now."),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BLOOD_GIFT_RESEARCH_LEARNED" },
    line = ccb.content.text("Concentrate on the blood and watch closely."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_14594555e665") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_VAMPIRE" },
    line = ccb.content.text("I can do it, if you truly want it.  I've seen that those who willingly become vampires are more likely to fully walk the path so I won't attempt to force you."),
    replies = {
        {
            text = ccb.content.text("I am sure.  Grant me vampirism."),
            actions = { actions.add_effect("speaker", "vampire_virus", { permanent = true, intensity = 1 }) },
            next_topic = "TALK_VAMPIRE_MENTOR_NEWVAMPIRE",
        },
        { text = ccb.content.text("Maybe later, but not now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_NEWVAMPIRE" },
    line = ccb.content.text("[Drains a significant portion of your blood and begins speaking to you before you black out] Here you go.  You might not notice the effects at first, but keep some human blood close for when your thirst will appear and some shelter for when the sun will start to burn your skin.  There are levels of vampiric power that cannot be achieved through time alone.  When you'll reach that point, come back here and I'll help you reach them.  [Slits its own wrist and lets you drink, as the blood hits your tongue it energizes you and washes away the dizziness of blood loss]"),
    replies = {
        {
            text = ccb.content.text("Can we talk about something else?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_STRONGER" },
    line = {
        when = predicates.has_trait("speaker", "VAMPIRE3"),
        yes = ccb.content.text("You are ready for the next step.  However, I must warn you: there is no coming back from that.  Your vampirism will become impossible to lose.  Do you wish to proceed?"),
        no = ccb.content.text("Your vampirism isn't potent enough.  Come back when your mortal hungers will begin to be replaced by immortal hungers.  They are the signs that your power increased enough to withstand what you'll gain from my help."),
    },
    replies = {
        {
            text = ccb.content.text("I am certain.  Make me more powerful."),
            when = predicates.has_trait("speaker", "VAMPIRE3"),
            next_topic = "TALK_VAMPIRE_MENTOR_POWER",
        },
        {
            text = ccb.content.text("I do not wish to be struck as a vampire forever."),
            when = predicates.has_trait("speaker", "VAMPIRE3"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Got it.  See you."),
            when = predicates.negate(predicates.has_trait("speaker", "VAMPIRE3")),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER" },
    line = {
        when = predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"),
        yes = ccb.content.text("I cannot assist you until you bring back the components.  How is the search going?"),
        no = ccb.content.text("You are now ready to fully walk the path.  This time, you'll need to gather a few components before the ritual can be done.  I'll give you this book so you know what to look for."),
    },
    replies = {
        {
            text = ccb.content.text("I'll begin the search then."),
            next_topic = "TALK_VAMPIRE_MENTOR_GATHER_TIER_5",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
            actions = { actions.handler("dlg_a_xedra_evolved_ce0106b73c6d"), actions.set_actor_value("speaker", "received_mentor_book", "yes"), actions.assign_mission("GET_COMPONENTS_FOR_TIER_5") },
        },
        {
            text = ccb.content.text("A book?  You said I would only need a few components!"),
            next_topic = "TALK_VAMPIRE_MENTOR_WHY_BOOK",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
        },
        {
            text = ccb.content.text("It's progressing.  See you."),
            next_topic = "TALK_DONE",
            when = predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"),
        },
        {
            text = ccb.content.text("It'll wait for now.  See you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_POWER" },
    line = ccb.content.text("It's not something I do, it's something you'll do.  I know it'll be asking a lot from you, but I hope you'll understand why we are doing it."),
    replies = {
        { text = ccb.content.text("What is it?"), next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE" },
        { text = ccb.content.text("Don't tell me.  I'm going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE" },
    line = ccb.content.text("To become a true vampire, you must kill someone that cherishes you with your own hands.  It might be hard to bear at first, but with time you'll see how much it was worth it."),
    replies = {
        {
            text = ccb.content.text("That's all?"),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_1",
        },
        {
            text = ccb.content.text("I'll do it, if it what it takes."),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_2",
        },
        {
            text = ccb.content.text("[Uncaring] Make someone love me and then kill them in return for immortality and power?  What's the downside?"),
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_1",
            when = predicates.has_trait("speaker", "PSYCHOPATH"),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
        },
        {
            text = ccb.content.text("[Pacifist] That's monstrous, of course I won't do that!"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "PACIFIST"),
        },
        { text = ccb.content.text("I'm not doing that.  Bye."), next_topic = "TALK_DONE" },
    },
}

-- Note: the part about the kill being in melee only is due to bug #72281.  Remove it when the bug gets fixed
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE_1" },
    line = ccb.content.text("They need to be completely trusting of you, someone that consider themselves your \"best friend forever\".  They also need to declare how much they love you right before you kill them, then you'll become a true vampire.  And I almost forgot: you also need to kill them in melee combat or else it won't work.\n\nAnd when you are done, return to me.  There is more that you must learn."),
    replies = { { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" } },
}

-- Note: the part about the kill being in melee only is due to bug #72281.  Remove it when the bug gets fixed
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE_2" },
    line = ccb.content.text("Do not worry about the pain, my friend.  It is always temporary, no matter how much it hurts.  After that, you won't ever be temporary again.  Keep in mind that they need to be completely trusting of you, someone that consider themselves your \"best friend forever\".  They also need to declare how much they love you right before you kill them, then you'll be freed from your limited time as you become a true vampire.  And I almost forgot: you also need to kill them in melee combat or else it won't work.\n\nAnd when you are done, return to me.  There is more that you must learn."),
    replies = { { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_GATHER_TIER_5" },
    line = ccb.content.text("Here's the book.  It contains everything you need to know about the components you need to acquire.  Be sure to read it thoroughly as the rituals have very specific conditions to be accomplished.  Come back here when you'll have them all and you will fully walk the path."),
    replies = {
        {
            text = ccb.content.text("Thank you.  I'll bring back these components."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WHY_BOOK" },
    line = ccb.content.text("This book contains the rituals allowing to obtain the components.  Each of them requires a complicated process to get.  I'm giving you this book so you won't come back asking for more information every two hours."),
    replies = {
        {
            text = ccb.content.text("I'll begin the search then."),
            next_topic = "TALK_VAMPIRE_MENTOR_GATHER_TIER_5",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
            actions = { actions.handler("dlg_a_xedra_evolved_ce0106b73c6d"), actions.set_actor_value("speaker", "received_mentor_book", "yes"), actions.assign_mission("GET_COMPONENTS_FOR_TIER_5") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BOOK_NEED_NEW" },
    line = ccb.content.text("I do have another copy, however you'll have to buy it at a steep price.  Each of these are written by hand these days so we can't let people treat them like disposable things."),
    replies = {
        {
            text = ccb.content.text("[$100] I'll buy the book."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_c6ce859e7ff1") },
        },
        {
            text = ccb.content.text("We?"),
            next_topic = "TALK_VAMPIRE_MENTOR_WE",
        },
        {
            text = ccb.content.text("I'll come back later for that.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

-- the lore is that a bunch of vampires decided to try and make becoming a true vampire as accessible as possible.  Some of them are doing it out of wanting to help new vampires, most are in to make many powerful vampires to fight the hunters, a few have other motivations.  This lore isn't communicated to the player.
ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WE" },
    line = ccb.content.text("I'm not the only vampire looking to assist others on the path.  We wrote this book together and occasionally meet to update and refine it, all in the goal of helping new vampires reach their true potential as easily as possible."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Where are these other mentors?"),
            next_topic = "TALK_VAMPIRE_MENTOR_WE_WHERE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WE_WHERE" },
    line = ccb.content.text("I do not know of their whereabouts.  All what matters is that we know where to meet, but with the end of the world all meetings has been postponed indefinitely."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECAME_TIER_5" },
    line = ccb.content.text("You have now reached the apex of the vampiric condition and do not need further guidance.  Go forth and claim your title and crown of ruler of the night!  Make it clear that you are the one on the throne!"),
    replies = { { text = ccb.content.text("Got it.  Farewell, my friend."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_CURE" },
    line = ccb.content.text("No.  I've long passed the point of no return.  Either your cure won't do anything, or it'll kill me."),
    replies = {
        {
            text = ccb.content.text("Then you must die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_5c384dab2f0a") },
        },
        {
            text = ccb.content.text("I understand.  Can we talk?"),
            next_topic = "TALK_VAMPIRE_MENTOR_TALK",
        },
        {
            text = ccb.content.text("I just wanted to look around.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_ASSISTANCE" },
    line = ccb.content.text("No thanks.  I am here to help others, not because I need help."),
    replies = {
        {
            text = ccb.content.text("Then I'd like your help as a mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("Then I'd like your help as a vampire slayer."),
            next_topic = "TALK_VAMPIRE_MENTOR_KILLING_HELP",
        },
        { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_KILLING_HELP" },
    line = ccb.content.text("No thanks.  I've decided long ago to never gamble my life for someone else's cause.  I prefer waiting on the side, helping those who want my help."),
    replies = {
        {
            text = ccb.content.text("I want your help, mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("Then you must die."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_xedra_evolved_0e28e28b2a89") },
        },
        {
            text = ccb.content.text("Got it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_MENTOR_NO_CHAT" },
    line = ccb.content.text("I do not care for such frivolous things."),
    replies = {
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("See you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MENTOR_CHAT",
    line = {
        choices = {
            {
            when = predicates.minimum_attribute("interlocutor", "intelligence", 8),
            yes = ccb.content.text("<insightfulchitchat>"),
            no = ccb.content.text("<thoughtfulchitchat>"),
        },
            {
            when = predicates.minimum_attribute("interlocutor", "perception", 8),
            yes = ccb.content.text("<insightfulchitchat>"),
            no = ccb.content.text("<thoughtfulchitchat>"),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_trait("speaker", "PSYCHOPATH")),
            actions = { "morale_chat_activity", actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }) },
            switch = true,
        },
        {
            text = ccb.content.text("<chitchat_player_responses>"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "PSYCHOPATH"),
            actions = { actions.handler("dlg_a_xedra_evolved_1a6836919060"), actions.add_effect("interlocutor", "asked_to_socialize", { turns = 7000 }) },
            switch = true,
        },
    },
}

ccb.content.define_mission {
    id = "KILL_YOUR_BEST_FRIEND",
    name = ccb.content.text("Kill your best friend"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Kill someone that is very close to you to push your vampirism further."),
        offer = ccb.content.text("If you wish to become a true vampire, you must sacrifice someone that really, really likes you."),
        accepted = ccb.content.text("It brings me joy to see someone willing to fully walk the path.  Remember, pain is always temporary, no matter how it hurts.  By this sacrifice, you won't ever be temporary again."),
        rejected = ccb.content.text("I understand.  Some never wanted to walk the path.  Such wasted potential."),
        advice = ccb.content.text("They need to be completely trusting of you, someone that thinks of themselves as your \"best friend forever\".  In addition, keep in mind that the sacrifice must be killed by none and nothing other than you, or else you'll have to find a new sacrifice."),
        inquire = ccb.content.text("Have you found someone that considers you the best person in the world?"),
        success = ccb.content.text("You visibly succeeded.  You should gain more vampiric aptitudes soon.  However, you haven't fully walked the path yet.  Give your powers some time to grow, come here again and I'll explain what to do to completely walk the path!"),
        success_lie = ccb.content.text("Either your vampirism isn't advanced enough, or you tried to bypass the sacrifice.  Either way, do that sacrifice."),
        failure = ccb.content.text("Someday you'll find a suitable sacrifice."),
    },
    complete_when = "complete_kill_your_best_friend",
}

ccb.content.define_mission {
    id = "GET_COMPONENTS_FOR_TIER_5",
    name = ccb.content.text("Find the components for the vampiric ritual"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 240,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Gather the components your book mention and bring them to your mentor."),
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
    complete_when = "complete_get_components_for_tier_5",
}
