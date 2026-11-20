local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_KATHERINE_1",
    name = ccb.content.text("Fishy Business"),
    description = ccb.content.text("Find three cans of sardines, tuna, or salmon for Katherine."),
    goal = "MGOAL_CONDITION",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (value +1).
    finish = { item_rewards = { { item = "icon", count = 6 } }, handler = "deliver_mission_godco_katherine_1" },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some tuna."),
        offer = ccb.content.text("I've had a craving for fish recently.  Could you find three cans of tuna for me?  I'll pay you for them."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Alright.  I'll do it myself."),
        advice = ccb.content.text("A house or grocery store should have some."),
        inquire = ccb.content.text("Have you found the fish?"),
        success = ccb.content.text("Thank you, here's your payment."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
    complete_when = "complete_mission_godco_katherine_1",
}
