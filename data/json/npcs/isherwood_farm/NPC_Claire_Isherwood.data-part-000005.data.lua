local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_1",
    name = ccb.content.text("Gather 50 dandelions"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "raw_dandelion",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_CLAIRE_2",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = {
            { item = "thyme_oil", count = 2, container = "jar_glass_sealed" },
            { item = "poppy_pain", count = 20, container = "jar_glass_sealed" },
        },
    },
    dialogue = {
        describe = ccb.content.text("I could use some help foraging ingredients."),
        offer = ccb.content.text("I could use some fresh dandelions for the next batch of wine.  Can you bring me 50 dandelions?"),
        accepted = ccb.content.text("Thank you, I'll put these to good use."),
        rejected = ccb.content.text("Oh well.  Maybe some other time, thanks."),
        advice = ccb.content.text("You can find them in the fields during the spring and summer months."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks.  Here's a small reward to show my appreciation for your help."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder if the wildlife ate all the greens…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_2",
    name = ccb.content.text("Find 20 bee balm seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "seed_bee_balm",
    item_count = 20,
    followup = "MISSION_ISHERWOOD_CLAIRE_3",
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        item_rewards = {
            { item = "pine_tea", count = 2, container = "jar_glass_sealed" },
            { item = "royal_jelly", count = 1 },
            { item = "bee_balm_tea", count = 2, container = "jar_glass_sealed" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could use some seeds from the forest."),
        offer = ccb.content.text("We could use some seeds for the next planting season.  Can you bring me 20 bee balm seeds?"),
        accepted = ccb.content.text("Thank you.  It's important to have a good stock before the flu season hits."),
        rejected = ccb.content.text("Oh well.  Maybe some other time, thanks."),
        advice = ccb.content.text("You should search through the forest, make sure to check in the underbrush for bee balm and then harvest its seeds."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, perfect.  Here are some of my own remedies and if those don't work try my other gift."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to find someone more at home in the forest…"),
    },
}

-- om_special is a no-op here - we are already at 'Isherwood Farm Mutable'. I added it to suppress a linter false positive.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CLAIRE_3",
    name = ccb.content.text("Find and capture a cat"),
    goal = "MGOAL_FIND_MONSTER",
    difficulty = 4,
    value = 100000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    start = {
        target = {
            special = "Isherwood Farm Mutable",
            terrain = "cabin_isherwood",
            reveal_radius = 1,
            random = true,
            min_distance = 8,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_cat_isherwood", pack_size = { 3, 6 }, x = 20, y = 22, target = true },
                    },
                },
            },
        },
        item_rewards = { { item = "chicken_cage", count = 1 } },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        handler = "mark_u_did_claire_missions",
        item_rewards = { { item = "isherwood_herbal_remedies", count = 1 } },
    },
    dialogue = {
        describe = ccb.content.text("I could use a barn cat to keep the mice down."),
        offer = ccb.content.text("I saw some feral cats out by the old cabin.  Can you capture one for me?"),
        accepted = ccb.content.text("Thank you!  Please hurry back!  Take this cage so you have a chance of capturing one."),
        rejected = ccb.content.text("I didn't want to use chemicals on these rats."),
        advice = ccb.content.text("Take this pet carrier; if you can get close to a cat, you can put it inside.  If you're having problems, try befriending it with cat food."),
        inquire = ccb.content.text("Have you found a cat?"),
        success = ccb.content.text("Thank you so much, I want you to have this copy of my natural remedy journal.  I'll name this handsome fellow Joshua."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Did you even bring back my cage?"),
        failure = ccb.content.text("Oh no!  I guess they are too nimble for you…"),
    },
}
