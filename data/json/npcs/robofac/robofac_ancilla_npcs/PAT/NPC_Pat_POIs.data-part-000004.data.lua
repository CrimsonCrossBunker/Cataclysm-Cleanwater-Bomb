local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_1",
    line = ccb.content.text("&The line is silent a moment before Pat chirps back: \"Well, nothin'.  It's just that this buildin' isn' on my maps.  If I had to guess, it's some sort of government spook shit.  Ovah\""),
    replies = {
        {
            text = ccb.content.text("It's that LIXA place - that contract I accepted from the intercom.  Over."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"),
        },
        { text = ccb.content.text("I'll be careful.  Over and out."), next_topic = "TALK_DONE" },
    },
}
