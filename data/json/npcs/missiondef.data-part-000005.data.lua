local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_SOFTWARE",
    name = ccb.content.text("Retrieve Software"),
    description = ccb.content.text("Retrieve the software in their computer marked on your map."),
    goal = "MGOAL_FIND_ANY_ITEM",
    difficulty = 2,
    value = 80000,
    place = "near_town",
    start = "place_npc_software",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I can't believe I forgot to download it…"),
        offer = ccb.content.text("There's some important software on my computer that I need on USB."),
        accepted = ccb.content.text("Thanks!  Just pull the data onto this USB drive and bring it to me."),
        rejected = ccb.content.text("Seriously?  It's an easy job…"),
        advice = ccb.content.text("Take this USB drive.  Use the console, and download the software."),
        inquire = ccb.content.text("So, do you have my software yet?"),
        success = ccb.content.text("Excellent, thank you!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  All that work, down the drain…"),
    },
}
