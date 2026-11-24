local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates

-- Breadcrumb quest from Free Merchants -> Hub 01.  Bring a hard drive to Hub 01 from the refugee center and then return.
ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
    name = ccb.content.text("Unknown Recipient"),
    description = ccb.content.text("Deliver the FEMA hard drive to the strange group that Smokes mentioned.  Return to the evacuation center when the data's been delivered."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    start = {
        target = { terrain = "robofachq_surface_entrance", special = "hub_01", reveal_radius = 1 },
        item_rewards = { { item = "fema_data", count = 1 } },
    },
    finish = { handler = "set_world_free_merchants_hub_trade_route_to_1" },
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Got the hard drive delivered?"),
        success = ccb.content.text("Oh, good.  I'm glad you're alright; I had no idea what to make of them.  Well, one less thing to worry about."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("At least you came back alive.  Don't sweat it too much - it's no skin off my back.  If they want it that bad, they can come get another copy themselves."),
    },
    complete_when = "complete_mission_free_merchants_hub_delivery_1",
}

-- om_special does nothing because we are at the evac_center. I added this to make the linter happy.
ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_1",
    name = ccb.content.text("Clear Back Bay"),
    description = ccb.content.text("Clear out the barricaded back area in the refugee center and lay the former leader of the Free Merchants to rest, in exchange for the local currency: Free Merchant certified notes."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 2,
    value = 50000,
    start = {
        target = { special = "evac_center", terrain = "evac_center_9", reveal_radius = 1 },
        map_updates = {
            {
                terrain = "evac_center_9",
                layout = {
                    monster_placements = {
                        {
                            group = "GROUP_REFUGEE_BOSS_ZOMBIE",
                            name = ccb.content.text("Sean McLaughlin"),
                            x = 10,
                            y = 10,
                            target = true,
                        },
                    },
                },
            },
        },
        actions = {
            ccb.content.dialogue_actions.update_map("smokes_take_down_back_bay_barricade", "evac_center_8"),
        },
    },
    finish = {
        map_updates = {
            {
                terrain = "evac_center_9",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 0,
                            y = 23,
                            end_x = 1,
                            end_y = 23,
                        },
                    },
                },
            },
        },
        actions = {
            { item = "FMCNote", count = 25 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_FMShopkeep_Mission1", "yes"),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_3" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("If you really want to lend a hand we could use your help clearing out the dead in the back bay.  Fearful of going outside during the first days of the Cataclysm we ended up throwing our dead and the zombies we managed to kill in the sealed back bay.  Our promising leader at the time even fell… he turned into something different.  Kill all of them and make sure they won't bother us again.  We can't pay much, besides some of our own internal money which isn't good for that much yet, but it would help us to reclaim the bay.  <color_red>If you accept, I'll tell the guards to immediately take down the barricade in the back.  You should only accept if you're ready to do this now.</color>"),
        accepted = ccb.content.text("Please be careful, we don't need any more deaths."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("If you can, get a friend or two to help you."),
        inquire = ccb.content.text("Will they be bothering us any longer?"),
        success = ccb.content.text("Thank you, having that big of a threat close to home was nerve wracking.  Here's some of our local certified notes, we've been paying these to our workers in exchange for supplies.  They're getting some value in the center as a trade item, I'm afraid they're all we have to spare at the moment."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_2",
    name = ccb.content.text("Missing Caravan"),
    description = ccb.content.text("Investigate the last known location of a disappeared scavenger trading party, and eliminate any bandits or raiders in the vicinity in exchange for <reward_count:FMCNote> certified notes."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 5000,
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, search_range = 80 },
        map_updates = {
            {
                layout = {
                    rows = {
                        "                        ",
                        "                        ",
                        "                        ",
                        "      ggggggggggggg     ",
                        "      ggggggggggggg     ",
                        "      gg....R...ggg     ",
                        "      gg........ggg     ",
                        "      gg.......Rggg     ",
                        "      gg.F..a...ggg     ",
                        "      gg........ggg     ",
                        "      gg........ggg     ",
                        "      gg........ggg     ",
                        "      gg........ggg     ",
                        "      gg........ggg     ",
                        "      ggggggggggggg     ",
                        "      ggggggggggggg     ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "            b b         ",
                        "           b bb         ",
                        "             b          ",
                        "                        ",
                        "                        ",
                    },
                    flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
                    field_glyphs = { b = { id = "fd_blood", intensity = 1 } },
                    loot_placements = {
                        { group = "cannedfood", x = { 6, 18 }, y = { 3, 15 }, chance = 100 },
                        {
                            group = "alcohol_bottled_canned",
                            x = { 6, 18 },
                            y = { 3, 15 },
                            repetitions = 2,
                            chance = 75,
                        },
                        {
                            group = "SUS_trash_forest_manmade",
                            x = { 6, 18 },
                            y = { 3, 15 },
                            repetitions = 2,
                            chance = 75,
                        },
                        { group = "stash_drugs", x = { 6, 18 }, y = { 3, 15 }, chance = 75 },
                        { group = "dresser", x = { 9, 10 }, y = { 10, 14 }, chance = 75 },
                        { group = "softdrugs", x = { 9, 10 }, y = { 10, 14 }, chance = 50 },
                        { group = "camping", x = { 9, 10 }, y = { 10, 14 }, chance = 75 },
                        { group = "casings", x = { 10, 15 }, y = { 15, 18 }, repetitions = 5, chance = 100 },
                        { id = "corpse", x = 13, y = 19, chance = 100 },
                        { id = "corpse", x = 12, y = 20, chance = 100 },
                    },
                    npc_placements = {
                        { id = "bandit", x = 15, y = 7 },
                        { id = "thug", x = 12, y = 5 },
                        { id = "bandit", x = 9, y = 8, target = true },
                    },
                    vehicle_placements = {
                        { id = "cube_van", x = 12, y = 12 },
                        {
                            id = "quad_bike",
                            x = 18,
                            y = 7,
                            rotation = 270,
                            fuel = 500,
                            status = -1,
                            chance = 100,
                        },
                        {
                            id = "motorcycle",
                            x = 10,
                            y = 3,
                            rotation = 315,
                            fuel = 500,
                            status = -1,
                            chance = 100,
                        },
                        {
                            id = "motorcycle",
                            x = 7,
                            y = 7,
                            rotation = 90,
                            fuel = 500,
                            status = -1,
                            chance = 100,
                        },
                    },
                    terrain = {
                        g = "t_region_groundcover",
                        ["."] = "t_region_groundcover_barren",
                        a = "t_region_groundcover_barren",
                        b = "t_region_groundcover_barren",
                        R = "t_region_groundcover_barren",
                        F = "t_region_groundcover_barren",
                    },
                    furniture = { a = "f_ash" },
                    traps = { F = "tr_fur_rollmat", R = "tr_rollmat" },
                },
            },
        },
    },
    finish = {
        handler = "mark_mission_flag_FMShopkeep_Mission2",
        item_rewards = { { item = "FMCNote", count = 30 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("This is a bit more involved than the last request, we recently lost a scavenger party coming to trade with us and would like you to investigate.  We strongly suspect a raider band or horde caught them off-guard.  I can give you the coordinates of their last radio message but little else.  In either case, deal with the threat so that the scavengers can continue to pass through in relative safety.  The best reward I can offer is a claim to the supplies they were carrying, plus thirty certified notes - that's our own internal money, good for trading and such."),
        accepted = ccb.content.text("Our community survives on trade, we appreciate it."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("If you can, get a friend or two to help you."),
        inquire = ccb.content.text("Have you dealt with them?"),
        success = ccb.content.text("Thank you, the world is a better place without them.  Two of our more skilled individuals accepted the assistance of the Old Guard in setting up an outpost while you were out.  We didn't have many other options, refugees are still streaming in and we don't know what else to do with our limited food supply.  If you get a chance, you should see if they need your assistance in the future…"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_3",
    name = ccb.content.text("Retrieve Prospectus"),
    description = ccb.content.text("Visit the farming commune and bring the foreman's prospectus back to the refugee center, for <reward_count:FMCNote> certified notes."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "commune_prospectus",
    start = {
        target = { terrain = "ranch_camp_67", special = "ranch_camp", reveal_radius = 1 },
        handler = "mark_knowledge_flag_tacoma_started",
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "ranch_foreman", x = 16, y = 15, target = true, traits = "NPC_MISSION_LEV_1" },
                        { id = "ranch_construction_1", x = 9, y = 17 },
                    },
                },
            },
        },
    },
    finish = {
        handler = "mark_mission_flag_FMShopkeep_Mission3",
        map_updates = {
            {
                terrain = "evac_center_8",
                layout = {
                    tile_edits = {
                        {
                            shape = "point",
                            operation = "terrain",
                            id = "t_gates_mech_control_lab",
                            x = 17,
                            y = 1,
                        },
                        {
                            shape = "point",
                            operation = "terrain",
                            id = "t_gates_mech_control_lab",
                            x = 17,
                            y = 3,
                        },
                    },
                },
            },
        },
        item_rewards = { { item = "FMCNote", count = 50 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We recently set out some skilled people to start an outpost, to secure us some food supplies in a safer location.  The new outpost that we've started could use your assistance.  I need you to get the foreman's prospectus before we begin to send additional refugees to the farming commune.  Consult with the foreman to get more detailed tasks.  We've got 50 Certified Notes for you if you can do this for us."),
        accepted = ccb.content.text("I'm sure the outpost will expand quickly with your assistance."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Just follow your map."),
        inquire = ccb.content.text("Do you have the prospectus?"),
        success = ccb.content.text("With this we'll be able to convince others to invest in the commune.  Thank you, here's your money.  We also managed to get a manual crank hooked up to the garage in the back, so feel free to make use of that - you've been a great help to us."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_4",
    name = ccb.content.text("Solar Power"),
    description = ccb.content.text("Deliver 10 solar panel arrays to help the Free Merchants set up a renewable power grid, in exchange for a handsome reward."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 400000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_5",
    finish = {
        item_rewards = { { item = "FMCNote", count = 100 } },
        handler = { "mark_mission_flag_FMShopkeep_Mission4", "deliver_mission_free_merchants_evac_4" },
    },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("We are starting to build new infrastructure here and would like to get a few new electrical systems online… unfortunately our existing system relies on an array of something called RTGs.  Running generators isn't a viable option underground, of course.  We have a big flat roof up top, and if we had a few solar panel arrays we could use them to top up our usage.  We could pay you pretty handsomely to bring us, say, ten solar panel arrays?  If you find any advanced solar panels, those are even better."),
        accepted = ccb.content.text("If you can do this for us our survival options would vastly increase."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Solar panel arrays are pretty common on solar farms and on rooftops.  Each advanced solar panel array is worth two solar panel array."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great, I know it isn't much but we hope to continue to expand thanks to your help."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    complete_when = "complete_mission_free_merchants_evac_4",
}

ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_5",
    name = ccb.content.text("In a Pickle"),
    description = ccb.content.text("Deliver 100 0.5 L glass jars to the Free Merchants to kickstart their food storage plans."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 400000,
    item = "jar_glass_sealed",
    item_count = 100,
    finish = {
        handler = "mark_mission_flag_FMShopkeep_Mission5",
        item_rewards = { { item = "FMCNote", count = 25 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("While we've managed to secure day to day food supplies, it's very much hand to mouth.  Our reserves would barely last a few days if something kept our people locked in.  We need a stockpile to avoid that.  Thanks to our outpost we have a bit of meat and vegetables coming in, but we need a better way to preserve them.  Some of our people know enough about food canning that if we had a good stock of canning jars, we could make pickles and canned meats to get us set for the winter.  I'll pay you a premium rate if you can bring us around a hundred jars to get us started."),
        accepted = ccb.content.text("It'll take a load off my shoulders if I can finally stop worrying about this."),
        rejected = ccb.content.text("We'll hold for the moment, but I'll get an ulcer if I have to keep worrying.  If you reconsider let me know."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("That's one less thing to worry about.  Glad to have someone like you on our side.  Here's 25 merch, and the broker will buy any further glass jars you can find - at a reduced price, we can't keep up the premium rate.  Actually, the broker was saying they had some jobs like this for you, and that it might be easier to just go straight through their office if you want more work."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac",
    line = ccb.content.text("Well, we had an odd group come by maybe two days after the power grid went off.  Two armed guards wearing brown uniforms, and what looked like a government doctor, had a hazmat suit on.  Everyone had masks they never took off.  They looked organized… maybe a military remnant from somewhere close by."),
    replies = {
        {
            text = ccb.content.text("What were they here for?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac1",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac1",
    line = ccb.content.text("The doctor paid us in advance to get some old FEMA info from our computers here, and told us to deliver the data to an isolated building afterwards.  We still haven't done that.  I'm half worried it might have been some kind of trap, or trick."),
    replies = {
        {
            text = ccb.content.text("Where's that building at, exactly?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac2",
        },
        {
            text = ccb.content.text("You seem right to be suspicious."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac2",
    line = ccb.content.text("I could share the dropoff location if you want to bring the drive there for us, but whatever's there, I'm not sure it's worth all the trouble.  I'll reward you for your trouble."),
    replies = {
        {
            text = ccb.content.text("That seems fine to me.  I'll take your drive for you."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac_Start",
            actions = { actions.offer_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"), actions.set_actor_value("speaker", "general_free_merchants_u_hub01_breadcrumb_accepted", "yes") },
        },
        {
            text = ccb.content.text("Actually, I can see why you haven't done it yet.  Hold that thought for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac_Start",
    line = ccb.content.text("I was hoping you'd say that.  It's an old isolated building not too far from here; you should probably just leave the drive to whoever's there and be on your way.  And like I said, be careful approaching the place.  I wouldn't like leading you straight into your death."),
    replies = {
        {
            text = ccb.content.text("Don't worry, I'll be careful.  I'll let you know when it's done."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I'm sure I'll manage."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup",
    line = ccb.content.text("Hmm.\"  Smokes looks thoughtful, rubbing his chin.  \"Well, most of the people downstairs aren't willing to come up for things like that, and a lot of folks that are up here have a lot of bad memories from that.  You could try asking around some of the people we have upstairs, but it'll be tough.  If you have some merch you could spare, though, I could get some people off guard duty and into your little crew for some hazard pay.  You might also have luck asking the Old Guard rep in the southwest bay, near the library - I hear they've got some volunteers lately."),
    replies = {
        {
            text = ccb.content.text("[5 merch] Five merch for someone sounds fair to me."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup1",
            when = predicates.has_inventory("speaker", "FMCNote", 5),
            actions = { actions.handler("dlg_a_dda_1771a2e9be11"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_0a12ed09c118") },
        },
        {
            text = ccb.content.text("[10 merch] How about ten merch to do it?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup2",
            when = predicates.has_inventory("speaker", "FMCNote", 10),
            actions = { actions.handler("dlg_a_dda_b041becec6c3"), actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_73da091850f1") },
        },
        {
            text = ccb.content.text("Thanks for the advice.  Maybe I'll come back with some more merch."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup1",
    line = ccb.content.text("That's enough to get someone off guard duty, yeah.  Hand it here and I'll set it up.\"  The money exchanges hands.  \"Right.  I haven't updated this list in a while, so some people are still assigned to watch the back bay, which is technically a free shift now.  I'll let one of them know about what's up and they can spend the time helping to clean up back there.  Hope it helps."),
    replies = { { text = ccb.content.text("Thank you!"), next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup2",
    line = ccb.content.text("Woah, you're really intent, hey?  That's a lot for most people here.\"  The money exchanges hands.  \"That's enough to get two people off guard duty for an afternoon, even with all the ugliness back there.  And you know what?  I'll help out, too, so make that three.  I can appreciate someone who's willing to put their money where their mouth is."),
    replies = {
        {
            text = ccb.content.text("Thank you very much!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission",
    line = ccb.content.text("*looks at you cautiously.  \"He hasn't been bothering you, has he?  Dave's usually pretty harmless.\""),
    replies = {
        {
            text = ccb.content.text("He wants permission to build himself a little shelter outside of your lobby, somewhere out of the way.  He'd need access to your washrooms and things, but you could clear him out of this space."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission2",
    line = ccb.content.text("Sure, sounds great on paper, but *where*?  We aren't swimming in real estate here, the place is seriously overcrowded.  And I won't have him living out of a soggy cardboard box on the doorstep, it's an even worse look than the lobby."),
    replies = {
        {
            text = ccb.content.text("What about the rooftop?  There's a stair access there, I can see it from outside, and he'd probably be able to do a bit of a lookout job."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission3",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission3",
    line = ccb.content.text("*rubs his chin.  \"It's probably technically a fire hazard, but there's not much to light up there besides what Dave brings.  And a few of the guards are pretty attached to him, so we could maybe send folks up to keep an eye on him and make sure he's doing okay.  That wouldn't interfere with comings and goings, either.\"  He pauses a moment, looking at his ledger as if it contains answers.  \"You know what?  Sure.  If Dave is okay with it, I can talk the others into letting him have rooftop access to build himself a little shelter, as long as he continues to keep it clean up there like he has in here.\""),
    on_enter = { { actions = { actions.set_actor_value("speaker", "mission_Dave_Permission", "yes") } } },
    replies = { { text = ccb.content.text("Thanks.  I'll go let him know."), next_topic = "TALK_DONE" } },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "smokes_take_down_back_bay_barricade",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 6,
                y = 3,
                end_x = 17,
                end_y = 3,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 3,
                y = 4,
                end_x = 20,
                end_y = 14,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 4,
                y = 15,
                end_x = 20,
                end_y = 15,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 5,
                y = 16,
                end_x = 18,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 3,
                y = 3,
                end_x = 20,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 21,
                y = 12,
                end_x = 23,
                end_y = 15,
            },
        },
    },
}
