local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY1",
    name = ccb.content.text("Trophy Hunt I"),
    description = ccb.content.text("Help Russell Connelly expand his trophy collection by gathering three hunks of slime glob."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "slimepit_z0", special = "Slime Pit", reveal_radius = 3 } },
    item = "slime_scrap",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_RUSSELL_TROPHY2",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("I have the location for an alien crash site.  I want you to investigate and bring me anything you'd find interesting."),
        accepted = ccb.content.text("Good luck out there!"),
        rejected = ccb.content.text("That's all right.  Not everyone is cut out for this."),
        advice = ccb.content.text("Worst case scenario you'll be covered in slime.  There's nothing to fear, I hope."),
        inquire = ccb.content.text("Any luck, survivor?"),
        success = ccb.content.text("Good one!  Survivor, you have just passed my test.  I knew you could do it.  Your work shall be rewarded!"),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 4 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}
