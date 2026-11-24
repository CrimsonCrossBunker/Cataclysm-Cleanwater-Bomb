local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
    line = ccb.content.text("As a chronomancer, you have a nigh-unique ability to alter the flow of time to your benefit.  However, in order to improve your abilities you must have insight into time.\n\nYou may gain chronal insight in several ways:\n #1: Using any chronomancy spell will temporarily allow you to gain insight on killing any enemy for a short time based on the difficulty of the spell.\n #2: Killing time altered creatures, such as monochrome zombies, will give you immediate insight based on the difficulty of that enemy.\n #3: You will gain a small amount of insight every day, proportionally increased by the amount of negative temporal traits you have.\n\n Current Insight: <u_val:xedra_chronomancer_insight_count>"),
    replies = {
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_time_bubble>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_8af6f3690c03"),
            actions = { actions.handler("dlg_a_xedra_evolved_37bf4214d9d0"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_bubble>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_bubble>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_bubble" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_time_bubble>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_07283b57c144"),
            actions = { actions.handler("dlg_a_xedra_evolved_1c5e5da1ab4a"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_bubble>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_bubble>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_bubble" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_time_freeze_target>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_e06eed9d7398"),
            actions = { actions.handler("dlg_a_xedra_evolved_c0b71bb83072"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_freeze_target>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_freeze_target>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_freeze_target" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_normalize_time>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_eb5a1c338423"),
            actions = { actions.handler("dlg_a_xedra_evolved_8577ba069972"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_normalize_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_normalize_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_normalize_time" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_entropic_burst>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_3c6a72c6b80d"),
            actions = { actions.handler("dlg_a_xedra_evolved_cb233f0b91fb"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_entropic_burst>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_entropic_burst>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_entropic_burst" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 16 <spell_name:xedra_chronomancer_time_bubble>" }), actions.handler("dlg_a_xedra_evolved_216cd926ece8") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_entropic_burst>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_d7a4238f8023"),
            actions = { actions.handler("dlg_a_xedra_evolved_9ca86534e9a0"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_entropic_burst>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_entropic_burst>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_entropic_burst" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_revert_wound>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_4183b6eb5b37"),
            actions = { actions.handler("dlg_a_xedra_evolved_cee14717bcf5"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_revert_wound>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_revert_wound>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_revert_wound" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_revert_wound>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_428f501dd629"),
            actions = { actions.handler("dlg_a_xedra_evolved_1a819b25b63f"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_revert_wound>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_revert_wound>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_revert_wound" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_time_loop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_75f4521b94a8"),
            actions = { actions.handler("dlg_a_xedra_evolved_587ddafb09e8"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_loop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_time_loop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_4e392be2ce43"),
            actions = { actions.handler("dlg_a_xedra_evolved_eb92ea277d74"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_loop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_time_stop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_f8ec20b85090"),
            actions = { actions.handler("dlg_a_xedra_evolved_af5018b125f5"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_stop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_stop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_stop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 20 <spell_name:xedra_chronomancer_time_freeze_target>" }), actions.handler("dlg_a_xedra_evolved_28329a927547") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_time_stop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_e4b849fa6818"),
            actions = { actions.handler("dlg_a_xedra_evolved_1aef20396c7d"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_time_stop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_time_stop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_time_stop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_revert_location>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_fff11404d2d9"),
            actions = { actions.handler("dlg_a_xedra_evolved_0df961d5a7c1"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_revert_location>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_revert_location>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_revert_location" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 16 <spell_name:xedra_chronomancer_stable_loop> + Level 16 <spell_name:xedra_chronomancer_revert_wound>" }), actions.handler("dlg_a_xedra_evolved_69cdad98a75a") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_revert_location>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_954d1f4970ff"),
            actions = { actions.handler("dlg_a_xedra_evolved_cdca0774c4c9"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_revert_location>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_revert_location>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_revert_location" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_cement_time>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_02b29db42e8f"),
            actions = { actions.handler("dlg_a_xedra_evolved_9ced1a10f928"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_cement_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_cement_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_cement_time" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 16 <spell_name:xedra_chronomancer_time_freeze_target> + Level 16 <spell_name:xedra_chronomancer_time_bubble>" }), actions.handler("dlg_a_xedra_evolved_41b1b34a4db9") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_cement_time>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_98864fc3e560"),
            actions = { actions.handler("dlg_a_xedra_evolved_29a8f36e3839"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_cement_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_cement_time>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_cement_time" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_paradox>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_0594f8e6d416"),
            actions = { actions.handler("dlg_a_xedra_evolved_6cbab3670f7a"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_paradox>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_paradox>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_paradox" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 15 <spell_name:xedra_chronomancer_cement_time> + Level 15 <spell_name:xedra_chronomancer_entropic_burst> + Level 15 <spell_name:xedra_chronomancer_stable_loop>" }), actions.handler("dlg_a_xedra_evolved_bffa399f46dd") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_paradox>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_6cc6a4257264"),
            actions = { actions.handler("dlg_a_xedra_evolved_27c3794e8a89"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_paradox>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_paradox>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_paradox" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_chronal_acceleration>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_478871cf2099"),
            actions = { actions.handler("dlg_a_xedra_evolved_cccee07de106"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_chronal_acceleration>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_chronal_acceleration>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_chronal_acceleration" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_chronal_acceleration>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_85792181c1c8"),
            actions = { actions.handler("dlg_a_xedra_evolved_c47db0be44aa"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_chronal_acceleration>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_chronal_acceleration>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_chronal_acceleration" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_stable_loop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_a74d6ae6637b"),
            actions = { actions.handler("dlg_a_xedra_evolved_97c82251b24c"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_stable_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_stable_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_stable_loop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 16 <spell_name:xedra_chronomancer_time_loop>" }), actions.handler("dlg_a_xedra_evolved_b7c1b3a58a48") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_stable_loop>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_1b596f4c9f53"),
            actions = { actions.handler("dlg_a_xedra_evolved_4eaecdcdca6e"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_stable_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_stable_loop>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_stable_loop" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_destabilizing_strikes>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_02b12571ca75"),
            actions = { actions.handler("dlg_a_xedra_evolved_cd288d13dae4"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_destabilizing_strikes>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_destabilizing_strikes>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_destabilizing_strikes" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_destabilizing_strikes>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_a119d45027b3"),
            actions = { actions.handler("dlg_a_xedra_evolved_6096d689d486"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_destabilizing_strikes>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_destabilizing_strikes>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_destabilizing_strikes" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_stabilize_timeline>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_78ecdeb1c9fc"),
            actions = { actions.handler("dlg_a_xedra_evolved_729e6df32435"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_stabilize_timeline>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_stabilize_timeline>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_stabilize_timeline" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_stabilize_timeline>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_29aeebc23c8f"),
            actions = { actions.handler("dlg_a_xedra_evolved_1354870a324f"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_stabilize_timeline>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_stabilize_timeline>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_stabilize_timeline" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_reverse_entropy>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_a6260ec2b9a1"),
            actions = { actions.handler("dlg_a_xedra_evolved_6da4dcd431c6"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_reverse_entropy>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_reverse_entropy>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_reverse_entropy" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_reverse_entropy>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_8c141998200f"),
            actions = { actions.handler("dlg_a_xedra_evolved_6395802b76f7"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_reverse_entropy>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_reverse_entropy>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_reverse_entropy" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_rewrite_wound_causality>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_22b6c7bb78ce"),
            actions = { actions.handler("dlg_a_xedra_evolved_633bdbcabb39"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_rewrite_wound_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_rewrite_wound_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_rewrite_wound_causality" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 10 <spell_name:xedra_chronomancer_revert_wound>" }), actions.handler("dlg_a_xedra_evolved_91e8684580a3") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_rewrite_wound_causality>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_bbb60c818474"),
            actions = { actions.handler("dlg_a_xedra_evolved_2530e835a651"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_rewrite_wound_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_rewrite_wound_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_rewrite_wound_causality" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Learn [<spell_name:xedra_chronomancer_rewrite_equipment_causality>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_ee2c93501b7d"),
            actions = { actions.handler("dlg_a_xedra_evolved_5cb29fa32fa6"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_rewrite_equipment_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_rewrite_equipment_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_rewrite_equipment_causality" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight and Level 10 <spell_name:xedra_chronomancer_reverse_entropy>" }), actions.handler("dlg_a_xedra_evolved_cc4f5a63f105") },
        },
        {
            text = ccb.content.text("Level [<spell_name:xedra_chronomancer_rewrite_equipment_causality>]"),
            next_topic = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_6b9ae0e2f0b9"),
            actions = { actions.handler("dlg_a_xedra_evolved_fb72a14f1a31"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<spell_name:xedra_chronomancer_rewrite_equipment_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<spell_description:xedra_chronomancer_rewrite_equipment_causality>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "xedra_chronomancer_rewrite_equipment_causality" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "Requires <u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Resolve [<trait_name:XEDRA_CHRONOMANCER_LOOPING_WOUND>]"),
            next_topic = "TALK_CHRONOMANCER_TRAIT_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_31b069a572b2"),
            actions = { actions.handler("dlg_a_xedra_evolved_5caa4b4614c2"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<trait_name:XEDRA_CHRONOMANCER_LOOPING_WOUND>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<trait_description:XEDRA_CHRONOMANCER_LOOPING_WOUND>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "XEDRA_CHRONOMANCER_LOOPING_WOUND" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Resolve [<trait_name:XEDRA_CHRONOMANCER_TIME_SLOWDOWN>]"),
            next_topic = "TALK_CHRONOMANCER_TRAIT_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_15974d739448"),
            actions = { actions.handler("dlg_a_xedra_evolved_5caa4b4614c2"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<trait_name:XEDRA_CHRONOMANCER_TIME_SLOWDOWN>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<trait_description:XEDRA_CHRONOMANCER_TIME_SLOWDOWN>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "XEDRA_CHRONOMANCER_TIME_SLOWDOWN" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Resolve [<trait_name:XEDRA_CHRONOMANCER_UNSTABLE_POWERS>]"),
            next_topic = "TALK_CHRONOMANCER_TRAIT_MENU_SELECT",
            when = predicates.handler("dlg_p_xedra_evolved_5131adbaea5f"),
            actions = { actions.handler("dlg_a_xedra_evolved_5caa4b4614c2"), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_name" }, { "<trait_name:XEDRA_CHRONOMANCER_UNSTABLE_POWERS>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_description" }, { "<trait_description:XEDRA_CHRONOMANCER_UNSTABLE_POWERS>" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_choice_id" }, { "XEDRA_CHRONOMANCER_UNSTABLE_POWERS" }), actions.set_string({ scope = "conversation", key = "chronomancer_menu_requirement_description" }, { "<u_val:chronomancer_menu_insight_cost> Insight" }), actions.handler("dlg_a_xedra_evolved_87d9b74af6e5") },
        },
        {
            text = ccb.content.text("Options"),
            next_topic = "TALK_CHRONOMANCER_MENU_SETTINGS",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
    line = ccb.content.text("You either don't have enough insight or you fail to meet the prerequisites for this power."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_TRAIT_MENU_FAIL",
    line = ccb.content.text("You either don't have enough insight or you fail to meet the prerequisites to resolve this issue."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_MENU_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\nSpell Difficulty:<context_val:chronomancer_menu_difficulty>\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Learn Power."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_4158d561cb43") },
            failure_topic = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_SPELL_LEVEL_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\nSpell Level:<context_val:chronomancer_spell_level>\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Level Power."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_81702efd677c") },
            failure_topic = "TALK_CHRONOMANCER_SPELL_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_TRAIT_MENU_SELECT",
    line = ccb.content.text("<context_val:chronomancer_menu_choice_name>: \"<context_val:chronomancer_menu_choice_description>\"\n<context_val:chronomancer_menu_requirement_description>.\n<context_val:chronomancer_menu_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Resolve Problem."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            when = predicates.handler("dlg_p_xedra_evolved_5ec7ca106bcd"),
            actions = { actions.handler("dlg_a_xedra_evolved_ecbdaa951f27") },
            failure_topic = "TALK_CHRONOMANCER_TRAIT_MENU_FAIL",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRONOMANCER_MENU_SETTINGS",
    line = ccb.content.text("Chronomancy Settings:"),
    replies = {
        {
            text = ccb.content.text("Disable Insight Gain Messages."),
            next_topic = "TALK_CHRONOMANCER_MENU_SETTINGS",
            when = predicates.handler("dlg_p_xedra_evolved_7b4bc1011653"),
            actions = { actions.handler("dlg_a_xedra_evolved_025fe1f04f4d") },
        },
        {
            text = ccb.content.text("Enable Insight Gain Messages."),
            next_topic = "TALK_CHRONOMANCER_MENU_SETTINGS",
            when = predicates.handler("dlg_p_xedra_evolved_164a52567b2b"),
            actions = { actions.handler("dlg_a_xedra_evolved_1ee970e6ee34") },
        },
        {
            text = ccb.content.text("Main Menu."),
            next_topic = "TALK_CHRONOMANCER_INSIGHT_MENU_MAIN",
            actions = { actions.set_string({ scope = "conversation", key = "chronomancer_menu_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}
