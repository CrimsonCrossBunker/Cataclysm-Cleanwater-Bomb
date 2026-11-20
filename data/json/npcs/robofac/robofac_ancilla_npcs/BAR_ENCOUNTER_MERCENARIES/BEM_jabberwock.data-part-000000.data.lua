local ccb = require("ccb")

-- All dialogue about this mission is handled through talk_topics, so we don't use any of these strings.
ccb.content.define_mission {
    id = "BEM_jabberwock_mission",
    name = ccb.content.text("\"God\"-Slayer"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 200000,
    urgent = true,
    description = ccb.content.text("A traumatized mercenary has claimed to have seen what you assume to be a powerful monster.  Maybe you should investigate this for the benefit of everyone."),
    start = {
        target = {
            terrain = "forest_thick",
            replace_terrain = "forest",
            reveal_radius = 1,
            random = true,
            search_range = 60,
            min_distance = 15,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { handler = "mark_dialogue_bem_completed_bem_jabberwock" },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
