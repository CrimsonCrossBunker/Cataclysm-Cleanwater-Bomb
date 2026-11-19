local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    line = ccb.content.text("Easy, head out to one of those supply stores outta town.  I used'ta pass one when out doing field recahrdings.  Heah, I'll upload the location."),
    replies = {
        {
            text = ccb.content.text("Thanks, maybe I'll check it out."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_PAT_OUTTA_TOWN"),
                actions.set_actor_value("speaker", "robofac_pat_gave_directions_farm_supply", "yes"),
            },
        },
    },
}
