local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
    line = ccb.content.text("*smiles slightly.  \"Awesome, getting our team kitted out better will go a long way to making this possible.\""),
    replies = {
        {
            text = ccb.content.text("[5 Riot Armor] I've got enough riot armor for everyone."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_f53210a49dbf"),
            actions = { actions.handler("dlg_a_dda_ac36764419c7") },
        },
        {
            text = ccb.content.text("[5 Riot Helmet] These crowd control helmets should help a lot."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_683b81f6faa8"),
            actions = { actions.handler("dlg_a_dda_5bcc06cfd5dd") },
        },
        {
            text = ccb.content.text("[5 Riot Arm Guard] I hope these armguards won't interfere with people's aim."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_657aabd51a14"),
            actions = { actions.handler("dlg_a_dda_a11617c84486") },
        },
        {
            text = ccb.content.text("[5 Riot Leg Guard] I've got these leg guards to keep people from getting hobbled."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_60d6d15b9b8b"),
            actions = { actions.handler("dlg_a_dda_e5ad87d70cd3") },
        },
        {
            text = ccb.content.text("We have enough full sets of riot control armor to cover everyone, head to toe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
            when = predicates.handler("dlg_p_dda_58b387811876"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
