local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2",
    line = ccb.content.text("Pat taps their glasses - you see that they're a very expensive pair of AR glasses.  \"See these?  Handy, yeah.  Picked'em up after my last paycheck before it all happened.  I'm thinkin' if you can find yourself a pair, plus a couple'a tablet PCs for spare parts, and a couple'a two-way radios, we could set up a controller-operator thing, you know, like in the movies.  I've got a big cache of downloaded map data from my old gig, so no doubt I can keep you informed.  With internet and cell service down, it won't be easy, and we can't share video, but I think I could set up a LoRa system for audio and pictures here at the station - long range radio, yeah?  Wicked.  Anyway, you do the field work, you keep the rewards - all the while, I'll use the contraption I'm gonna make to collect data I can sell to our employers.  Win-Win."),
    replies = {
        {
            text = ccb.content.text("I like it.  1 pair of advanced AR glasses, 2 E-ink tablet PCs, and 2 two-way radios, coming right up."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("Where could I find a pair of those glasses?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2_advice",
        },
        {
            text = ccb.content.text("Actually, I've got this really advanced headset.  Will that work?"),
            when = predicates.any({ predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1) }),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
    line = ccb.content.text("Lemme see heah… Well, hole-lee shit, fahk yeah it'll work!  That thing's probably got a radio built in, yeah?  In that case, just get a radio and a tablet for me, for parts."),
    replies = {
        {
            text = ccb.content.text("I like it.  I'll find a two-way radio and an E-ink tablet PC."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2_advice",
    line = ccb.content.text("Bought mine at an electronics shop back in town, but they were in demand before the end.  Pre-ordah only.  If you can't find one in a shop, I guess you could always rob someone dead, hah.  Or check out one'a them containah yahrds, or swipe it off a truck.  Don't matter to me."),
    replies = {
        {
            text = ccb.content.text("I like it.  1 pair of advanced AR glasses, 2 E-ink tablet PCs, and 2 two-way radios, coming right up."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_2") },
        },
        {
            text = ccb.content.text("Actually, I've got this really advanced headset.  Will that work?"),
            when = predicates.any({ predicates.has_inventory("speaker", "military_vis_aug_system", 1), predicates.has_inventory("speaker", "robofac_head_rig_ar", 1) }),
            next_topic = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_2b",
        },
        {
            text = ccb.content.text("On second though, let's talk about this later.  I gotta go."),
            next_topic = "TALK_DONE",
        },
    },
}
