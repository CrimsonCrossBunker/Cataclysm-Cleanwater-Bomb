local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN",
    line = ccb.content.text("&A very human-like cyborg stands before you.  Its steel frame is perfectly clean, but tarnished and clouded as if it were constantly exposed to harsh chemical cleansers.\n\nIt stares at you, not moving."),
    replies = {
        {
            text = ccb.content.text("[Motion to your belongings] Can we trade?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            native_actions = { "start_trade" },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Motion to the surgical bot] Can you help me with CBM surgery?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_EXODII_VENN_Bionic_Install",
        },
        {
            text = ccb.content.text("[Motion to your bionic limbs] Could you repair my Cyberframe?"),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_EXODII_VENN_repair",
        },
        {
            text = ccb.content.text("Good talk, Venn.  See you later."),
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_BODY_1"), predicates.has_trait("speaker", "EXODII_BODY_1b"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Well, nevermind, I guess."),
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "EXODII_BODY_1")), predicates.negate(predicates.has_trait("speaker", "EXODII_BODY_1b")), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            next_topic = "TALK_DONE",
        },
    },
}
