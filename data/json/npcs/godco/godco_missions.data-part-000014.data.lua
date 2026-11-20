local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_4",
    name = ccb.content.text("Preservation of Sustenance"),
    description = ccb.content.text("Find five canning pots for Helena Misinter."),
    goal = "MGOAL_FIND_ITEM",
    item = "pot_canning",
    item_count = 5,
    difficulty = 5,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        before_rewards = "set_world_godco_has_canningpots_to_1",
        item_rewards = {
            { item = "icon", count = 30 },
            { item = "pickled_egg", count = 10, container = "jar_glass_sealed" },
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get five canning pots."),
        offer = ccb.content.text("While we are blessed with a bountiful stock, we need a way to preserve our newer food, mainly those potatoes Darryl's growing.  Fortunately, he brought a book on canning things.  We need five canning pots to get the setup going in full fashion."),
        accepted = ccb.content.text("May the Lord bless you."),
        rejected = ccb.content.text("I'll find someone else, then."),
        advice = ccb.content.text("An old factory might have one, or a hobby shop."),
        inquire = ccb.content.text("Have you found the canning pots?"),
        success = ccb.content.text("Thank you.  You're welcome to some of our first batch, if you're interested."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("As expected of such a person…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_VISIT_MERCHANTS",
    name = ccb.content.text("Investigate the Center"),
    description = ccb.content.text("Go to the location Helena told you about and see who's there."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    start = "reveal_refugee_center",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        before_rewards = "set_world_godco_met_merchants_to_0",
        item_rewards = { { item = "icon", count = 5 } },
        handler = "wait_half_hour",
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("See who's over there."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("What have you found out?"),
        success = ccb.content.text("This should be very useful to us.  Now we can truly begin our march of righteousness."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("As expected of such a person…"),
    },
    complete_when = "complete_mission_godco_helena_visit_merchants",
}
