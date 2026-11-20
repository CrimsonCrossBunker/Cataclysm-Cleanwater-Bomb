local ccb = require("ccb")

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_HUB01_PAY_BACK_RIOT_GEAR",
    name = ccb.content.text("Pay Back The Riot Gear to Hub 01"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    failure = { handler = "lose_robofac_trust_for_riot_gear" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    deadline = { "20 days", "20 days" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
