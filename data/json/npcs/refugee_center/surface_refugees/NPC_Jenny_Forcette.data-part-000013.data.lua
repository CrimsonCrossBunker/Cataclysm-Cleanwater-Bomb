local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Refugees2_Borichenko",
    line = {
        when = predicates.handler("dlg_p_dda_3b14879c9833"),
        yes = ccb.content.text("I didn't get to know Boris, Garry, and Stan so well for the first while.  They kinda kept to themselves.  Boris and Stan had just lost their son, you know.  It's pretty lucky that Garry was with them, he's Stan's little brother.  Together, they're a pretty good team.  I feel bad for thinking they were standoffish before.  They probably do the most to pull their weight around here whenever there's work to be done."),
        no = ccb.content.text("Boris and Stan are married, I guess.  They kinda keep to themselves, they seem a bit standoffish if you ask me.  Garry is Stan's brother, I think, but I'm not totally sure.  He seems nice enough, but he's a man of few words.  I can't get a good bead on them.  I've learned not to pry too much though."),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Refugees2_Singh",
    line = {
        when = predicates.handler("dlg_p_dda_179329b6cb3b"),
        yes = ccb.content.text("The Singhs are really shy, and I think they feel pretty bad about making it through this together.  They're the only complete family I've seen since <the_cataclysm>.  That has to feel really weird, and I think it's made them stick really close together.  I think… I think they also just don't really like any of us."),
        no = ccb.content.text("I really can't get a bead on them.  They never really talk to anyone outside of their little family group, they just sit in their own spot and speak Punjabi.  They always seem nice, and they do their share, they just don't have any social connection."),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Refugees2_Others",
    line = {
        when = predicates.handler("dlg_p_dda_fe3a896fea99"),
        yes = ccb.content.text("Vanessa… I'm doing my best, I really am, but we just do not get along.  One of these days one of us is probably going to brain the other with a tire iron, and I'm just grateful I spend more time around the tire irons.  Uyen and Rhyzaea are both excellent people, and I genuinely like them, but I can't stand this ongoing political bullshit they've got going on.  Alonso is just a… he's… there's no polite word for what he is.  A lot of the others are fine with it, and okay, sure, I guess.  John is a walking stereotype, but he's a great poker buddy.  I admit I kinda like him."),
        no = ccb.content.text("Vanessa… well, she's nice, I guess.  I gotta say, she kinda drives me nuts, but we're in this together so I try not to be too harsh.  Uyen and Rhyzaea both seem to want to run the show here, but I try to stay out of those politics and just focus on building stuff.  I don't see much good coming of it.  Alonso is fine, he's clearly interested in me, and also in every other single person here.  Not my thing, in a group this small.  John is a walking stereotype, I imagine there must be more depth to him, but I haven't seen it yet."),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

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
