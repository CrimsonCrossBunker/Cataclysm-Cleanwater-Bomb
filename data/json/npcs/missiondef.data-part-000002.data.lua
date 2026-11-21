local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_ANTIBIOTICS",
    name = ccb.content.text("Find Antibiotics"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC" },
    deadline = "1 day",
    dialogue = {
        describe = ccb.content.text("This infection is bad, totally bad…"),
        offer = ccb.content.text("I'm infected.  Badly.  I need you to get some good antibiotics for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("There's a town nearby.  Check pharmacies; it'll be in the back, either antibiotics or broad-spectrum antibiotics will do."),
        inquire = ccb.content.text("Find any antibiotics yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "infection", { permanent = true }),
            ccb.content.dialogue_actions.remove_items("interlocutor", "antibiotics"),
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
            { handler = "deliver_mission_get_antibiotics" },
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_antibiotics",
}

ccb.content.define_mission {
    id = "MISSION_GET_BLACK_BOX",
    name = ccb.content.text("Retrieve Military Black Box"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "black_box",
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GET_BLACK_BOX_TRANSCRIPT",
    dialogue = {
        describe = ccb.content.text("We've got the flag, now we need to locate US forces."),
        offer = ccb.content.text("We have the flag but now we need to locate US troops to see what we can do to help.  I haven't seen any but I'm figurin' one of those choppers that were flyin' round during th' outbreak would have a good idea.  If you can get me a black box from one of the wrecks I'll look into where we might open 'er at."),
        accepted = ccb.content.text("Fuck yeah, America!"),
        rejected = ccb.content.text("Do you have any better ideas?"),
        advice = ccb.content.text("Survivors were talkin' 'bout seeing 'em falling out of the sky but I don't know where.  If I were a pilot I'd avoid crash landing in a city or forest though.  Black boxes are housed in the tail to survive the crash so check there when you do find one.  Now get to it!"),
        inquire = ccb.content.text("How 'bout that black box?"),
        success = ccb.content.text("America, fuck yeah!"),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, I'll have to find 'er myself."),
    },
}
