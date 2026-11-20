local ccb = require("ccb")

-- Enough pebbles for 28 planters.
ccb.content.define_mission {
    id = "MISSION_GODCO_KOSTAS_2",
    name = ccb.content.text("Pebble Pusher"),
    description = ccb.content.text("Get 814 pounds of pebbles (5,600 pebbles) for Kostas."),
    goal = "MGOAL_FIND_ITEM",
    item = "pebble",
    item_count = 5600,
    difficulty = 5,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +2).
    finish = { actions = { { item = "icon", count = 120 }, { handler = "start_godco_garden" } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_KOSTAS_3",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 5,600 pebbles."),
        offer = ccb.content.text("Demand for my herbal medicine has gone up recently, and I'm struggling to get all of my ingredients sustainably.  I'm going to build some planters on the rooftop, but I lack the material to do so in full.  I'd compensate you fairly for 814 pounds of pebbles."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("I understand that it seems formidable, but there is a good deal of money for you."),
        advice = ccb.content.text("An outdoor emporium should have some.  Of course, you could always dig them up from a lakeshore or driveway."),
        inquire = ccb.content.text("Do you have the pebbles?"),
        success = ccb.content.text("Blessings be unto you.  I'll start on the garden right away."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
