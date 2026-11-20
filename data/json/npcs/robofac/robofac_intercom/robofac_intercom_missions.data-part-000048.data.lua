local ccb = require("ccb")

-- Place the field team here instead of at the entrance, just incase the rare Yrax spawns.  It'd be odd for them to be in the same place.
ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_FIELD_TEAM",
    name = ccb.content.text("Invasive \"Meteorology:\" contact the field team"),
    description = ccb.content.text("A team of Hub 01 contractors is at work near the organic mass.  I can check in with them if I want to, but it isn't essential to my mission."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "corpse_surface",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "corpse_surface",
            special = "nether_monster_corpse",
            reveal_radius = 2,
            random = false,
        },
        map_updates = {
            { layout = { nested = { { x = 0, y = 0, id = "robofac_monster_corpse_field_team" } } } },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
