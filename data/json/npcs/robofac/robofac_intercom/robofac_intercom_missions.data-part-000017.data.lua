local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Gun",
    line = ccb.content.text("If you'll give me a moment…\"  You hear the sounds of typing.  \"Its working name is the hm12.  It functions similarly to a laser, but is specifically designed to incapacitate robots without harming their internals.  Once a subject is stunned, it can be manually deactivated.\"\n\n\"A shot will only stun the robot if you manage to hit its main sensory array, which will rely on your aim.  After a stunning shot, you might proceed to the deactivation attempts by examining the robot from up close."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Trifacet",
    line = ccb.content.text("We are as of yet uncertain of its origin and purpose.  Its body most closely resembles a pyramid on what we believe are three sets of legs for mobility.  It is lightly armed, and has attacked our cam-spy drones using high-voltage electric discharge.  We theorize that this is most likely for deterrence, and not to cause direct harm.  Nonetheless, we need to emphasize that its full capabilities are unknown, and we do not know how it will react when confronted with a living threat."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_ACCEPTED",
    line = ccb.content.text("Lovely.  Just a moment; we will transfer the prototype and handling procedures, which includes information of its last recorded location.\"\n\nThe intercom tray thumps several times as objects are placed into it.  After about a minute, it slides open, revealing a slender weapon that looks a bit like a radar gun, a tool battery, a sheaf of papers in a binder, and a UPS.  \"The hm12 draws power from a connected UPS.  Please remember to bring the specimen back *intact* - battered salvage is of no use to us.  To safely perform the task of deactivation, <color_yellow>please review the provided documentation</color>, and pay special attention to the procedures detailed in subsections IV and VII."),
}
