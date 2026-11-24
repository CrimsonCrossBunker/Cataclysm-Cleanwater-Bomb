local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_MAGIC_BOOK",
    name = ccb.content.text("Retrieve The Tome of The Battle Mage"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 4,
    value = 250000,
    item = "magus_spellbook",
    start = {
        actions = {
            ccb.content.dialogue_actions.remove_items("interlocutor", "magus_spellbook"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_old_magus_npc_magus_book_done", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Where did I put that blasted…"),
        offer = ccb.content.text("I seem to have misplaced my book, The Tome of The Battle Mage.  That worthless apprentice probably stole it.  Bring it to me."),
        accepted = ccb.content.text("…What?  Oh you're still here.  Go find my book."),
        rejected = ccb.content.text("Just as useless as that apprentice…"),
        advice = ccb.content.text("You want me to do your job for you?  Bah.  That apprentice said something about wanting to look around town, you might start there.  Oh, and it's called The Tome of The Battle Mage, you can read at least the title, can't you?"),
        inquire = ccb.content.text("Where's my book?"),
        success = ccb.content.text("Finally.  Took you long enough."),
        success_lie = ccb.content.text("Nonsense!  Useless!  Waste of my time!"),
        failure = ccb.content.text("Ugh, why am I cursed with useless people?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_POWER_CBM",
    name = ccb.content.text("Find Power Storage CBM"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "bio_power_storage",
    start = {
        actions = {
            ccb.content.dialogue_actions.remove_items("interlocutor", "bio_power_storage"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = { item_rewards = { { item = "techno_fundamentals", count = 1 } } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("More power… moar power… MOAR POWAA!"),
        offer = ccb.content.text("I need more power.  Find me more power storage and I'll give you this book."),
        accepted = ccb.content.text("I don't care where it comes from so long as it's clean."),
        rejected = ccb.content.text("You want more power too, don't you?"),
        advice = ccb.content.text("Electronic Stores might have what I need.  Or you could just cut it out of something."),
        inquire = ccb.content.text("Find anything?"),
        success = ccb.content.text("Perfect.  More power… power…"),
        success_lie = ccb.content.text("I don't understand."),
        failure = ccb.content.text("I must find more power, this setback is inconvenient."),
    },
}

ccb.content.define_mission {
    id = "MISSION_PURGE_50_Z",
    name = ccb.content.text("Kill 50 Zombies"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 50,
    difficulty = 5,
    value = 250000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_PURGE_150_Z",
    dialogue = {
        describe = ccb.content.text("Will you answer the call?"),
        offer = ccb.content.text("This world has fallen to chaos and death.  Remove 50 of the cursed from this world; assist me in purging this curse and you shall be rewarded."),
        accepted = ccb.content.text("Blessed be.  I shall observe your efforts and judge you as one of the many or one of the few."),
        rejected = ccb.content.text("You will not help purge this curse?  Perhaps you are a part of the curse…"),
        advice = ccb.content.text("The awakened congregate in towns and cities, the closer to the center the more you will find."),
        inquire = ccb.content.text("Blessed be."),
        success = ccb.content.text("Blessed be.  You are one of the few.  We shall do great works together."),
        success_lie = ccb.content.text("Deception is the realm of the cursed.  You disappoint me."),
        failure = ccb.content.text("Was the curse too strong for you?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_PURGE_150_Z",
    name = ccb.content.text("Kill 150 Zombies"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 150,
    difficulty = 7,
    value = 250000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("You have proven you are one of the few, will you stand with the few again?"),
        offer = ccb.content.text("We must continue the purge.  Remove 150 more of the cursed from this land and you shall be blessed with greatness."),
        accepted = ccb.content.text("Blessed be. You are a true testament to the few."),
        rejected = ccb.content.text("I see.  Perhaps you will find your way back to us one day."),
        advice = ccb.content.text("The awakened stir in even the darkest of corners.  Seek them out and destroy them."),
        inquire = ccb.content.text("Blessed be."),
        success = ccb.content.text("Blessed be.  You are a valuable asset to our cause.  Perhaps you may even be our salvation."),
        success_lie = ccb.content.text("You have come so far.  Only to fall."),
        failure = ccb.content.text("The curse of this land infects that which does not seek to purge."),
    },
}
