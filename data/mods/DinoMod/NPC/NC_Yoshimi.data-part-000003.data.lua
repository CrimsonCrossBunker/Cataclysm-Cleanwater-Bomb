local ccb = require("ccb")

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
