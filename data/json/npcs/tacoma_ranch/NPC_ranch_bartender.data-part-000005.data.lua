local ccb = require("ccb")

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
