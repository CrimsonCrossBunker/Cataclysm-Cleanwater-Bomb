local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON",
    line = ccb.content.text("&You see a bulbous, black computer screen.  It would almost be mundane on Earth's early 1990s.  Next to it is a large, clear plastic toggle switch, yellowed and brittle with age."),
    replies = {
        {
            text = ccb.content.text("[Flip the switch]"),
            next_topic = "COMP_SD_EXODII_DISTRESS_BEACON_1",
            when = predicates.handler("dlg_p_dda_3ecc492a505d"),
            actions = { actions.handler("dlg_a_dda_4410e4b406f7") },
        },
        {
            text = ccb.content.text("[Flip the switch]"),
            next_topic = "COMP_SD_EXODII_DISTRESS_BEACON_2",
            when = predicates.handler("dlg_p_dda_a9d7b442011c"),
            actions = { actions.handler("dlg_a_dda_604b9f532b04") },
        },
        {
            text = ccb.content.text("[Flip the switch]"),
            next_topic = "COMP_SD_EXODII_DISTRESS_BEACON_3",
            when = predicates.handler("dlg_p_dda_2d0e96f50ccd"),
            actions = { actions.handler("dlg_a_dda_b8f9bf4cb80b"), actions.assign_mission("MISSION_STRING_DIMENSION_EXODII_DOME") },
        },
        {
            text = ccb.content.text("[Flip the switch]"),
            next_topic = "COMP_SD_EXODII_DISTRESS_BEACON_4",
            when = predicates.handler("dlg_p_dda_8057a2507437"),
            actions = { actions.handler("dlg_a_dda_b3da69c687e2") },
        },
        {
            text = ccb.content.text("[Step away]"),
            next_topic = "TALK_DONE",
        },
    },
}
