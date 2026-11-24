local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "yoshimi",
    unique_name = ccb.content.text("Yoshimi"),
    suffix = ccb.content.text("DinoLab survivor"),
    class = "dm_dinolab_survivor",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_Yoshimi_1",
    faction = "no_faction",
    missions_offered = "MISSION_DinoLab_Yos_1",
}

ccb.content.define_npc_class {
    id = "dm_dinolab_survivor",
    name = ccb.content.text("DinoLab survivor"),
    job_description = ccb.content.text("Need to learn what happened…"),
    common = false,
    worn = "lab_torso",
    carry = "NC_DOCTOR_misc",
    weapon = "EMPTY_GROUP",
    traits = {
        { "PRETTY", 100 },
        { "ANIMALEMPATH2", 100 },
        { "QUICK", 100 },
        { "LIZ_EYE", 100 },
        { "SCALES", 100 },
        { "NAILS", 100 },
        { "RAP_TALONS", 100 },
        { "THRESH_RAPTOR", 100 },
        { "ARM_FEATHERS", 100 },
    },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -4 } } } } },
        },
        { skill = "firstaid", bonus = { rng = { 4, 8 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Yoshimi_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }),
        yes = {
            choices = {
                ccb.content.text("How can I help you, survivor?"),
                ccb.content.text("Seen any interesting specimens?  I mean dinosaurs."),
                ccb.content.text("I was just imagining you transforming into a tyrannosaurus rex.  Of course that's impossible.  Unless…"),
                ccb.content.text("Let's do some science."),
            },
        },
        no = ccb.content.text("Please leave me be, I am but a humble muck farmer in this humble muck."),
    },
    replies = {
        {
            text = ccb.content.text("You are dressed like a scientist.  Are you a scientist?  You look like a dinosaur.  Are you a dinosaur?  Are you a scientist dinosaur?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_yoshimi", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } })),
            next_topic = "TALK_yoshimi_firstmeet",
        },
        {
            text = ccb.content.text("Die demon mutant!"),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_yoshimi", "yes"),
                "insult_combat",
            },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Yos_chemistry" } }) }),
            next_topic = "TALK_yoshimi_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }) }),
            next_topic = "TALK_yoshimi_ask_mood",
        },
        {
            text = ccb.content.text("You look like you need help.  Can I do something for you?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }) }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Goodbye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_firstmeet",
    line = ccb.content.text("You have seen through my ruse.  In retrospect I should have prepared a costume of some kind.  Unimportant!  You haven't attacked me or tried to seduce me so you aren't like the others.  Had any bad headaches recently, strange mood swings, strong urges, desire for human flesh?"),
    replies = {
        {
            text = ccb.content.text("Only the usual.  What are you really?"),
            next_topic = "TALK_yoshimi_what",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm then?"),
            next_topic = "TALK_yoshimi_cataclysm",
        },
        {
            text = ccb.content.text("I'd rather not say at this point."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_what",
    line = ccb.content.text("I am a hard working professional in a challenging field adjusting to a recent change in circumstances.  That is all you need to know."),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_Yoshimi_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_ask_past",
    line = ccb.content.text("My manager Dr. Tingle made some important mistakes and I have had to make some quick decisions I would rather not go into detail on.  In retrospect our faculties may have been influenced by external factors.  Suffice to say Dr. Tingle is no longer with us but died happy.  And I escaped alive."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_cataclysm",
    line = ccb.content.text("Look at me.  Yes, I am aware.  The question is what happens next."),
    replies = {
        {
            text = ccb.content.text("Yes.  Let's talk about something else."),
            next_topic = "TALK_Yoshimi_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_yoshimi_ask_mood",
    line = ccb.content.text("I just got here, actually; I've recently found it wise to move a lot.  There may be some interesting specimens nearby.  I mean dinosaurs."),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_Yoshimi_1" } },
}

ccb.content.define_mission {
    id = "MISSION_DinoLab_Yos_1",
    name = ccb.content.text("First we need some supplies"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "chemistry_set",
    start = {
        target = { special = "4x4_DinoLab_surface", terrain = "microlab_DinoLab_surface", reveal_radius = 1 },
        map_updates = {
            {
                terrain = "microlab_DinoLab_surface",
                layout = {
                    item_placements = { { id = "chemistry_set", x = 12, y = 12 } },
                    monster_placements = { { group = "GROUP_DINOSAUR_ZOMBIE", x = 12, y = 12 } },
                },
            },
        },
        handler = "set_mission_flag_Yos_chemistry_to_in_progress",
    },
    finish = { handler = { "mark_mission_flag_Yos_chemistry", "advance_counter_DinoLab_DinoLab_power_by_2" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_DinoLab_Yos_2",
    dialogue = {
        describe = ccb.content.text("I think I might know where a decent chemistry set is…"),
        offer = ccb.content.text("I need a full chemistry set to do my work properly.  I could use some help."),
        accepted = ccb.content.text("Fine.  I've marked one I know about on your map but any set will work."),
        rejected = ccb.content.text("Fine, you'll probably be dead soon anyway."),
        advice = ccb.content.text("It might be too dangerous now, any working full chemistry set is fine.  There is a good chance something got out."),
        inquire = ccb.content.text("Do you have the set yet?"),
        success = ccb.content.text("Let's get started."),
        success_lie = ccb.content.text("Very convincing.  I do need an actual chemistry set to work though."),
        failure = ccb.content.text("It's fine, I'll make something work."),
    },
}

ccb.content.define_mission {
    id = "MISSION_DinoLab_Yos_2",
    name = ccb.content.text("Kiernan consult"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "kiernans_notes",
    start = {
        target = {
            special = "dinosaur exhibit",
            terrain = "dinoexhibit",
            reveal_radius = 1,
            random = true,
            search_range = 120,
        },
        map_updates = {
            {
                terrain = "dinoexhibit",
                layout = {
                    item_placements = { { id = "kiernans_notes", x = 20, y = 19 } },
                    monster_placements = {
                        { id = "mon_zombie_scientist", name = ccb.content.text("Kiernan"), x = 20, y = 19 },
                    },
                },
            },
        },
    },
    finish = {
        item_rewards = { { item = "kiernans_notes" } },
        handler = "advance_counter_DinoLab_DinoLab_power_by_2",
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_DinoLab_Yos_3",
    dialogue = {
        describe = ccb.content.text("I need some expert advice…"),
        offer = ccb.content.text("I don't have access to my old lab's procedural documents here.  Find Dr. Kiernan and get some notes on the basics.  I can work from there."),
        accepted = ccb.content.text("Right.  I've marked his last location on your map."),
        rejected = ccb.content.text("Ugh."),
        advice = ccb.content.text("Kiernan is probably still at the old field office.  It should be fine as long as the emergency power is still working.  You may have to do some kind of stupid task before Kiernan talks.  Try not to get violent.  If Kiernan is dead try and find some notes or books."),
        inquire = ccb.content.text("Do you have the information yet?"),
        success = ccb.content.text("Let's get started.  Oh, I'll make you a copy just in case."),
        success_lie = ccb.content.text("Very convincing.  I do need the information to work though."),
        failure = ccb.content.text("It's fine, I'll make something work."),
    },
}

ccb.content.define_mission {
    id = "MISSION_DinoLab_Yos_3",
    name = ccb.content.text("Nice relaxing break"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    difficulty = 2,
    value = 1000,
    monster_species = "DINOSAUR",
    monster_kill_goal = 5,
    start = {
        target = {
            terrain = "dinozoo_1_1",
            replace_terrain = "land",
            reveal_radius = 1,
            random = true,
            search_range = 220,
        },
    },
    finish = {
        item_rewards = { { item = "mutagen_raptor" } },
        handler = "advance_counter_DinoLab_DinoLab_power_by_2",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Time for a nice relaxing trip…"),
        offer = ccb.content.text("We have been working so hard.  We deserve a break.  Here is what I want you to do.  There is a special zoo with very special animals in it. I need you to go there and kill anything dangerous and smash the corpses bloody so they don't rise and try to kill me.  For science.  Then I'm going to go there and study what is there to get ready for the next step."),
        accepted = ccb.content.text("Clean up if you can, I don't like mess."),
        rejected = ccb.content.text("Ugh."),
        advice = ccb.content.text("You're good at this kind of brutality I assume.  Bring a weapon of some kind.  I don't know how dangerous it will be but I would assume the worst.  I always do."),
        inquire = ccb.content.text("Are you back from your relaxing trip?"),
        success = ccb.content.text("Wonderful.  I trust you weren't hurt by those animals.  I have some spare chemicals you might enjoy."),
        success_lie = ccb.content.text("Wonderful, now I'm off to inspect your work."),
        failure = ccb.content.text("It's fine, I'll make something work."),
    },
}
