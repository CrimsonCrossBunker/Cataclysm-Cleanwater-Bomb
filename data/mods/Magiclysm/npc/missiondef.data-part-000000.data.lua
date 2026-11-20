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
