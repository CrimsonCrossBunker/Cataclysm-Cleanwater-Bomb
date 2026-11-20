local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_1",
    name = ccb.content.text("Gather 120 Rocks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "rock",
    item_count = 120,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_EDDIE_2",
    dialogue = {
        describe = ccb.content.text("We need to build some kilns."),
        offer = ccb.content.text("I could use 120 rocks to construct some kilns."),
        accepted = ccb.content.text("You can break up some larger stones, or gather them up from the fields."),
        rejected = ccb.content.text("Thanks anyway, we'll find the time to get them ourselves."),
        advice = ccb.content.text("Mining would always be an option if you had the resources."),
        inquire = ccb.content.text("Do you have the stone?"),
        success = ccb.content.text("I appreciate it, this will make Luke happy."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    nested = { { x = 0, y = 0, id = "isherwood_outbuilding_kilns" } },
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 8, y = 13 },
                        { shape = "point", operation = "furniture", id = "f_forge_rock", x = 9, y = 6 },
                        { shape = "point", operation = "furniture", id = "f_clay_kiln", x = 7, y = 6 },
                    },
                },
            },
        },
        item_rewards = {
            { item = "meat_smoked", count = 12 },
            { item = "milk", count = 12, container = "jar_3l_glass_sealed" },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_2",
    name = ccb.content.text("Gather 2000 units of sand"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "material_sand",
    item_count = 2000,
    followup = "MISSION_ISHERWOOD_EDDIE_3",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = {
            { item = "butter", count = 6 },
            { item = "milk", count = 12, container = "jar_3l_glass_sealed" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some resource gathering I could use help with."),
        offer = ccb.content.text("Now that the forge is set up, we could use 2000 units of sand to get production going."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I'll try to find time to get it myself, thanks."),
        advice = ccb.content.text("You can find it along river banks, or maybe landscaping supplies and hardware stores."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, now Luke can get started.  Here's a token of my thanks."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the sand went…"),
    },
}
