local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_5",
    name = ccb.content.text("Find Lab Tunnels"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "train_data",
    start = {
        target = {
            terrain = "underground_lab_cargo_stationA",
            special = "lab_mutagen_6_level",
            reveal_radius = 1,
            cant_see = true,
            z = -4,
        },
        item_rewards = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("In the data we found a major contract for tunneling and train equipment, ordered eight months ago.  It's the best lead we have.  Here's the address of the government lab where the equipment was delivered.  I want you to go there, find the tunnels that they dug, and download everything you can about the train network.  On the other hand, our sponsors were extremely impressed in getting this far without their direction, and would like to apologize by supporting this mission with a whole 300 merch!"),
        accepted = ccb.content.text("So glad for your help."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("The equipment was rated for 50 feet underground, so that tunnel entrance is going to be deeper inside a lab than a normal subway.  Fifty feet would mean maybe four stories down.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Fantastic!  I should be able to reconstruct what cargo moved between which labs.  I wonder what was really going on down there."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { item_rewards = { { item = "FMCNote", count = 300 } } },
}
