local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- If you have met her already, skip the introduction and go to the normal menu.
-- If you haven't met her, go to her non-earthborn introduction.
-- If you haven't met her and your Earthborn she chastizes you harder. Her exerpiences with Artemis makes her assume you're a panzy.
ccb.content.define_dialogue_topic {
    id = { "TALK_SALVOR_FABRICATOR" },
    line = ccb.content.text("&As you approach the counter, you can't help but notice the chaotic scene before you: Juxtaposed to the makeshift structure, an awkward marriage of ship hulls and foamcrete walls, stands neatly arranged shelving, and near-pristine furniture.  The tools and parts lining the shelves have each been meticulously arranged.  A Salvor sits behind the counter with her arm perched on the surface, supporting her head in her hand.  In her other hand, she idly waves a cigarette, making small circles in the air.  Gray hairs peek out from the edges of her Cryo suit, and her wrinkle-creased face wears a permanent scowl."),
    replies = {
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_MAIN",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } }),
        },
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.negate(predicates.has_trait("speaker", "BKGR_EARTH")) }),
        },
        {
            text = ccb.content.text("[Approach the counter]"),
            next_topic = "TALK_SALVOR_FABRICATOR_INTRODUCTION_EARTH",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "player_has_met" } })), predicates.has_trait("speaker", "BKGR_EARTH") }),
        },
    },
}
