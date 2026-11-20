local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_GET_GUITAR_STRING",
    name = ccb.content.text("Obtain a guitar string"),
    description = ccb.content.text("Find a length of tempered steel wire to be used as a guitar string."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "qt_wire",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need a new guitar string."),
        offer = ccb.content.text("One of my guitar strings busted from where I smacked a zombie.  If you could get me a new string, I can fix my guitar."),
        accepted = ccb.content.text("Thanks.  I'll give you a performance when you get back with it."),
        rejected = ccb.content.text("I guess I'll just skip that note."),
        advice = ccb.content.text("I read that musical wire is made of tempered steel.  Music shops should have some, or you could take apart a piano."),
        inquire = ccb.content.text("Do you have it?"),
        success = ccb.content.text("Thank you so much!  This should last for a while."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, I'll do it myself."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = { { item = "icon", count = 1 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_sonia_guitar_fixed", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_WELL1",
    name = ccb.content.text("Well Construction"),
    description = ccb.content.text("Find eight pipes for Darryl Johnson."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "pipe",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_DARRYL_WELL2",
    dialogue = {
        describe = ccb.content.text("I need eight pipes to start construction."),
        offer = ccb.content.text("Now that's some enthusiasm, pal.  Ever since our water supply shut off, we've been using the nearby river for most of our water needs.  Who knows how many bloated corpses have decayed in that.  I want to construct a well, but I'm missing some building materials - eight pipes to be exact."),
        accepted = ccb.content.text("I wish you the best, pal.  I appreciate it."),
        rejected = ccb.content.text("Come back when you get a chance."),
        advice = ccb.content.text("Try disassembling some lockers.  Just don't destroy our furniture, we'll be needing it."),
        inquire = ccb.content.text("Well, do you have them?"),
        success = ccb.content.text("Great, I can finally start constructing this thing."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I guess it was just a pipe dream."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "godco_5",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_null", x = 15, y = 23 },
                        { shape = "point", operation = "terrain", id = "t_covered_well", x = 15, y = 23 },
                    },
                },
            },
        },
        item_rewards = { { item = "icon", count = 3 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_godco_darryl_mission1", "in-progress"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_WELL2",
    name = ccb.content.text("Water Pump Construction"),
    description = ccb.content.text("Find a mechanical pump for Darryl Johnson."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "well_pump",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_DARRYL_COOP1",
    dialogue = {
        describe = ccb.content.text("I need a mechanical pump to finish construction."),
        offer = ccb.content.text("It's less like a well, and more like a covered pit currently.  I'll need you to find a mechanical pump, one that will make this <freaking> thing work."),
        accepted = ccb.content.text("Take care of yourself out there."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Try disassembling another well."),
        inquire = ccb.content.text("Managed to find that pump?"),
        success = ccb.content.text("Much obliged, survivor.  Thanks to you, we don't need to worry about where our water's gonna come from.  Here, take this as a token of our gratitude."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "godco_5",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_water_pump", x = 15, y = 23 },
                    },
                },
            },
        },
        item_rewards = { { item = "icon", count = 5 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_godco_darryl_mission1", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}
