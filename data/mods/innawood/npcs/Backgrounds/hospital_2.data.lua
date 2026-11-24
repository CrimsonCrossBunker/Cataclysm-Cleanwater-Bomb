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
            yes = ccb.content.text("I was at work trying to heal the sick, when it all went down.  It's a bit of a blur.  For a while there were weird rumors, stuff that sounded unbelievable about people getting back up after dying, but mostly things normal.  Then, towards the end, stuff just skyrocketed.  We thought it was some kind of attack, and that's what we were being told.  People coming in crazed, covered in wounds.  About halfway through my shift I… well, I broke."),
            no = ccb.content.text("I was at work trying to heal the sick, when it all went down.  It's a bit of a blur.  For a while there were weird rumors, stuff that sounded unbelievable about people getting back up after dying, but mostly things normal.  Then, towards the end, stuff just skyrocketed.  We thought it was some kind of attack, and that's what we were being told.  People coming in crazed, covered in wounds.  About halfway through my shift I… well, I broke.  I'd seen such horrible injuries, and then I… <swear!>, I can't even talk about it."),
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
            text = ccb.content.text("Suck it up buttercup.  If we're going to work together I need to know you."),
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
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY2",
    line = ccb.content.text("A young mother.  I know she was a mother, because I delivered her baby.  Sweet girl, she… she had a good sense of humor.  She came in, spitting that black goo, fighting the orderlies, dead from a spear wound through the chest.  That's when I… I don't know if I woke up, finally, or if I finally went crazy.  Either way, I broke.  I broke a lot earlier than my colleagues, and that's the only reason I lived.  I skipped out and hid for hours, while I listened to the world crumbling outside and inside."),
    replies = {
        {
            text = ccb.content.text("How did you get out of there?"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "BGSS_HOSPITAL_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDYES", { permanent = true }) },
            next_topic = "TALK_FRIEND",
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
    line = ccb.content.text("Somehow, I don't know how, I managed to fall asleep.  I think it might have started with me hyperventilating and passing out.  When I woke up it was night, I was starving and parched, and… and the screaming had died down.  At first I tried to go out the way I came in, but I peaked around a corner and saw one of the nurses stumbling around, spitting that black shit up.  Her name was Becky.  She wasn't Becky anymore.  So, I went back up and somehow made it up a hill nearby.  I drank water from some nasty old puddle and I camped out there for a while, watching it all burn."),
    replies = {
        {
            text = ccb.content.text("What finally brought you down?"),
            next_topic = "BGSS_HOSPITAL_2_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY4",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_hospital_2_started_quest" } }),
        yes = ccb.content.text("Well, I still didn't have any food.  Eventually I had to climb down… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the giant bugs don't, because I was able to slip right past them and get away.  I'd kind of scouted out my route from above…  I avoided the major spiked blockades, and headed out towards a friend's place.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle."),
        no = ccb.content.text("Well, I still didn't have any food.  Eventually I had to climb down… so I did, as quietly as I could.  It was night, and I have pretty good nightvision.  Apparently the giant bugs don't, because I was able to slip right past them and get away.  I'd kind of scouted out my route from above…  I avoided the major spiked blockades, and headed out towards a friend's place.  I had to fight off a couple of the <zombies>, but I managed to avoid any big fuss, by some miracle.  I never made it to the where I was going, but that's not important now."),
    },
    replies = {
        {
            text = ccb.content.text("What did you see, up there?"),
            next_topic = "BGSS_HOSPITAL_2_ROOF",
        },
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_ROOF",
    line = ccb.content.text("I was up pretty high on that hill, so I saw quite a bit.  The men with spears set up blockades, and there was quite a lightshow going on out there when I started up.  I think it was mostly fires, I didn't hear much shouting.  I saw a few people try to run the barricade and get stabbed to pieces.  There were swarms of <zombies>, traveling in packs towards sounds and noises.  I watched them rip a few people to shreds, screaming and trying to get away.  You know.  The usual stuff.  I was pretty numb by that point."),
    replies = {
        { text = ccb.content.text("How did you get down?"), next_topic = "BGSS_HOSPITAL_2_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
