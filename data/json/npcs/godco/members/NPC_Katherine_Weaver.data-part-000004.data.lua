local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Zachary",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
        yes = ccb.content.text("He can keep his distance with his smug nothingness.  At least he's a bit more useful than some of the others.  He helped Corrie make that generator."),
        no = ccb.content.text("I'm not planning to communicate with him, that's for certain.  He can keep his distance with his smug nothingness.  At least he knows how to cut lumber."),
    },
}
