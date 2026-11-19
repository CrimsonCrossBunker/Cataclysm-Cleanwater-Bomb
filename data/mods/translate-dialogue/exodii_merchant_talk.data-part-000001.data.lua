local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_started_rubik_intro" } }),
        yes = {
            joined = {
                ccb.content.text("Sure as you c'n try.  Us're not the greatest yarker, nor do it all for gratis, kennit."),
                ccb.content.text("\"\n\n[TRANSLATE:] \""),
                ccb.content.text("You can surely try.  I'm not the greatest speaker, and I won't just chat forever for free, you know."),
            },
        },
        no = {
            joined = {
                ccb.content.text("Oy, c'n I bark you summat first?"),
                ccb.content.text("\"\n\n[TRANSLATE:] \""),
                ccb.content.text("Hey, can I ask you something first?"),
            },
        },
    },
}
