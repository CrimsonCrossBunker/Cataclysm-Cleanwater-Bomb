local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "NC_ANCILLA_BOSS_CHOP_SHOP" },
    line = ccb.content.text("&The mercenary points their firearm at you and stares you down.  Their eyes are fierce, wide, and bloodshot.  In the background, another merc starts talking into their radio."),
    replies = {
        {
            text = ccb.content.text("[Put your hands up] Woah!  Easy!"),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_2",
            actions = { actions.handler("w16b_a_dda_9d667fd980a9") },
        },
        {
            text = ccb.content.text("Hey, fuck you!"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_dda_745865974c3d") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ANCILLA_BOSS_CHOP_SHOP_2" },
    line = ccb.content.text("&The mercenary addresses you sternly: \"You got one minute to get the fuck out of here.  And don't try anything funny.  One of my guys is callin' in your description as we speak, got it?\""),
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_WHO_FAILED_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } })),
            actions = { actions.set_actor_value("speaker", "robofac_chop_shop_warned", "yes") },
        },
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } }),
            actions = { "hostile", actions.handler("w16b_a_dda_dd0badb4aabd") },
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_WHAT_FAILED_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } })),
            actions = { actions.set_actor_value("speaker", "robofac_chop_shop_warned", "yes") },
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } }),
            actions = { "hostile", actions.handler("w16b_a_dda_35c88564e93a") },
        },
        {
            text = ccb.content.text("Are you the only people here?"),
            next_topic = "NC_ANCILLA_BOSS_CHOP_SHOP_WHO_ELSE_FAILED_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } })),
            actions = { actions.set_actor_value("speaker", "robofac_chop_shop_warned", "yes") },
        },
        {
            text = ccb.content.text("Are you the only people here?"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_chop_shop_warned" } }),
            actions = { "hostile", actions.handler("w16b_a_dda_ec688fccf9b6") },
        },
        {
            text = ccb.content.text("I know what you're doing here, and I'm not leaving until you're all dead."),
            next_topic = "TALK_DONE",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"),
            actions = { "hostile", actions.handler("w16b_a_dda_d9a597053fde") },
        },
        {
            text = ccb.content.text("I'm here for the alien robot, and I'm not leaving until I get it."),
            next_topic = "TALK_DONE",
            when = predicates.has_mission("EXODII_MISSION_CHOP_SHOP"),
            actions = { "hostile", actions.handler("w16b_a_dda_a97d0be01535") },
        },
        {
            text = ccb.content.text("I'm here for the scientist, and just the scientist, on orders from the intercom.  I'll give you and your team one chance to back down."),
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"),
            trial = { kind = "intimidate", difficulty = 15, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_DONE", actions = { actions.handler("w16b_a_dda_93367a8c1117") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_dda_e9ec6878b6ec") } },
        },
        {
            text = ccb.content.text("I'm here for the alien.  I'll give you and your team one chance to back down."),
            when = predicates.has_mission("EXODII_MISSION_CHOP_SHOP"),
            trial = { kind = "intimidate", difficulty = 15, modifiers = { { score = "BRAVERY", scale = -1 }, { score = "FEAR", scale = 3 } } },
            success = { next_topic = "TALK_DONE", actions = { actions.handler("w16b_a_dda_93367a8c1117") } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("w16b_a_dda_0f501b39b0a4") } },
        },
        {
            text = ccb.content.text("Fuck you, I'm not leaving."),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_dda_b08aa8604017") },
        },
        {
            text = ccb.content.text("Alright, I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}
