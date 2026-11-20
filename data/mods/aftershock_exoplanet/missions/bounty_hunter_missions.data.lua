local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_LAST_DANCE",
    name = ccb.content.text("The bounty is on Salus IV"),
    description = ccb.content.text("You've chased your bounty all the way to the ass end of the galaxy here in the Salus system; a place of so little value to UICA that it's left to pirates and hermits.  While you don't know where exactly your bounty is in this desolate wasteland, you do have a lead on one of his associates.  Maybe he'll be able to tell you where to go."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 4,
    start = {
        target = {
            terrain = "afs_augmentation_clinic_n3",
            special = "afs_augmentation_clinic_1",
            reveal_radius = 6,
            min_distance = 15,
            z = 3,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "afs_mon_reaver_rifle",
                            name = ccb.content.text("Friend of Bounty"),
                            x = 11,
                            y = 11,
                            target = true,
                        },
                        { id = "afs_mon_reaver", name = ccb.content.text("The Guard"), x = 12, y = 12 },
                        { id = "afs_mon_reaver", name = ccb.content.text("The Collaborator"), x = 9, y = 9 },
                        { id = "afs_mon_reaver", name = ccb.content.text("The Aristocrat"), x = 13, y = 13 },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_last_dance" },
}
