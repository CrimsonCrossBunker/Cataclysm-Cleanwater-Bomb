local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_GEMMA_SUPPLEMENTS",
    name = ccb.content.text("Retrieve the fertility supplements"),
    description = ccb.content.text("Get Gemma's 25 fertility supplements."),
    goal = "MGOAL_FIND_ITEM",
    item = "fert_supplement",
    item_count = 25,
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "s_pharm",
            special = "s_pharm",
            reveal_radius = 1,
            random = false,
            min_distance = 3,
        },
        map_updates = {
            { layout = { item_group_placements = { { group = "fertility_supplements", x = 15, y = 15 } } } },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            { item = "icon", count = 15 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_meeting_gemma_got_supplements", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some supplements."),
        offer = ccb.content.text("To be honest, I'm not alright.  Have you met Darryl?  He's my husband, and we had a go at getting a baby recently.  The thing is, its not happening.  Now that we're in a safe spot, on our feet again, I want to try.  I'm trying to find some fertility supplements.  I ordered some before <the_cataclysm>, but I never got to pick them up.  If you'd go over and get them for me, I'd pay you."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("This means so much to me."),
        advice = ccb.content.text("They should be near the counter, or on a shelf."),
        inquire = ccb.content.text("Have you found my pills?"),
        success = ccb.content.text("Oh thank you!  Darryl will be so happy to hear about this!  Take there for your payment, it must've been hard for you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}
