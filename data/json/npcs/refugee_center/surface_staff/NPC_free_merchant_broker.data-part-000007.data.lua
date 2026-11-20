local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_BROKER_1",
    name = ccb.content.text("In a Pickle Pt. 2"),
    description = ccb.content.text("Deliver 50 large three-liter jars in exchange for <reward_count:FMCNote> certified notes."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "jar_3l_glass_sealed",
    item_count = 50,
    finish = {
        handler = "mark_mission_flag_FMBroker_Mission1",
        item_rewards = { { item = "FMCNote", count = 25 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some work for you."),
        offer = ccb.content.text("You heard right.  When you brought in those canning jars, it got us thinking about expanding our food storage from dehydrated to include cans.  We could use some larger jars though for big stock items.  Can you bring me 50 large three liter jars?  I'll pay you a Certified Note per two."),
        accepted = ccb.content.text("Thank you.  Once we get a cottage industry set up with some of our inhabitants, I'll be able to start buying these from you and other scavengers in smaller lots.  This should be enough to test out our equipment."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another supplier, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, that's a lot more jars than it sounded on paper.  Thanks.  Here's your payment."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the jars went…"),
    },
}
