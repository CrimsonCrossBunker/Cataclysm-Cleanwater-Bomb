local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_GEMMA_SEEDS",
    name = ccb.content.text("Find cactus seeds"),
    description = ccb.content.text("Find ten cactus seeds for Gemma."),
    goal = "MGOAL_FIND_ITEM",
    item = "seed_cactus",
    item_count = 10,
    difficulty = 1,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some cactus seeds."),
        offer = ccb.content.text("I'm wanting to try growing some new plants.  I've never tried growing cactus; if you could find some seeds for me, I'd pay you."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("I suppose more local fauna could work."),
        advice = ccb.content.text("I'd try a gardening store or a home supply store would have some."),
        inquire = ccb.content.text("Have you found any cactus seeds?"),
        success = ccb.content.text("I appreciate that, here's your money.  Parts of the cactus, such as the fruit, are edible.  I'll have to ask Simon if he can experiment with some of them."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}
