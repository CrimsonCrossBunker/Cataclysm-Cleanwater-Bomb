local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_1",
    name = ccb.content.text("Locate Commo Team"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 250000,
    item = "necropolis_freq",
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("My communications team went to secure the radio control room after we breached the facility.  I haven't heard from them since, I need you to locate them.  Their first objective was to record all active channels that were transmitting information on other survivors or facilities.  Find them and return the frequency list to me.  I'm sure they could probably use your help also."),
        accepted = ccb.content.text("Good luck, the communications room shouldn't be far from here."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("We were briefed that the communications array was on this level."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, let me know when you need another tasking."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_2",
    name = ccb.content.text("Cull Nightmares"),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    difficulty = 5,
    value = 250000,
    monster_type = "mon_charred_nightmare",
    start = { target = { terrain = "necropolis_c_44", special = "Necropolis", z = -2 } },
    monster_kill_goal = 20,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Your assistance is greatly appreciated, we need to clear out the more ruthless monsters that are wandering up from the lower levels.  If you could cull twenty or so of what we refer to as 'nightmares' my men would be much safer.  If you've cleared out most of this floor then the lower levels should be your next target."),
        accepted = ccb.content.text("Good luck, finding a clear passage to the second level may be tricky."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("These creatures can swing their appendages surprisingly far."),
        inquire = ccb.content.text("How is the hunt going?"),
        success = ccb.content.text("Thanks, let me know when you need another tasking."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
