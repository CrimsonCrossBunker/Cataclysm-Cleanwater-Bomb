local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_3",
    line = ccb.content.text("&Rubik leans in and starts to tap the device's screen, showing you how it works.  \"Right, guess it's all scribbles to ya'.  It's a click-clack paddywack.  A tippidy-type.  A computer.  Has a few jobs, but only a pair for you.  First, is a talk-box - a radio.  Should work, still.  Second is fer wobbles - that is, it can wibble out Labyrinths, and where they're at.  It won't finger'em to you properly, but keep it turnt on, and it'll record'em'if'it'finds'em, aye?  Then, bring'er back to the terminal downstairs.  Might use'em to delve back into a Labyrinth, for better'er'worse.\""),
    replies = {
        {
            text = ccb.content.text("Where should I look for these wobbles?  These entrances to labyrinths?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_4",
        },
        {
            text = ccb.content.text("So I turn this on, and just leave it on, and if I get close to a \"wobble\", that is, an entrance to a Labyrinth, it'll record the location?  Then take it back to the computer.  Well, thanks, I guess."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "rubik_told_about_exodii_wrist_computer", "yes"), actions.handler("dlg_a_dda_b66461188429") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_4",
    line = ccb.content.text("Anyplace the fabric'a space, time, reality, n' all the bits between grows thin.  When the sky cracks, or the earth glows.  Ye'll ken it.  No doubt."),
    replies = {
        {
            text = ccb.content.text("That's cryptic.  So I turn this on, and just leave it on -- especially in places where \"reality grows thin\", AND if I get close to a \"wobble\" it'll record the location?  Then take it back to the computer?  THEN I can get back to the Labyrinths?  Well, thanks, I guess."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "rubik_told_about_exodii_wrist_computer", "yes"), actions.handler("dlg_a_dda_b66461188429") },
        },
    },
}
