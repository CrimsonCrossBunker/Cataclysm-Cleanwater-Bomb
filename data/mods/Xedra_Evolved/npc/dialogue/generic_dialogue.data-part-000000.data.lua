local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_MUG", "TALK_STRANGER_AGGRESSIVE" },
    replies = {
        {
            text = ccb.content.text("[Autumn Glamour] *Use Scarecrow's Mien*."),
            when = predicates.handler("dlg_p_xedra_evolved_5a52ac7f915d"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_xedra_evolved_91d05d3070a1") },
            success = { next_topic = "TALK_MUG_SCARECROW_MIEN_USED", actions = { actions.add_effect("speaker", "effect_changeling_autumn_scare_humans", { turns = 15 }), actions.handler("dlg_a_xedra_evolved_72b8fc8b39b8") }, opinion = { fear = 5 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile", actions.handler("dlg_a_xedra_evolved_50775eaa3d7a") } },
        },
        {
            text = ccb.content.text("<color_light_green>[Hypnotic Gaze] *Look directly into their eyes*</color>."),
            next_topic = "TALK_HYPNOTIC_GAZE_USED",
            when = predicates.handler("dlg_p_xedra_evolved_937b74baf8cf"),
            actions = { actions.handler("dlg_a_xedra_evolved_08365a1060b5") },
        },
    },
}
