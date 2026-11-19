local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
    line = ccb.content.text("The convoy was composed of vehicles and personnel from the US Army, and it was heavily armed.  Our surveillance of the area has shown that the majority of the slain military personnel have revived, including one wearing a light combat exoskeleton.  Resistance will be heavy, but if possible, you may be able to locate and retrieve the hard case, then exfiltrate without direct combat as long as you can outpace the undead there.  Otherwise, bring a rifle and plenty of ammo."),
}

-- This is a lie.  The researcher was XEDRA; DARPA is just the organization being used as a front.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
    line = ccb.content.text("Officially speaking, they were a senior DARPA researcher.  Their corpse should stick out; it's likely the only one not wearing camouflage.  That's all you need to know."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ACCEPTED",
    line = ccb.content.text("It was ambushed on the road.\"  The intercom recites a series of coordinates.  \"Report back with the hard case.  If the researcher brought it with him, it will be intact; have no doubt about that."),
}
