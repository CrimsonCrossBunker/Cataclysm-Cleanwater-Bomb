local ccb = require("ccb")

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
