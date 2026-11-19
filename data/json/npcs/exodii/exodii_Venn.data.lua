local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_VENN_Bionic_Install",
    line = ccb.content.text("&You sit on the surgical table and Venn pulls an aging CRT into view.  The spider-like surgical robot starts to greedily poke and prod you.  The monitor highlights your current bionics, and available upgrades, all accompanied by text you don't understand."),
    replies = {
        {
            text = ccb.content.text("[Point to a CBM on the screen to install]"),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("[Point to a CBM on the screen to remove]"),
            next_topic = "TALK_DONE",
            native_actions = { "bionic_remove" },
        },
    },
}
