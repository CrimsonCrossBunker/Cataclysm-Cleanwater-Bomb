local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "NPC_lighthouse_man",
    gender = "male",
    class = "NC_NONE",
    unique_name = ccb.content.text("Mikhail Frolov"),
    suffix = ccb.content.text("Fisherman"),
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_lighthouse_man_1",
    faction = "fisherman_family",
    missions_offered = "MISSION_lighthouse_man_1",
}

ccb.content.define_npc_class {
    id = "NC_lighthouse_man",
    common = false,
    name = ccb.content.text("Fisherman"),
    job_description = ccb.content.text("I'm just wandering."),
    shop_groups = "NPC_lighthouse_man_shop",
    traits = { { group = "NPC_starting_traits" }, { group = "Appearance_Caucasian" } },
    skills = {
        {
            skill = "ALL",
            level = { mul = { { one_in = 3 }, { sum = { { dice = { 4, 2 } }, { rng = { -4, -1 } } } } } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_lighthouse_man_1", "TALK_lighthouse_man_Background", "TALK_lighthouse_man_hay", "TALK_lighthouse_man_survivors_yes", "TALK_lighthouse_man_survivors_no" },
    line = ccb.content.text("<greet>"),
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("<BGSS_intro_question>"),
            next_topic = "TALK_lighthouse_man_Background",
        },
        {
            text = ccb.content.text("How are you doing?"),
            next_topic = "TALK_lighthouse_man_hay",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_help_helped_lighthouse_man" } }),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_lighthouse_man_1",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "flag_help_helped_lighthouse_man" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Has anyone come recently?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "global_safe_space_lighthouse_fixed" } }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_372a8aa8260c") },
            success = { next_topic = "TALK_lighthouse_man_survivors_yes", actions = { actions.handler("dlg_a_dda_81e6145c1e01"), actions.update_map("lighthouse_man_survivor", "lighthouse_ground") } },
            failure = { next_topic = "TALK_lighthouse_man_survivors_no" },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_Background",
    line = ccb.content.text("I'm just a simple man from a simple family.  Before <the_cataclysm> I had a fishing boat, and I went to sea on it, to catch fish and other marine life.  This is how my grandfather lived, my father lived, and I began to live like that.  I had a large family, 7 children, but not many survived, only my wife and daughter remained…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_hay",
    line = ccb.content.text("You know, pretty good.  It is cozy here, there is a lot of space, and most importantly, it's safe.  We even started considering this place as our new home.  By the way, while I was fishing, a bottle with a piece of paper came to the shore of our island.  Here, take a look.\", he gave you a piece of paper, something was written on it: '0030045-0030045-35321700', with something similar to lightning scribbled nearby.  \"I wonder what it could mean…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_yes",
    line = ccb.content.text("Good news, <name_g>.  One survivor sailed to us recently."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_no",
    line = ccb.content.text("Nobody came, <name_g>.  I'm beginning to doubt that anyone else has survived besides us…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_lighthouse",
    line = ccb.content.text("Are we there yet, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_lighthouse_man_lighthouse",
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("We're here."),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.actor_state("interlocutor", "mission_complete"),
            actions = { "stop_following", actions.set_first_topic("TALK_lighthouse_man_1") },
        },
        {
            text = ccb.content.text("Almost."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaning",
    line = ccb.content.text("Is it safe, my <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Yes.  Ground floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_fec335eb9be6"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  First floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_68b8f4637593"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Second floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_29d23b48e708"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Third floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_98ac3e0825da"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Fourth floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned",
            when = predicates.handler("dlg_p_dda_da9c2bf37a4d"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Yes.  Top floor is clear."),
            next_topic = "TALK_lighthouse_man_cleaned_done",
            when = predicates.handler("dlg_p_dda_b06a4ea01e6e"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Looks like that's over."),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.handler("dlg_p_dda_2a9fd24c7bad"),
            actions = { actions.handler("dlg_a_dda_a7048e987687") },
        },
        {
            text = ccb.content.text("Not yet."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaned",
    line = ccb.content.text("<its_safe>  Let's clean the next floor."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaned_done",
    line = ccb.content.text("<its_safe>  Let's return to the first floor."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_family",
    line = ccb.content.gendered_line("Did you find them, <name_g>?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("We did it.  All safe."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.all({ predicates.has_mission("MISSION_lighthouse_man_3"), predicates.negate(predicates.actor_state("interlocutor", "mission_complete")), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_girl" } }) }),
            actions = { "mission_success", actions.set_first_topic("TALK_lighthouse_man_1") },
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring them alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }) }),
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring your wife alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_girl" } }) }),
        },
        {
            text = ccb.content.text("I'm sorry, I failed you… I couldn't bring your daughter alive…"),
            next_topic = "TALK_lighthouse_man_fail",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "mission_complete")), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_safe_lighthouse_woman" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "flag_death_lighthouse_girl_dead" } }) }),
        },
        { text = ccb.content.text("Nothing, really."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_fail",
    line = ccb.content.text("<name_g>… I entrusted you with the most valuable thing that I have left, and you…"),
    replies = {
        {
            text = ccb.content.text("I'm sorry…"),
            next_topic = "TALK_DONE",
            native_actions = { "mission_failure", "clear_mission", "end_conversation" },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_1",
    generic_rewards = false,
    name = ccb.content.text("Lighthouse"),
    description = ccb.content.text("Lead Mikhail to lighthouse."),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 5000,
    start = {
        target = {
            terrain = "lighthouse_ground",
            special = "Lighthouse Island",
            reveal_radius = 10,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "lighthouse_ground",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 1, 22 }, y = { 1, 22 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z1",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z2",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z3",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z4",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z5",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
        },
        actions = {
            "follow_only",
            ccb.content.dialogue_actions.set_first_topic("TALK_lighthouse_man_lighthouse"),
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_lighthouse_man_2",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("We've been wandering around the state with my family for a long time since <the_cataclysm>, and I realized that the safest hideout is the island.  I left my family in a shelter, and went to explore the area, looking for some island nearby, in a lake or in the ocean.  And you know, I found a sea map marked with navigational beacons near here.  If you want, you can help me get to one of these and take a good look at it."),
        accepted = ccb.content.text("Good.  I'll be right behind you."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("First we need to find a transport to get there."),
        inquire = ccb.content.text("We finally reached it."),
        success = ccb.content.text("Looks nice, <name_g>.  Now I need to clean it from <zombies> somehow…"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}

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

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_5",
    name = ccb.content.text("Fixing lighthouse"),
    description = ccb.content.text("Mikhail asked you to find someone, who have enough expertise to fix the mechanism of lighthouse."),
    goal = "MGOAL_CONDITION",
    difficulty = 0,
    value = 100000,
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        map_updates = {
            {
                terrain = "lighthouse_z5",
                layout = {
                    terrain_placements = {
                        { id = "t_floor_olight", x = 11, y = 12 },
                        { id = "t_floor_olight", x = 13, y = 13 },
                    },
                },
            },
        },
        actions = {
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "time_survivors_wait" }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "global_safe_space_lighthouse_fixed", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("My family is here, we have food, water, boat and a roof over our heads, all thanks to you, <name_g>.  Now, I also want to help other survivors.  Here's what I thought: if I can get this old lighthouse up and running, other survivors will see its light from afar.  If they see it, they will think that there are living people here, and will try to get here.  Can you help me fix it?"),
        accepted = ccb.content.text("I knew you wouldn't refuse!  But there is one problem: I have no idea how to fix it.  Maybe if you met someone who have experience in electrical engineering, we can figure out how to start this old junk."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("I'm sure that not all burned in flames of <the_cataclysm> and you can find someone suitable."),
        inquire = ccb.content.text("Well, have you fixed it?"),
        success = ccb.content.text("Splendid, <name_g>!  We can only wait now…"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
    complete_when = "complete_mission_lighthouse_man_5",
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lighthouse_man_survivor",
    layout = {
        npc_placements = { { id = "NPC_survivor_lighthouse", x = { 7, 17 }, y = { 10, 15 } } },
    },
}
