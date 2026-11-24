local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BOSS_NC_FARMER_Story1",
    line = ccb.content.gendered_line("Actually, I ran into another survivor once - survivalist, total nutcase.  He was headed for a military bunker to try and loot it, guessing that didn't go well.  Anyway, he mentioned a pack of survivors who camped out at a farm around here, some of them actually knew about farming.  There's a chance they're still out there, could be worth looking for.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Let's see how to get there and go check on them."),
            next_topic = "BOSS_NC_FARMER_Story2",
            when = predicates.handler("dlg_p_dda_ee75ba89fa07"),
            actions = { actions.assign_mission("directions_farmer") },
            switch = true,
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BOSS_NC_FARMER_Story2",
    line = ccb.content.text("*shows you on your map where to find it.  \"This looks right to me.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "directions_farmer",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("There's maybe still some farmers left."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Farm Mutable", terrain = "farm_2", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_farmer",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("There's maybe still some farmers left."),
        offer = ccb.content.text("There's maybe still some farmers left."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
