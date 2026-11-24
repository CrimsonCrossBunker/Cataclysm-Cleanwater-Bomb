local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- In charge of outside communications in Necropolis
ccb.content.define_npc {
    id = "old_guard_necropolis_commo",
    suffix = ccb.content.text("SFC"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_NEC_COMMO",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_NEC_COMMO_1",
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_COMMO",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Marshal, I'm rather surprised to see you here."),
        no = {
            when = predicates.actor_state("speaker", "male"),
            yes = ccb.content.text("Sir you are not authorized to be here… you should leave."),
            no = ccb.content.text("Ma'am you are not authorized to be here… you should leave."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[MISSION] The captain sent me to get a frequency list from you."),
            next_topic = "TALK_OLD_GUARD_NEC_COMMO_FREQ",
            when = predicates.all({ predicates.wears("speaker", "badge_marshal"), predicates.has_mission("MISSION_OLD_GUARD_NEC_1"), predicates.negate(predicates.has_effect("speaker", "has_og_comm_freq")) }),
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_OLD_GUARD_NEC_COMMO_GOAL",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.has_effect("speaker", "has_og_comm_freq"), predicates.wears("speaker", "badge_marshal") }),
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
        { text = ccb.content.text("I should be going"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_COMMO_GOAL",
    line = ccb.content.text("We are securing the external communications array for this facility.  I'm rather restricted in what I can release… go find my commander if you have any questions."),
    replies = {
        {
            text = ccb.content.text("I'll try and find your commander then…"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_NEC_COMMO_FREQ",
    line = ccb.content.text("I was expecting the captain to send a runner.  Here is the list you are looking for.  What we can identify from here are simply the frequencies that have traffic on them.  Many of the transmissions are indecipherable without repairing or replacing the equipment here.  When the facility was being overrun, standard procedure was to destroy encryption hardware to protect federal secrets and maintain the integrity of the comms network.  We are hoping a few plain text messages can get picked up though."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_NONE",
            actions = { actions.handler("dlg_a_no_hope_8683ce392b9e"), actions.add_effect("speaker", "has_og_comm_freq", { permanent = true }) },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_1",
    name = ccb.content.text("Fabricate Repeater Mod"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 250000,
    item = "radio_repeater_mod",
    start = {
        target = { terrain = "necropolis_c_23", special = "Necropolis", reveal_radius = 3, z = -2 },
        item_rewards = { { item = "repeater_mod_guide" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("My chief responsibility is to monitor radio traffic and locate potential targets to secure or rescue.  The majority of radio repeaters are down and those that are working have only emergency power.  If you have a basic understanding of electronics you should be able to fabricate the 'radio repeater mod' found in these plans.  When this mod is attached to a radio station's main terminal, all short range radio traffic on emergency channels is boosted so we can pick it up at much longer ranges.  I really need you make me one."),
        accepted = ccb.content.text("Thanks, I know the labs on the other side of the complex have electronic parts sitting around."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("I'm sure the motorpool has a truck battery you could salvage."),
        inquire = ccb.content.text("Have you had any luck fabricating it?"),
        success = ccb.content.text("Thanks, I'll see to installing this one.  It will be some time but I could use someone to position these around the region."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_2",
    name = ccb.content.text("Disable External Power"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 150000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I guess I could use your skills once again.  There are small transmitters located in the nearby evacuation shelters; if we don't separate them from the power grid their power systems will rapidly deteriorate over the next few weeks.  The task is rather simple but the shelters offer us a place to redirect refugees until this vault can be secured."),
        accepted = ccb.content.text("Thanks, I should be ready for you to install the radio repeater mods by the time you get back."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("Try searching on the outskirts of towns."),
        inquire = ccb.content.text("Have you had any luck severing the connection?"),
        success = ccb.content.text("We are good to go!  The last of the gear is powering up now."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_3",
    name = ccb.content.text("Install Repeater Mod"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 300000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Most of my essential gear has been brought back online so it is time for you to install your first radio repeater mod.  Head topside and locate the nearest radio station.  Install the mod on the backup terminal and return to me so that I can verify that everything was successful.  Radio towers must unfortunately be ignored for now, without a dedicated emergency power system they won't be useful for some time."),
        accepted = ccb.content.text("I'll be standing by down here once you are done."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("If you could make some sort of directional antenna, it might help locating the radio stations."),
        inquire = ccb.content.text("Have you had any luck finding a radio station?"),
        success = ccb.content.text("That's one down."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_NEC_COMMO_4",
    name = ccb.content.text("Install Repeater Mod"),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 2,
    value = 350000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_NEC_COMMO_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I could always use you to put another repeater mod up.  I don't have to remind you but every one that goes up extends our response area just a little bit more.  With enough of them we'll be able to maintain communication with anyone in the region."),
        accepted = ccb.content.text("I'll be standing by."),
        rejected = ccb.content.text("I don't know why you would bother wasting your time down here if you can't handle a few small tasks…"),
        advice = ccb.content.text("Getting a working vehicle is going to become important as the distance you have to travel increases."),
        inquire = ccb.content.text("Have you had any luck finding a radio station?"),
        success = ccb.content.text("I'll try and update the captain with any signals that I need investigated."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
