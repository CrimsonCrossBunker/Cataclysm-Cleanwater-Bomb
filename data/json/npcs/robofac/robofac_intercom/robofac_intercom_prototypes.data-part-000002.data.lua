local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- quick access to prototype menu through the merc vouching
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_GUN_YES",
    line = ccb.content.text("Yes, Foster gave you quite a recommendation.  Very well - I will authorize you access to our prototype fabrication services for agents in the field.  This includes the Hybrid Weapons Platform, alongside the ability to order spare or replacement parts for your field gear."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Great.  What exactly is this 'Hybrid Weapons Platform', anyway?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
