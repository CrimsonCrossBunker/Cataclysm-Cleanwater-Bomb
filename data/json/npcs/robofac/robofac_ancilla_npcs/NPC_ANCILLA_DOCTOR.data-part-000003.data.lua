local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_REPAIR",
    line = ccb.content.text("What do you need?  Repairing cybernetics isn't cheap, but I guess it's cheaper than replacing them.  Make sure you unload anything or remove any mods you want to keep.\"  The Doc then gently pats the automated surgical suite.  \"Doc Junior here will tear up anything you leave in during the repair."),
    replies = {
        {
            text = ccb.content.text("Can you repair damage to my bionic limbs?"),
            actions = { "repair_bionic_limbs" },
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT") }),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Actually, can you help me with something else?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS",
        },
    },
}
