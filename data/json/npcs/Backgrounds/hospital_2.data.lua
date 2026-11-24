local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY1",
    line = {
        when = predicates.has_effect("interlocutor", "player_BGSS_SAIDNO"),
        yes = ccb.content.text("I just can't talk about that right now.  I can't."),
        no = {
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            yes = ccb.content.gendered_line("I was at work at the hospital, when it all went down.  It's a bit of a blur.  For a while there were weird reports, stuff that sounded unbelievable about patients getting back up after dying, but mostly things were business as usual.  Then, towards the end, stuff just skyrocketed.  We thought it was a Chinese attack, and that's what we were being told.  People coming in crazed, covered in wounds from bullets and bites.  About halfway through my shift I… well, I broke.", { "interlocutor" }),
            no = ccb.content.gendered_line("I was at work at the hospital, when it all went down.  It's a bit of a blur.  For a while there were weird reports, stuff that sounded unbelievable about patients getting back up after dying, but mostly things were business as usual.  Then, towards the end, stuff just skyrocketed.  We thought it was a Chinese attack, and that's what we were being told.  People coming in crazed, covered in wounds from bullets and bites.  About halfway through my shift I… well, I broke.  I'd seen such horrible injuries, and then I…  <swear!>  I can't even talk about it.", { "interlocutor" }),
        },
    },
    replies = {
        {
            text = ccb.content.text("It might help to get it off your chest."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "persuade",
                difficulty = 40,
                modifiers = { { score = "TRUST", scale = 2 }, { score = "VALUE", scale = 3 } },
            },
            success = { next_topic = "BGSS_HOSPITAL_2_STORY2" },
            failure = { next_topic = "BGSS_HOSPITAL_2_NOTYET" },
        },
        {
            text = ccb.content.text("Suck it up.  If we're going to work together I need to know you."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDNO")), predicates.negate(predicates.has_effect("interlocutor", "player_BGSS_SAIDYES")) }),
            trial = {
                kind = "intimidate",
                difficulty = 40,
                modifiers = {
                    { score = "BRAVERY", scale = 2 },
                    { score = "TRUST", scale = 1 },
                    { score = "ANGER", scale = -2 },
                },
            },
            success = { next_topic = "BGSS_HOSPITAL_2_STORY2" },
            failure = { next_topic = "BGSS_HOSPITAL_2_NOTYET" },
        },
        {
            text = ccb.content.text("What was it that 'broke' you?"),
            when = predicates.has_effect("interlocutor", "player_BGSS_SAIDYES"),
            next_topic = "BGSS_HOSPITAL_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_NOTYET",
    line = ccb.content.text("No.  I can't.  Just, no."),
    replies = {
        {
            text = ccb.content.text("Sorry… I'll let you be."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY2",
    line = ccb.content.gendered_line("A young mother.  I know she was a mother, because I delivered her baby.  Sweet girl, she… she had a good sense of humor.  She came in, spitting that black goo, fighting the orderlies, dead from a bullet wound through the chest.  That's when I… I don't know if I woke up, finally, or if I finally went crazy.  Either way, I broke.  I broke a lot earlier than my colleagues, and that's the only reason I lived.  I skipped out, went to a dead corner of the hospital I used to hide in when I was a resident.  An old stairwell leading to a closed-off unit the maintenance staff were using to store old equipment.  I hid there for hours, while I listened to the world crumbling outside and inside.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you get out of there?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_HOSPITAL_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY3",
    line = ccb.content.gendered_line("Somehow, I don't know how, I managed to fall asleep in there.  I think it might have started with me hyperventilating and passing out.  When I woke up it was night, I was starving and parched, and… and the screaming had died down.  At first I tried to go out the way I came in, but I peaked out the window and saw one of the nurses stumbling around, spitting that black shit up.  Her name was Becky.  She wasn't Becky anymore.  So, I went back up and somehow made it into the storage area.  From there, the roof.  I drank water from some nasty old puddle and I camped out there for a while, watching the city around me burn.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What finally brought you down?"),
            next_topic = "BGSS_HOSPITAL_2_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_hospital_2_started_quest" } }),
        yes = ccb.content.gendered_line("Well, I still didn't have any food.  Eventually I had to climb down the side of the building… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the zombies don't, because I was able to slip right past them and steal a bicycle that was just laying on the side of the road.  I'd kind of scouted out my route from above… I'm not from a big city, the hospital was the tallest building around.  I avoided the major military blockades, and headed out of town towards a friend's old cabin.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.", { "interlocutor" }),
        no = ccb.content.gendered_line("Well, I still didn't have any food.  Eventually I had to climb down the side of the building… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the zombies don't, because I was able to slip right past them and steal a bicycle that was just laying on the side of the road.  I'd kind of scouted out my route from above… I'm not from a big city, the hospital was the tallest building around.  I avoided the major military blockades, and headed out of town towards a friend's old cabin.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.  I never made it to the cabin, but that's not important now.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("What did you see, up there on the roof?"),
            next_topic = "BGSS_HOSPITAL_2_ROOF",
        },
        {
            text = ccb.content.text("Any chance you could point the way to that cabin for me?"),
            when = predicates.handler("w16b_p_dda_f49cb36318c1"),
            trial = { kind = "persuade", difficulty = 40, modifiers = { { score = "TRUST", scale = 5 }, { score = "VALUE", scale = 2 }, { score = "ANGER", scale = -6 } } },
            success = { next_topic = "BGSS_HOSPITAL_2_CABINSUCCESS", actions = { actions.handler("w16b_a_dda_bff2189d5b26") } },
            failure = { next_topic = "BGSS_HOSPITAL_2_CABINFAILURE", actions = { actions.handler("w16b_a_dda_e1e3d10f9e00"), actions.set_actor_value("speaker", "general_BGSS_hospital_2_asked_about_quest", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_ROOF",
    line = ccb.content.gendered_line("My hospital was the tallest building in town, so I saw quite a bit.  The military set up blockades on the roads coming in and out of the town, and there was quite a lightshow going on out there when I started up.  I think it was mostly automated turrets and robots, I didn't hear much shouting.  I saw a few cars and trucks try to run the barricade and get blown to high hell.  There were swarms of <zombies> in the streets, traveling in packs towards sounds and noises.  I watched them rip a few running cars to shreds, including the people inside who were trying to get away.  You know.  The usual stuff.  I was pretty numb by that point.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("How did you get down?"), next_topic = "BGSS_HOSPITAL_2_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_CABINSUCCESS",
    line = ccb.content.text("I suppose it couldn't hurt now.  I doubt anyone's still there anyway."),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_CABINFAILURE",
    line = ccb.content.text("Yeah, fat chance I'm giving up that kind of personal information to someone I barely know.  What are you trying to pull?"),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_mission {
    id = "directions_hospital_2_CABIN",
    name = ccb.content.text("Check out that cabin"),
    description = ccb.content.text("Maybe there's something left in that cabin you heard about."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Cabin_2", terrain = "cabin_2", reveal_radius = 3 },
        handler = "mark_mission_BGSS_hospital_2_started_quest",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Any luck finding the cabin?"),
        success = ccb.content.text("Thanks so much for coming back here with me!  I'm not sure I would have ever gotten here alive."),
        success_lie = ccb.content.text("Great!"),
        failure = ccb.content.text("Not that surprising."),
    },
}
