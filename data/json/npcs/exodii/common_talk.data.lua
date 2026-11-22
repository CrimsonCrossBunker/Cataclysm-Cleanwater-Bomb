local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_MERCHANT_EXODII_MISSION_WAREHOUSE", "TALK_FREE_MERCHANT_TEAMSTER_EXODII_MISSION_WAREHOUSE", "TALK_JOHN_BAILEY_EXODII_MISSION_WAREHOUSE", "TALK_NPC_SCRAP_TRADER_EXODII_MISSION_WAREHOUSE", "TALK_CARAVAN_REFUGEES_EXODII_MISSION_WAREHOUSE", "TALK_NPC_CAMPER_VAN_TRAVELER_EXODII_MISSION_WAREHOUSE", "TALK_NPC_LUMBERMILL_LOGGER_MISSION_WAREHOUSE" },
    replies = {
        {
            text = ccb.content.text("Can you give me directions?"),
            next_topic = "TALK_Directions_exodii_true",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
        },
        {
            text = ccb.content.text("Can you give me directions?"),
            next_topic = "TALK_Directions_exodii_false",
            when = predicates.any_equal({ "alternate", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Directions_exodii_true",
    line = {
        choices = {
            {
            joined = {
                ccb.content.text("&You listen to the directions, and jot them down in your map"),
                {
                when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
                yes = ccb.content.text(".  Liam looks over your shoulder, and nods.  \"I've got a good feeling about this one.\""),
                no = ccb.content.text("."),
            },
            },
        },
            ccb.content.text("&You listen to the directions, and jot them down in your map."),
        },
    },
    on_enter = {
        { actions = { actions.assign_mission("mission_exodii_wh_directions") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Directions_exodii_false",
    line = {
        choices = {
            {
            joined = {
                ccb.content.text("&You listen to the directions, and jot them down in your map"),
                {
                when = predicates.handler("dlg_p_dda_bac2d697a2af"),
                yes = ccb.content.text(".  The Merc looks at the map with an eyeroll.  \"This ain't it, chief.\""),
                no = {
                    when = predicates.handler("dlg_p_dda_f796115021ee"),
                    yes = ccb.content.text(".  Yusuke studies the drawing for a moment, then raises an eyebrow.  \"I've been out that way scavenging before, and I don't remember seeing anything like the warehouse we're looking for.\""),
                    no = {
                        when = predicates.handler("dlg_p_dda_6a9f959762b2"),
                        yes = ccb.content.text(".  Chris watches over your shoulder, frowning slightly.  \"I think I know that area, and I'm not quite sure that's what we're looking for.\""),
                        no = ccb.content.text("."),
                    },
                },
            },
            },
        },
            ccb.content.text("&You listen to the directions, and jot them down in your map."),
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_7e3dd5075416") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

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
