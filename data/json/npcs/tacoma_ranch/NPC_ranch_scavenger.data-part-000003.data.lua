local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_SCAVENGER_2",
    name = ccb.content.text("Make 5 Headlamps"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "wearable_light",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RANCH_SCAVENGER_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Night is the ideal time for my team to go on raids, but they are going to need better light sources to speed up their missions.  Could you craft a set of five headlamps for them?  Keeping both hands free greatly helps during combat."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You should be able to make them with the most basic of skills."),
        inquire = ccb.content.text("Do you have the headlamps?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_48",
                layout = {
                    nested = { { x = 18, y = 19, id = "tacoma_commune_junk_shop_shed_1" } },
                    vehicle_placements = {
                        {
                            id = "car_chassis",
                            chance = 100,
                            rotation = 0,
                            x = 20,
                            y = 15,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_49",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "mischw",
                            x = { 11, 12 },
                            y = { 13, 16 },
                            repetitions = { 3, 6 },
                        },
                        { chance = 100, group = "allsporting", x = 14, y = { 11, 17 }, repetitions = { 1, 2 } },
                    },
                    item_placements = { { id = "30gal_drum", x = 8, y = 20, faction = "tacoma_commune" } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chaingate_c",
                            x = 2,
                            y = 22,
                            end_x = 3,
                            end_y = 22,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_SCAVENGER_3",
    name = ccb.content.text("Make 3 Leather Body Armor"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "armor_larmor",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RANCH_SCAVENGER_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Clothing that can withstand the wear and tear of climbing through windows and fighting back wild animals is in high demand.  The best that we have been able to find is leather body armor, but it is difficult to make with our limited resources.  Could you craft us three pairs of leather body armor?  The life expectancy of my scavengers would drastically increase if you did."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Finding the leather might be easier in town rather than making it yourself."),
        inquire = ccb.content.text("Do you have the leather body armors?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_48",
                layout = {
                    nested = { { x = 18, y = 19, id = "tacoma_commune_junk_shop_shed_2" } },
                    item_placements = {
                        { id = "wheel_wide", x = 16, y = 21, faction = "tacoma_commune" },
                        { id = "wheel_wide", x = 17, y = 21, faction = "tacoma_commune" },
                        { id = "v8_combustion", x = 23, y = 18, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 23,
                            y = 16,
                            end_x = 23,
                            end_y = 17,
                        },
                        { shape = "point", operation = "furniture", id = "f_machinery_light", x = 23, y = 16 },
                        { shape = "point", operation = "furniture", id = "f_arcade_machine", x = 23, y = 17 },
                    },
                },
            },
            {
                terrain = "ranch_camp_49",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "mischw",
                            x = { 1, 4 },
                            y = 10,
                            repetitions = { 3, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "allsporting",
                            x = { 1, 4 },
                            y = 10,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "mischw",
                            x = { 1, 4 },
                            y = 13,
                            repetitions = { 3, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "allsporting",
                            x = { 1, 4 },
                            y = 13,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                        { chance = 100, group = "home_hw", x = 14, y = { 11, 17 }, repetitions = { 2, 3 } },
                        { chance = 100, group = "allsporting", x = 14, y = { 11, 17 }, repetitions = { 1, 2 } },
                    },
                    item_placements = { { id = "hdframe", x = 2, y = 15, faction = "tacoma_commune" } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 1,
                            y = 15,
                            end_x = 3,
                            end_y = 15,
                        },
                        { shape = "point", operation = "furniture", id = "f_fridge", x = 1, y = 15 },
                        { shape = "point", operation = "furniture", id = "f_washer", x = 3, y = 15 },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_SCAVENGER_4",
    name = ccb.content.text("Make 12 Molotov Cocktails"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "molotov",
    item_count = 12,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_NULL",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("When outnumbered or forced to pull back, my scavengers have been taught to throw Molotov cocktails to keep monsters from chasing them.  We go through one or two on every mission, so we can always use a few more.  Would you be willing to make us a dozen?  I'm willing to pay you what I can for your assistance."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Alcohol or kerosene is probably easier to refine rather than find in large quantities."),
        inquire = ccb.content.text("Do you have the Molotov cocktails?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_48",
                layout = {
                    item_placements = {
                        { id = "wheel_motorbike_or", x = 16, y = 20, faction = "tacoma_commune" },
                        { id = "wheel_motorbike_or", x = 17, y = 20, faction = "tacoma_commune" },
                        { id = "v6_diesel", x = 22, y = 21, faction = "tacoma_commune" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 22,
                            y = 21,
                            end_x = 23,
                            end_y = 21,
                        },
                        { shape = "point", operation = "furniture", id = "f_pinball_machine", x = 23, y = 21 },
                    },
                },
            },
            {
                terrain = "ranch_camp_49",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "mischw",
                            x = { 1, 4 },
                            y = 10,
                            repetitions = { 3, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "allsporting",
                            x = { 1, 4 },
                            y = 10,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "mischw",
                            x = { 1, 4 },
                            y = 13,
                            repetitions = { 3, 4 },
                            faction = "tacoma_commune",
                        },
                        {
                            chance = 100,
                            group = "allsporting",
                            x = { 1, 4 },
                            y = 13,
                            repetitions = { 2, 4 },
                            faction = "tacoma_commune",
                        },
                        { chance = 100, group = "home_hw", x = 14, y = { 11, 17 }, repetitions = { 2, 3 } },
                        { chance = 100, group = "allsporting", x = 14, y = { 11, 17 }, repetitions = { 1, 2 } },
                    },
                    item_placements = { { id = "frame", x = 4, y = 15, faction = "tacoma_commune" } },
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_dirt", x = 0, y = 21 },
                        { shape = "point", operation = "furniture", id = "f_glass_fridge", x = 0, y = 21 },
                    },
                },
            },
        },
    },
}
