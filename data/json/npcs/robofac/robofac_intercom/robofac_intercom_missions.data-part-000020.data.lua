local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE",
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
    },
    line = ccb.content.text("&The intercom tray quickly slides shut.\n\n\"We expected nothing less.  We hope you found the prototype's performance to be satisfactory.\""),
    replies = {
        {
            text = ccb.content.text("Will this weapon work on other robots, as well?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
        },
        {
            text = ccb.content.text("The handling procedures you gave me seemed to predate the Cataclysm.  How long had that robot been here?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
            actions = {
                actions.set_actor_value("speaker", "global_portal_storms_u_heard_of_portal_storms", "yes"),
            },
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}
