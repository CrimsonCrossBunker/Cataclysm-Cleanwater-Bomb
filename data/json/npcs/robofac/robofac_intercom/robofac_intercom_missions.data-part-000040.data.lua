local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_OFFER", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype" },
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("As you are aware, we have recovered advanced equipment from the Exodii warehouse.  Analysis indicates it may constitute an automated surgical suite; however, additional hardware is required to fully assemble and activate the system.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
        no = ccb.content.text("Our robotics research division has requested new robot specimens.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
    },
    replies = {
        {
            text = ccb.content.text("So take down an Exodii worker and bring it to you?  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ACCEPTED",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI"), actions.handler("dlg_a_dda_f6e107a6ca8f") },
        },
        {
            text = ccb.content.text("What's an Exodii?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })),
            actions = { actions.set_actor_value("speaker", "hub01_explained_exodii", "yes") },
        },
        {
            text = ccb.content.text("How am I supposed to take down an Exodii worker?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("What exactly am I looking for?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("Tell me more about this prototype HOUND."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}
