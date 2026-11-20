local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_ZOMBIE_BLOOD_ANAL",
    name = ccb.content.text("Analyze Zombie Blood"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 8,
    value = 250000,
    item = "software_blood_data",
    start = {
        target = { terrain = "hospital_2", special = "hospital", reveal_radius = 3 },
        item_rewards = { { item = "vacutainer" }, { item = "usb_drive" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("It could be very informative to perform an analysis of zombie blood…"),
        offer = ccb.content.text("I need someone to get a sample of zombie blood, take it to a hospital, and perform a centrifuge analysis of it."),
        accepted = ccb.content.text("Excellent.  Take this blood draw kit; once you've produced a zombie corpse, use it to extract blood from the body, then take it to a hospital for analysis."),
        rejected = ccb.content.text("Are you sure?  The scientific value of that blood data could be priceless…"),
        advice = ccb.content.text("The centrifuge is a bit technical; you might want to study up on the usage of computers before completing that part."),
        inquire = ccb.content.text("Well, do you have the data yet?"),
        success = ccb.content.text("Excellent!  This may be the key to removing the infection."),
        success_lie = ccb.content.text("Wait, you couldn't possibly have the data!  Liar!"),
        failure = ccb.content.text("What a shame, that data could have proved invaluable…"),
    },
}
