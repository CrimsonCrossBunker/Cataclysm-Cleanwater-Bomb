local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_ACCOUNTING",
    name = ccb.content.text("Find Corporate Accounts"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 140000,
    item = "record_accounting",
    start = { reveal_terrain = "office_tower" },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_SAFE_BOX",
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("Our world fell apart because our leaders were as crooked as the con-men that paid for their elections.  Just find me one of those corporate accounting books and I'll show you and the rest of the world just who is at fault."),
        accepted = ccb.content.text("You'll see, I know I'm right."),
        rejected = ccb.content.text("I know it isn't pressing but the big corporations didn't get a chance to destroy the evidence yet."),
        advice = ccb.content.text("Try a big corporate building of some sort, they're bound to have an accounting department."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great, let's see… uh… hmmm….  Fine, I didn't even do my own taxes but I'm sure this will prove their guilt if we get an expert to examine it."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the corporations if it hasn't already."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_PATIENT",
    name = ccb.content.text("Find Patient Records"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 60000,
    item = "record_patient",
    start = { reveal_terrain = { "office_doctor", "hospital_2" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_REACH_FEMA_CAMP",
    dialogue = {
        describe = ccb.content.text("I hope I don't see many names I know…"),
        offer = ccb.content.text("I've lost so many friends… please find me a patient list from the regional hospital or doctor's office.  I just want to know who might still be out there."),
        accepted = ccb.content.text("Thank you, I suppose it won't change what has already happened but it will bring me closure."),
        rejected = ccb.content.text("Please, I just want to know what happened to everyone."),
        advice = ccb.content.text("I bet you'll run into a lot of those things in the hospital, please be careful."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Oh dear, I thought Timmy would have made it…"),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I bet some of them are still out there…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_WEATHER",
    name = ccb.content.text("Find Weather Log"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 50000,
    item = "record_weather",
    start = { reveal_terrain = "station_radio" },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("I wonder if a retreat might exist…"),
        offer = ccb.content.text("Everyone who dies gets back up, right?  Which means that whatever is causing this it must be airborne to have infected everyone.  I believe that if that is the case then there should be regions that were not downwind from where-ever the disease was released.  We need to find a record of all the weather patterns leading up to the outbreak."),
        accepted = ccb.content.text("Thanks so much, you may save both of us yet."),
        rejected = ccb.content.text("Ya, it was a long shot I admit."),
        advice = ccb.content.text("I'm not sure, maybe a news station would have what we are looking for?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("These look more complicated than I thought, just give me some time."),
        success_lie = ccb.content.text("This isn't what we need."),
        failure = ccb.content.text("If only we could find a great valley or something."),
    },
}
