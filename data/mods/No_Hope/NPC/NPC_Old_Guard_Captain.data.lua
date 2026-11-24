local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Commander in Necropolis
ccb.content.define_npc {
    id = "old_guard_necropolis_cpt",
    suffix = ccb.content.text("CPT"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_NEC_CPT",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_NEC_1",
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Marshal, I hope you're here to assist us."),
        no = {
            when = predicates.actor_state("speaker", "male"),
            yes = ccb.content.text("Sir, I don't know how the hell you got down here but if you have any sense you'll get out while you can."),
            no = ccb.content.text("Ma'am, I don't know how the hell you got down here but if you have any sense you'll get out while you can."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing down here?"),
            next_topic = "TALK_OLD_GUARD_NEC_CPT_GOAL",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Can you tell me about this facility?"),
            next_topic = "TALK_OLD_GUARD_NEC_CPT_VAULT",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("What do you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("About the mission…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.assigned_missions(1, 1), predicates.wears("speaker", "badge_marshal") }),
        },
        {
            text = ccb.content.text("About one of those missions…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.all({ predicates.assigned_missions(2), predicates.wears("speaker", "badge_marshal") }),
        },
        { text = ccb.content.text("I've got to go…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT_GOAL",
    line = ccb.content.text("I'm leading what remains of my company on a mission to re-secure this facility.  We entered the complex with two dozen men and immediately went about securing this control room.  From here I dispatched my men to secure vital systems located on this floor and the floors below this one.  If we are successful, this facility can be cleared and used as a permanent base of operations in the region.  Most importantly it will allow us to redirect refugee traffic away from overcrowded outposts and free up more of our forces to conduct recovery operations."),
    replies = { { text = ccb.content.text("Seems like a decent plan…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_CPT_VAULT",
    line = ccb.content.text("This facility was constructed to provide a safe haven in the event of a global conflict.  The vault can support several thousand people for a few years if all systems are operational and sufficient notification is given.  Unfortunately, the power system was damaged or sabotaged at some point and released a single extremely lethal burst of radiation.  The catastrophic event lasted for several minutes and resulted in the deaths of most people located on the 2nd and lower floors.  Those working on this floor were able to seal the access ways to the lower floors before succumbing to radiation sickness.  The only other thing the logs tell us is that all water pressure was diverted to the lower levels."),
    replies = {
        {
            text = ccb.content.text("Whatever they did it must have worked since we are still alive…"),
            next_topic = "TALK_NONE",
        },
    },
}

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
