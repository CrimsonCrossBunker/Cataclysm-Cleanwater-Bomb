local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("What can you tell me about Xedra?"),
            next_topic = "TALK_EXODII_MERCHANT_XEDRA",
        },
        {
            text = ccb.content.text("What can you tell me about these faeries?"),
            next_topic = "TALK_EXODII_MERCHANT_FAE",
        },
        {
            text = ccb.content.text("[DEDUCTION 2] So does that mean the stories I heard about vampires are true as well?"),
            next_topic = "TALK_EXODII_MERCHANT_VAMPIRE",
            when = predicates.handler("dlg_p_xedra_evolved_89df39a2ceaa"),
        },
        {
            text = ccb.content.text("I saw some much larger and more heavily armed and armored cyborgs ."),
            next_topic = "TALK_EXODII_MERCHANT_JOTUNN",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_exodii_seen_jotunn" } }),
        },
    },
}
