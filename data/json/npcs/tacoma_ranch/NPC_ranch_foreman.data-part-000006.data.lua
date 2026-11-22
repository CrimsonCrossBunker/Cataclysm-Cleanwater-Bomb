local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_Bartender_done",
    line = ccb.content.text("Ever since you got the bartender set up, our liquor business has been running so much better!  As thanks for your efforts, I wanted to reward you with a portion of recent profits."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_74a06dbaf8f4"), actions.clear_actor_value("speaker", "mission_flag_Bartender_rewarded") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_RANCH_FOREMAN_reward",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_Doctor_done",
    line = ccb.content.text("I heard you helped jumpstart our local medical services.  With that basic need covered, everyone has been able to focus on their work a lot more, so to thank you for your efforts, I wanted to reward you."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_b97e0f4a1de0"), actions.clear_actor_value("speaker", "mission_flag_Doctor_rewarded") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_RANCH_FOREMAN_reward",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_RANCH_FOREMAN_1",
    name = ccb.content.text("Cut 200 planks"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "2x4",
    item_count = 200,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_RANCH_FOREMAN_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Our first project is to enclose the barn so that new refugees have a safe place to sleep.  Before we can begin serious improvements, we need lumber to work with.  Enclosing the four barn entrances will take nearly 400 planks… if you could provide half of that, we should be able to take care of the other half and construction.  If you don't have a truck, I'd make finding one your first priority."),
        accepted = ccb.content.text("The more men we can bring to the camp, the quicker improvements can be made."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Avoid destroying the furniture, we'll be needing it."),
        inquire = ccb.content.text("Do you have them?"),
        success = ccb.content.text("Great, I'll send word that we could use another set of hands or two to help out here."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = {
        map_updates = {
            {
                terrain = "ranch_camp_65",
                layout = {
                    nested = { { x = 22, y = 0, id = "tacoma_commune_west_wall_door" } },
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
            {
                terrain = "ranch_camp_66",
                layout = {
                    nested = {
                        { x = 0, y = 0, id = "tacoma_commune_east_wall_door" },
                        { x = 13, y = 0, id = "tacoma_commune_west_wall_door" },
                        { x = 15, y = 0, id = "tacoma_commune_east_wall_door" },
                    },
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
            {
                terrain = "ranch_camp_74",
                layout = {
                    nested = { { x = 22, y = 0, id = "tacoma_commune_west_wall_door" } },
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
            {
                terrain = "ranch_camp_75",
                layout = {
                    nested = {
                        { x = 0, y = 0, id = "tacoma_commune_east_wall_door" },
                        { x = 13, y = 0, id = "tacoma_commune_west_wall_door" },
                        { x = 15, y = 0, id = "tacoma_commune_east_wall_door" },
                    },
                    transform_placements = { { id = "cut_foliage", x = { 0, 23 }, y = { 0, 23 } } },
                },
            },
        },
    },
}
