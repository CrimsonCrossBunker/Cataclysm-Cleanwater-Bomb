local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_KOSTAS_1",
    name = ccb.content.text("Natural Chemistry"),
    description = ccb.content.text("Get a chemistry set for Kostas."),
    goal = "MGOAL_FIND_ITEM",
    item = "chemistry_set",
    difficulty = 3,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 12 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_KOSTAS_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get a chemistry set."),
        offer = ccb.content.text("I've decided to start making more concentrated remedies for more serious cases, but I don't have a way of refining any herbs to that degree.  I'd pay for a chemistry set."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("We could all use the medicine, including you."),
        advice = ccb.content.text("A laboratory or pharmaceutical factory should have one."),
        inquire = ccb.content.text("Have you found the chemistry set?"),
        success = ccb.content.text("Blessings be unto you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
