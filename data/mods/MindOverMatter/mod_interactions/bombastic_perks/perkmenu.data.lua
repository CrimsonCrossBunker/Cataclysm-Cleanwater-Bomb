local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PERK_MENU_PSIONICS",
    line = ccb.content.text("Psionic Perks:\nLevel <u_val:current_level>.\n<u_val:num_perks> perk points to spend.\nCurrent EXP: <u_val:available_exp>.\nEXP to next level: <u_val:exp_to_perk>."),
    replies = {
        {
            text = ccb.content.text("Gain [<trait_name:perk_clear_minded_channeling>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_clear_minded_channeling")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_clear_minded_channeling>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_clear_minded_channeling>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_clear_minded_channeling" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must know the Concentration (Beginner) proficiency and must not have the Easily Distracted trait" }), actions.handler("dlg_a_mindovermatter_98efafa391b5") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_concussive_blasts>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_concussive_blasts")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_concussive_blasts>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_concussive_blasts>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_concussive_blasts" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must know the Mindhammer or Wrecking Ball powers" }), actions.handler("dlg_a_mindovermatter_d4a20b456449") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_efficient_slumber>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_efficient_slumber")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_efficient_slumber>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_efficient_slumber>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_efficient_slumber" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have the Biokinetic power Metabolic Hyperefficiency 6+ or the Vitakinetic power Wakeful Rest 5+" }), actions.handler("dlg_a_mindovermatter_749adcaaabfb") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_grace_under_pain>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_grace_under_pain")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_grace_under_pain>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_grace_under_pain>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_grace_under_pain" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have the Biokinetic Power Overcome Pain 5+, the Electrokinetic power Pain Suppression 6+ or the Telepathic power Mood Stabilization 8+" }), actions.handler("dlg_a_mindovermatter_41e132fb13c4") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_in_the_zone>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_in_the_zone")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_in_the_zone>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_in_the_zone>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_in_the_zone" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have at least 40 levels worth of powers in a single psionic path" }), actions.handler("dlg_a_mindovermatter_a61b3676c020") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_mind_cry>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_mind_cry")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_mind_cry>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_mind_cry>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_mind_cry" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have the telepathic power Synaptic Blast at level 9+, the telepathic power Psychic Scream at level 4+, or the knack version of either of those powers" }), actions.handler("dlg_a_mindovermatter_cdd63c5284b6") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_mastery_of_form>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_mastery_of_form")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_mastery_of_form>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_mastery_of_form>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_mastery_of_form" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must know at least 100 levels of powers between Biokinesis and/or Vitakinesis" }), actions.handler("dlg_a_mindovermatter_2cae873e6578") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:MOM_PSYCHIC_VAMPIRE>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "MOM_PSYCHIC_VAMPIRE")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:MOM_PSYCHIC_VAMPIRE>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:MOM_PSYCHIC_VAMPIRE>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "MOM_PSYCHIC_VAMPIRE" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must be a telepath or a vitakinetic" }), actions.handler("dlg_a_mindovermatter_cd77c4fba5af") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:PYROMANIA>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "PYROMANIA")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:PYROMANIA>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:PYROMANIA>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "PYROMANIA" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must know at least 30 levels of Pyrokinesis powers" }), actions.handler("dlg_a_mindovermatter_f528bfef766d") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_wary_sleeper>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_wary_sleeper")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_wary_sleeper>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_wary_sleeper>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_wary_sleeper" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have the Clairsentience power Premonition 5+" }), actions.handler("dlg_a_mindovermatter_d65b127805f4") },
        },
        {
            text = ccb.content.text("================== Psionic Playstyle perks are below this line =================="),
            next_topic = "TALK_PERK_MENU_PSIONICS",
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_burning_bright>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_burning_bright")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_burning_bright>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_burning_bright>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_burning_bright" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have the Torrential Channeling trait" }), actions.handler("dlg_a_mindovermatter_9421131d4410") },
        },
        {
            text = ccb.content.text("Gain [<trait_name:perk_phoenix_rising>]"),
            next_topic = "TALK_PERK_MENU_SELECT",
            when = predicates.negate(predicates.has_trait("speaker", "perk_phoenix_rising")),
            actions = { actions.set_string({ scope = "conversation", key = "trait_name" }, { "<trait_name:perk_phoenix_rising>" }), actions.set_string({ scope = "conversation", key = "trait_description" }, { "<trait_description:perk_phoenix_rising>" }), actions.set_string({ scope = "conversation", key = "trait_id" }, { "perk_phoenix_rising" }), actions.set_translated_string({ scope = "conversation", key = "trait_requirement_description" }, { "Must have psionic powers" }), actions.handler("dlg_a_mindovermatter_bcccfc29c279") },
        },
        {
            text = ccb.content.text("Back"),
            next_topic = "TALK_PERK_MENU_MAIN",
        },
        {
            text = ccb.content.text("Settings"),
            next_topic = "TALK_PERK_MENU_CONFIG",
        },
        {
            text = ccb.content.text("Quit."),
            next_topic = "TALK_DONE",
        },
    },
}
