local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_Accept_Boris_Mission_1",
    line = ccb.content.text("It's your lucky day: I just made contact with a couple volunteers like yourself, and that's exactly the sort of project I can put them to."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_70d7de14f9c9") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, that's great news!"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_1",
    name = ccb.content.text("Kill Bandits"),
    description = ccb.content.text("A pair of bandits have been preying on locals, based out of a nearby cabin.  Ensure they meet a bitter end along with any associates, but watch out for traps around their hideout."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 50000,
    start = {
        target = { terrain = "bandit_cabin", special = "bandit_cabin", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    npc_placements = { { id = "bandit", x = 12, y = 12, target = true } },
                    tile_edits = {
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 7, y = 6 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 5, y = 5 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 8, y = 5 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 0, y = 11 },
                    },
                },
            },
        },
    },
    finish = { handler = "mark_proven_worth_to_old_guard_representative" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I don't like sending untested men into the field but if you have stayed alive so far you might have some skills.  There are at least a pair of bandits squatting in a local cabin, anyone who preys upon civilians meets a quick end… execute both of them for their crimes.  Complete this and the Old Guard will consider you an asset in the region."),
        accepted = ccb.content.text("Contractor, I welcome you aboard."),
        rejected = ccb.content.text("The States will remain a wasteland unless good men choose to save it."),
        advice = ccb.content.text("They might suspect you are coming, keep an eye out for traps."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("The Old Guard thanks you for eliminating the criminals.  You won't be forgotten."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_2",
    name = ccb.content.text("Deal with Informant"),
    description = ccb.content.text("The Hell's Raiders bandit group may have an informant working inside the Refugee Center.  Investigate and bring them to justice without arousing any suspicions."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 50000,
    start = {
        map_updates = {
            {
                terrain = "evac_center_19",
                layout = { npc_placements = { { id = "evac_guard3", x = 12, y = 12, target = true } } },
            },
            {
                terrain = "evac_center_7",
                layout = { npc_placements = { { id = "scavenger_hunter", x = { 9, 15 }, y = { 9, 15 } } } },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("This task is going to require a little more persuasive skill.  I believe the Hell's Raiders have an informant here to monitor who comes and goes.  I need you to find out who it is and deal with them without letting anyone else know of my suspicions.  We normally allow the Free Merchants to govern themselves so I would hate to offend them."),
        accepted = ccb.content.text("Thank you, please keep this discreet."),
        rejected = ccb.content.text("Come back when you get a chance, we could use a few good men."),
        advice = ccb.content.text("If they draw first blood their friends are less likely to blame you…"),
        inquire = ccb.content.text("You deal with the rat?"),
        success = ccb.content.text("Thank you, I'll do the explaining if anyone else asks about it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
