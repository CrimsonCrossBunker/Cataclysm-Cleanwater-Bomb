local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Introdialogue",
    line = ccb.content.text("Years ago, you and your old group of friends made a pact.  It seemed like a joke at the time: if the world ended, you'd all meet up at Liam's cabin, if you could, and work together to help each other out.  Now, the unthinkable has happened, and somehow you've made it out in one piece.  It's been years since you saw those friends, though you've kept a little bit in touch on social media, and you can only hope that the others perhaps took the idea seriously.  Even if they did, it would be a hard trip.  The roads were blocked off by military forces trying to prevent the riots from spreading, and you had to make the last part of the journey on foot.\n\nAs the morning light breaks into day, you've reached Liam's cabin, a ramshackle building in the woods outside <city>.  You can see Liam's car in front, looking a bit more run down since you last saw him a few years ago.  You feel a swell of relief: at least Liam seems to have made it!  As you approach the door, you hear a shout of terror from inside, and then the unmistakable sound of a gunshot.  Were you a moment too late?"),
    replies = {
        {
            text = ccb.content.text("I'd better get in there and check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

-- Special NPC you can only meet through the 'start with a friend' scenario. Will need his own class and items before completing this.
ccb.content.define_npc {
    id = "starting_follower_liam",
    unique_name = ccb.content.text("Liam"),
    class = "NC_STARTINGNPC_LIAM",
    gender = "male",
    attitude = 0,
    mission = "GUARD",
    faction = "no_faction",
    age = 27,
    height = 182,
    strength = 9,
    dexterity = 8,
    intelligence = 7,
    perception = 9,
    personality = { aggression = 0, bravery = 0, collector = 0, altruism = 8 },
    chat = "TALK_Liam_Meeting1",
    friend_chat = "TALK_FRIEND_Liam",
    friend_guard_chat = "TALK_FRIEND_GUARD_Liam",
}

ccb.content.define_npc_class {
    id = "NC_STARTINGNPC_LIAM",
    name = ccb.content.text("expert in entry level jobs"),
    job_description = ccb.content.text("It's you and me in this together, buddy."),
    common = false,
    strength = { rng = { -1, 1 } },
    dexterity = { rng = { -1, 1 } },
    perception = { rng = { -1, 1 } },
    skills = {
        { skill = "archery", bonus = { rng = { 2, 4 } } },
        { skill = "computer", bonus = { rng = { 1, 2 } } },
        { skill = "cooking", bonus = { rng = { 1, 2 } } },
        { skill = "cutting", bonus = { rng = { 1, 2 } } },
        { skill = "dodge", bonus = { rng = { 1, 2 } } },
        { skill = "driving", bonus = { rng = { 1, 5 } } },
        { skill = "electronics", bonus = { rng = { 1, 2 } } },
        { skill = "fabrication", bonus = { rng = { 2, 3 } } },
        { skill = "firstaid", bonus = { rng = { 1, 2 } } },
        { skill = "gun", bonus = { rng = { 2, 3 } } },
        { skill = "melee", bonus = { rng = { 1, 2 } } },
        { skill = "mechanics", bonus = { rng = { 1, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 2 } } },
        { skill = "survival", bonus = { rng = { 3, 5 } } },
        { skill = "swimming", bonus = { rng = { 0, 1 } } },
        { skill = "rifle", bonus = { rng = { 1, 2 } } },
    },
    proficiencies = {
        "prof_bow_basic",
        "prof_carpentry_basic",
        "prof_driver",
        "prof_food_prep",
        "prof_frying",
        "prof_gun_cleaning",
        "prof_wound_care",
    },
    worn = "Liam_worn",
    carry = "Liam_carry",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "BADHEARING", weight = 50 },
        { trait = "LIGHTSTEP", weight = 70 },
        { trait = "OPTIMISTIC" },
        { trait = "PACKMULE", weight = 80 },
        { trait = "SLOWREADER", weight = 50 },
        { trait = "STRONGBACK", weight = 80 },
        { trait = "TOUGH", weight = 80 },
        { group = "Hair_Black" },
        { group = "Skin_Medium" },
        { group = "Eye_light" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting1",
    line = {
        when = predicates.any_equal({ "ddotd", { scope = "speaker", key = "flag_modded" } }),
        yes = ccb.content.text("<talk_snippet_modded_liam_meeting1>"),
        no = ccb.content.text("*, your old friend, stares at you with blank, confused eyes.  He is standing over a freshly mangled corpse, a smoking shotgun at his feet.  \"Holy shit dude.\"  He blinks.  \"Is this about Chris?  If you're here to kill me, just get it over with man.  I don't know what the fuck is happening but I can't take you out too.\""),
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "talked_liam", "yes") }, opinion = { trust = 5, fear = -4, value = 10, anger = -6 } },
    },
    replies = {
        {
            text = ccb.content.text("Get ahold of yourself, man.  What's happening?  Chris?"),
            next_topic = "TALK_Liam_Meeting2",
            when = predicates.negate(predicates.any_equal({ "ddotd", { scope = "speaker", key = "flag_modded" } })),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting2",
    line = ccb.content.text("*gestures at the body.  \"Chris.  You know Chris, you've known Chris for years.  We all agreed to meet up here if shit got bad, remember?  We got here around the same time, set up a little camp.  Something seemed really off since we arrived though, Chris kept going on and on about how the food wasn't good enough.\"  He shifts his gaze back to you, eyes red.  \"We got plenty of food!  I tried to calm him down but just now the fucker came running in with an axe, tried to take my head off!  I… I…\" Liam gestures again to the corpse.  \"Then you came in.  Do you got anything to do with this?\""),
    replies = {
        {
            text = ccb.content.text("I heard gunshots, so I came in to see what's up.  I was just on my way here to see if you'd made it."),
            next_topic = "TALK_Liam_Meeting3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting3",
    line = ccb.content.text("Well, shit.  I'm guessing my story sounds like a lot of bullshit then.\"  Liam sags into the sofa behind him, wiping his eyes with his sleeve.  \"What the hell are we gonna do?  Holy shit."),
    replies = {
        {
            text = ccb.content.text("I believe you.  People have been acting crazy for weeks, it must have got Chris too.  Come on.  We're in this together."),
            next_topic = "TALK_Liam_Meeting4a",
        },
        {
            text = ccb.content.text("Pull yourself together.  You did what you had to.  The shit has hit the fan, no time for moping around."),
            next_topic = "TALK_Liam_Meeting4b",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting4a",
    line = ccb.content.text("Thanks.  It's good to hear that.  Look, I'm sure I should be questioning you and making sure you're not gonna attack me with an axe or something, but I just can't anymore.  Come on, let's get Chris out of here and then figure out what to do next."),
    replies = {
        {
            text = ccb.content.text("Sure thing.  <lets_go>"),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Meeting4b",
    line = ccb.content.text("All right, yeah.  Fair call.  I'm just a bit shell shocked, but it's good to see you.  Let's get Chris out of here and figure out what to do next"),
    replies = {
        {
            text = ccb.content.text("Sure thing.  <lets_go>"),
            native_actions = { "follow" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FIND_LIAM",
    name = ccb.content.text("Check to see if Liam is OK"),
    goal = "MGOAL_CONDITION",
    start = { target = { terrain = "cabin_liam", special = "cabin_liam", reveal_radius = 1, random = false } },
    difficulty = 0,
    value = 0,
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_find_liam",
}
