local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SERVICE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a cash test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_f27c7fa135d4"),
        },
        {
            text = ccb.content.text("This is an NPC service test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_87ccf0c55585"),
        },
        {
            text = ccb.content.text("This is an NPC available test response."),
            next_topic = "TALK_DONE",
            when = predicates.actor_state("interlocutor", "available"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_LOCATION",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a om_location_field test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7efddb1bb928"),
        },
        {
            text = ccb.content.text("This is a faction camp any test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1dd60607d899"),
        },
        {
            text = ccb.content.text("This is a om_location_field direction variant response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_984ab760e381"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_ROLE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a nearby role test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7413844009f7"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_CLASS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a class test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_48323e72abf5"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_ALLIES",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC allies 1 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_430389987a1c"),
        },
        {
            text = ccb.content.text("This an error!  npc allies 2 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c64ba9d1f4e7"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_RULES",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC engagement rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e858505b4f4f"),
        },
        {
            text = ccb.content.text("This is an NPC aim rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3053cf449896"),
        },
        {
            text = ccb.content.text("This is an NPC rule test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_7464481c8b48"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NPC_NEEDS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is an NPC thirst test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_116846416c99"),
        },
        {
            text = ccb.content.text("This is an NPC hunger test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b661ecaa4a50"),
        },
        {
            text = ccb.content.text("This is an NPC sleepiness test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_db3bbd60cd2c"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_MISSION_GOAL",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a mission goal test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1236053a2f9b"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SEASON",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("This is a basic test response."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("This is a season spring test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d7c0a82ef9e4"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 30 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        },
        {
            text = ccb.content.text("This is a season summer test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e13e38001d0d"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 120 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_1a1ea07b65c8"),
        },
        {
            text = ccb.content.text("This is a season autumn test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c76eb4551f41"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 210 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0cab2db62407"),
        },
        {
            text = ccb.content.text("This is a season winter test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0b5c98d989be"),
        },
        {
            text = ccb.content.text("This is a days since Cataclysm 300 test response."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_8ed8637b0254"),
        },
    },
}
