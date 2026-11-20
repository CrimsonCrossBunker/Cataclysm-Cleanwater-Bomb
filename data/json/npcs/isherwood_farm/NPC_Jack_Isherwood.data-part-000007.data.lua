local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JACK_1",
    name = ccb.content.text("Find 10 3 L jars"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "jar_3l_glass_sealed",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_JACK_2",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "veggy_pickled", count = 12, container = "jar_3l_glass_sealed" } } },
    dialogue = {
        describe = ccb.content.text("I could use some help scavenging."),
        offer = ccb.content.text("We could use some 3 liter jars to preserve our produce.  Can you bring me 10 large three liter jars?  I'll give you some preserves in exchange."),
        accepted = ccb.content.text("Thank you.  It's important to preserve foods while we can."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another way, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Thanks.  Here's your reward."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the jars went…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JACK_2",
    name = ccb.content.text("Find 100 wheat seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "seed_wheat",
    item_count = 100,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        handler = "mark_u_did_jack_missions",
        item_rewards = {
            { item = "tomato", count = 25 },
            { item = "onion", count = 25 },
            { item = "cucumber", count = 25 },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some more scavenging for you."),
        offer = ccb.content.text("We could use some seeds for the next planting season.  Can you bring me 100 wheat seeds?  I'll give you some fresh produce."),
        accepted = ccb.content.text("Thank you.  It's important to preserve healthy foods while we can."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another supplier, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Thanks.  Here's your reward."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the seeds went…"),
    },
}
