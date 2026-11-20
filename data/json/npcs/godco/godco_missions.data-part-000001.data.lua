local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_FOOD_GUARD_BETTER_FOOD_STORAGE",
    name = ccb.content.text("Store Up Your Grain"),
    description = ccb.content.text("Find 5,398 pounds of sheet metal (408 units) to help Eddie build a warehouse."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "sheet_metal",
    item_count = 408,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I'd like to have better food storage."),
        offer = ccb.content.text("I've been drawing up some plans to expand our food storage around here.  Now that we won't starve to death anytime soon, our old crates just aren't cutting it, so we're going to build a small warehouse to store everything, and I've gathered a crew to build it.  We've got most of the materials covered, but we don't have enough sheet metal to make the shelves.  If you could get us about 5,000 pounds of the stuff, I'll pay you handsomely with what we have.  How does that sound?"),
        accepted = ccb.content.text("Just bring it to me when you have it."),
        rejected = ccb.content.text("Alright, I'll find someone else."),
        advice = ccb.content.text("If you can find a steel mill, I'd look there."),
        inquire = ccb.content.text("Do you have the sheet metal?"),
        success = ccb.content.text("I can't thank you enough, here's the pay for it.  Here in a while, we'll have a spot to put all of our food."),
        success_lie = ccb.content.text("Alright, where's it all at?"),
        failure = ccb.content.text("Sorry, I had to find someone else since you didn't come through."),
    },
    -- Native mission phases did not apply the giver opinion (trust +7, value +6, anger -3).
    finish = { actions = { { handler = "start_godco_warehouse" }, { item = "icon", count = 175 } } },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
}
