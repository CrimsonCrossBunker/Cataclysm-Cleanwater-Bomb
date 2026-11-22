local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_INTERESTING_THINGS",
    line = {
        when = predicates.handler("dlg_p_dda_93de4f1e1331"),
        yes = ccb.content.gendered_line("I haven't found anything out of the ordinary, just a bunch of <zombies> and the ruins of our old lives.", { "interlocutor" }),
        no = {
            when = predicates.handler("dlg_p_dda_2fad9a32b6ea"),
            yes = ccb.content.gendered_line("Actually, I came across a group of farmers on my way here.  They were a little suspicious, but turned out to be pretty nice.  Good place to buy some food, if they're still around.", { "interlocutor" }),
            no = {
                when = predicates.handler("dlg_p_dda_ffef735f5e6b"),
                yes = ccb.content.gendered_line("I found a small cabin out in the woods, someone was living there and had some serious chemistry equipment.  I managed to get good medical supplies from there.  They even had some oddball things too, like fucking napalm and black powder.", { "interlocutor" }),
                no = {
                    when = predicates.handler("dlg_p_dda_c854bbaab2c0"),
                    yes = ccb.content.gendered_line("I ran in to someone living in an old barn, didn't want anything to do with the world.  The odd thing is, they looked like one of those old, Wild West cowboys.", { "interlocutor" }),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How do I get to that farm?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_965ef3fae5ff"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "isherwood"), actions.assign_mission("directions_isherwood_traveler") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that cabin?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_730976137644"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "chem_chabin"), actions.assign_mission("directions_cabin") },
            switch = true,
        },
        {
            text = ccb.content.text("Where were they at?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_676606e9ce0a"),
            actions = { actions.set_actor_value("interlocutor", "camper_van_traveler_mission_directions", "cowboy"), actions.assign_mission("directions_cowboy") },
            switch = true,
        },
        {
            text = ccb.content.text("Ah, that's nothing new to me.  Thanks anyway though."),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}
