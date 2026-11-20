local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_COOP1",
    name = ccb.content.text("Chicken Coop Construction"),
    description = ccb.content.text("Get 150 nails for Darryl."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "nail",
    item_count = 150,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I need nails to build a chicken coop"),
        offer = ccb.content.text("Now that we've got a steady supply of water, I've been thinking about raising some livestock.  I'm starting with some chickens I found on a farm the other day, but I don't have a coop for them.  If you can get me 150 nails, I can start building one."),
        accepted = ccb.content.text("Take care of yourself out there."),
        rejected = ccb.content.text("Its a simple job."),
        advice = ccb.content.text("You could take apart some furniture in town, or make them yourself."),
        inquire = ccb.content.text("Got the nails?"),
        success = ccb.content.text("Thank you.  I should have some eggs in a week, once I finish the coop.  Come back and buy some!"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { actions = { { handler = "start_godco_coop" }, { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
}
