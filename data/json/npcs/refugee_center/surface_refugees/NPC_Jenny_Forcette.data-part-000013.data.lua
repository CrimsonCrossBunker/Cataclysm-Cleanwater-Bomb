local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
    name = ccb.content.text("Find reference material about air rifles for Jenny."),
    description = ccb.content.text("Find reference material about air rifles.  <color_yellow>A book that has 'Pneumatic' in its name</color> could be the thing she wants.  She probably wants a physical copy, if I can find it. "),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "book_pneumatics",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        offer = ccb.content.text("If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        accepted = ccb.content.text("Great!  Bring it to me if you find one."),
        rejected = ccb.content.text("Oh well.  Thanks anyway."),
        advice = ccb.content.text("Honestly I don't even have a search engine to find the name of a good book.  It's the air compression part I need to know about, gun books won't help much."),
        inquire = ccb.content.text("Any sign of an air rifle book I can use?"),
        success = ccb.content.text("That's exactly what I need!  Here, I saved a few merch for you, I hope this helps cover your troubles."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 4 } },
        handler = "set_Jenny_pneumatics_to_mission_complete",
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_MOTOR",
    name = ccb.content.text("Find an electric motor"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "motor",
    followup = "MISSION_REFUGEE_Jenny_GET_TANK",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Yeah, if you want to risk your neck out there and bring me what I need, I'm not gonna say no.  I can't, like, pay you or anything though, you know that right?"),
        offer = ccb.content.text("Before I get anything going, I'm going to need to set up a compressor.  I have a lot of the stuff for that, but I need a large tank for air, and a good sized electric motor - about 10 kg or so.  I'm also going to need a 60 liter tank, after that."),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("Try a basic hybrid car, or maybe farm equipment that uses an electric motor.  The kind on a bike would be too small, and the kind on those fancy Edison sports cars is going to be too big."),
        inquire = ccb.content.text("Any sign of a motor I can use?"),
        success = ccb.content.text("That's exactly what I need!  Want to talk about that tank now?  I saved a few merch for you, by the way."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 4 } },
        handler = {
            "mark_mission_completed_Jenny_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_TANK",
    name = ccb.content.text("Bring back a 60 L metal tank"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "metal_tank",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Jenny_GET_TEXT",
    dialogue = {
        describe = ccb.content.text("Now that I've got that motor, I can get my compressor mostly built.  I will need a tank though."),
        offer = ccb.content.text("I can get started building the compressor, but I need a large metal tank to store compressed air centrally.  About 60 liters should do…"),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("It needs to be a good strong tank, like a big propane tank or something… you could look at fuel storage tanks and things, as long as they're durable enough.  Heck, if you get some sheet metal you could probably even weld a good one together."),
        inquire = ccb.content.text("Any sign of a tank I can use?"),
        success = ccb.content.text("Hey, this is perfect, \"tanks\" a bunch.  Okay, I'm sorry for that.  Anyway, now that I've got the parts, I might be able to build a proof of concept.  First I gotta get this thing up and running, and argue with the bean counters about letting me draw power to run it.  Oh right, and here's some merch, thanks for the help!"),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought.  Back to the drawing board I guess."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Jenny_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}
