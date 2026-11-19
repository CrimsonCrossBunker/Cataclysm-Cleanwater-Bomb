local ccb = require("ccb")

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
