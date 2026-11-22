local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_2",
    line = ccb.content.text("&The Doc spends a long moment clacking away on the keyboard, until the machine beeps several times.  \"Yup, all looks good.  Healthy as a horse.  Well, good enough for the machine, at least.  Maybe too healthy, seeing as you still have all your limbs, but that's none of my business.\n\n\"So you're sure about this?  What can I do ya' for?  Not sure yet if you have any cybernetics installed that won't swap over, but if you do, I'll remove them first.\n\n\"Oh, and the important parts.  Firstly, it'll take 6 hours, and I don't have the spare supplies to keep you hydrated, so come fed and healthy.  Second, it's 20 HGC per limb - a nice discounted price.  Third, you'll need to come back here if you damage them - trust me, you don't want to go fucking with the electronics yourself.  Let the robot do it.  Got all that?\""),
    replies = {
        {
            text = ccb.content.text("[20 HGC] Give me a right bionic arm."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_3b0f6c80d508"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_RIGHT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a left bionic arm."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_3b0f6c80d508"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_LEFT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] I've already got one bionic arm.  Install the other."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT") }), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_5eb7d97f57e0"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_BOTH"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a right bionic leg."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_abe9cab787b0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_RIGHT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a left bionic leg."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_abe9cab787b0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_LEFT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] I've already got one bionic leg.  Install the other."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT") }), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_27cd72b84fb0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_BOTH"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("Actually, maybe another time."),
            next_topic = "TALK_DONE",
        },
    },
}
