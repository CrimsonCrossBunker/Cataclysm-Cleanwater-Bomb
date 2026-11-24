local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_MAIN",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        { text = ccb.content.text("Tempo Techniques."), next_topic = "TALK_MA_PERK_MENU_TEMPO" },
        {
            text = ccb.content.text("Momentum Techniques."),
            next_topic = "TALK_MA_PERK_MENU_MOMENTUM",
        },
        { text = ccb.content.text("Insight Techniques."), next_topic = "TALK_MA_PERK_MENU_INSIGHT" },
        {
            text = ccb.content.text("Defensive Stance Techniques."),
            next_topic = "TALK_MA_PERK_MENU_POISE",
        },
        {
            text = ccb.content.text("Standalone Techniques."),
            next_topic = "TALK_MA_PERK_MENU_STANDALONE",
        },
        { text = ccb.content.text("Help."), next_topic = "TALK_MA_PERK_MENU_HELP" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_TEMPO",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_COMBAT_TEMPO>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_COMBAT_TEMPO")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_COMBAT_TEMPO>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_COMBAT_TEMPO>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_COMBAT_TEMPO" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_COMBAT_TEMPO_2>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_COMBAT_TEMPO_2")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_COMBAT_TEMPO_2>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_COMBAT_TEMPO_2>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_COMBAT_TEMPO_2" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I" }), actions.handler("dlg_a_perk_melee_ebb3872ec2f7") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TEMPO_SHIFT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TEMPO_SHIFT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TEMPO_SHIFT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TEMPO_SHIFT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TEMPO_SHIFT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I" }), actions.handler("dlg_a_perk_melee_ebb3872ec2f7") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TEMPO_ASSAULT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TEMPO_ASSAULT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TEMPO_ASSAULT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TEMPO_ASSAULT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TEMPO_ASSAULT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I and Perfect Tempo" }), actions.handler("dlg_a_perk_melee_6b502c186d59") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TEMPO_ZONING>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TEMPO_ZONING")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TEMPO_ZONING>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TEMPO_ZONING>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TEMPO_ZONING" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I and Perfect Tempo" }), actions.handler("dlg_a_perk_melee_6b502c186d59") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_DUELIST_COMBO>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_DUELIST_COMBO")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_DUELIST_COMBO>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_DUELIST_COMBO>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_DUELIST_COMBO" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I and Perfect Tempo" }), actions.handler("dlg_a_perk_melee_6b502c186d59") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TEMPO_THROW>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TEMPO_THROW")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TEMPO_THROW>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TEMPO_THROW>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TEMPO_THROW" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I" }), actions.handler("dlg_a_perk_melee_ebb3872ec2f7") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_KNIFE_FINISHER>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_KNIFE_FINISHER")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_KNIFE_FINISHER>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_KNIFE_FINISHER>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_KNIFE_FINISHER" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I" }), actions.handler("dlg_a_perk_melee_ebb3872ec2f7") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_STAGGER_STRIKE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_STAGGER_STRIKE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_STAGGER_STRIKE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_STAGGER_STRIKE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_STAGGER_STRIKE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Combat Tempo I" }), actions.handler("dlg_a_perk_melee_ebb3872ec2f7") },
        },
        {
            text = ccb.content.text("Go back"),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_MOMENTUM",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MOMENTUM>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MOMENTUM")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MOMENTUM>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MOMENTUM>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MOMENTUM" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MOMENTUM_2>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MOMENTUM_2")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MOMENTUM_2>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MOMENTUM_2>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MOMENTUM_2" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MOMENTUM_DUELIST>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MOMENTUM_DUELIST")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MOMENTUM_DUELIST>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MOMENTUM_DUELIST>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MOMENTUM_DUELIST" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MOMENTUM_BULLET_DODGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MOMENTUM_BULLET_DODGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MOMENTUM_BULLET_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MOMENTUM_BULLET_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MOMENTUM_BULLET_DODGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I and Spry Footwork" }), actions.handler("dlg_a_perk_melee_a6b5fcca89b7") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_COILING_STRIKE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_COILING_STRIKE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_COILING_STRIKE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_COILING_STRIKE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_COILING_STRIKE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_ESTOCADA>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_ESTOCADA")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_ESTOCADA>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_ESTOCADA>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_ESTOCADA" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_DUELIST_LUNGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_DUELIST_LUNGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_DUELIST_LUNGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_DUELIST_LUNGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_DUELIST_LUNGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TACKLE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TACKLE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TACKLE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TACKLE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TACKLE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Momentum I" }), actions.handler("dlg_a_perk_melee_0fcf6c68bf37") },
        },
        {
            text = ccb.content.text("Go back"),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_INSIGHT",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_INSIGHT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_INSIGHT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_INSIGHT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_INSIGHT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_INSIGHT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_INSIGHT_INFINITE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_INSIGHT_INFINITE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_INSIGHT_INFINITE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_INSIGHT_INFINITE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_INSIGHT_INFINITE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I" }), actions.handler("dlg_a_perk_melee_724cde31b873") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_TWILIGHT_FORM>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_TWILIGHT_FORM")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_TWILIGHT_FORM>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_TWILIGHT_FORM>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_TWILIGHT_FORM" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I" }), actions.handler("dlg_a_perk_melee_724cde31b873") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_INSIGHT_DODGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_INSIGHT_DODGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_INSIGHT_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_INSIGHT_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_INSIGHT_DODGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I" }), actions.handler("dlg_a_perk_melee_724cde31b873") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MYSTIC_SHOT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MYSTIC_SHOT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MYSTIC_SHOT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MYSTIC_SHOT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MYSTIC_SHOT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I" }), actions.handler("dlg_a_perk_melee_724cde31b873") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MYSTIC_SHOT_2>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MYSTIC_SHOT_2")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MYSTIC_SHOT_2>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MYSTIC_SHOT_2>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MYSTIC_SHOT_2" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I and Mystic Shot I" }), actions.handler("dlg_a_perk_melee_f5541b229d19") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_SIXTH_SENSE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_SIXTH_SENSE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_SIXTH_SENSE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_SIXTH_SENSE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_SIXTH_SENSE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I" }), actions.handler("dlg_a_perk_melee_724cde31b873") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_BLIND_CALCULUS>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_BLIND_CALCULUS")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_BLIND_CALCULUS>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_BLIND_CALCULUS>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_BLIND_CALCULUS" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Insight I and Sixth Sense" }), actions.handler("dlg_a_perk_melee_0f04e630b95f") },
        },
        {
            text = ccb.content.text("Go back"),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_POISE",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_POISE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_POISE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_POISE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_POISE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_POISE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_SHRUG_OFF>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_SHRUG_OFF")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_SHRUG_OFF>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_SHRUG_OFF>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_SHRUG_OFF" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires defensive stance" }), actions.handler("dlg_a_perk_melee_3f1205ad201a") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_POISE_RECKLESS>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_POISE_RECKLESS")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_POISE_RECKLESS>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_POISE_RECKLESS>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_POISE_RECKLESS" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires defensive stance" }), actions.handler("dlg_a_perk_melee_3f1205ad201a") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_POISE_PARRY>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_POISE_PARRY")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_POISE_PARRY>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_POISE_PARRY>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_POISE_PARRY" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires defensive stance" }), actions.handler("dlg_a_perk_melee_3f1205ad201a") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_POISE_FOOTWORK>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_POISE_FOOTWORK")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_POISE_FOOTWORK>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_POISE_FOOTWORK>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_POISE_FOOTWORK" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires defensive stance" }), actions.handler("dlg_a_perk_melee_3f1205ad201a") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_POISE_MOUNTAIN>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_POISE_MOUNTAIN")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_POISE_MOUNTAIN>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_POISE_MOUNTAIN>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_POISE_MOUNTAIN" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires defensive stance" }), actions.handler("dlg_a_perk_melee_3f1205ad201a") },
        },
        {
            text = ccb.content.text("Go back"),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_STANDALONE",
    line = ccb.content.text("Level <u_val:ma_current_level>.\n<u_val:num_ma_perks> perk points to spend.\nCurrent EXP: <u_val:ma_available_exp>.\nEXP to next level: <u_val:ma_exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_DODGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_DODGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_DODGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_BLOCK>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_BLOCK")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_BLOCK>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_BLOCK>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_BLOCK" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_SHRUG_OFF>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_SHRUG_OFF")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_SHRUG_OFF>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_SHRUG_OFF>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_SHRUG_OFF" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_PRESSURE_STRIKES>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_PRESSURE_STRIKES")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_PRESSURE_STRIKES>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_PRESSURE_STRIKES>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_PRESSURE_STRIKES" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_RIPOSTE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_RIPOSTE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_RIPOSTE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_RIPOSTE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_RIPOSTE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_UNDODGING>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_UNDODGING")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_UNDODGING>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_UNDODGING>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_UNDODGING" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MOVING_DODGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MOVING_DODGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MOVING_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MOVING_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MOVING_DODGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_CAREFREE_STANCE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_CAREFREE_STANCE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_CAREFREE_STANCE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_CAREFREE_STANCE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_CAREFREE_STANCE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_FEINT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_FEINT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_FEINT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_FEINT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_FEINT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_FORE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_FORE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_FORE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_FORE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_FORE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_MAKE_WAY>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_MAKE_WAY")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_MAKE_WAY>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_MAKE_WAY>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_MAKE_WAY" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_STAFF_KICK>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_STAFF_KICK")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_STAFF_KICK>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_STAFF_KICK>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_STAFF_KICK" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_KNIFE_COUNTER_DODGE>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_KNIFE_COUNTER_DODGE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_KNIFE_COUNTER_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_KNIFE_COUNTER_DODGE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_KNIFE_COUNTER_DODGE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_JUST_HIT_IT>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_JUST_HIT_IT")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_JUST_HIT_IT>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_JUST_HIT_IT>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_JUST_HIT_IT" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_EXECUTION>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_EXECUTION")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_EXECUTION>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_EXECUTION>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_EXECUTION" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "No Requirements" }), actions.handler("dlg_a_perk_melee_8ccd5f544ce6") },
        },
        {
            text = ccb.content.text("Learn [<trait_name:MELEE_PERK_BRUTALITY>]"),
            next_topic = "TALK_MA_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MELEE_PERK_BRUTALITY")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MELEE_PERK_BRUTALITY>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MELEE_PERK_BRUTALITY>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MELEE_PERK_BRUTALITY" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Requires Execution" }), actions.handler("dlg_a_perk_melee_d8171d3c5ec0") },
        },
        {
            text = ccb.content.text("Go back."),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_SELECT",
    line = ccb.content.text("<context_val:trait_name>: \"<context_val:trait_description>\"\n<context_val:trait_requirement_description>.\n<context_val:trait_additional_details>"),
    replies = {
        {
            text = ccb.content.text("Select Perk."),
            next_topic = "TALK_MA_PERK_MENU_MAIN",
            when = predicates.handler("dlg_p_perk_melee_dd59e3b64789"),
            actions = { actions.handler("dlg_a_perk_melee_129bcec5a018") },
            failure_topic = "TALK_NONE",
            failure_explanation = ccb.content.text("Requirements Not Met"),
        },
        {
            text = ccb.content.text("Go Back."),
            next_topic = "TALK_NONE",
            actions = { actions.set_string({ scope = "conversation", key = "trait_additional_details" }, { "" }) },
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_FAIL",
    line = ccb.content.text("You don't have a perk point, or meet the prerequisites for this perk."),
    replies = {
        { text = ccb.content.text("Go Back."), next_topic = "TALK_PERK_MENU_MAIN" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MA_PERK_MENU_HELP",
    line = ccb.content.text("XP is gained by killing enemies, either by melee or ranged combat, with tougher enemies giving more XP.  You'll gain a perk point every time you level up, which can be used to unlock a perk through this menu.  Most perks are completely passive, and apply their effects automatically on movement, combat or waiting.\n\nPerks cannot be refunded or disabled once learned, consider your choices carefully."),
    replies = {
        { text = ccb.content.text("Go back."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Quit."), next_topic = "TALK_DONE" },
    },
}
