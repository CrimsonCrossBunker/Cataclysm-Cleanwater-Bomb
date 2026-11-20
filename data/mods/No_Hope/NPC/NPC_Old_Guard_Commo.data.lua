local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_2",
    name = ccb.content.text("Disable External Power"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 150000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I guess I could use your skills once again.  There are small transmitters located in the nearby evacuation shelters; if we don't separate them from the power grid their power systems will rapidly deteriorate over the next few weeks.  The task is rather simple but the shelters offer us a place to redirect refugees until this vault can be secured."),
        accepted = ccb.content.text("Thanks, I should be ready for you to install the radio repeater mods by the time you get back."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("Try searching on the outskirts of towns."),
        inquire = ccb.content.text("Have you had any luck severing the connection?"),
        success = ccb.content.text("We are good to go!  The last of the gear is powering up now."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_3",
    name = ccb.content.text("Install Repeater Mod"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 300000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Most of my essential gear has been brought back online so it is time for you to install your first radio repeater mod.  Head topside and locate the nearest radio station.  Install the mod on the backup terminal and return to me so that I can verify that everything was successful.  Radio towers must unfortunately be ignored for now, without a dedicated emergency power system they won't be useful for some time."),
        accepted = ccb.content.text("I'll be standing by down here once you are done."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("If you could make some sort of directional antenna, it might help locating the radio stations."),
        inquire = ccb.content.text("Have you had any luck finding a radio station?"),
        success = ccb.content.text("That's one down."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_4",
    name = ccb.content.text("Install Repeater Mod"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 350000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I could always use you to put another repeater mod up.  I don't have to remind you but every one that goes up extends our response area just a little bit more.  With enough of them we'll be able to maintain communication with anyone in the region."),
        accepted = ccb.content.text("I'll be standing by."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("Getting a working vehicle is going to become important as the distance you have to travel increases."),
        inquire = ccb.content.text("Have you had any luck finding a radio station?"),
        success = ccb.content.text("I'll try and update the captain with any signals that I need investigated."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
