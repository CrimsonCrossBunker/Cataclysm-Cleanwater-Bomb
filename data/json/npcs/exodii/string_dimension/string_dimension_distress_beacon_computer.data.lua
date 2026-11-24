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

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_1",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, one circle lights up orange."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_2",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, two circles light up orange."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_3",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  The screen turns on and garbled text and images cover the screen.  It is either some language you do not understand, or a series of confounding errors.  Three circle dominate the top of the screen - after just a few seconds, all three circles light up orange.\n\nImmediately, three similar dots appear on the garbled image, and after a few punctuated corrections, the image morphs into a highly pixelated topological map.  A fourth, blinking light appears.  You make note if its location in reference to the three terminals you've visited."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_SD_EXODII_DISTRESS_BEACON_4",
    line = ccb.content.text("&There is an electronic whirr, following by a click and a high-pitched ringing that slowly fades.  A familiar topological map forms.  You glean no new information from it."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_furniture {
    id = "f_string_dimension_distress_beacon_1",
    copy_from = "f_console_broken",
    name = ccb.content.text("powered odd monitor"),
    looks_like = "t_console_broken",
    description = ccb.content.text("A bulbous monitor.  It displays a garbled image and one glowing circle."),
    symbol = "6",
    color = "light_gray",
}

ccb.content.define_furniture {
    id = "f_string_dimension_distress_beacon_2",
    copy_from = "f_console_broken",
    name = ccb.content.text("powered odd monitor"),
    looks_like = "t_console_broken",
    description = ccb.content.text("A bulbous monitor.  It displays a garbled image and two glowing circles."),
    symbol = "6",
    color = "light_gray",
}

ccb.content.define_furniture {
    id = "f_string_dimension_distress_beacon_3",
    copy_from = "f_console_broken",
    name = ccb.content.text("powered odd monitor"),
    looks_like = "t_console_broken",
    description = ccb.content.text("A bulbous monitor.  It displays a topological map.  There's nothing new or interesting on it."),
    symbol = "6",
    color = "light_gray",
}

ccb.content.define_mission {
    id = "MISSION_STRING_DIMENSION_EXODII_DOME",
    name = ccb.content.text("Investigate the Blinking Dot"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "string_dimension_dome_x1y2z0",
    start = {
        target = {
            terrain = "string_dimension_dome_x1y2z0",
            special = "string_dimension_dome",
            reveal_radius = 0,
            random = false,
        },
    },
    difficulty = 2,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("-"),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
