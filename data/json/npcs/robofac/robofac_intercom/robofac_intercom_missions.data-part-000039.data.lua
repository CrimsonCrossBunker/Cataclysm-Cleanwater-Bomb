local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What",
    line = ccb.content.text("Killer robots that invaded earth during the portal storm.  They have a large fortress somewhere - some sort of metal castle - and thus show signs of dangerous intelligence.  We do not fully understand their directives or functions, and thus need a salvaged robot to deconstruct and reverse engineer."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How",
    line = ccb.content.text("We understand these Exodii can be quite dangerous, hence why we are assigning you a HOUND unit.  You can disable the robot by any violent means you deem necessary, as long as it does not seriously damage its frame."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which",
    line = ccb.content.text("Yes, a good question.  Our recon teams have identified several units that appear to be mindless \"worker\" drones.  These worker units can be found at some of their field sites, which may look like large shipping containers, metal boxes, or strange barns.  We also know that there are infected robots roaming near some of their facilities, which we have taken to calling \"zomborgs\".  But, we have other contractors working with these zomborgs, and these efforts have not yet yielded results, so please do not bring us any of those."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype",
    line = ccb.content.text("We refer to it as the Hostile Overstimulation and Unmanned Neutralization Drone, or HOUND.  It is a custom-build robot that will engage hostiles with a noisemaker and taser unit.  It should keep hostile Exodii, and other threats, distracted so that you can engage them safely.  We strongly suggest you bring hearing protection."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ACCEPTED",
    line = ccb.content.text("&The intercom's tray slides open, revealing an inactive robot and a pair of earplugs.  \"Happy hunting.\""),
}
