local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_1",
    generic_rewards = false,
    name = ccb.content.text("Lighthouse"),
    description = ccb.content.text("Lead Mikhail to lighthouse."),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 5000,
    start = {
        target = {
            terrain = "lighthouse_ground",
            special = "Lighthouse Island",
            reveal_radius = 10,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "lighthouse_ground",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 1, 22 }, y = { 1, 22 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z1",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z2",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z3",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z4",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
            {
                terrain = "lighthouse_z5",
                layout = {
                    monster_group_placements = {
                        { group = "GROUP_ZOMBIE", x = { 11, 16 }, y = { 8, 16 }, density = 0.3 },
                    },
                },
            },
        },
        actions = {
            "follow_only",
            ccb.content.dialogue_actions.set_first_topic("TALK_lighthouse_man_lighthouse"),
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_lighthouse_man_2",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("We've been wandering around the state with my family for a long time since <the_cataclysm>, and I realized that the safest hideout is the island.  I left my family in a shelter, and went to explore the area, looking for some island nearby, in a lake or in the ocean.  And you know, I found a sea map marked with navigational beacons near here.  If you want, you can help me get to one of these and take a good look at it."),
        accepted = ccb.content.text("Good.  I'll be right behind you."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("First we need to find a transport to get there."),
        inquire = ccb.content.text("We finally reached it."),
        success = ccb.content.text("Looks nice, <name_g>.  Now I need to clean it from <zombies> somehow…"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
