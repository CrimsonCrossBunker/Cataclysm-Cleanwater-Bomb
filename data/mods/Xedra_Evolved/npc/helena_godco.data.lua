local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_1",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Are you looking at me funny?"),
            when = predicates.has_effect("speaker", "effect_weird_equipment"),
            next_topic = "TALK_GODCO_Helena_INVENTOR",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_INVENTOR",
    line = ccb.content.text("Blasphemy!  I see your tools of devilry!"),
    replies = {
        {
            text = ccb.content.text("Blasphemy???  Before what God?  A God repulsed by the miserable humanity He created in His own image?  I will not be shackled by the failures of your God!  The only blasphemy is to wallow in insignificance!"),
            next_topic = "TALK_GODCO_Helena_Angry",
        },
    },
}
