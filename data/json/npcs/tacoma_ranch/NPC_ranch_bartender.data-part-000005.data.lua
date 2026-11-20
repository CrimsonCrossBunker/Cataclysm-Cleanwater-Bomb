local ccb = require("ccb")

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
