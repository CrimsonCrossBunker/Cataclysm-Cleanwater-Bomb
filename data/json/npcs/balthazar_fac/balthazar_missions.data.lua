local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_SOLAR_PANELS_BALTHAZAR",
    name = ccb.content.text("Gather 12 solar panel arrays for Balthazar"),
    description = ccb.content.text("Balthazar needs <color_yellow>12 solar panel arrays</color> to stabilize the power to their bunker."),
    goal = "MGOAL_CONDITION",
    complete_when = "complete_mission_get_solar_panels_balthazar",
    difficulty = 1,
    value = 1000,
    finish = {
        actions = {
            ccb.content.dialogue_actions.update_map("balthazar_bunker_solar_panel_row_l", "balthazar_bunker_02"),
            ccb.content.dialogue_actions.update_map("balthazar_bunker_solar_panel_row_r", "balthazar_bunker_03"),
            { handler = "record_balthazar_solar_power" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("The power in my bunker is failing and I need <color_yellow>12 solar panel arrays</color> to stabilize them."),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("Most commercial buildings have some solar panel arrays or, if we're lucky, you might find a solar farm."),
        inquire = ccb.content.text("Power is holding for now but I need those panels soon."),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("Where are the panels??"),
        failure = ccb.content.text("You shouldn't fail me, human."),
    },
}

ccb.content.define_mission {
    id = "MISSION_FIND_BALTHAZAR_BUNKER",
    name = ccb.content.text("Reach source of mysterious transmission"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "balthazar_bunker_00",
            special = "balthazar_bunker",
            reveal_radius = 1,
            random = false,
        },
    },
    origins = { "ORIGIN_COMPUTER" },
    destination = "balthazar_bunker_00",
}
