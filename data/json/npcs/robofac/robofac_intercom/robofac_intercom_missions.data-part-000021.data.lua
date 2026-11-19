local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
    line = ccb.content.text("We believe so; it underwent intensive internal tests on existing and theoretical models before giving it to you.  UGVs, autonomous CROWS units, manhacks, and other robots should all be possible to neutralize by using the weapon, although we advise great caution; the weapon is short-ranged, and was not designed to target distant enemies."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
    line = ccb.content.text("Pardon me.\"  The voice briefly turns away from the microphone and asks something.  \"Very well.  I am cleared to tell you that it appeared near the beginning of the portal storms, and during this time, it was logged and documented.  No attempt was ever made to retrieve it before the government collapsed.  That is all I am able to share with you at this time."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_FAILED",
    line = ccb.content.text("&The intercom tray quickly slides shut.  After a pause, the voice on the other end sighs.\n\n\"…we requested that the subject remain intact.  This outcome is… unfortunate.  We will process the specimen, but it is unlikely that it will yield usable information as to its purpose.\"\n\n\"You may keep the prototype.  You are dismissed.\""),
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Alright, alright."), next_topic = "TALK_DONE" },
    },
}
