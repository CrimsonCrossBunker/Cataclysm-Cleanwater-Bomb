local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_ANIMIST",
    line = ccb.content.text("<trait_name:perk_caster_level_up_animist>: \"<trait_description:perk_caster_level_up_animist>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_animist"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_MAGUS",
    line = ccb.content.text("<trait_name:perk_caster_level_up_magus>: \"<trait_description:perk_caster_level_up_magus>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_magus"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_STORMSHAPER",
    line = ccb.content.text("<trait_name:perk_caster_level_up_stormshaper>: \"<trait_description:perk_caster_level_up_stormshaper>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_stormshaper"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_KELVINIST",
    line = ccb.content.text("<trait_name:perk_caster_level_up_kelvinist>: \"<trait_description:perk_caster_level_up_kelvinist>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_kelvinist"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_EARTHSHAPER",
    line = ccb.content.text("<trait_name:perk_caster_level_up_earthshaper>: \"<trait_description:perk_caster_level_up_earthshaper>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_earthshaper"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_TECHNOMANCER",
    line = ccb.content.text("<trait_name:perk_caster_level_up_technomancer>: \"<trait_description:perk_caster_level_up_technomancer>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_technomancer"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_DRUID",
    line = ccb.content.text("<trait_name:perk_caster_level_up_druid>: \"<trait_description:perk_caster_level_up_druid>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_druid"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_CASTER_LEVEL_UP_BIOMANCER",
    line = ccb.content.text("<trait_name:perk_caster_level_up_biomancer>: \"<trait_description:perk_caster_level_up_biomancer>\""),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_magiclysm_5418beee4326"),
            actions = { actions.replace_mutation("speaker", "perk_caster_level_up_biomancer"), actions.handler("dlg_a_magiclysm_35c28be1f42d") },
            failure_topic = "TALK_PERK_MENU_FAIL",
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_PLAYSTYLE_STORMWROUGHT",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_portal_storm_mutator_mana>]"),
            next_topic = "TALK_PERK_MENU_SELECT_PLAYSTYLE",
            when = predicates.negate(predicates.has_trait("speaker", "perk_portal_storm_mutator_mana")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_portal_storm_mutator_mana>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_portal_storm_mutator_mana>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_portal_storm_mutator_mana" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No requirements" }), actions.handler("dlg_a_magiclysm_0a74c5591bcc") },
        },
    },
}
