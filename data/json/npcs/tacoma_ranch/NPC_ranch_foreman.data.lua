local ccb = require("ccb")

-- tilled soil in the fields
-- tilled soil in the fields
ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_3",
    name = ccb.content.text("Gather 2500 Nails"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "nail",
    item_count = 2500,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Our supply of nails has been depleted.  I'm going to have to ask you to get us a few more boxes.  Hardware stores should have a few if they haven't been looted.  I suppose you may be able to find handfuls of them in building rubble.  We'd need 2500 to have enough that we won't be sending you back out too soon."),
        accepted = ccb.content.text("Deconstructing furniture isn't going to be efficient, try looking for boxes or grabbing any sitting on top of rubble piles."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Avoid destroying the furniture here, we'll be needing it."),
        inquire = ccb.content.text("Do you have them?"),
        success = ccb.content.text("Your assistance is always appreciated."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_46",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 7,
                            y = 4,
                            end_x = 22,
                            end_y = 23,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 8,
                            y = 5,
                            end_x = 9,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 11,
                            y = 5,
                            end_x = 12,
                            end_y = 22,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_55",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 7,
                            y = 0,
                            end_x = 22,
                            end_y = 18,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 8,
                            y = 2,
                            end_x = 9,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 11,
                            y = 2,
                            end_x = 12,
                            end_y = 17,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_56",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    vehicle_placements = {
                        {
                            id = "hippie_van",
                            x = 13,
                            y = 19,
                            rotation = 270,
                            chance = 100,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_65",
                layout = {
                    furniture_placements = { { id = "f_bookcase", x = 17, y = 11 } },
                    npc_placements = { { id = "ranch_farmer_1", x = 19, y = 20 } },
                },
            },
            {
                terrain = "ranch_camp_66",
                layout = { npc_placements = { { id = "ranch_woodcutter_1", x = 4, y = 11 } } },
            },
        },
    },
}

-- tilled soil in the fields
-- tilled soil in the fields
ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_4",
    name = ccb.content.text("Gather 30lb (3888 units) of Salt"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "salt",
    item_count = 3888,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I'm sure you've noticed the new workers that have started trickling in.  The Free Merchant counsel is demanding that we immediately begin projects to become self-sufficient due to limited supplies.  We are going to need to rapidly setup an agricultural industry before winter and starvation catches us unprepared and unsupported.  In order to get a half dozen shovels and a couple of bags of seeds, we are going to have to trade for it.  I've already got the deal lined up, but the only thing they are willing to trade it for is salt.  I negotiated them down from 50 lbs to 30… we were hoping you might have access to a source."),
        accepted = ccb.content.text("Salt is key to preserving meat and other perishables… without any excess food it wouldn't do us much good now, but I imagine we'll need to send you out to get more in the future."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("If you can find a source of salt water you should be able to boil it down.  Alternatively, you can go into the cities and search restaurants."),
        inquire = ccb.content.text("Do you have the salt?"),
        success = ccb.content.text("We are going to begin preparing our fields immediately."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_46",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 14,
                            y = 5,
                            end_x = 15,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 17,
                            y = 5,
                            end_x = 18,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 20,
                            y = 5,
                            end_x = 21,
                            end_y = 22,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_55",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 14,
                            y = 2,
                            end_x = 15,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 17,
                            y = 2,
                            end_x = 18,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 20,
                            y = 2,
                            end_x = 21,
                            end_y = 17,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_56",
                layout = {
                    vehicle_placements = {
                        {
                            id = "flatbed_truck",
                            x = 21,
                            y = 3,
                            rotation = 0,
                            chance = 100,
                            faction = "tacoma_commune",
                        },
                        {
                            id = "beetle",
                            x = 21,
                            y = 9,
                            rotation = 180,
                            chance = 100,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_57",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    npc_placements = { { id = "ranch_crop_overseer", x = 12, y = 7 } },
                },
            },
            {
                terrain = "ranch_camp_58",
                layout = {
                    nested = { { x = 0, y = 2, id = "tacoma_commune_lumbermill_4" } },
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
            {
                terrain = "ranch_camp_67",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 21,
                            y = 19,
                            end_x = 23,
                            end_y = 19,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_5",
    name = ccb.content.text("Gather 30 Bottles (120 units) of Liquid Fertilizer"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "fertilizer_liquid",
    item_count = 120,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_6",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Well, our first crop will be planted shortly, but I'm starting to suspect that our profit margin is going to be much smaller than we expect.  With limited seed for our original crop, our next course of action is to increase the soil's fertility.  Is there any way you could find or produce a basic liquid fertilizer for us?  We'd need at least 120 units or 30 full bottles to make a significant improvement in our output."),
        accepted = ccb.content.text("I don't know the exact recipe, but I'm sure you could make it from a commercial fertilizer or produce it from bonemeal."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("I'd look through a few basic chemistry books to find a simple recipe."),
        inquire = ccb.content.text("Do you have the liquid fertilizer?"),
        success = ccb.content.text("This really should make the first winter easier to survive."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_56",
                layout = {
                    vehicle_placements = {
                        {
                            id = "car_chassis",
                            x = 17,
                            y = 11,
                            rotation = 90,
                            chance = 100,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_58",
                layout = {
                    nested = { { x = 0, y = 2, id = "tacoma_commune_lumbermill_5" } },
                    tile_edits = { { shape = "point", operation = "terrain", id = "t_pit", x = 6, y = 18 } },
                },
            },
            {
                terrain = "ranch_camp_66",
                layout = {
                    npc_placements = { { id = "ranch_farmer_2", x = 9, y = 22 } },
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_palisade", x = 23, y = 22 },
                    },
                },
            },
            {
                terrain = "ranch_camp_67",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 0,
                            y = 22,
                            end_x = 5,
                            end_y = 22,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_6",
    name = ccb.content.text("Gather 75 Rocks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "rock",
    item_count = 75,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_7",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Our current assessment for survivability has increased significantly thanks to your efforts.  The next priority issue is securing a cleaner water source.  Drinking from the pond on the back end of the ranch has led to an outbreak of dysentery.  We need to improve the sanitary conditions in the camp as quickly as possible.  To do so, the first step is to dig a well and construct stone fireplaces in the barn for the migrants to boil water.  We are going to need at least 75 rocks from you if we hope to accomplish the task before we all get sick.  After we have them installed, you will have free access to them, guaranteed."),
        accepted = ccb.content.text("If you take a shovel to a pile of rubble, you should be able to pull out structural grade rocks."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Mining would always be an option if you had the resources."),
        inquire = ccb.content.text("Do you have the rocks?"),
        success = ccb.content.text("I appreciate the work you do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_58",
                layout = {
                    nested = { { x = 0, y = 2, id = "tacoma_commune_lumbermill_6" } },
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_covered_well", x = 6, y = 18 },
                    },
                },
            },
            {
                terrain = "ranch_camp_66",
                layout = {
                    item_placements = {
                        { id = "log", x = 3, y = 11 },
                        { id = "log", x = 3, y = 12 },
                        { id = "log", x = 3, y = 13 },
                        { id = "log", x = 11, y = 11 },
                        { id = "log", x = 11, y = 12 },
                        { id = "log", x = 11, y = 13 },
                    },
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_fireplace", x = 6, y = 12 },
                        { shape = "point", operation = "furniture", id = "f_fireplace", x = 8, y = 12 },
                    },
                },
            },
        },
    },
}

-- western palisade
-- finish the well
-- untilled soil in the fields
ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_7",
    name = ccb.content.text("Gather 50 Pipes"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "pipe",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_8",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("To fabricate the well's hand pump and construct components for several other projects, we are going to need to find or fabricate a number of steel pipes.  Plumbing is a distant possibility for now, but some form of irrigation will eventually become desirable.  You could assist us with procuring 50 steel pipes, if you so have the chance."),
        accepted = ccb.content.text("Hopefully we will be able to assign new migrants to help fulfill our needs in the future."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Pipes are used in numerous metal constructions.  Smashing abandoned furniture may provide the material we need."),
        inquire = ccb.content.text("Do you have the pipes?"),
        success = ccb.content.text("I appreciate the work you do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_56",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 16,
                            y = 17,
                            end_x = 16,
                            end_y = 23,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 16,
                            y = 14,
                            end_x = 19,
                            end_y = 14,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 19,
                            y = 11,
                            end_x = 19,
                            end_y = 13,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_58",
                layout = {
                    nested = { { x = 0, y = 2, id = "tacoma_commune_lumbermill_7" } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_concrete",
                            x = 5,
                            y = 17,
                            end_x = 7,
                            end_y = 19,
                        },
                        { shape = "point", operation = "terrain", id = "t_water_pump", x = 6, y = 18 },
                    },
                },
            },
            {
                terrain = "ranch_camp_65",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 0,
                            y = 4,
                            end_x = 12,
                            end_y = 18,
                        },
                    },
                },
            },
        },
    },
}

-- finish western palisade
-- tilled soil in the fields
ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_8",
    name = ccb.content.text("Gather 2 Electric Motors"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "motor",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_9",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("With the well's completion, we are rapidly closing the sustainability gap.  In order to expand from here, we will need massive quantities of lumber to construct fortifications and new buildings.  We have already begun work on a manually operated sawmill, but we will need two electric motors to control the actual blades.  We were hoping you might be able to secure the motors for us."),
        accepted = ccb.content.text("Power for the motors will be provided by a salvaged truck battery, you need not bring additional mechanical components."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("A car dealership or a golf course might have some electric vehicles to get one from.  Otherwise there's probably something broken down along the road."),
        inquire = ccb.content.text("Do you have the motors?"),
        success = ccb.content.text("I appreciate the work you do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_56",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 23,
                            y = 7,
                            end_x = 23,
                            end_y = 10,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 20,
                            y = 11,
                            end_x = 23,
                            end_y = 11,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade_gate",
                            x = 16,
                            y = 15,
                            end_x = 16,
                            end_y = 16,
                        },
                        { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 15, y = 14 },
                        { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 17, y = 17 },
                    },
                },
            },
            {
                terrain = "ranch_camp_58",
                layout = { nested = { { x = 0, y = 2, id = "tacoma_commune_lumbermill_8_done" } } },
            },
            {
                terrain = "ranch_camp_59",
                layout = {
                    nested = {
                        { x = 13, y = 17, id = "tacoma_commune_toolshed_8" },
                        { x = 2, y = 0, id = "tacoma_commune_clinic_8" },
                    },
                },
            },
            {
                terrain = "ranch_camp_65",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 1,
                            y = 5,
                            end_x = 2,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 4,
                            y = 5,
                            end_x = 5,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 7,
                            y = 5,
                            end_x = 8,
                            end_y = 17,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirtmound",
                            x = 10,
                            y = 5,
                            end_x = 11,
                            end_y = 17,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_68",
                layout = { nested = { { x = 16, y = 1, id = "tacoma_commune_outhouse_8" } } },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_9",
    name = ccb.content.text("Gather 150 Units of Bleach"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "bleach",
    item_count = 150,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_10_1",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Disease and infection remains a persistent problem among the refugees.  Without dedicated medical personnel and facilities, I doubt everyone will be willing to stick around when the next outbreak happens.  Until we can get a former medic or nurse, I'm just going to have to improvise.  Sterilization would be the first step I imagine.  Bring me 150 units of bleach so we can get started."),
        accepted = ccb.content.text("I'm sure you can find bleach in most homes…"),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("If you can't find a large supply I'd recommend checking hospitals or research labs."),
        inquire = ccb.content.text("Do you have the bleach?"),
        success = ccb.content.text("I appreciate it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = {
                    nested = {
                        { x = 13, y = 17, id = "tacoma_commune_toolshed_9_done" },
                        { x = 2, y = 0, id = "tacoma_commune_clinic_9" },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 10,
                            y = 23,
                            end_x = 12,
                            end_y = 23,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_68",
                layout = { nested = { { x = 16, y = 1, id = "tacoma_commune_outhouse_9_done" } } },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_10_1",
    name = ccb.content.text("Gather 36 bandages"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "bandages",
    item_count = 36,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_10",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We've started planning a medical clinic, but we are going to need a lot more supplies if we hope to warrant sending one of the few people with medical experience from the refugee center to our outpost.  I know first aid equipment is rare, but they have all the basic supplies that I'm uncertain of.  If you could bring in thirty-six bandages I'm sure we could supplement them to make theirs last a bit longer."),
        accepted = ccb.content.text("We'll do our best to make them last…"),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Homes, hospitals, labs, and doctor offices would be where I'd check."),
        inquire = ccb.content.text("Do you have the bandages?"),
        success = ccb.content.text("I appreciate it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = { nested = { { x = 2, y = 0, id = "tacoma_commune_clinic_10_1" } } },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_10",
    name = ccb.content.text("Gather 6 bottles (60 units) of antiseptic"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "disinfectant",
    item_count = 60,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_11",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We've started planning a medical clinic, but we are going to need a lot more supplies if we hope to warrant sending one of the few people with medical experience from the refugee center to our outpost.  I know first aid equipment is rare, but they have all the basic supplies that I'm uncertain of.  If you could bring in 6 bottles of antiseptic, I'm sure we could supplement them to make theirs last a bit longer."),
        accepted = ccb.content.text("We'll do our best to make them last…"),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Homes, hospitals, labs, and doctor offices would be where I'd check."),
        inquire = ccb.content.text("Do you have the antiseptic?"),
        success = ccb.content.text("I appreciate it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = { nested = { { x = 2, y = 0, id = "tacoma_commune_clinic_10" } } },
            },
            {
                terrain = "ranch_camp_60",
                layout = { nested = { { x = 0, y = 4, id = "tacoma_commune_chopshop_10" } } },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_11",
    name = ccb.content.text("Find 2 Arc Welders"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "welder",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_12",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The work you have done has swayed the leaders at the refugee center to send someone out to assist with our medical needs.  The next step is for us to get a sort of chop-shop setup so that we can begin using scrap metal to build fortifications and equipment.  We are going to need a pair of arc welders for our mechanics to use."),
        accepted = ccb.content.text("With two, we should be able to repair one if it breaks."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("The only place I've seen them is garages, but I imagine you could find them in some stores."),
        inquire = ccb.content.text("Do you have the welders?"),
        success = ccb.content.text("I appreciate it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_59",
                layout = { nested = { { x = 3, y = 0, id = "tacoma_commune_clinic_11" } } },
            },
            {
                terrain = "ranch_camp_60",
                layout = { nested = { { x = 0, y = 4, id = "tacoma_commune_chopshop_11" } } },
            },
            {
                terrain = "ranch_camp_61",
                layout = {
                    vehicle_placements = {
                        { id = "car", chance = 100, rotation = 270, x = 1, y = 20, faction = "tacoma_commune" },
                        {
                            id = "cube_van_cheap",
                            chance = 100,
                            rotation = 90,
                            x = 10,
                            y = 10,
                            faction = "tacoma_commune",
                        },
                        {
                            id = "car_sports",
                            chance = 100,
                            rotation = 90,
                            x = 3,
                            y = 9,
                            faction = "tacoma_commune",
                        },
                        {
                            id = "pickup",
                            chance = 100,
                            rotation = 180,
                            x = 8,
                            y = 22,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_69",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    vehicle_placements = {
                        {
                            id = "car_chassis",
                            chance = 100,
                            rotation = 0,
                            x = 3,
                            y = 14,
                            faction = "tacoma_commune",
                        },
                        {
                            id = "pickup",
                            chance = 100,
                            rotation = 0,
                            x = 8,
                            y = 15,
                            faction = "tacoma_commune",
                        },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_palisade",
                            x = 0,
                            y = 12,
                            end_x = 2,
                            end_y = 12,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_70",
                layout = {
                    vehicle_placements = {
                        {
                            id = "schoolbus",
                            chance = 100,
                            rotation = 120,
                            x = 4,
                            y = 13,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_12",
    name = ccb.content.text("Find 12 Car Batteries"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "battery_car",
    item_count = 12,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_13",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We have the basic equipment that we need, but without a functioning power grid, we are forced to rely on the readily available vehicle batteries.  This is going to be a chore, but I'll need twelve car batteries to swap between charging and powering our equipment.  The good news is that they don't need to be charged; we can take care of that."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Cars can be found in traffic jams along roads or in parking lots… I'm sure you can find a few."),
        inquire = ccb.content.text("Do you have the car batteries?"),
        success = ccb.content.text("I'm impressed with your abilities."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_49",
                layout = { nested = { { x = 0, y = 9, id = "tacoma_commune_junk_shop_12" } } },
            },
            {
                terrain = "ranch_camp_60",
                layout = { nested = { { x = 0, y = 4, id = "tacoma_commune_chopshop_12_done" } } },
            },
            {
                terrain = "ranch_camp_69",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    vehicle_placements = {
                        {
                            id = "cube_van",
                            chance = 100,
                            rotation = 180,
                            x = 13,
                            y = 15,
                            faction = "tacoma_commune",
                        },
                        {
                            id = "car_sports",
                            chance = 100,
                            rotation = 0,
                            x = 21,
                            y = 14,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_13",
    name = ccb.content.text("Find 2 Two-Way Radios"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "two_way_radio",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_14",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Check with the nurse when you get a chance; I know she will need help setting up our clinic.  On the construction front, we are going to need to get dedicated scavenger teams setup to bring in the miscellaneous supplies that we use in small quantities.  We are going to start setting up a junk shop for them behind the sawmill, so we could use your help with that.  Communication is the biggest obstacle for the teams… could you bring in a pair of two-way radios?"),
        accepted = ccb.content.text("Organizing the scavenging missions is difficult enough without communication."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You should be able to find them in electronics stores or at a police station."),
        inquire = ccb.content.text("Do you have the two-way radios?"),
        success = ccb.content.text("I'm sure the scavengers will find these useful."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_49",
                layout = { nested = { { x = 0, y = 9, id = "tacoma_commune_junk_shop_13" } } },
            },
            {
                terrain = "ranch_camp_51",
                layout = { nested = { { x = 0, y = 0, id = "tacoma_commune_bar_13" } } },
            },
            {
                terrain = "ranch_camp_66",
                layout = { npc_placements = { { id = "ranch_barber", x = 5, y = 3 } } },
            },
            {
                terrain = "ranch_camp_70",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    vehicle_placements = {
                        {
                            id = "car_sports",
                            chance = 100,
                            rotation = 90,
                            x = 9,
                            y = 2,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_14",
    name = ccb.content.text("Gather 5 Backpacks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "backpack",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_15",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The volunteers for the scavenging teams will need to be issued some basic equipment.  When the boss sets up shop in the junk shed, you should ask him what else he needs for his teams.  In the meantime, we can provide a few backpacks to get them started.  Could you find five backpacks to give to the initial team?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("It may be easier to make them if you can't find a school or something."),
        inquire = ccb.content.text("Do you have the backpacks?"),
        success = ccb.content.text("Having at least basic equipment greatly increases survivability.  Thanks."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_49",
                layout = { nested = { { x = 0, y = 9, id = "tacoma_commune_junk_shop_14_done" } } },
            },
            {
                terrain = "ranch_camp_51",
                layout = { nested = { { x = 0, y = 0, id = "tacoma_commune_bar_14" } } },
            },
            {
                terrain = "ranch_camp_61",
                layout = {
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                    vehicle_placements = {
                        {
                            id = "ambulance",
                            chance = 100,
                            rotation = 270,
                            x = 13,
                            y = 2,
                            faction = "tacoma_commune",
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_15",
    name = ccb.content.text("Find a copy of Homebrewer's Bible"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "brewing_cookbook",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_16",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Growth has lately begun to stall.  We have individuals passing through the outpost, but the prospect of hard labor just to eke out an existence is driving them away.  We've asked around and decided that, despite our pressing needs, building a bar ought to draw some of the less committed individuals to the outpost.  Unlike other settlements, the more hands we have, the more food we can produce… at least in the long term.  Unfortunately, no one here has brewed alcoholic drinks before, so we are going to need you to find a book called the 'Homebrewer's Bible' or something along those lines."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("I guess you should search homes or libraries?"),
        inquire = ccb.content.text("Do you have the book?"),
        success = ccb.content.text("I guarantee we will toast to your name when the bar is finished."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = { nested = { { x = 0, y = 0, id = "tacoma_commune_bar_15" } } },
            },
            {
                terrain = "ranch_camp_52",
                layout = {
                    vehicle_placements = {
                        {
                            id = "car_mini",
                            chance = 100,
                            rotation = 90,
                            x = 15,
                            y = 21,
                            faction = "tacoma_commune",
                        },
                    },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 2,
                            y = 10,
                            end_x = 12,
                            end_y = 22,
                        },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_16",
    name = ccb.content.text("Gather 110lb (10000 units) of Sugar"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "sugar",
    item_count = 10000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_17",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Just flipping through the book, I can tell that one ingredient in most of the alcoholic drinks that we don't have a large supply of is sugar.  What alcohol we have been able to loot isn't going to last us long, so starting our first large batch is a priority.  Could you bring in 110 lbs of sugar?  That should last us until we can start producing our own supply."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You might get lucky finding it, but you could always boil it out of fruit if you are familiar with the process.  Or go into the cities and look in restaurants and bakeries."),
        inquire = ccb.content.text("Do you have the sugar?"),
        success = ccb.content.text("There is a large group of thirsty individuals in our outpost that are truly thankful for your work."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = { nested = { { x = 0, y = 0, id = "tacoma_commune_bar_16_done" } } },
            },
            {
                terrain = "ranch_camp_52",
                layout = { nested = { { x = 2, y = 10, id = "tacoma_commune_greenhouse_16" } } },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_17",
    name = ccb.content.text("Collect 30 Glass Sheets"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "glass_sheet",
    item_count = 30,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_NULL",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Although we are an agricultural outpost, we are restricted to growing plants that are compatible with the New England climate during the warmer months.  The easiest way to work around that is to build greenhouses to supplement our external fields.  There isn't going to be an easy way to build these.  We are going to need a massive number of glass sheets to enclose the frames.  The first house will need 30 sheets of glass if you are still interested."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Deconstructing existing windows is the only way I know of to keep the sheets intact."),
        inquire = ccb.content.text("Do you have the glass sheets?"),
        success = ccb.content.text("We'll begin planting our first seeds as soon as we can get these installed."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_52",
                layout = { nested = { { x = 2, y = 10, id = "tacoma_commune_greenhouse_17_done" } } },
            },
        },
    },
}
