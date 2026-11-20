local ccb = require("ccb")

-- Quest handled via external dialogue, player will never see this text.
ccb.content.define_mission {
    id = "MISSION_GODCO_ZACHARY_KILL_NIGHTMARE",
    name = ccb.content.text("End The Nightmare"),
    goal = "MGOAL_KILL_MONSTER",
    description = ccb.content.text("Kill whatever's keeping Zachary up at night."),
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "forest", reveal_radius = 1, random = false, min_distance = 5, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { id = "mon_zombie_screecher", x = 11, y = 11, target = true } },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        handler = "mark_mission_meeting_zachary_willing_to_follow",
        item_rewards = { { item = "icon", count = 12 } },
    },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Kill whatever's keeping Zachary up at night."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("Any luck with that horror?"),
        success = ccb.content.text("Oh thank you!  Now I can finally get a nights sleep.  Here, I've got some icons saved up, I want you to have them."),
        success_lie = ccb.content.text("I can still hear it, crying out in the night."),
        failure = ccb.content.text("I'm not gonna go and fix this <freaking> mess."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_1",
    name = ccb.content.text("Fungus Among Us"),
    description = ccb.content.text("Purge the cultists in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 4,
    value = 0,
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, min_distance = 20 },
        map_updates = {
            {
                layout = {
                    rows = {
                        "     ..............     ",
                        "  .........&&.........  ",
                        " ......,,,&,,,,,,...... ",
                        " ....,,,,,&,&,,,,,,.... ",
                        " ...,,,,,&&__&,,,,,,... ",
                        "...,,,,&&&___&___,,,,...",
                        "...,,,&&____&_____,,&...",
                        "..,,,,_&&&&&___&__&&,,..",
                        "..&&,_&__&__&&&_&&_,,,..",
                        "..,,&_&_&_______&__,,,..",
                        "..,,_&_&&_______&__&&,..",
                        "..,&&&_&___XX_&&&&&&,,..",
                        ".&&,&__&___XX_&_&___,,..",
                        "..&,&__&&_____&_&_&_,,..",
                        "..&&&&__&&&&&&___&&,,,..",
                        "..,&,&&_______&____,,,..",
                        "..,&,,&____&&&___&&&,,..",
                        "...&,,&&__&____&&_,,,...",
                        "..&,,,,&&&_&&&&__,,,,...",
                        " ...,,,,,&__&_,,,,,,... ",
                        " ....,,,&&,,,&,,,,,.... ",
                        " ......&,,,,,,&&,...... ",
                        "  ..............&&....  ",
                        "     ..............     ",
                    },
                    flags = { "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
                    monster_placements = {
                        { id = "mon_marloss_zealot_m", x = 10, y = 10, target = true },
                        { id = "mon_marloss_zealot_f", x = 11, y = 11, target = true },
                        { id = "mon_marloss_zealot_m", x = 12, y = 12, target = true },
                        { id = "mon_marloss_zealot_f", x = 13, y = 13, target = true },
                    },
                    terrain = {
                        [" "] = {
                            { id = "t_grass_dead", copies = 4 },
                            { id = "t_dirtmound" },
                            { id = "t_grass" },
                            { id = "t_fungus" },
                        },
                        ["."] = { { id = "t_grass_dead", copies = 2 }, { id = "t_fungus" } },
                        [","] = {
                            { id = "t_grass_dead", copies = 3 },
                            { id = "t_fungus", copies = 7 },
                            { id = "t_fungus_mound" },
                        },
                        _ = {
                            { id = "t_fungus", copies = 25 },
                            { id = "t_fungus_mound" },
                            { id = "t_tree_fungal", copies = 3 },
                            { id = "t_tree_fungal_young", copies = 2 },
                        },
                        ["&"] = "t_fungus_mound",
                        X = "t_marloss",
                    },
                    furniture = {
                        [" "] = {
                            { id = "f_null", copies = 18 },
                            { id = "f_boulder_small", copies = 3 },
                            { id = "f_boulder_medium", copies = 2 },
                            { id = "f_boulder_large" },
                            { id = "f_flower_fungal", copies = 2 },
                            { id = "f_fungal_mass" },
                        },
                        ["."] = {
                            { id = "f_null", copies = 18 },
                            { id = "f_flower_fungal", copies = 4 },
                            { id = "f_fungal_mass", copies = 3 },
                            { id = "f_fungal_clump" },
                        },
                        [","] = {
                            { id = "f_null", copies = 12 },
                            { id = "f_fungal_mass", copies = 2 },
                            { id = "f_flower_fungal" },
                            { id = "f_fungal_clump" },
                        },
                        _ = {
                            { id = "f_null", copies = 10 },
                            { id = "f_fungal_mass", copies = 2 },
                            { id = "f_fungal_clump" },
                        },
                        ["&"] = {
                            { id = "f_fungal_tangle", copies = 8 },
                            { id = "f_fungal_clump" },
                            { id = "f_fungal_mass" },
                        },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 15 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_GREENWOOD_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's a weird fungus that started to invade ever since <the_cataclysm>, and several individuals in strange robes are cultivating it.  I've seen what it can do, so I need you to execute them and destroy all traces of these strange mushrooms."),
        accepted = ccb.content.text("God bless you!"),
        rejected = ccb.content.text("That fungus is going to kill us all if it isn't stopped."),
        advice = ccb.content.text("Despite how fast it grows, it's highly vulnerable to fire."),
        inquire = ccb.content.text("Have you dealt with them?"),
        success = ccb.content.text("Thank you.  I don't like killing people, but this time we had to.  Here, take this; its some of our internal money that we've started using.  You know those religious pamphlets shaped like bills people would leave?  These are some of those, couldn't stand 'em myself."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("We'll have to try again, I suppose."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_2",
    name = ccb.content.text("Relic Recovery"),
    description = ccb.content.text("Retrieve a religious relic for Greenwood in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "small_relic",
    start = {
        target = { terrain = "cathedral_1_SE", special = "cathedral", reveal_radius = 1, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_GREENWOOD_3",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("I've been looking to spruce up this place with some iconography, and a small relic would do just that.  It'd help tremendously with morale around here, so I need you to find one for me."),
        accepted = ccb.content.text("Please bring it back as soon as possible."),
        rejected = ccb.content.text("It'd really help us…"),
        advice = ccb.content.text("I know most cathedrals keep small relics, that's a good place to look."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, <name_g>.  Take these for your trouble."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to make my own, I guess…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 10 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

-- 5.50 (price of bibles) x 20 (count), with a 10% upcharge as a delivery fee. Divide by 2.50 to convert to icons.
ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_3",
    name = ccb.content.text("Bible Belt"),
    description = ccb.content.text("Find twenty King James Bibles for Greenwood in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "holybook_bible1",
    item_count = 20,
    start = {
        target = { terrain = "s_bookstore", special = "s_bookstore", reveal_radius = 1, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("When we skipped town during <the_cataclysm>, most of us left our possessions behind.  We only have a few Bibles here for all of us, and they're starting to fall apart.  If you could get 20 more, in the King James version, I'd pay well for them."),
        accepted = ccb.content.text("May God bless you."),
        rejected = ccb.content.text("It'd really help us…"),
        advice = ccb.content.text("A book store should have enough, I'll mark one for you."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("May God bless you, <name_g>."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to make my own, I guess…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 48 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_PAPER",
    name = ccb.content.text("Remnants of Civilization"),
    description = ccb.content.text("Find ten rolls of toilet paper for Julian Ray."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "toilet_paper",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_JULIAN_RINGS",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have a job for you…"),
        offer = ccb.content.text("As a matter of fact, yes you can.  You see, we're running low on toilet paper.  It's not something we can't live without, but it's luxury we can afford.  I can pay you handsomely if you find us ten rolls of toilet paper."),
        accepted = ccb.content.text("Well, that's great.  Good luck."),
        rejected = ccb.content.text("Changed your mind already?"),
        advice = ccb.content.text("You remember what toilet paper is, right?"),
        inquire = ccb.content.text("How's the search going?  Any luck?"),
        success = ccb.content.text("Thank you.  Maybe you people aren't so bad after all."),
        success_lie = ccb.content.text("Could you give it to me then?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 8 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
}
