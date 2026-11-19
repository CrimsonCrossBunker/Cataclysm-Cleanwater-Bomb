local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE_YES_FOUND",
    line = ccb.content.text("Boom!  Found it.  I think.  I'll upload the data.  Look, like I said befoah, maybe you go check this place out, but don' touch nothin'.  Negotiate somethin' with the intercom, yeah?"),
    replies = {
        {
            text = ccb.content.text("Thanks, Pat!  If it's what I'm looking for, I guess I'll have to decide if I want to activate the transponder for Rubik, or come talk to the intercom about it."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.finish_mission("MISSION_ROBOFAC_PAT_1", { success = true }),
                actions.assign_mission("mission_exodii_wh_directions"),
            },
        },
    },
}
