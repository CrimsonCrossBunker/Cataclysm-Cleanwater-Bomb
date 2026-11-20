local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_5",
    name = ccb.content.text("In a Pickle"),
    description = ccb.content.text("Deliver 100 0.5 L glass jars to the Free Merchants to kickstart their food storage plans."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 400000,
    item = "jar_glass_sealed",
    item_count = 100,
    finish = {
        handler = "mark_mission_flag_FMShopkeep_Mission5",
        item_rewards = { { item = "FMCNote", count = 25 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("While we've managed to secure day to day food supplies, it's very much hand to mouth.  Our reserves would barely last a few days if something kept our people locked in.  We need a stockpile to avoid that.  Thanks to our outpost we have a bit of meat and vegetables coming in, but we need a better way to preserve them.  Some of our people know enough about food canning that if we had a good stock of canning jars, we could make pickles and canned meats to get us set for the winter.  I'll pay you a premium rate if you can bring us around a hundred jars to get us started."),
        accepted = ccb.content.text("It'll take a load off my shoulders if I can finally stop worrying about this."),
        rejected = ccb.content.text("We'll hold for the moment, but I'll get an ulcer if I have to keep worrying.  If you reconsider let me know."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("That's one less thing to worry about.  Glad to have someone like you on our side.  Here's 25 merch, and the broker will buy any further glass jars you can find - at a reduced price, we can't keep up the premium rate.  Actually, the broker was saying they had some jobs like this for you, and that it might be easier to just go straight through their office if you want more work."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
