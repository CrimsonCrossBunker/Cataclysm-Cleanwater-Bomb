local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_meteorologist",
    class = "NC_meteorologist",
    suffix = ccb.content.text("meteorologist"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_meteorologist_1",
    faction = "no_faction",
    missions_offered = "MISSION_meteorologist_1",
}

ccb.content.define_npc_class {
    id = "NC_meteorologist",
    name = ccb.content.text("Meteorologist"),
    job_description = ccb.content.text("Meteorologist."),
    common = false,
    strength = { rng = { -2, 2 } },
    dexterity = { rng = { -2, 2 } },
    intelligence = { rng = { 2, 5 } },
    perception = { rng = { -1, 3 } },
    worn = "NC_meteorologist_worn",
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "BGSS_METEOROLOGIST" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "computer", bonus = { rng = { 2, 3 } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "chemistry", bonus = { rng = { 2, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_meteorologist_1" },
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_mission_u_helped_meteorologist" } }),
        yes = ccb.content.text("Run, I need to run, where to run…"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_meteorologist" } }),
            yes = ccb.content.gendered_line("Air temperature, precipitation, but what about… oh, I'm sorry, I didn't notice you.  Hello.", { "interlocutor" }),
            no = ccb.content.gendered_line("I have not seen living people for a long time.  Glad to see another survivor.  Greetings, <name_g>.", { "interlocutor" }),
        },
    },
    on_enter = {
        { once = "u_met_meteorologist", actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_meteorologist", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("<BGSS_intro_question>"),
            next_topic = "TALK_meteorologist_Background",
        },
        {
            text = ccb.content.text("Maybe I can help you with your problem?"),
            next_topic = "TALK_meteorologist_safety",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_mission_u_helped_meteorologist" } }),
            switch = true,
        },
        {
            text = ccb.content.text("Do you need any help?"),
            switch = true,
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_f855db4d8b27") },
            success = { next_topic = "TALK_MISSION_LIST", actions = { actions.clear_actor_value("interlocutor", "time_mission_meteorologist_wait") } },
            failure = { next_topic = "TALK_meteorologist_wait" },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_wait",
    line = ccb.content.text("I need more time.  Come back later."),
    replies = { { text = ccb.content.text("No problem."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety",
    line = ccb.content.gendered_line("Help?  Help with what?  Oh, yes, yes.  If you know a place with many survivors, can you take me there?  I doubt I can survive alone…", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow_only", actions.set_first_topic("TALK_meteorologist_safety_lead") },
        },
        { text = ccb.content.text("Want to travel with me?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety_lead",
    line = ccb.content.text("Are we there yet, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Yes, you can relax now."),
            next_topic = "TALK_meteorologist_safety_done",
            when = predicates.handler("dlg_p_dda_f67f3b47ebe4"),
        },
        {
            text = ccb.content.text("Don't worry, we're getting there soon."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety_done",
    line = ccb.content.text("Thank you.  I will never forget your kindness, <name_g>.  Take this book as token of my gratitude."),
    replies = {
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_e9a3927a8073"), "stop_following", actions.set_first_topic("TALK_meteorologist_safe") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safe",
    line = ccb.content.gendered_line("I'm glad you still alive.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Me too."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_Background",
    line = ccb.content.gendered_line("I'm just a regular meteorologist.  In recent years I have worked at a weather station, monitored the weather, state of air, read and wrote reports, drew up schedules… in general, complete boredom.  In my free time I was studying electronics and radio engineering, making various devices, some for work, some just for fun.  When the first riots began, I gathered all my things that I managed to take with me and settled here.  Since then I've been sitting here, wasting my time doing all sorts of nonsense.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_meteorologist_1",
    generic_rewards = false,
    name = ccb.content.text("Find scrap for the meteorologist"),
    description = ccb.content.text("The meteorologist asked to bring him 50 pieces of scrap."),
    goal = "MGOAL_FIND_ITEM",
    item = "scrap",
    item_count = 50,
    difficulty = 0,
    value = 100,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_meteorologist_2",
    dialogue = {
        describe = ccb.content.text("We need scrap metal to assemble a drone…"),
        offer = ccb.content.text("I've been sitting here for a long time, and all that time I was wondering how bad everything is outside.  I want to build a drone that I can use to fly over New England, check the air condition, take a few pictures from above to get a glimpse of how is it.  There were a lot of things in our back room that could be useful, but still I'm missing a lot of things.  You look like an experienced survivalist.  Can you help me?"),
        accepted = ccb.content.text("Good.  I just need a little stuff: 50 scrap, 6 medium batteries, 5 small high-quality lenses and a radio remote control.  Bring the scrap for now, but don't forget about the rest."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("I don't think this is a difficult task.  Surely there is a lot of it underfoot."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Great, I'm starting to work on it…"),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_meteorologist_2",
    generic_rewards = false,
    name = ccb.content.text("Find batteries for the meteorologist"),
    description = ccb.content.text("The meteorologist asked to bring him 6 medium batteries."),
    goal = "MGOAL_FIND_ITEM",
    item = "medium_battery_cell",
    item_count = 6,
    difficulty = 0,
    value = 100,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_meteorologist_3",
    dialogue = {
        describe = ccb.content.text("We need batteries to assemble a drone…"),
        offer = ccb.content.text("Well, what's next on the list… yeah, batteries.  6 medium batteries would be enough."),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("Try looking for some battery-powered trinkets and take them apart."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Great, I'll continue to work on it…"),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_meteorologist_3",
    generic_rewards = false,
    name = ccb.content.text("Find high-quality lenses for the meteorologist"),
    description = ccb.content.text("The meteorologist asked to bring him 5 small high-quality lenses."),
    goal = "MGOAL_FIND_ITEM",
    item = "lens_small",
    item_count = 5,
    difficulty = 0,
    value = 100,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_meteorologist_4",
    dialogue = {
        describe = ccb.content.text("We need small high quality lenses for our drone…"),
        offer = ccb.content.text("Well, what's next on the list… yeah, lenses.  5 small high-quality lenses would be enough."),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("Try looking for telescopes or microscopes to dismantle."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Great, I'm continuing to work on it…"),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_meteorologist_4",
    name = ccb.content.text("Find a radio controller for the meteorologist"),
    description = ccb.content.text("The meteorologist asked to bring him a radio controller."),
    goal = "MGOAL_FIND_ITEM",
    item = "radiocontrol",
    item_count = 1,
    difficulty = 0,
    value = 100,
    finish = {
        actions = {
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "time_mission_meteorologist_wait" }),
            { item = "textbook_electronics" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_meteorologist_5",
    dialogue = {
        describe = ccb.content.text("We need an RC to assemble a drone…"),
        offer = ccb.content.text("Well, what's next on the list… yeah, radio control.  Any kind will do, but the simplest one is better, so I can easily reconfigure it for my drone."),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("I advise you to search in a store, such as electronics or toy store."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Great, very little work left.  I need a few days to finish all this, and to try it in work.  I hope everything will work fine!  While I'm working on the drone, you can read this book.  Maybe you can learn something new from it."),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_meteorologist_5",
    generic_rewards = false,
    name = ccb.content.text("Find the meteorologist's crashed drone"),
    description = ccb.content.text("The meteorologist asked to bring him his crashed drone."),
    goal = "MGOAL_FIND_ITEM",
    item = "module_meteorologist",
    item_count = 1,
    difficulty = 0,
    value = 100,
    start = {
        target = { terrain = "field", reveal_radius = 1, search_range = 50, min_distance = 15, random = true },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "module_meteorologist", x = { 5, 15 }, y = { 5, 15 } },
                        { id = "scrap", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 5, 30 } },
                        {
                            id = "lens_small",
                            x = { 5, 15 },
                            y = { 5, 15 },
                            chance = 45,
                            repetitions = { 1, 3 },
                        },
                        { id = "cable", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 1, 2 } },
                    },
                    monster_placements = {
                        { id = "mon_mi_go", x = { 5, 15 }, y = { 5, 15 }, repetitions = { 2, 5 } },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +4).
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "flag_mission_u_helped_meteorologist", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I've lost the drone, we should find out what happened…"),
        offer = ccb.content.text("I'm glad that you are alive and that you haven't forgot about me.  The drone turned out to be great, it managed to take off and even was able to fly several hundred meters!  Unfortunately, after that, I lost control of it… I don't know what happened to it, though.  Maybe you can check?  I'm a little afraid to go out there…"),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("I don't know quite what happened.  Maybe something noticed my drone and tried to bring it down.  Be careful."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Hmm, I see that the drone is not with you.  Maybe at least the memory module remains?  Okay, show it to me… hmm, situation is worse than I expected, much, much worse… I'm not feeling good.  I don't feel safe in this place anymore.  I have to run, run somewhere.  But where to run if these monsters are everywhere…"),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}
