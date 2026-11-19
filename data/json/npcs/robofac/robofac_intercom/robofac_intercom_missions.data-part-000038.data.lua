local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_OFFER",
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
    },
    line = ccb.content.text("When the portal storms started, alien structures started to appear all over the surrounding area.  We sent a field team to recover and study them, and we have been in constant contact since.  However, we have since learned that the project lead, Dr. Michael Harlow, has been performing unethical human experimentation at his field site, without approval from our Institutional Review Board.  While we would usually take the IRB report to the authorities, there are no more authorities.  The IRB has unanimously determined that these experiments must be put to an end.  However, Dr. Harlow has indicated that the experiments will not stop, so they must be stopped by force.\"\n\n\"We want you to travel to the field site, execute Dr. Harlow, and free any living prisoners he may still have.  If Dr. Harlow's mercenaries resist, you are authorized to respond with deadly force.  Given the severity of Dr. Harlow's ethics violations, this is the most utilitarian outcome.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract, and you may keep anything valuable you find at the site."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  I'll kill the scientist."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ACCEPTED",
        },
        {
            text = ccb.content.text("What sort of resistance might there be?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
        },
        {
            text = ccb.content.text("What sort of experiments is Dr. Harlow doing?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
