local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_LEADER_KILL_LURKING_STRIGOI",
    name = ccb.content.text("Kill the lurking strigoi"),
    goal = "MGOAL_KILL_MONSTERS",
    description = ccb.content.text("Kill the strigoi that was spotted in a nearby house."),
    difficulty = 3,
    value = 5000,
    start = {
        target = { terrain = "house", match = "PREFIX", reveal_radius = 1, min_distance = 5, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { id = "mon_vampire_strigoi", x = 12, y = 12, target = true } },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { handler = "mark_killed_strigoi_for_hunters" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_GANG",
    name = ccb.content.text("Kill the renfield gang"),
    goal = "MGOAL_KILL_MONSTERS",
    description = ccb.content.text("A handful of armed renfields are roaming near the base.  Better kill them before they attack it."),
    difficulty = 5,
    value = 7500,
    start = {
        target = { terrain = "field", reveal_radius = 1, min_distance = 15, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_renfield_9mm", x = 12, y = 12, target = true },
                        { id = "mon_renfield_9mm", x = 11, y = 11, target = true },
                        { id = "mon_renfield_9mm", x = 13, y = 13, target = true },
                        { id = "mon_renfield_9mm", x = 12, y = 14, target = true },
                        { id = "mon_renfield_shotgun", x = 14, y = 12, target = true },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { handler = "mark_killed_renfields_for_hunters" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_LEADER_KILL_RENFIELD_MONSTER",
    name = ccb.content.text("Kill the monstrous renfield"),
    goal = "MGOAL_KILL_MONSTERS",
    description = ccb.content.text("A massive renfield is roaming near the base.  Better kill it before they attack the hunters."),
    difficulty = 5,
    value = 5000,
    start = {
        target = { terrain = "field", reveal_radius = 1, min_distance = 15, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { id = "mon_renfield_abomination", x = 12, y = 12, target = true } },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { handler = "mark_killed_renfield_monster_for_hunters" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

-- It is an assassination mission so the game can spawn and point to the target.  Killing them is not always required.
ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET",
    name = ccb.content.text("Cure or kill the vampire"),
    goal = "MGOAL_ASSASSINATE",
    description = ccb.content.text("A recently-made vampire has been spotted nearby.  The better move is to cure them, but if they refuse you have to kill them."),
    difficulty = 5,
    value = 5000,
    start = {
        target = { terrain = "field", reveal_radius = 1, min_distance = 15, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "xe_vampire_mission_target", x = { 1, 22 }, y = { 1, 22 }, target = true },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { handler = "mark_completed_hunter_kill_target" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}
