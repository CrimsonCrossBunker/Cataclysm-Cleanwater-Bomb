local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Mission source, shopkeep
ccb.content.define_npc {
    id = "ranch_bartender",
    suffix = ccb.content.text("Bartender"),
    class = "NC_BARTENDER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_RANCH_BARKEEP",
    missions_offered = "MISSION_RANCH_BARTENDER_1",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP",
    line = ccb.content.text("Want a drink?"),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = { actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes") },
        },
        {
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_BARKEEP_JOB",
        },
        {
            text = ccb.content.text("I'm looking for information."),
            next_topic = "TALK_RANCH_BARKEEP_INFORMATION",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Let me see what you keep behind the counter."),
            next_topic = "TALK_RANCH_BARKEEP",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What do you have on tap?"),
            next_topic = "TALK_RANCH_BARKEEP_TAP",
        },
        {
            text = ccb.content.text("What's this token you gave me?"),
            next_topic = "RANCH_BARTENDER_ASK_TOKEN",
            when = predicates.has_item("speaker", "tacoma_drink_token"),
        },
        {
            text = ccb.content.text("I'd like to exchange ten tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 10), predicates.has_inventory("speaker", "shot_glass", 10) }),
            actions = { actions.transfer_items("tacoma_drink_token", 10), actions.transfer_items("shot_glass", 10), actions.handler("dlg_a_dda_3e95a51957d9") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange five tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 5), predicates.has_inventory("speaker", "shot_glass", 5) }),
            actions = { actions.transfer_items("tacoma_drink_token", 5), actions.transfer_items("shot_glass", 5), actions.handler("dlg_a_dda_162b8f5bd295") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange four tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 4), predicates.has_inventory("speaker", "shot_glass", 4) }),
            actions = { actions.transfer_items("tacoma_drink_token", 4), actions.transfer_items("shot_glass", 4), actions.handler("dlg_a_dda_80e62868d654") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange three tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 3), predicates.has_inventory("speaker", "shot_glass", 3) }),
            actions = { actions.transfer_items("tacoma_drink_token", 3), actions.transfer_items("shot_glass", 3), actions.handler("dlg_a_dda_c1052b9b0e46") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange two tokens"),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_inventory("speaker", "tacoma_drink_token", 2), predicates.has_inventory("speaker", "shot_glass", 2) }),
            actions = { actions.transfer_items("tacoma_drink_token", 2), actions.transfer_items("shot_glass", 2), actions.handler("dlg_a_dda_dfd1b92f2682") },
            switch = true,
        },
        {
            text = ccb.content.text("I'd like to exchange a token."),
            next_topic = "TALK_NONE",
            when = predicates.all({ predicates.has_item("speaker", "tacoma_drink_token"), predicates.has_item("speaker", "shot_glass") }),
            actions = { actions.transfer_items("tacoma_drink_token"), actions.transfer_items("shot_glass"), actions.handler("dlg_a_dda_d27e8c4e9fd4") },
            switch = true,
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_JOB",
    line = ccb.content.text("If it isn't obvious, I oversee the bar here.  The scavengers bring in old world alcohol that we sell for special occasions.  For most that come through here though, the drinks we brew ourselves are the only thing they can afford."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_BARKEEP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_INFORMATION",
    line = ccb.content.text("We have a policy of keeping information to ourselves.  Ask the patrons if you want to hear rumors or news."),
    replies = { { text = ccb.content.text("Thanks for nothing."), next_topic = "TALK_RANCH_BARKEEP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARKEEP_TAP",
    line = {
        when = predicates.has_trait("interlocutor", "NPC_WHISKEY"),
        yes = {
            choices = {
                ccb.content.text("Take a look at our selection and let me know what you're interested in."),
                ccb.content.text("We have a decent variety of drinks.  What interests you?"),
                ccb.content.text("What are you in the mood for?"),
            },
        },
        no = ccb.content.text("Our selection is a bit limited at the moment.  If you're willing to help out, I can get some more variety in here."),
    },
    replies = {
        {
            text = ccb.content.text("Just a glass of water, please."),
            next_topic = "TALK_DONE",
            actions = { actions.update_map("tacoma_commune_glass_water", "ranch_camp_51"), actions.handler("dlg_a_dda_df0892817ffd") },
        },
        {
            text = ccb.content.text("[$8] I'll take a beer."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_22a7b1bd6868") },
        },
        {
            text = ccb.content.text("[$12] I'll take a shot of brandy."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_BRANDY"),
            actions = { actions.handler("dlg_a_dda_120b90d90d9e"), actions.update_map("tacoma_commune_shot_brandy", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("[$12] I'll take a shot of rum."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_RUM"),
            actions = { actions.handler("dlg_a_dda_13aed4f4da60"), actions.update_map("tacoma_commune_shot_rum", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("[$15] I'll take a shot of whiskey."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "NPC_WHISKEY"),
            actions = { actions.handler("dlg_a_dda_5adf4fb1b6c9"), actions.update_map("tacoma_commune_shot_whiskey", "ranch_camp_51"), actions.handler("dlg_a_dda_376c24fc937b") },
        },
        {
            text = ccb.content.text("On second thought, don't bother."),
            next_topic = "TALK_RANCH_BARKEEP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "RANCH_BARTENDER_ASK_TOKEN",
    line = {
        choices = {
            ccb.content.text("Bring the token back with your glass and I'll exchange it for a merch."),
            ccb.content.gendered_line("Oh, that?  There were too many people stealing our glasses, so I started stamping a logo on some bottle caps as a token and raised the drink prices a bit to encourage their return.  I'll give you a merch back when you bring me the token with your glass.", { "interlocutor" }),
            ccb.content.text("Some people like to hang on to them thinking they'll have value someday, but I'd prefer it if you brought it back with your glass and I'll give you a merch back from your purchase."),
        },
    },
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_BARKEEP" } },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_BARTENDER_1",
    name = ccb.content.text("Make 2 Stills"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "still",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_BARTENDER_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The wine and beer we can brew are sufficient to attract most patrons, but we need something a bit stronger to get them to forget their misery.  Could you build me a pair of stills?"),
        accepted = ccb.content.text("This should let us start producing whiskey, rum, and brandy when we get access to the ingredients."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("I'm sure you could find the design for the stills in home brewing books."),
        inquire = ccb.content.text("Do you have the stills?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = {
                    nested = { { x = 0, y = 0, id = "tacoma_commune_bar_bartender_1" } },
                    item_group_placements = {
                        {
                            group = "cleaning",
                            x = 11,
                            y = { 7, 8 },
                            chance = 100,
                            repetitions = { 1, 2 },
                            faction = "tacoma_commune",
                        },
                        { group = "SUS_trash_floor", x = 13, y = 10, chance = 80, repetitions = { 1, 2 } },
                        { group = "SUS_trash_floor", x = 4, y = 16, chance = 80, repetitions = { 1, 2 } },
                    },
                },
            },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_BARTENDER_2",
    name = ccb.content.text("Find 20 Yeast"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "yeast",
    item_count = 20,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_BARTENDER_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The last batch that I brewed was terrible, I'm fairly sure something contaminated the yeast we have been using.  Could you locate a source of fresh yeast for us to use?  I'd need about 20 teaspoons of dry yeast to get started."),
        accepted = ccb.content.text("Thank you for your assistance."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Yeast should be common in homes or bakeries."),
        inquire = ccb.content.text("Do you have the yeast?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = {
                    nested = { { x = 0, y = 0, id = "tacoma_commune_bar_bartender_2" } },
                    item_group_placements = {
                        {
                            group = "cleaning",
                            x = 11,
                            y = { 7, 8 },
                            chance = 100,
                            repetitions = { 1, 2 },
                            faction = "tacoma_commune",
                        },
                        { group = "SUS_trash_floor", x = 13, y = 10, chance = 80, repetitions = { 1, 2 } },
                        { group = "SUS_trash_floor", x = 4, y = 16, chance = 80, repetitions = { 1, 2 } },
                    },
                },
            },
        },
        actions = { ccb.content.dialogue_actions.replace_mutation("interlocutor", "NPC_BRANDY") },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_BARTENDER_3",
    name = ccb.content.text("Find 10 Sugar Beet Seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "seed_sugar_beet",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_BARTENDER_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Sugar and molasses remains in short supply.  I've put in a request for more, but it is unlikely that I'm going to see a reliable source for some time.  If you are interested, we are going to need sugar beet seeds to meet future demand regardless of what the scavengers can find.  Could you bring me at least enough seeds to plant a small 10 meter long patch?"),
        accepted = ccb.content.text("Thank you for your assistance."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Farms or supply stores might have a few seeds…"),
        inquire = ccb.content.text("Do you have the sugar beet seeds?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = {
                    nested = { { x = 0, y = 0, id = "tacoma_commune_bar_bartender_3" } },
                    item_group_placements = {
                        { group = "SUS_trash_floor", x = 13, y = 10, chance = 80, repetitions = { 1, 2 } },
                        { group = "SUS_trash_floor", x = 4, y = 16, chance = 80, repetitions = { 1, 2 } },
                    },
                },
            },
            {
                terrain = "ranch_camp_52",
                layout = { nested = { { x = 2, y = 10, id = "tacoma_commune_greenhouse_bartender_beets" } } },
            },
        },
        actions = { ccb.content.dialogue_actions.replace_mutation("interlocutor", "NPC_RUM") },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_BARTENDER_4",
    name = ccb.content.text("Find 12 60-Liter Metal Tanks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "metal_tank",
    item_count = 12,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_BARTENDER_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The drinks we brew here have become a major draw for visitors and the occasional trader.  Our batches have become larger, but we are still running out of storage space between trading runs.  I've been able to get a few volunteers to help me build a set of standing tanks, but I still need 12 60-liter metal tanks to build them.  I've talked with the scrappers, but we are a low priority at the moment."),
        accepted = ccb.content.text("Thank you for your assistance."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Scrapping vehicles might be your best bet."),
        inquire = ccb.content.text("Do you have the 60-liter metal tanks?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = {
                    nested = { { x = 3, y = 1, id = "tacoma_commune_bar_bartender_4" } },
                    item_group_placements = {
                        { group = "SUS_trash_floor", x = 13, y = 10, chance = 80, repetitions = { 1, 2 } },
                        { group = "SUS_trash_floor", x = 4, y = 16, chance = 80, repetitions = { 1, 2 } },
                    },
                },
            },
        },
        actions = { ccb.content.dialogue_actions.replace_mutation("interlocutor", "NPC_WHISKEY") },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_BARTENDER_5",
    name = ccb.content.text("Find 2 200-Liter Drums"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "55gal_drum",
    item_count = 2,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_NULL",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The other survivor outposts that we have contact with have been more than eager to trade for beer or other drinks.  Transporting the drinks to them has presented a number of challenges though.  If you could locate a pair of 200-liter drums, we should be able to keep them supplied while turning a significant profit."),
        accepted = ccb.content.text("Thank you for your assistance."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Factories or junk yards are the only places I know where to look."),
        inquire = ccb.content.text("Do you have the 200-liter drums?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_51",
                layout = {
                    item_placements = {
                        { id = "55gal_drum", x = 18, y = 3, repetitions = 2, faction = "tacoma_commune" },
                    },
                    item_group_placements = {
                        { group = "SUS_trash_floor", x = 13, y = 10, chance = 80, repetitions = { 1, 2 } },
                        { group = "SUS_trash_floor", x = 4, y = 16, chance = 80, repetitions = { 1, 2 } },
                    },
                },
            },
        },
        handler = "set_mission_flag_Bartender_rewarded_to_no",
    },
}
