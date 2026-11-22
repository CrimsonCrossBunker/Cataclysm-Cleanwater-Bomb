local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCAVENGER_1_HIRE",
    line = ccb.content.text("Are you interested in the scavenging runs or one of the other tasks that I might have for you?"),
    replies = {
        {
            text = ccb.content.text("Tell me more about the scavenging runs."),
            next_topic = "TALK_RANCH_SCAVENGER_1",
            actions = { actions.handler("dlg_a_dda_cae9c6cdf218") },
        },
        {
            text = ccb.content.text("What kind of tasks do you have for me?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("No, thanks."),
            next_topic = "TALK_RANCH_SCAVENGER_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCAVENGER_ANESTHETIC_FOR_DOCTOR",
    line = ccb.content.text("We don't have any of the parts needed right now, but we could send out a scavenging party to a hospital if you have anyone willing to go."),
    replies = {
        {
            text = ccb.content.text("Tell me more about the scavenging runs."),
            next_topic = "TALK_RANCH_SCAVENGER_1",
            actions = { actions.handler("dlg_a_dda_7c9def81e689") },
        },
        {
            text = ccb.content.text("Not right now."),
            next_topic = "TALK_RANCH_SCAVENGER_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_SCAVENGER_1",
    name = ccb.content.text("Make 12 Simple Knife Spears"),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 50000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RANCH_SCAVENGER_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I can usually use additional survival gear to kit out the new recruits.  The most basic weapon that everyone gets is the simple knife spear… it provides a good mix of range, power, and ease of use when engaging the more common monsters.  Could you make me a dozen of them?  I may need more later, but that should help the first few teams."),
        accepted = ccb.content.text("I'm counting on you."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("You should be able to make them with the most basic of skills."),
        inquire = ccb.content.text("Do you have the simple knife spears?"),
        success = ccb.content.text("Thank you for the delivery."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_48",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 15,
                            y = 13,
                            end_x = 15,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 16,
                            y = 13,
                            end_x = 23,
                            end_y = 13,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 16,
                            y = 22,
                            end_x = 17,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 22,
                            y = 22,
                            end_x = 23,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 18,
                            y = 19,
                            end_x = 21,
                            end_y = 22,
                        },
                    },
                },
            },
            {
                terrain = "ranch_camp_49",
                layout = {
                    item_group_placements = {
                        {
                            chance = 100,
                            group = "mechanics",
                            x = { 8, 9 },
                            y = { 13, 16 },
                            repetitions = { 3, 6 },
                        },
                        { chance = 100, group = "allsporting", x = 14, y = { 11, 17 }, repetitions = { 1, 2 } },
                    },
                    item_placements = { { id = "30gal_drum", x = 8, y = 19, faction = "tacoma_commune" } },
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 0,
                            y = 22,
                            end_x = 1,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_dirt",
                            x = 2,
                            y = 22,
                            end_x = 3,
                            end_y = 22,
                        },
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_chainfence",
                            x = 4,
                            y = 22,
                            end_x = 6,
                            end_y = 22,
                        },
                    },
                },
            },
        },
        handler = "deliver_mission_ranch_scavenger_1",
    },
    complete_when = "complete_mission_ranch_scavenger_1",
}
