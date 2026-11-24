local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
    line = ccb.content.text("Dr. Harlow discovered some sort of alien robotics, and has been performing unsanctioned medical procedures in an attempt to adapt a banned neuromorphic interface in living humans.  The experiments are unethical and a failure to boot, and thus must be stopped."),
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_OFFER", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype" },
    line = {
        when = predicates.handler("dlg_p_futurismcataclysmlegacy_97f048b36363"),
        yes = ccb.content.text("As you are aware, we have recovered advanced equipment from the Exodii warehouse.  Analysis indicates it may constitute an automated surgical suite for highly mechanized cyborg; however, additional hardware is required to fully assemble and activate the system.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
        no = ccb.content.text("Our robotics research division has requested new robot specimens.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
    },
}
