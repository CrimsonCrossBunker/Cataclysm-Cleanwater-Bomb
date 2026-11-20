local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_EDDIE_3",
    name = ccb.content.text("Gather 100 units of clay"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "clay_lump",
    item_count = 100,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "u_did_eddie_missions", "yes"),
            { item = "rope_6", count = 1 },
            ccb.content.dialogue_actions.purchase_pet("mon_cow", { count = 1, name = ccb.content.text("Daisy") }),
            { item = "cattlefodder", count = 3 },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some resource gathering I could use help if you have time."),
        offer = ccb.content.text("Now that the clay kiln is set up, we could use 100 units of clay to get production going."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I'll try to find time to get it myself, thanks."),
        advice = ccb.content.text("You can find it along river banks, or maybe look for deposits in the forest."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, now Luke can get started making jugs, We'd like to give you a cow, Here's Daisy, take good care of her and she'll provide you with milk."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the sand went…"),
    },
}
