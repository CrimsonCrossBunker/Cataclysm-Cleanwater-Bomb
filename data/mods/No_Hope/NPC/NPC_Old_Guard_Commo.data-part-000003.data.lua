local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

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
