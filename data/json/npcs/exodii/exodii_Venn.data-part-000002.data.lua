local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN_repair",
    line = ccb.content.text("&You sit on the surgical table and Venn pulls an aging CRT into view.  The spider-like surgical robot starts to greedily poke and prod you.  The monitor highlights your needs on a low resolution blueprint of your Cyberframe."),
    replies = {
        {
            text = ccb.content.text("[Offer to trade for the repairs]"),
            actions = { "repair_bionic_limbs" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Actually, nevermind."), next_topic = "TALK_DONE" },
    },
}
