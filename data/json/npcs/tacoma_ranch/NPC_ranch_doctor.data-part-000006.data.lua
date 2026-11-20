local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RANCH_DOCTOR_CRUTCHES",
    name = ccb.content.text("A Crutch to Lean on"),
    description = ccb.content.text("Bring the doctor some crutches."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 2500,
    item = "crutches",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_DOCTOR_MEDICAL_GLOVES",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("One of the laborers injured their foot pretty badly and I don't want them walking on it for a few days at least.  Do you think you could find a pair of crutches?"),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You might be able to find some in hospitals, but some makeshift crutches would be better than nothing."),
        inquire = ccb.content.text("Do you have the crutches?"),
        success = ccb.content.text("Thank you for your assistance."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
