local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_1",
    name = ccb.content.text("Collect 100 Aspirin"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "aspirin",
    item_count = 100,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I've got a handful of bandages and a few first aid kits to work with at the moment… in other words I'm completely unable to treat most serious medical emergencies.  I'm supposed to have priority on any medical supplies that the scavengers bring in, but I imagine the black market for the stuff will prevent me from ever seeing it.  I could use your help getting me 100 aspirin pills to start with."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Aspirin is pretty common in homes and convenience stores."),
        inquire = ccb.content.text("Do you have the aspirin?"),
        success = ccb.content.text("We'll go through this pretty quickly, but it does help."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_group_placements = {
                        {
                            group = "ranch_nurse_clinic_aspirin",
                            chance = 100,
                            x = 18,
                            y = 7,
                            repetitions = { 1, 2 },
                            faction = "tacoma_commune",
                        },
                    },
                    item_placements = {
                        { id = "bandages", x = 17, y = 7, amount = { 3, 9 }, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_rack",
                            x = 17,
                            y = 7,
                            end_x = 18,
                            end_y = 7,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_2",
    name = ccb.content.text("Collect 3 Hotplates"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "hotplate",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I was given a few bottles of bleach when I arrived, but I need a number of hotplates to actually sterilize equipment.  I'm sure you can find them in any old house or appliance store.  Three should be enough for now."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("It should be a fairly common item.  Don't know what else to say."),
        inquire = ccb.content.text("Do you have the hotplates?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_placements = {
                        { id = "hotplate", x = 7, y = 5, amount = 3, faction = "tacoma_commune" },
                        { id = "manual_first_aid", x = 3, y = 4, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_rack",
                            x = 3,
                            y = 4,
                            end_x = 3,
                            end_y = 5,
                        },
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_counter",
                            x = 5,
                            y = 5,
                            end_x = 7,
                            end_y = 5,
                        },
                        { shape = "point", operation = "furniture", id = "f_stool", x = 7, y = 6 },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_3",
    name = ccb.content.text("Collect 200 Multivitamin Pills"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "vitamins",
    item_count = 200,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Disease is spreading rapidly due to poor nutrition and there is little that I can do about it.  With food being scarce, people are willing to survive on whatever they can.  I need to start supplementing the outpost's diet with vitamins to prevent potential deaths indirectly attributable to nutrition.  I know it is a lot, but if you could bring me 200 multivitamin pills, I'd be able to treat the most vulnerable before they spread anything to the rest of us."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("It should be a fairly common item.  Don't know what else to say."),
        inquire = ccb.content.text("Do you have the vitamins?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 2,
                            y = 16,
                            end_x = 9,
                            end_y = 23,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 13,
                            y = 16,
                            end_x = 20,
                            end_y = 23,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 10,
                            y = 17,
                            end_x = 12,
                            end_y = 23,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_placements = {
                        { id = "vitamins", x = 17, y = 7, amount = { 1, 3 }, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 4,
                            y = 0,
                            end_x = 18,
                            end_y = 2,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 10,
                            y = 3,
                            end_x = 12,
                            end_y = 4,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_4",
    name = ccb.content.text("Make 4 Charcoal Purifiers"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "char_purifier",
    item_count = 4,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Despite my recommendations, we continue to have travelers come in with illnesses that I've been able to trace back to contaminated drinking water.  When boiling water isn't an option, they need some form of charcoal water filter that they can use.  If you could build me four charcoal water filters, I'll distribute them to groups as they pass through."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("With some basic survival and crafting skills, you should be able to make them with little effort."),
        inquire = ccb.content.text("Do you have the charcoal water filters?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = { nested = { { x = 2, y = 5, id = "tacoma_commune_clinic_12a" } } },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    nested = { { x = 3, y = 0, id = "tacoma_commune_clinic_12b" } },
                    item_placements = {
                        { id = "char_purifier", x = 15, y = 4, amount = { 1, 2 }, faction = "tacoma_commune" },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_5",
    name = ccb.content.text("Find a Chemistry Set"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "chemistry_set",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_6",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I've been working on producing some of our own medical supplies, but I'm going to need a chemistry set to get everything that I need in order.  Is there any way you could go through one of the school chemistry labs and steal me a chemistry set?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You might be able to find one in a pharmacy if you can't find a school."),
        inquire = ccb.content.text("Do you have the chemistry set?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    transform_placements = { { id = "ranch_wall_upgrade1", x = { 0, 23 }, y = { 0, 23 } } },
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_window_empty", x = 2, y = 18 },
                        { shape = "point", operation = "terrain", id = "t_window_empty", x = 2, y = 21 },
                        { shape = "point", operation = "terrain", id = "t_window_empty", x = 20, y = 18 },
                        { shape = "point", operation = "terrain", id = "t_window_empty", x = 20, y = 21 },
                        { shape = "point", operation = "terrain", id = "t_window_empty", x = 11, y = 17 },
                    },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    transform_placements = { { id = "ranch_wall_upgrade1", x = { 0, 23 }, y = { 0, 23 } } },
                    item_placements = { { id = "chemistry_set", x = 5, y = 5, faction = "tacoma_commune" } },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_6",
    name = ccb.content.text("Find 10 Filter Masks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "mask_filter",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_7",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The number of airway infections that I've encountered in the past week has depleted my supply of masks.  Could you find me 10 filter masks?  I tend to only distribute them in severe cases, so I'll be sure to make them last."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You may be able to make one if you had the right guide."),
        inquire = ccb.content.text("Do you have the filter masks?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    nested = { { x = 2, y = 5, z = 1, id = "tacoma_commune_clinic_12a_roof" } },
                    transform_placements = {
                        { id = "ranch_window_upgrade1", x = { 0, 23 }, y = { 0, 23 } },
                        { id = "fit_door", x = { 0, 23 }, y = { 0, 23 } },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 3,
                            y = 17,
                            end_x = 8,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 14,
                            y = 17,
                            end_x = 19,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 10,
                            y = 18,
                            end_x = 12,
                            end_y = 23,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    nested = { { x = 3, y = 0, z = 1, id = "tacoma_commune_clinic_12b_roof" } },
                    transform_placements = { { id = "fit_door", x = { 0, 23 }, y = { 0, 23 } } },
                    item_placements = {
                        { id = "mask_filter", x = 15, y = 4, amount = { 2, 6 }, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 5,
                            y = 0,
                            end_x = 8,
                            end_y = 2,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 10,
                            y = 0,
                            end_x = 12,
                            end_y = 4,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtfloor",
                            x = 14,
                            y = 0,
                            end_x = 17,
                            end_y = 2,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_7",
    name = ccb.content.text("Find 4 Pairs of Rubber Gloves"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "gloves_rubber",
    item_count = 4,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_8",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The bodily fluids that I often have to clean up and the caustic chemicals I deal with have done a number on my current pair of gloves.  Could you find me four pairs of heavy rubber gloves?  That should be enough that I can task a few laborers with cleanup details in the event of an outbreak."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You should be able to find them in cleaning closets."),
        inquire = ccb.content.text("Do you have the rubber gloves?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 3,
                            y = 17,
                            end_x = 8,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 14,
                            y = 17,
                            end_x = 19,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 10,
                            y = 18,
                            end_x = 12,
                            end_y = 23,
                        },
                        { shape = "point", operation = "terrain", id = "t_floor_olight", x = 6, y = 20 },
                        { shape = "point", operation = "terrain", id = "t_floor_olight", x = 16, y = 20 },
                    },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "cleaning",
                            x = 17,
                            y = { 0, 2 },
                            repetitions = { 1, 3 },
                            faction = "tacoma_commune",
                        },
                    },
                    item_placements = {
                        { id = "gloves_rubber", x = 17, y = 0, amount = { 2, 3 }, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 5,
                            y = 0,
                            end_x = 8,
                            end_y = 2,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 10,
                            y = 0,
                            end_x = 12,
                            end_y = 4,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 14,
                            y = 0,
                            end_x = 17,
                            end_y = 2,
                        },
                        { shape = "point", operation = "terrain", id = "t_floor_olight", x = 11, y = 0 },
                        {
                            shape = "rectangle",
                            operation = "furniture",
                            id = "f_rack",
                            x = 17,
                            y = 0,
                            end_x = 17,
                            end_y = 2,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_8",
    name = ccb.content.text("Find 2 Scalpels"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "scalpel",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_9",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I heard that we may have a physician on his way here.  The workers have already begun expanding the clinic, but I need you to locate a pair of scalpels to use in surgery when he arrives.  I'm sure you should be able to find them in a hospital or craft shop."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals and crafting stores should have a few."),
        inquire = ccb.content.text("Do you have the scalpels?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    nested = {
                        { x = 4, y = 21, id = "tacoma_commune_clinic_bed" },
                        { x = 7, y = 21, id = "tacoma_commune_clinic_bed" },
                        { x = 15, y = 21, id = "tacoma_commune_clinic_bed" },
                        { x = 18, y = 21, id = "tacoma_commune_clinic_bed" },
                        { x = 4, y = 17, id = "tacoma_commune_clinic_bed" },
                        { x = 7, y = 17, id = "tacoma_commune_clinic_bed" },
                        { x = 15, y = 17, id = "tacoma_commune_clinic_bed" },
                        { x = 18, y = 17, id = "tacoma_commune_clinic_bed" },
                    },
                    transform_placements = { { id = "ranch_wall_upgrade2", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    transform_placements = { { id = "ranch_wall_upgrade2", x = { 0, 23 }, y = { 0, 23 } } },
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "cleaning",
                            x = 17,
                            y = { 0, 2 },
                            repetitions = { 1, 3 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "ranch_nurse_clinic_surgery",
                            x = { 15, 18 },
                            y = 4,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                    },
                    item_placements = {
                        { id = "scalpel", x = 15, y = 4, amount = 2, faction = "tacoma_commune" },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_9",
    name = ccb.content.text("Find Advanced Emergency Care"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "emergency_book",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_NURSE_11",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Have you heard of a book called the 'Guide to Advanced Emergency Care?'  I really need a copy.  The doctor is requesting a lot of supplies that I'm not familiar with, but I believe I could make if I could get a copy of the book."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Libraries are the only place I'd think to look."),
        inquire = ccb.content.text("Do you have the Guide to Advanced Emergency Care?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_50",
                layout = {
                    npc_placements = { { id = "ranch_doctor", x = 16, y = 19 } },
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 3, y = 22 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 8, y = 22 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 14, y = 22 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 19, y = 22 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 3, y = 17 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 8, y = 17 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 14, y = 17 },
                        { shape = "point", operation = "furniture", id = "f_dresser", x = 19, y = 17 },
                    },
                },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_placements = { { id = "emergency_book", x = 3, y = 5, faction = "tacoma_commune" } },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_NURSE_11",
    name = ccb.content.text("Find 10 Syringes"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "syringe",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_NULL",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We are starting to isolate a few natural antibiotic serums, but we don't have the supplies to administer the cocktails.  I need you to bring me 10 empty syringes to use.  I'll take care of cleaning them to prevent transferring infections."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Hospitals or clinics might have a few sitting around."),
        inquire = ccb.content.text("Do you have the empty syringes?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "cleaning",
                            x = 17,
                            y = { 0, 2 },
                            repetitions = { 1, 3 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "ranch_nurse_clinic_surgery",
                            x = { 15, 18 },
                            y = 4,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                    },
                    item_placements = {
                        { id = "syringe", x = 15, y = 4, amount = { 4, 8 }, faction = "tacoma_commune" },
                    },
                },
            },
        },
    },
}
