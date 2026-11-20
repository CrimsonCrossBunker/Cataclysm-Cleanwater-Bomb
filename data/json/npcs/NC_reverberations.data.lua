local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS",
    name = ccb.content.text("Follow the old map"),
    description = ccb.content.text("I found an old notebook full of text I didn't understand.  However, I could understand the map drawn on the inside cover.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_entrance",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_entrance",
            special = "inner_cabins_depths_entrance",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_2",
    name = ccb.content.text("Follow the old map"),
    description = ccb.content.text("I found an old map detailing a maze in the depths.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_sewer_sub_station",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_sewer_sub_station",
            special = "inner_cabins_depths_sewer_sub_station",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_3a",
    name = ccb.content.text("Follow the subway map"),
    description = ccb.content.text("I found a strange subway map with a location circled.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_cathedral_b_NW",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_cathedral_b_NW",
            special = "inner_cabins_depths_cathedral",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_3b",
    name = ccb.content.text("Follow the subway map"),
    description = ccb.content.text("I found a strange subway map with a location circled.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_mall_a_58_basement",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_mall_a_58_basement",
            special = "inner_cabins_depths_mall",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_3c",
    name = ccb.content.text("Follow the subway map"),
    description = ccb.content.text("I found a strange subway map with a location circled.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_hotel_tower_b_2",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_hotel_tower_b_2",
            special = "inner_cabins_depths_hotel_tower_b",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_3d",
    name = ccb.content.text("Follow the subway map"),
    description = ccb.content.text("I found a strange subway map with a location circled.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_office_skyscraper_1",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_office_skyscraper_1",
            special = "inner_cabins_depths_office_skyscraper",
            reveal_radius = 0,
            random = false,
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
    id = "MISSION_INNER_CABINS_GO_TO_DEPTHS_3e",
    name = ccb.content.text("Follow the subway map"),
    description = ccb.content.text("I found a strange subway map with a location circled.  Where could it lead, in this strange place?"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "inner_cabins_depths_zoo_3_3_basement",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "inner_cabins_depths_zoo_3_3_basement",
            special = "inner_cabins_depths_zoo",
            reveal_radius = 0,
            random = false,
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
