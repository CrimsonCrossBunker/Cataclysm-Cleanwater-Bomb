local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_INHALER",
    name = ccb.content.text("Find Spurge Tea"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    deadline = { "30 days", "48 days" },
    dialogue = {
        describe = ccb.content.text("I'm… short… of breath…"),
        offer = ccb.content.text("I'm asthmatic.  I need you to get some kind of medicinal tea for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("I'm dead unless I can get this special tea.  Maybe it's from a flower?"),
        inquire = ccb.content.text("Find any tea yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.replace_mutation("interlocutor", "ASTHMA"),
            ccb.content.dialogue_actions.remove_items("interlocutor", "spurge_tea"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            ccb.content.dialogue_actions.transfer_items("spurge_tea"),
            "npc_thankful",
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_inhaler_spurge_tea",
}

ccb.content.define_mission {
    id = "MISSION_GET_ANTIBIOTICS",
    name = ccb.content.text("Find Cattail Jelly"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC" },
    deadline = { "24 days", "48 days" },
    dialogue = {
        describe = ccb.content.text("This infection is bad, totally bad…"),
        offer = ccb.content.text("I'm infected.  Badly.  I need you to get something antiseptic for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry.  Get me some cattail jelly.  That should hopefully be good enough."),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("I think if you can pull cattail jelly out of some cattails from like a swamp or something, I can smear it on the wound."),
        inquire = ccb.content.text("Find any jelly yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "infection", { permanent = true }),
            ccb.content.dialogue_actions.remove_items("interlocutor", "cattail_jelly"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.remove_effects("interlocutor", { "infection" }),
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            "npc_thankful",
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_antibiotics_cattail_jelly",
}
