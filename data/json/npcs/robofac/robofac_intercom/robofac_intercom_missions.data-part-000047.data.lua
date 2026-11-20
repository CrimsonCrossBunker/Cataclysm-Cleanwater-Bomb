local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1",
    name = ccb.content.text("Weather Permitting"),
    description = ccb.content.text("Assemble and <color_yellow>activate the 1-hour recording subroutine</color> on a <color_yellow>mobile weather station</color> during an <color_yellow>early</color>, <color_yellow>distant</color>, or <color_yellow>close portal storm</color>.  After 1 hour the station will print some sort of <color_yellow>strange weather datasheet</color> to return to Hub 01."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_1",
            "advance_hub01_completed_missions_by_1",
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

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2",
    name = ccb.content.text("System Retrieval"),
    description = ccb.content.text("Travel to the DARPA research station and find the <color_yellow>mobile hazardous environment weather station</color>.  Should I bring a swimsuit?"),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "dls_small_surface",
            special = "limnological_station",
            reveal_radius = 2,
            random = true,
            search_range = 2000,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_2",
            "advance_hub01_completed_missions_by_1",
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

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3",
    name = ccb.content.text("Storm Chaser"),
    description = ccb.content.text("Take the <color_yellow>mobile hazardous environment weather station</color> into an <color_yellow>early</color>, <color_yellow>distant</color>, or <color_yellow>close portal storm</color>, assemble it, and start a recording.  Return the resulting <color_yellow>HEW anomalous weather printout</color> to Hub 01."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_3",
            "advance_hub01_completed_missions_by_1",
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

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4",
    name = ccb.content.text("True Weatherperson"),
    description = ccb.content.text("Record \"atmospheric\" data return a HEW datasheet to Hub 01.  They recommend scanning with the HEW system anywhere there is, or was, portal activity."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = { handler = "mark_dialogue_intercom_accepted_robofac_intercom_mws_4" },
    finish = {
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_4",
            "advance_hub01_completed_missions_by_1",
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

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE",
    name = ccb.content.text("Invasive \"Meteorology\""),
    description = ccb.content.text("Go to the <color_yellow>exact underground coordinates</color>, set up a HEW station, and make a recording.  Return the <color_yellow>alien \"atmospheric\" datasheet</color> to Hub 01.  You may wish to rendezvous with the advanced field team, if you can find them."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "corpse_bowels_mid",
            special = "nether_monster_corpse",
            reveal_radius = 1,
            random = false,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_monster_corpse",
            "advance_hub01_completed_missions_by_1",
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
