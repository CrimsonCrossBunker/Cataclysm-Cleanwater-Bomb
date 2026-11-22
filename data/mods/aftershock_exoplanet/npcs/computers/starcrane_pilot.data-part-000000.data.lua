local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "THI_CONTROL_START", "THI_CONTROL_BAY_RAMP_STATUS" },
    line = ccb.content.text("&●◐ Tristar Heavy Industries\nTHI-14 StarCrane\n\n**Welcome Captain.**\n"),
    replies = {
        {
            text = ccb.content.text("> Plot a course.  <color_light_red>ERROR: BAY RAMP MUST CLOSE BEFORE TAKEOFF</color>"),
            next_topic = "THI_CONTROL_START",
            when = predicates.handler("w16b_p_aftershock_exoplanet_7a79c7d7cbcf"),
        },
        {
            text = ccb.content.text("> Plot a course to a known destination."),
            next_topic = "THI_CONTROL_PLOT_KNOWN",
            when = predicates.handler("w16b_p_aftershock_exoplanet_36e4be47b755"),
        },
        {
            text = ccb.content.text("> Plot a manual course."),
            next_topic = "THI_CONTROL_MANUAL_READY",
            when = predicates.handler("w16b_p_aftershock_exoplanet_36e4be47b755"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_c2ae7fee24ef") },
        },
        {
            text = ccb.content.text("> Close bay ramp."),
            next_topic = "THI_CONTROL_BAY_RAMP_STATUS",
            when = predicates.handler("w16b_p_aftershock_exoplanet_7a79c7d7cbcf"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_4fe8bc1c7561") },
        },
        {
            text = ccb.content.text("Shut down."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "THI_CONTROL_MANUAL_READY" },
    line = ccb.content.text("&************************************************\n\nINTEGRITY CHK : ███████████████ 100% (COMPLETE)\nNAV TRANSFER :  ███████████████ 100% (COMPLETE)\n\n************************************************\n*  Operation Successful                         *\n************************************************"),
    replies = {
        {
            text = ccb.content.text("<color_light_red>Invalid course.  Destination must be clear of obstacles and at least 5 map tiles away.</color>"),
            next_topic = "THI_CONTROL_START",
            when = predicates.handler("w16b_p_aftershock_exoplanet_14478cd75069"),
        },
        {
            text = ccb.content.text("Pilot the ship"),
            next_topic = "THI_CONTROL_CONTROL_READY",
            when = predicates.handler("w16b_p_aftershock_exoplanet_4ce94378d266"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_6ff86387a35f") },
        },
        {
            text = ccb.content.text("Cancel."),
            next_topic = "THI_CONTROL_START",
        },
    },
}
