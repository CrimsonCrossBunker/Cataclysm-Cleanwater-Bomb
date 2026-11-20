local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_INHALER",
    name = ccb.content.text("Find Inhaler"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    deadline = { "2 days", "3 days" },
    dialogue = {
        describe = ccb.content.text("I'm… short… of breath…"),
        offer = ccb.content.text("I'm asthmatic.  I need you to get an inhaler for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("There's a town nearby.  Check pharmacies; it'll be in the back with the good stuff."),
        inquire = ccb.content.text("Find any inhaler yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.replace_mutation("interlocutor", "ASTHMA"),
            ccb.content.dialogue_actions.remove_items("interlocutor", "inhaler"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            ccb.content.dialogue_actions.transfer_items("inhaler"),
            "npc_thankful",
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_inhaler_inhaler",
}
