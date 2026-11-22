local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_VAMPIRE",
    line = ccb.content.text("Claret drinking brown bread, an' a crew of Renny's, on this mudball.  Us un's can't tell if they're part of the enemy or parasites exposed when the enemy rises.  Not on every mudball but definitely moar than enough to be a right pain."),
    replies = {
        {
            text = ccb.content.text("Well that's certainly disturbing."),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("[DEDUCTION 4 or INT 14 ] Would you have any specialized weapons to use against them?"),
            next_topic = "TALK_EXODII_MERCHANT_VAMPIRE_GEAR",
            when = predicates.handler("dlg_p_xedra_evolved_b3eba08a0db3"),
            actions = { actions.set_actor_value("speaker", "rubik_vampire_weapons", "banger_and_smash") },
        },
    },
}
