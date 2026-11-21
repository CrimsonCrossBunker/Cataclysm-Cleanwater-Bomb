local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_2",
    generic_rewards = false,
    name = ccb.content.text("House cleaning"),
    description = ccb.content.text("Clean lighthouse from <zombies> with Mikhail."),
    goal = "MGOAL_CONDITION",
    complete_when = "complete_mission_lighthouse_man_2",
    difficulty = 0,
    value = 5000,
    start = {
        actions = {
            "follow_only",
            ccb.content.dialogue_actions.set_first_topic("TALK_lighthouse_man_cleaning"),
            { handler = "reset_lighthouse_man_cleaning_count" },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        map_updates = {
            {
                terrain = "lighthouse_ground",
                layout = {
                    faction_areas = {
                        { id = "fisherman_family", x = { 0, 23 }, y = { 0, 23 } },
                    },
                    zone_placements = {
                        { id = "NPC_INVESTIGATE_ONLY", faction = "fisherman_family", x = { 0, 23 }, y = { 0, 23 } },
                    },
                },
            },
        },
        actions = {
            "stop_following",
            ccb.content.dialogue_actions.set_first_topic("TALK_lighthouse_man_1"),
            ccb.content.dialogue_actions.clear_actor_value("interlocutor", "count_cleaning_lighthouse_man"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_lighthouse_man_3",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("So, we found the lighthouse.  Now, I need to clean it.  Want to help me with it?"),
        accepted = ccb.content.text("Great.  Let's do it together.  I'll be right behind you.  We will clean floor by floor.  If you decide that the floor is clean, tell me about it, and we will move on to the next, and so on to the very top."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("Be careful.  These <name_b>s are most dangerous in tight spaces."),
        inquire = ccb.content.text("<its_safe>"),
        success = ccb.content.text("Great, incredibly great.  All that remains is to wash all the floors…"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_3",
    name = ccb.content.text("Fisherman's family"),
    description = ccb.content.text("Mikhail asked you to bring back his family."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 0,
    value = 25000,
    start = {
        target = { terrain = "house_04_basement", reveal_radius = 2 },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "NPC_lighthouse_woman", x = 4, y = 8, target = true },
                        { id = "NPC_lighthouse_girl", x = 3, y = 8 },
                    },
                },
            },
        },
        actions = { ccb.content.dialogue_actions.set_first_topic("TALK_lighthouse_man_family") },
    },
    -- Native mission phases did not apply the giver opinion (trust +6, value +6).
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "flag_help_lighthouse_family_safe", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_lighthouse_man_4",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("We found the lighthouse and cleared it of <zombies>.  Now, I need to bring my family here.  May I ask you for a favor?  Since you bring me here, can you go back, find my family and bring them here?"),
        accepted = ccb.content.text("You are my savior!  I'll take a look around here for a while, prepare everything here for their arrival."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("Please be very careful.  I don't want to lose them…"),
        inquire = ccb.content.text("-"),
        success = ccb.content.text("I don't even know how to thank you, <name_g>.  I am in eternal debt to you."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_4",
    name = ccb.content.text("Fisherman's boat"),
    description = ccb.content.text("Help Mikhail make a boat.  Bring 250 nails."),
    goal = "MGOAL_FIND_ITEM",
    item = "nail",
    item_count = 250,
    difficulty = 0,
    value = 10000,
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        map_updates = {
            {
                terrain = "lighthouse_ground",
                layout = {
                    vehicle_placements = {
                        { id = "canoe", x = 3, y = 3, rotation = 0, status = 0, chance = 100 },
                    },
                },
            },
        },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "flag_help_helped_lighthouse_man", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_lighthouse_man_5",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("The building has been cleared of <zombies>, my family is here, everything is going very well.  It remains only to provide ourselves with food, transport and we can not worry about the future.  You helped me and my family so much, can you help us with something else?  I need a boat for fishing, or just to explore the area.  Can you help me make a boat?"),
        accepted = ccb.content.text("Thank you, <name_g>.  I need only 250 nails.  I'll find the planks, the rest of the tools too, but the main problem is the nails.  Too much for one boat, but I want to have resources in reserve, just in case."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("Please, if you can, don't disassemble furniture here.  It can still be useful."),
        inquire = ccb.content.text("Did you find it?"),
        success = ccb.content.text("Very good, <name_g>, thank you!  Now we are not afraid of hunger, rain, or other bad weather, he-he.  By the way, I have a small supply of fish, tackle, baits and rods.  If you are interested, I can share some with you."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
