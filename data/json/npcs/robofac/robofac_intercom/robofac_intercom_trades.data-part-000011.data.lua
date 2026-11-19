local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This is a very curious recording.  The unit detected an active 'tear' in spacetime.  More importantly, there is something like an event horizon surrounding the source of the resonance recordings - that is to say that if you were to enter, you may never be able to leave.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report contains what we can only call… human-like radio and other signals.  We've recorded similar transmissions recently and independently.  We suggest you do not engage with these creatures, should you find the source of the information.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This is a very curious recording.  For the most part it's normal.  However, the instruments detected a point where anomalous converge - whatever this structure is, it houses something of extra-dimensional origins.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"You've located a severe spacetime disturbance.  Notably, several of the recordings performed unexpected loops in their subroutines.  In fact, these anomalies seem to be centered around a facility we are familiar with, and where we have recently performed extensive aerial surveillance.  If you are interested, we are willing to offer you a contract to retrieve something from this location.  Let us know if you are interested.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Astounding!  Incredible!  You've clearly recorded these in a non-Earth environment.  While the atmosphere is similar to ours, the humidity is substantially higher, and the pressure makes it more prone to violent storms.  The report also identified several concentrated anomalies, indicating there are extra-dimensional objects located in the area you scanned.  Interestingly, there are no signs of artificial communication such as radio waves.  This place is clearly not housing any advanced intelligent life.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Unbelievable!  You've clearly recorded these in a non-Earth environment.  The atmosphere has several foreign materials, but does not appear toxic.  Most interestingly, there are substantial signs of life in the electromagnetic spectrum.  We'll speak with Research, as they may be interested in acquiring a specimen.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The recording you have brought us contains classified information.  The likelihood of death if you enter the source of this recording is extremely high.  Please accept payment and disregard any knowledge you have of this place.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We have detected an extremely large source of extra-dimensional energy - energy we have not seen since the initial cataclysm.  We have also detected extreme geological anomalies.  We believe this underground location is unstable, perhaps due to an active tear in spacetime.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Incredible - these are clearly non-Earth conditions!  What is strange is that there are a substantial number of man-made radio waves, but they all appear to be the same very high frequency radio waveform.  We will study these further.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Curiously, this report indicates that there are alien volatile organic compounds in the area you recorded in, and hints that they have an underground origin.  We may be interested in contracting you for further investigation.  Ask of you are interested.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The recordings performed unexpected loops in its subroutines, resulting in a multitude of errors, but the report otherwise seems normal.  We note that these loops only occur when scanning the roof of a structure in the scan-zone.  In any case, we will forward this to Research, but perhaps you should investigate that roofs.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}
