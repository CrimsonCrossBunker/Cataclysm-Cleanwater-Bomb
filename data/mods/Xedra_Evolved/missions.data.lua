local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SAFEHOUSE",
    name = ccb.content.text("Return to the safehouse and grab your gear."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "safe_house",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "safe_house", special = "safe_house" } },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_KILL_DREAM_DRAINER",
    name = ccb.content.text("Kill that mosquito"),
    description = ccb.content.text("You summoned a dream-draining mosquito.  Now it is time for you to kill it."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_dream_drainer_mosquito",
    monster_kill_goal = 1,
    difficulty = 10,
    value = 0,
    finish = {
        before_rewards = "announce_dream_drainer_loot",
        item_rewards = { { item = "dream_drainer_heart", count = 1, preview = false } },
    },
    generic_rewards = false,
    origins = { "ORIGIN_SECONDARY" },
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
    id = "MISSION_KILL_LUNA_ATTUNED",
    name = ccb.content.text("Kill the Luna-attuned revenant"),
    description = ccb.content.text("You created a Luna-attuned revenant.  Now it is time for you to kill it."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_luna_attuned_revenant",
    monster_kill_goal = 1,
    difficulty = 10,
    value = 0,
    finish = {
        before_rewards = "announce_luna_attuned_loot",
        item_rewards = { { item = "moonstruck_pearl", count = 1, preview = false } },
    },
    generic_rewards = false,
    origins = { "ORIGIN_SECONDARY" },
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
    id = "MISSION_SEVENOCLOCK",
    name = ccb.content.text("Find the source of the bloody footsteps."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "cabin_sevenoclock",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "cabin_sevenoclock", special = "old cabin" } },
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
    id = "MISSION_DEATHWORM",
    name = ccb.content.text("Find the source of the acid-burned hole."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "field_deathworm",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "field_deathworm", special = "acid-scarred field" } },
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
    id = "MISSION_LOW_VAMPIRE_HUNTER",
    name = ccb.content.text("Kill a vampire"),
    description = ccb.content.text("You prepared for so long to kill vampires, and there's no way you let all that preparation be for nothing.  Kill a vampire to show that you can and will hunt them!"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "VAMPIRE",
    monster_kill_goal = 1,
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_low_vampire_hunter" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER",
    name = ccb.content.text("Kill ten vampires"),
    description = ccb.content.text("The end of society is no excuse to stop the hunt.  In fact, it's another reason to continue your work.  Kill ten vampires, so the world will be a little more free of them."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "VAMPIRE",
    monster_kill_goal = 10,
    difficulty = 5,
    value = 0,
    finish = { handler = "morale_mission_vampire_hunter" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_FIND_VAMPIRE_HUNTER_BASE",
    name = ccb.content.text("Find the building from the smudged map."),
    description = ccb.content.text("You found a map pointing to a building on a vampire's corpse.  Going there might not be safe, but it will surely be worth it."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "lodge_VH_ground1",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "lodge_VH_ground1", special = "Vampire Hunter Lodge" } },
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

-- TODO: If we ever get narrower search ranges than 'circular' make this further away
ccb.content.define_mission {
    id = "MISSION_REVENANT_VENGEANCE",
    name = ccb.content.text("Vengeance Shall Be Mine"),
    description = ccb.content.text("Your murderer is out there, and you will find them."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 4,
    start = {
        target = {
            terrain = "bandit_camp",
            match = "CONTAINS",
            reveal_radius = 1,
            min_distance = 540,
            search_range = 1500,
            random = true,
        },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit_revenant", x = { 7, 22 }, y = { 6, 19 }, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "complete_revenant_vengeance" },
}
