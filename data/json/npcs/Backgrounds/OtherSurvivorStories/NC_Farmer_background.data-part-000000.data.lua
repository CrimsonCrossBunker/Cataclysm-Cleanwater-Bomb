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
