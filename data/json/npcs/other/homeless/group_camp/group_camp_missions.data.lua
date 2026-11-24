local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_KILL_SLIMES",
    name = ccb.content.text("Sticky Situation"),
    description = ccb.content.text("Kill some slimes in exchange for credit with some of the traders and bring back six of their slime scraps."),
    goal = "MGOAL_FIND_ITEM",
    item = "slime_scrap",
    item_count = 6,
    difficulty = 1,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_HUNT_ANTS",
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, search_range = 15, min_distance = 10 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_blob", pack_size = { 6, 6 }, x = 8, y = 8, target = true },
                    },
                },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("We've had some trouble with slimes not far from us.  It's been hard going through there with all them around, so I want you to go take care of it."),
        advice = ccb.content.text("Sure, they can be cut, but I'd say it's better to splatter them with something large and heavy."),
        accepted = ccb.content.text("I'll be here when you get back."),
        rejected = ccb.content.text("No problem.  I'm sure one of us will get to it anyway."),
        inquire = ccb.content.text("Are those slimes dead yet?"),
        success = ccb.content.text("Nice.  I'll just take those off your hands.  Might be good for greasing the bike chains and door hinges around here even though it is a bit… abnormal."),
        success_lie = ccb.content.text("You don't look nearly as sticky as you're supposed to.  Get back to it."),
        failure = ccb.content.text("Did they give you the slip?  It's worse than I thought, then."),
    },
}

ccb.content.define_mission {
    id = "MISSION_HUNT_ANTS",
    name = ccb.content.text("Arthropod Hunting"),
    description = ccb.content.text("Kill some ants and bring back ten slices of their meat in exchange for credit with some of the traders."),
    goal = "MGOAL_FIND_ITEM",
    item = "mutant_meat",
    item_count = 10,
    difficulty = 1,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_1",
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, search_range = 15 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_ant", pack_size = { 2, 2 }, x = 8, y = 8, target = true },
                    },
                },
            },
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_ant_meat_tradeable", "yes"),
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("The last time we went out scouting we found some gargantuan ants crawling around.  We thought we might see how they taste, if they could be cooked and whatnot.  I want you to go kill one and bring back some of its meat."),
        advice = ccb.content.text("A shotgun of some sort might work well."),
        accepted = ccb.content.text("I'll be here when you get back."),
        rejected = ccb.content.text("Alright, I can understand that."),
        inquire = ccb.content.text("Do you have the meat?"),
        success = ccb.content.text("Nice.  I'll get these cooked up.  Who knows, we might want some more in the future."),
        success_lie = ccb.content.text("You sure?  I don't see my meat anywhere."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_1",
    name = ccb.content.text("Refurbishments"),
    description = ccb.content.text("Obtain 100 planks."),
    goal = "MGOAL_FIND_ITEM",
    item = "2x4",
    item_count = 100,
    difficulty = 1,
    value = 10000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_2",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_1" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("My buddies and I have decided to stay here for a while.  This is about the only safe place out here, and it's kinda become our home.  Anyway, we're going to build a wall.  Our old logs have provided a bunch of the wood, but we still need quite a few planks.  About 100 of them.  If you could get it for us, I'd be grateful."),
        advice = ccb.content.text("Any nearby forest should have all you need.  Otherwise, you might try breaking down some furniture in town."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my lumber?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_2",
    name = ccb.content.text("Refurbishments Pt. II"),
    description = ccb.content.text("Obtain 150 planks."),
    goal = "MGOAL_FIND_ITEM",
    item = "2x4",
    item_count = 150,
    difficulty = 1,
    value = 15000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_3",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, z = 0, id = "homeless_camp_refurb_2" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Now that we've got the wall done, we decided to move out of these old tents.  We still have some leftover nails but we need more wood.  So, if you could get us 150 planks, we'd be grateful."),
        advice = ccb.content.text("Any nearby forest should have all you need.  Otherwise, you might try breaking down some furniture in town."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my lumber?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}

-- TO-DO - Dynamic response dialogs would be more natural to accept so many alternate items here and everywhere else these conditional item accept conditions appear.
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_3",
    name = ccb.content.text("Refurbishments Pt. III"),
    description = ccb.content.text("Obtain 6 ropes."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_4",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_3" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Our entrance is wide open so we're building a gate over it.  Problem is we don't have any ropes.  If you could find some for us, we'll pay you."),
        advice = ccb.content.text("If you can't find any rope around, one of our books should have something on rope-making.  Most plants can be woven into a halfway decent rope."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my ropes?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
    complete_when = "complete_mission_build_camp_3",
}

-- TO-DO - Dynamic response dialogs would be more natural to accept so many alternate items here and everywhere else these conditional item accept conditions appear.
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_4",
    name = ccb.content.text("Refurbishments Pt. IV"),
    description = ccb.content.text("Obtain a wood saw."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_5",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("We appreciate all of your help but we can't rely on everyone else to do things for us.  I'd be willing to buy a wood saw of some kind from you so we can cut our own wood as needed."),
        advice = ccb.content.text("A hardware store or lumbermill should have one."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my saw?"),
        success = ccb.content.text("Thank you.  Pick what you want from our stash."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
    complete_when = "complete_mission_build_camp_4",
}

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_5",
    name = ccb.content.text("Refurbishments Pt. V"),
    description = ccb.content.text("Obtain a shovel."),
    goal = "MGOAL_FIND_ITEM",
    item = "shovel",
    item_count = 1,
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_6",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_4" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Our sanitation here has become… problematic.  We've mostly just been going outside the walls to piss.  Not only is it kinda unhealthy, but the last time I wandered out I almost got eaten!  So, if you'd get us a shovel, we could make a latrine for ourselves.  We'll pay you fairly, as usual."),
        advice = ccb.content.text("A hardware store should have one lying around."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have the shovel?"),
        success = ccb.content.text("Thank you.  We're eternally grateful to you."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("I'll do it myself, then."),
    },
}

-- TO-DO - Maybe add a physical charcoal smoker 'fake_char_smoker' to the camp mapgen?
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_6",
    name = ccb.content.text("Refurbishments Pt. VI"),
    description = ccb.content.text("Obtain a charcoal smoker."),
    goal = "MGOAL_FIND_ITEM",
    item = "char_smoker",
    item_count = 1,
    difficulty = 1,
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_5" } } },
            },
        },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_smoked_meat_tradeable", "yes"),
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Turns out that ant meat you got us wasn't actually too bad.  A little tough, sure, but perfectly edible.  The problem now is we need a way of preserving it.  One of those portable charcoal smokers would be really great.  Heck, you might even wanna buy some."),
        advice = ccb.content.text("Maybe try a farm?  I bet those rural folks were pretty invested in preserving their food."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have the charcoal smoker?"),
        success = ccb.content.text("Thank you.  We'll get started right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}
