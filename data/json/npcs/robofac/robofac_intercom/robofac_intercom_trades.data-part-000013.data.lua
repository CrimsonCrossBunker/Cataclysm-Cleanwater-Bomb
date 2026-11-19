local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report shows signs of what we might call 'portal storm scarring.'  Preliminarily we expect this may be a site of significant activity during the initial portal storms, but we have forwarded it to Research for further study.\""),
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
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report shows signs of what we might call 'portal storm scarring.'  We also noted some other features suggesting extradimensional materials may have been, or are, present.  Preliminarily we suspect this may be a site of significant activity during the initial portal storms.  We have forwarded it to Research for further study.\""),
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
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Your story would be unbelievable if it weren't for these recordings.  Even the mundane aspects, like the temperature and humidity, are astounding.  We have forwarded this report to Research for further study.\""),
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
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The graph you perhaps saw on the report is an anomalous ground radar recoding.  The instruments in the HEW system are not very advanced, but they've clearly picked up someone with intelligent design.  We've forwarded it to Research for further study.\""),
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
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR",
    line = ccb.content.text("&You deposit the sheet in the tray.  The person behind the microphone starts mumbling, as if speaking to someone off mic:  \"New HEW…  yeah…  atmospheric readings are normal…  subterranean…  several returned null, look.  Should be noisy…  yeah…  no, can't read the GC-MS until we plug it in…  right…  could be the instrument, but we've seen recordings like this before.\"\n\nThe intercom clicks twice, off then on, then the tray slides open, this time with a pile of coins.  \"This is an odd one.  We've turned it over to Research, but you might expect a relevant contract to be added to your list in the future.  Keep an eye out.  Thank you for your contributions to science, as always.\""),
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
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON",
    line = ccb.content.text("&You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We imagine what you experienced was harrowing, but we think this may be a localized effect of the portal storm, rather than a new world.  It's difficult to tell from the recordings.  But they are nevertheless valuable, and we have turned them over to Research for further investigation.  Thank you for your contributions to science, as always.  If you return, please note any, let us say, passageways, that you may see, which could, well, lead to other places.  Yes?  Clear?  Thank you.\""),
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
