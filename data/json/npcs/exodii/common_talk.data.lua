local ccb = require("ccb")

ccb.content.define_mission {
    id = "mission_exodii_wh_directions",
    name = ccb.content.text("Possible directions to Exodii warehouse"),
    description = ccb.content.text("You've gotten directions to what might be the warehouse Rubik asked you to find."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Strange warehouse", terrain = "exo_warehouse_1", reveal_radius = 2, z = 0 },
    },
    origins = { "ORIGIN_SECONDARY" },
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

ccb.content.define_mission {
    id = "mission_exodii_wh_bad_directions1",
    name = ccb.content.text("Possible directions to Exodii warehouse"),
    description = ccb.content.text("You've gotten directions to what might be the warehouse Rubik asked you to find."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Out-of-place Stone Barn", terrain = "exo_safehouse_stone_0", reveal_radius = 2 },
    },
    origins = { "ORIGIN_SECONDARY" },
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

ccb.content.define_mission {
    id = "mission_exodii_wh_bad_directions2",
    name = ccb.content.text("Possible directions to Exodii warehouse"),
    description = ccb.content.text("You've gotten directions to what might be the warehouse Rubik asked you to find."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { special = "Mi-Go Scout Tower", terrain = "mi-go_scout_tower_3", reveal_radius = 2 } },
    origins = { "ORIGIN_SECONDARY" },
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

ccb.content.define_mission {
    id = "mission_exodii_wh_bad_directions3",
    name = ccb.content.text("Possible directions to Exodii warehouse"),
    description = ccb.content.text("You've gotten directions to what might be the warehouse Rubik asked you to find."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = { target = { special = "desolate barn", terrain = "desolatebarn", reveal_radius = 2 } },
    origins = { "ORIGIN_SECONDARY" },
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
